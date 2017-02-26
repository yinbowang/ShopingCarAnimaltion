//
//  ViewController.m
//  ShopingCarAnimaltion
//
//  Created by wyb on 2017/2/26.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import "ViewController.h"

#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<CAAnimationDelegate>

@property(nonatomic,strong)UIImageView *shopCarImageView;

@property(nonatomic,strong)UIImageView *goodsImageView;

@property(nonatomic,strong)UIButton *addToCarBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addToCarBtn = [UIButton new];
    self.addToCarBtn.frame = CGRectMake(50, 50, 100, 30);
    self.addToCarBtn.backgroundColor = [UIColor greenColor];
    [self.addToCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.addToCarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addToCarBtn addTarget: self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addToCarBtn];
    
    
    
    self.shopCarImageView = [[UIImageView alloc]init];
    self.shopCarImageView.frame = CGRectMake(KScreenWidth-60, KScreenHeight-60, 60, 60);
    self.shopCarImageView.image = [UIImage imageNamed:@"cart10"];
    [self.view addSubview:self.shopCarImageView];
    
    
}


- (void)btnAction {
    
    self.goodsImageView = [[UIImageView alloc]init];
    self.goodsImageView.frame = CGRectMake(0, 0, 40, 40);
    self.goodsImageView.image = [UIImage imageNamed:@"cup_ice_cream"];
    [self.view addSubview:self.goodsImageView];
    
    CAKeyframeAnimation *animal = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animal.delegate = self;
    animal.duration = 3;
    /*fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用.
    下面来讲各个fillMode的意义
    kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
    kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
    kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
    kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.*/
    
    animal.removedOnCompletion = NO;
    animal.fillMode = kCAFillModeForwards;
    
    //起点
    CGPoint startPoint = CGPointMake(self.addToCarBtn.center.x, self.addToCarBtn.center.y);
    
    //控点
    CGPoint controlPoint = CGPointMake(self.shopCarImageView.frame.origin.x, self.addToCarBtn.frame.origin.y);
    
    //终点
    CGPoint endPoint = CGPointMake(self.shopCarImageView.center.x, self.shopCarImageView.center.y);
    
    //设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    //开始位置
    CGPathMoveToPoint(path, NULL, startPoint.x,startPoint.y);
    //二阶贝塞尔曲线
    CGPathAddQuadCurveToPoint(path, NULL, controlPoint.x, controlPoint.y, endPoint.x,endPoint.y);
    animal.path = path;
    [self.goodsImageView.layer addAnimation:animal forKey:nil];
    
    CGPathRelease(path);
    

    
    
}

- (void)animationDidStart:(CAAnimation *)anim{
    
    NSLog(@"动画已经开始");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"动画已经结束");
    [self.goodsImageView removeFromSuperview];
    
    
}


@end
