Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVBBTpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVBBTpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVBBTkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:40:45 -0500
Received: from witte.sonytel.be ([80.88.33.193]:30357 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262832AbVBBTjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:39:00 -0500
Date: Wed, 2 Feb 2005 20:38:57 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Haakon Riiser <haakon.riiser@fys.uio.no>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
In-Reply-To: <20050202174509.GA773@s>
Message-ID: <Pine.GSO.4.61.0502022037440.2069@waterleaf.sonytel.be>
References: <20050202133108.GA2410@s> <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com>
 <20050202142155.GA2764@s> <1107357093.6191.53.camel@gonzales>
 <20050202154139.GA3267@s> <9e4733910502020825434a477@mail.gmail.com>
 <20050202174509.GA773@s>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Haakon Riiser wrote:
> > On Wed, 2 Feb 2005 16:41:39 +0100, Haakon Riiser
> > <haakon.riiser@fys.uio.no> wrote:
> >> Thanks for the tip, I hadn't heard about it.  I will take a look,
> >> but only to see if it can show me the user space API of /dev/fb.
> >> I don't need a general library that supports a bunch of different
> >> graphics cards.  I'm writing my own frame buffer driver for the
> >> GX2 CPU, and I just want to know how to call the various functions
> >> registered in struct fb_ops, so that I can test my code.  I mean,
> >> all those functions registered in fb_ops must be accessible
> >> somehow; if they weren't, what purpose would they serve?
> > 
> > You should look at writing a DRM driver. DRM implements the kernel
> > interface to get 3D hardware running. It is a fully accelerated driver
> > interface. They are located in drivers/char/drm
> 
> Have the standard frame buffer drivers been abandoned, even
> for devices that have no 3D acceleration (like the Geode GX2)?

No.

> GX2 is an integrated CPU/graphics chip for embedded systems.
> We have third party applications that use the framebuffer device,
> and I was hoping to make things faster by writing an accelerated
> driver.  The only thing I need answered is how to access fb_ops
> from userspace.  If that is impossible because all the framebuffer
> code is leftover junk that no one uses anymore, or even /can/
> use anymore because the userspace interface is gone, please let
> me know now so I don't have to waste any more time.

mmap() the MMIO registers to userspace, and program the acceleration engine
from userspace, like DirectFB (and XF*_FBDev 3.x for Matrox and Mach64) does.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
