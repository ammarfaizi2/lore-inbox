Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSLWJAo>; Mon, 23 Dec 2002 04:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSLWJAo>; Mon, 23 Dec 2002 04:00:44 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:17542 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261693AbSLWJAn>;
	Mon, 23 Dec 2002 04:00:43 -0500
Date: Mon, 23 Dec 2002 10:07:35 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] fix endian problem in color_imageblit
In-Reply-To: <20021221092744.A23531@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0212231004040.12134-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2002, Russell King wrote:
> On Sat, Dec 21, 2002 at 11:45:44AM +0800, Antonino Daplas wrote:
> > The pseudopalette will only matter for truecolor and directcolor as the
> > rest of the visuals bypasses the pseudopalette.  Typecasting to
> > "unsigned long" rather than "u32" is also safer (even for bpp16) since
> > in 64-bit machines, the drawing functions use fb_writeq instead of
> > fb_writel.
> 
> Erm, what does the size of the drawing functions have to do with the
> size of the pseudo palette.  The pseudo palette is only there to encode
> the pixel values for the 16 console colours.

Indeed.

> This means that a 64-bit pseudo palette would only be useful if you have
> a graphics card that supports > 32bpp, otherwise a 32-bit pseudo palette
> is perfectly adequate, even if you are using fb_writeq.

Yep. Cards with bpp > 32 are rumoured to exist, but there is no fbdev support
for them right now.

> (note that fbcon doesn't support > 32bpp, so we will only ever look at
> the first 32 bits, and having it be 64-bit would just be a needless
> waste of space imho.)

And this can be fixed, once we have some fbdev driver that uses bpp > 32.

Note that the size of the entries in the pseudo palette used to depend on the
mode, i.e. u16 for bpp = 16, u32 for bpp = 24 or 32.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

