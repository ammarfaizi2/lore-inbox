Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265185AbSJaDwq>; Wed, 30 Oct 2002 22:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265186AbSJaDwp>; Wed, 30 Oct 2002 22:52:45 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:30168 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265185AbSJaDwo>; Wed, 30 Oct 2002 22:52:44 -0500
Date: Wed, 30 Oct 2002 14:24:43 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Denis Oliver Kropp <dok@directfb.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44 - neofb-0.4
Message-ID: <20021030172443.GI12628@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Denis Oliver Kropp <dok@directfb.org>, linux-kernel@vger.kernel.org
References: <20021030165621.GA28352@skunk.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021030165621.GA28352@skunk.convergence.de>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 30, 2002 at 05:56:21PM +0100, Denis Oliver Kropp escreveu:
> diff -Naur linux-2.4.20-rc1/drivers/video/neofb.c linux-2.4.20-rc1-neofb-0.4/drivers/video/neofb.c
> --- linux-2.4.20-rc1/drivers/video/neofb.c	2002-10-30 15:20:39.000000000 +0100
> +++ linux-2.4.20-rc1-neofb-0.4/drivers/video/neofb.c	2002-10-30 15:49:30.000000000 +0100
>  static int disabled   = 0;
>  static int internal   = 0;
>  static int external   = 0;
> +static int libretto   = 0;
>  static int nostretch  = 0;
>  static int nopciburst = 0;

Could you just leave those globas uninitialized? That way it goes to the .bss
that will get zeroed anyway and the image will be slightly smaller.

> +static struct fb_var_screeninfo __devinitdata neofb_var800x480x8 = {
> +	accel_flags:	FB_ACCELF_TEXT,
> +	xres:		800,
> +	yres:		480,
> +	xres_virtual:   800,
> +	yres_virtual:   30000,
> +	bits_per_pixel: 8,
> +	pixclock:	25000,
> +	left_margin:	88,
> +	right_margin:	40,
> +	upper_margin:	23,
> +	lower_margin:	1,
> +	hsync_len:	128,
> +	vsync_len:	4,
> +	sync:		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	vmode:		FB_VMODE_NONINTERLACED
> +};

Please use ANSI C designated elements style, also supported by gcc and
that was the reason for massive conversion all over the kernel, it should
look like this:

static struct fb_var_screeninfo __devinitdata neofb_var800x480x8 = {
	.accel_flags	= FB_ACCELF_TEXT,
	.xres		= 800,
	.yres		= 480,
<snip>

>  static struct fb_var_screeninfo __devinitdata neofb_var1024x768x8 = {
>  	accel_flags:	FB_ACCELF_TEXT,
>  	xres:		1024,

ditto

