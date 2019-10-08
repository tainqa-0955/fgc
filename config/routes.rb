Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    resources :users, only: [:new, :create, :show]
    resources :posts, only: [:show, :new, :create] do
      collection do
        get "/sub_topics", to: "posts#load_subtopic"
      end
      resources :comments, only: [:new, :create]
    end
  end
end
