class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(parent_id: params[:parent_id],
                                  user_id:   params[:user_id] ,
                                  post_id:   params[:post_id])
    respond_to do |format|
        format.js
    end
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to user_post_path(@comment.user_id, @post), notice: 'comment created!' }
        format.js
      end
    else
      render 'pages/home'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, :parent_id)
  end
end
