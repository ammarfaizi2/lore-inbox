Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289234AbSA2JkO>; Tue, 29 Jan 2002 04:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289291AbSA2JkE>; Tue, 29 Jan 2002 04:40:04 -0500
Received: from mail.sonytel.be ([193.74.243.200]:36263 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S289234AbSA2Jjs>;
	Tue, 29 Jan 2002 04:39:48 -0500
Date: Tue, 29 Jan 2002 10:39:21 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Dave Jones <davej@suse.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev accel wrapper. II
In-Reply-To: <Pine.LNX.4.10.10201281521090.14010-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0201291034460.3801-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, James Simmons wrote:
> Oops. Forgot the patch. Here you go.
> 
> diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj6/drivers/video/fbcon-accel.c linux/drivers/video/fbcon-accel.c
> --- linux-2.5.2-dj6/drivers/video/fbcon-accel.c	Wed Dec 31 16:00:00 1969
> +++ linux/drivers/video/fbcon-accel.c	Mon Jan 28 11:15:10 2002

  [...]

> +void fbcon_accel_clear(struct vc_data *vc, struct display *p, int sy, int sx,
> +		       int height, int width)
> +{
> +	struct fb_info *info = p->fb_info;
> +	struct fb_fillrect region;
> +
> +	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
> +		region.color = attr_bgcol_ec(p,vc);
> +	else {
> +		if (info->var.bits_per_pixel > 16)
> +			region.color = ((u32*)info->pseudo_palette)[attr_bgcol_ec(p,vc)];
> +		else
> +			region.color = ((u16*)info->pseudo_palette)[attr_bgcol_ec(p,vc)];
> +	}

What about non-pseudocolor modes with bpp <= 8? We still use the 16-bit wide
pseudo-palette in that case?

Alternatively we can always use the 32-bit wide pseudo-palette, so the test
for info->var.bits_per_pixel can go away (assumed there are no pixel sizes
where more than 32 bits are needed for the color information). Then a pixel
value is just an opaque 32-bit value (cfr. fbtest).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

