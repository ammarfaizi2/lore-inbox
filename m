Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSGARDk>; Mon, 1 Jul 2002 13:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315883AbSGARDj>; Mon, 1 Jul 2002 13:03:39 -0400
Received: from www.transvirtual.com ([206.14.214.140]:29457 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315806AbSGARDj>; Mon, 1 Jul 2002 13:03:39 -0400
Date: Mon, 1 Jul 2002 10:05:47 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] 2.5.24 matroxfb off by one error
In-Reply-To: <20020630003410.GH25118@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0207011005350.21874-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applyed to the fbdev BK tree.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

On Sun, 30 Jun 2002, Petr Vandrovec wrote:

> Hi Linus,
>    please apply patch below.
>
>    It fixes off by one error in getcolreg/setcolreg in matroxfb's
> secondary head driver.
> 					Thanks,
> 						Petr Vandrovec
> 						vandrove@vc.cvut.cz
>
>
> diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
> --- linux/drivers/video/matrox/matroxfb_crtc2.c	Fri Jun 21 00:53:48 2002
> +++ linux/drivers/video/matrox/matroxfb_crtc2.c	Sat Jun 29 00:09:09 2002
> @@ -29,7 +29,7 @@
>  static int matroxfb_dh_getcolreg(unsigned regno, unsigned *red, unsigned *green,
>  		unsigned *blue, unsigned *transp, struct fb_info* info) {
>  #define m2info ((struct matroxfb_dh_fb_info*)info)
> -	if (regno > 16)
> +	if (regno >= 16)
>  		return 1;
>  	*red = m2info->palette[regno].red;
>  	*blue = m2info->palette[regno].blue;
> @@ -44,7 +44,7 @@
>  #define m2info ((struct matroxfb_dh_fb_info*)info)
>  	struct display* p;
>
> -	if (regno > 16)
> +	if (regno >= 16)
>  		return 1;
>  	m2info->palette[regno].red = red;
>  	m2info->palette[regno].blue = blue;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

