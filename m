Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbTC1LKd>; Fri, 28 Mar 2003 06:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262931AbTC1LKc>; Fri, 28 Mar 2003 06:10:32 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:62479 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S262924AbTC1LKb>; Fri, 28 Mar 2003 06:10:31 -0500
Subject: Re: [Linux-fbdev-devel] Framebuffer fixes.
From: Antonino Daplas <adaplas@pol.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0303280857240.7286-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0303280857240.7286-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1048849255.1000.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Mar 2003 19:02:00 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 16:00, Geert Uytterhoeven wrote:
> On Fri, 28 Mar 2003, James Simmons wrote:
> > > > > > Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> > > > > 
> > > > > Yes, fb_logo.depth == info->var.bits_per_pixel.
> > > > 
> > > > Euh, now I get confused... Do you mean
> > > > `Yes, it should be replaced by info->var.bits_per_pixel' or
> > > > `No, logo.depth is always equal to info->var.bits_per_pixel'?
> > > 
> > > :)  Sorry about that. I meant:
> > > 
> > > 
> > > `No, fb_logo.depth is always equal to info->var.bits_per_pixel'
> > 
> > No this is no longer true. For example last night I displayed the 16 color 
> > logo perfectly fine on a 16 bpp display!!!! The mono display still has 
> > bugs tho. The new logo tries to pick the best image to display. Say for 
> > example we have two video cards. One running VESA fbdev at 16 bpp and a 
> > another at vga 4 planar via vga16fb. This way we can have the both the 16 
> > color and 224 color logo compiled in.  The correct logo will be displayed 
> > then on the correct display. Now say we only have a mono display but all 
> 
> Didn't it always work like that? You got the 16 color logo on vga16fb and the
> 224 color logo on displays with more than 256 colors (except for directcolor).
> 

If I'm not mistaken, I think what James meant was that the new code has
the capability of choosing an appropriate logo even if it does not
maximize the color range of the display.  Ie if only 4bpp logo is
compiled, but display is set at 8bpp-pseudocolor, it would still
display a 4bpp logo correctly.

Personally, I think it's really a simple matter of choosing the
appropriate logo type for the correct display device, instead of the
code trying to outthink the intention of the user.   

However, that was never my point.  What I see is a problem with the new
code.  What if the display is set at 16-bpp DirectColor?  The code will
choose clut224 for it, but that is not correct and may even crash due to
an "out of bounds" error in the pseudo_palette.  Directcolor 565, for
instance, will only have 32 entries for red and blue, and 64 entries for
green, greatly exceeding 224.  Similarly, Directcolor < 12bpp, will
actually need monochrome, not even 4bpp, and definitely not clut224. 
There are other obvious and non-obvious examples that I can enumerate.

 
> > the cards support 8 bpp or better. That logo still gets displayed.
>                                      ^^^^
> Which logo do you mean with `that'? On a monochrome display, it should be the
> monochrome logo.
> 

The patch I submitted was tested by simulating monochrome on an 8-bit
display.  It used monochrome logo, drawn using monochrome expansion, and
it works for me.

Tony


