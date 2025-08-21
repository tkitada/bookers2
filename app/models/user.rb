class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :rememberable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :email, presence: true
  validates :password, presence: true, on: :create
  validates :introduction, length: { maximum: 50 }


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

end
