Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTJPT65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbTJPT65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:58:57 -0400
Received: from [80.88.36.193] ([80.88.36.193]:19618 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263142AbTJPT6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:58:53 -0400
Date: Thu, 16 Oct 2003 21:58:44 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] FBDEV 2.6.0-test7 updates.
In-Reply-To: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0310162156240.22417-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, James Simmons wrote:
> Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> Several fixes. The patch is against 2.6.0-test7

> --- linux-2.6.0-test7/drivers/video/logo/Makefile	Wed Oct 15 19:12:21 2003
> +++ fbdev-2.6/drivers/video/logo/Makefile	Wed Oct 15 19:20:50 2003
> @@ -13,30 +13,36 @@
>  obj-$(CONFIG_LOGO_SUPERH_VGA16)		+= logo_superh_vga16.o
>  obj-$(CONFIG_LOGO_SUPERH_CLUT224)	+= logo_superh_clut224.o
>  
> -# Dependencies on generated files need to be listed explicitly
> -
> -$(obj)/%_mono.o: $(src)/%_mono.c
> -
> -$(obj)/%_vga16.o: $(src)/%_vga16.c
> -
> -$(obj)/%_clut224.o: $(src)/%_clut224.c
> -
> -$(obj)/%_gray256.o: $(src)/%_gray256.c
> -
> -# How to generate them
> +# mono logo's
> +$(obj)/logo_linux_mono.o:	$(obj)/logo_linux_mono.c
> +$(obj)/logo_superh_mono.o:	$(obj)/logo_superh_mono.c
> +
> +# vga16 logo's
> +$(obj)/logo_linux_vga16.o:	$(obj)/logo_linux_vga16.c
> +$(obj)/logo_superh_vga16.o:	$(obj)/logo_superh_vga16.c
> +
> +# clut224 logo's
> +$(obj)/logo_linux_clut224.o:	$(obj)/logo_linux_clut224.c
> +$(obj)/logo_dec_clut224.o:	$(obj)/logo_dec_clut224.c
> +$(obj)/logo_mac_clut224.o:	$(obj)/logo_mac_clut224.c
> +$(obj)/logo_sgi_clut224.o:	$(obj)/logo_sgi_clut224.c
> +$(obj)/logo_sun_clut224.o:	$(obj)/logo_sun_clut224.c
> +$(obj)/logo_superh_clut224.o:	$(obj)/logo_superh_clut224.c

Why did you replace the generic rules?

> --- linux-2.6.0-test7/drivers/video/radeonfb.c	Wed Oct 15 19:12:22 2003
> +++ fbdev-2.6/drivers/video/radeonfb.c	Wed Oct 15 19:20:51 2003

drivers/video/radeonfb.c still exists, while the build system now uses the one
in drivers/video/aty?

> --- linux-2.6.0-test7/drivers/video/sgivwfb.c	Wed Oct 15 19:12:22 2003
> +++ fbdev-2.6/drivers/video/sgivwfb.c	Wed Oct 15 19:20:51 2003
> @@ -319,14 +319,14 @@
>  		var->transp.length = 0;
>  		break;
>  	case 16:		/* RGBA 5551 */

Please change the comment from `RGBA 5551' to `ARGB 1555' to match the code.

> -		var->red.offset = 11;
> +		var->red.offset = 10;
>  		var->red.length = 5;
> -		var->green.offset = 6;
> +		var->green.offset = 5;
>  		var->green.length = 5;
> -		var->blue.offset = 1;
> +		var->blue.offset = 0;
>  		var->blue.length = 5;
> -		var->transp.offset = 0;
> -		var->transp.length = 0;
> +		var->transp.offset = 15;
> +		var->transp.length = 1;
>  		break;
>  	case 32:		/* RGB 8888 */
>  		var->red.offset = 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

