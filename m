Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261820AbTC0I7S>; Thu, 27 Mar 2003 03:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261821AbTC0I7S>; Thu, 27 Mar 2003 03:59:18 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:48368 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261820AbTC0I7Q>;
	Thu, 27 Mar 2003 03:59:16 -0500
Date: Thu, 27 Mar 2003 10:09:33 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Antonino Daplas <adaplas@pol.net>
cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Framebuffer fixes.
In-Reply-To: <1048734021.982.4.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0303271008190.26358-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2003, Antonino Daplas wrote:
>        - image->depth should be representative of the data depth
> (currently, either 8 or 1).  If image->depth == 1, color expansion can
> now be used to draw the logo, thus there's no need to differentiate
> between mono logo drawing and monochrome expansion.

> +	/*
> +	 * Monochrome expansion and logo drawing functions are the same if
> +	 * fb_logo.needs_logo == 1.
> +	 */
> +	switch (info->fix.visual) {
> +	case FB_VISUAL_MONO10:
> +		image.fg_color = (u32) (~(~0UL << fb_logo.depth));
                                                  ^^^^^^^^^^^^^
> +		image.bg_color = 0;
> +		image.depth = 1;
> +		break;
> +	case FB_VISUAL_MONO01:
> +		image.bg_color = (u32) (~(~0UL << fb_logo.depth));
                                                  ^^^^^^^^^^^^^
> +		image.fg_color = 0;
> +		image.depth = 1;
> +		break;

Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

