Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263312AbUJ3BiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbUJ3BiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUJ2Ths
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:37:48 -0400
Received: from witte.sonytel.be ([80.88.33.193]:2793 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261263AbUJ2StZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:49:25 -0400
Date: Fri, 29 Oct 2004 20:49:09 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb: screeninfo initialization cleanup
In-Reply-To: <200410281712.i9SHCxDe025312@hera.kernel.org>
Message-ID: <Pine.GSO.4.61.0410292046380.23014@waterleaf.sonytel.be>
References: <200410281712.i9SHCxDe025312@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Linux Kernel Mailing List wrote:
> ChangeSet 1.2265, 2004/10/28 08:23:51-07:00, penberg@cs.helsinki.fi
> 
> 	[PATCH] radeonfb: screeninfo initialization cleanup
> 	
> 	This patch changes the initialization of radeonfb_default_var to use named
> 	initializers and avoids explicitly setting fields that are automatically
> 	zeroed.

> --- a/drivers/video/aty/radeon_monitor.c	2004-10-28 10:13:09 -07:00
> +++ b/drivers/video/aty/radeon_monitor.c	2004-10-28 10:13:09 -07:00
> @@ -7,10 +7,25 @@
>  #endif /* CONFIG_PPC_OF */
>  
>  static struct fb_var_screeninfo radeonfb_default_var = {
> -        640, 480, 640, 480, 0, 0, 8, 0,
> -        {0, 6, 0}, {0, 6, 0}, {0, 6, 0}, {0, 0, 0},
> -        0, 0, -1, -1, 0, 39721, 40, 24, 32, 11, 96, 2,
> -        0, FB_VMODE_NONINTERLACED
> +	.xres		= 640,
> +	.yres		= 480,
> +	.xres_virtual	= 640,
> +	.yres_virtual	= 480,
> +	.bits_per_pixel = 8,
> +	.red		= { 0, 6, 0 },
                               ^
> +	.green		= { 0, 6, 0 },
                               ^
> +	.blue		= { 0, 6, 0 },
                               ^
Should be 8 these days (256 usable color palette entries).
And why not use `{ .length = 8 }' if you don't care about automatically zeroed
fields?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
