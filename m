Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbUKBMWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUKBMWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUKBMWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:22:06 -0500
Received: from witte.sonytel.be ([80.88.33.193]:28642 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261225AbUKBMUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:20:06 -0500
Date: Tue, 2 Nov 2004 13:19:58 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: adaplas@pol.net, linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: Problem with current fb_get_color_depth
 function
In-Reply-To: <20041102055555.GJ6361@triplehelix.org>
Message-ID: <Pine.GSO.4.61.0411021314580.25281@waterleaf.sonytel.be>
References: <20041010225903.GA2418@darjeeling.triplehelix.org>
 <200410110832.19978.adaplas@hotpop.com> <20041102055555.GJ6361@triplehelix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Joshua Kwan wrote:
> [ long overdue follow-up ]
> 
> On Mon, Oct 11, 2004 at 08:33:10AM +0800, Antonino A. Daplas wrote:
> > So, linux_logo_224 cannot be drawn when visual is directcolor at RGB555 or
> > RGB565 because the logo clut requirements exceeds the hardware clut
> > capability. You need to use a logo image with a lower depth such as the
> > 16-color logo, linux_logo_16.
> 
> This is weird, because removing that conditional from fb_get_color_depth
> allows a 224-color logo to show correctly on my Radeon framebuffer, in
> full color.
> 
> Otherwise, it is dithered to kingdom come and mostly appears all orange
> and black.
> 
> You may be right conceptually, but the fact of the matter is that this
> is a regression because 224-color logos work perfectly with the old
> fb_get_color_depth. So what is the real problem?
> 
> > In short, fb_get_color_depth() and radeonfb both do the correct thing, but
> > you need a logo with a lower color depth. Or choose RGB888 or higher, or
> > set the visual to truecolor.
> 
> What does that last sentence mean? -- I have no idea...

In directcolor mode, the pixel color is:

    (clut.red[r], clut.green[g], clut.blue[b])

with r, g, and b being the values in the pixel (i.e. they are in the range
0..31 for RGB555, and g in the range 0..63 for RGB565).

In truecolor mode, the pixel color is:

    (r, g, b)

> > PS: Note that this behavior is the same as 2.4 behavior (224-color logo is
> > only chosen if directcolor and bpp >= 24).  It might have worked before, and
> > this is probably due to the directcolor clut being ramped to truecolor
> > values. However, the correct solution is to use a 16-color logo.
> 
> Oh, I see, I didn't read this before.
> 
> Well, 16-color logos being used when 224-color ones work perfectly
> enough 99% of the time is pretty bad aesthetically, if you ask me.

It's very strange that it did work before, since there's no way to set up the
32-entry CLUT (of which BTW the first 16 colors are the standard console
colors) for any random 224-color image in RGB555 mode.

In RGB888 mode (24-bit color) it's possible though, since the CLUT has 256
entries.

Can you show us a screenshot (e.g. using fbgrab) of the old behavior?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
