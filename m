Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290824AbSBLIRS>; Tue, 12 Feb 2002 03:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290828AbSBLIRI>; Tue, 12 Feb 2002 03:17:08 -0500
Received: from mail.sonytel.be ([193.74.243.200]:58505 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S290824AbSBLIRC>;
	Tue, 12 Feb 2002 03:17:02 -0500
Date: Tue, 12 Feb 2002 09:16:29 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Dave Jones <davej@suse.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] accel wrapper again
In-Reply-To: <Pine.LNX.4.10.10202111605310.5200-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0202120913150.12840-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, James Simmons wrote:
> diff -urN -X /home/jsimmons/dontdiff linux-2.5.3-dj5/drivers/video/fbcon-accel.c linux/drivers/video/fbcon-accel.c
> --- linux-2.5.3-dj5/drivers/video/fbcon-accel.c	Wed Dec 31 16:00:00 1969
> +++ linux/drivers/video/fbcon-accel.c	Mon Feb 11 16:52:44 2002

  [...]

> +void fbcon_accel_clear(struct vc_data *vc, struct display *p, int sy, int sx,
> +		       int height, int width)
> +{
> +	struct fb_info *info = p->fb_info;
> +	struct fb_fillrect region;
> +
> +	region.color = attr_bgcol_ec(p,vc);
> +	region.dx = sx * fontwidth(p);
> +	region.dy = sy * fontheight(p);
> +	region.width = width * fontwidth(p);
> +	region.height = height * fontheight(p);
> +	region.rop = ROP_COPY;
> +
> +	info->fbops->fb_fillrect(info, &region);

So now fb_fillrect.color is always the index into the console palette?
Is there any way to specify a color that's not in the console palette? This is
very useful in {true,direct}color modes.

How does imageblit work for the logo now, i.e. does an image contain console
palette indices too?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

