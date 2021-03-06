package fx::Controller::2020::11::15::main;
use Moose;
use namespace::autoclean;
use MY::DB;
use Log::Mini;
use MY::ToolFunc;
use utf8;
use JSON;
use Data::Dumper;
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

fx::Controller::2020::11::15::main - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 heading

=cut

sub auto : Private {

    my ( $self, $c ) = @_;

}


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;


    $c->stash->{template} = '20201115/base.tt2';
}


=head1 error

    error函数 全局error页面跳转位置，可以定制错误信息
    附带信息写入$c，来进行传输
=cut
sub error : Private {
    my ( $self, $c) = @_;
    $c->{ status_code } ||= 200;
    $c->{ msg } ||= "一切正常, 正在努力工作";
    $c->response->status( $c->{ status_code } );
	$c->stash(
        template => '20201019/error-500.html',
        msg      => $c->{ msg },
        code     => $c->{ status_code },
        title    => $c->{ msg },
    );
}

=head2 information()

提示信息页面

=cut

sub information : Local {
    my ( $self, $c, $param ) = @_;
    $c->stash->{info_msg} = $param;

    $c->stash->{template} = '20201115/information.tt2';
}

=head2 heading

测试文件上传
=cut

sub testUploads : Local {

    my ( $self, $c, $param ) = @_;

    if( $c->req->method eq 'POST' ) {

        my %res = ToolFunc::upload_func($c,'usr_wfw.T_FX_TEST',qw/XH XM XB KSH MZ NJ ZXXY ZXZY/);

        $c->log->info(Dumper \%res);
        $c->res->body(123);
        return 0;
    }

    $c->stash->{template} = '20201115/test.html';
}


=encoding utf8

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
