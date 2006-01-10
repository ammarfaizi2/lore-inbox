Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWAJME2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWAJME2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWAJME2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:04:28 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:46019 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751080AbWAJME1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:04:27 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: spereira@tusc.com.au
Subject: Re: [PATCH 1/2 RESEND- 2.6.15] net: 32 bit (socket layer) ioctl emulation for 64 bit kernels
Date: Tue, 10 Jan 2006 12:03:58 +0000
User-Agent: KMail/1.9.1
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Andi Kleen <ak@muc.de>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>, netdev <netdev@vger.kernel.org>,
       SP <pereira.shaun@gmail.com>
References: <1136871078.5742.26.camel@spereira05.tusc.com.au>
In-Reply-To: <1136871078.5742.26.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101203.59423.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 05:31, Shaun Pereira wrote:
> Hi Arnd, Arnaldo
> Thanks for your comments. I initially did not wish to change any of the 
> other modules, but based on Arnd's comments I have removed the
> extra macro, SOCKOPS_COMPAT_WRAP and use the original SOCKOPS_WRAP.

Ok, looks better now. Just a few tiny style comments:

> +++ linux-2.6.15/net/appletalk/ddp.c	2006-01-10 15:56:55.000000000 +1100
> @@ -1852,6 +1852,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
>  	.getname	= atalk_getname,
>  	.poll		= datagram_poll,
>  	.ioctl		= atalk_ioctl,
> +	.compat_ioctl   = NULL,
>  	.listen		= sock_no_listen,
>  	.shutdown	= sock_no_shutdown,
>  	.setsockopt	= sock_no_setsockopt,

No need to set .compat_ioctl to NULL, that's what it already is when you
don't assign it at all. Leaving it out makes it easier to grep for users.

> @@ -709,6 +710,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
>  	.getname =	econet_getname, 
>  	.poll =		datagram_poll,
>  	.ioctl =	econet_ioctl,
> +	.compat_ioctl=  NULL,
>  	.listen =	sock_no_listen,
>  	.shutdown =	sock_no_shutdown,
>  	.setsockopt =	sock_no_setsockopt,
> diff -uprN -X dontdiff linux-2.6.15-vanilla/net/ipx/af_ipx.c
> linux-2.6.15/net/ipx/af_ipx.c
> --- linux-2.6.15-vanilla/net/ipx/af_ipx.c	2006-01-03 14:21:10.000000000
> +1100
> +++ linux-2.6.15/net/ipx/af_ipx.c	2006-01-10 15:56:55.000000000 +1100
> @@ -1912,6 +1912,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
>  	.getname	= ipx_getname,
>  	.poll		= datagram_poll,
>  	.ioctl		= ipx_ioctl,
> +	.compat_ioctl   = NULL,
>  	.listen		= sock_no_listen,
>  	.shutdown	= sock_no_shutdown, /* FIXME: support shutdown */
>  	.setsockopt	= ipx_setsockopt,
> diff -uprN -X dontdiff linux-2.6.15-vanilla/net/irda/af_irda.c
> linux-2.6.15/net/irda/af_irda.c
> --- linux-2.6.15-vanilla/net/irda/af_irda.c	2006-01-03
> 14:21:10.000000000 +1100
> +++ linux-2.6.15/net/irda/af_irda.c	2006-01-10 15:56:55.000000000 +1100
> @@ -2474,6 +2474,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
>  	.getname =	irda_getname,
>  	.poll =		irda_poll,
>  	.ioctl =	irda_ioctl,
> +	.compat_ioctl=  NULL,
>  	.listen =	irda_listen,
>  	.shutdown =	irda_shutdown,
>  	.setsockopt =	irda_setsockopt,
> @@ -2495,6 +2496,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
>  	.getname =	irda_getname,
>  	.poll =		datagram_poll,
>  	.ioctl =	irda_ioctl,
> +	.compat_ioctl=  NULL,
>  	.listen =	irda_listen,
>  	.shutdown =	irda_shutdown,
>  	.setsockopt =	irda_setsockopt,
> @@ -2516,6 +2518,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
>  	.getname =	irda_getname,
>  	.poll =		datagram_poll,
>  	.ioctl =	irda_ioctl,
> +	.compat_ioctl=  NULL,
>  	.listen =	irda_listen,
>  	.shutdown =	irda_shutdown,
>  	.setsockopt =	irda_setsockopt,
> @@ -2538,6 +2541,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
>  	.getname =	irda_getname,
>  	.poll =		datagram_poll,
>  	.ioctl =	irda_ioctl,
> +	.compat_ioctl=  NULL,
>  	.listen =	sock_no_listen,
>  	.shutdown =	irda_shutdown,
>  	.setsockopt =	irda_setsockopt,
>  static struct proto_ops SOCKOPS_WRAPPED(x25_proto_ops) = {
>  	.family =	AF_X25,
>  	.owner =	THIS_MODULE,
> @@ -1402,6 +1403,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
>  	.getname =	x25_getname,
>  	.poll =		datagram_poll,
>  	.ioctl =	x25_ioctl,
> +	.compat_ioctl=  NULL,
>  	.listen =	x25_listen,
>  	.shutdown =	sock_no_shutdown,
>  	.setsockopt =	x25_setsockopt,
> 
> 

Same comment applies to all these.

> +static long compat_sock_ioctl(struct file *file, unsigned cmd, unsigned
> long arg)
> +{
> +	struct socket *sock;
> +	sock = file->private_data;
> +
> +	int ret = -ENOIOCTLCMD;
> +	if(sock->ops->compat_ioctl) {
> +		ret = sock->ops->compat_ioctl(sock,cmd,arg);
> +	}

Leave out the curly braces here and put a space between the function
arguments, so it becomes

+ if(sock->ops->compat_ioctl)
+ 	ret = sock->ops->compat_ioctl(sock, cmd, arg);

	Arnd <><
