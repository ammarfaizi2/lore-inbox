Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTKSL5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 06:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbTKSL5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 06:57:40 -0500
Received: from witte.sonytel.be ([80.88.33.193]:5003 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264030AbTKSL5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 06:57:38 -0500
Date: Wed, 19 Nov 2003 12:57:34 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ronald Lembcke <es186@fen-net.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: bugfix =?iso-8859-1?Q?f=FC?= =?iso-8859-1?Q?r?= RadeonFB
 (against 2.4.22-ac4, bug in 2.6.0-test9, too)
In-Reply-To: <20031119115016.GA2912@defiant.crash>
Message-ID: <Pine.GSO.4.21.0311191254160.7852-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Nov 2003, Ronald Lembcke wrote:
> On Wed, Nov 19, 2003 at 10:50:22AM +0100, Geert Uytterhoeven wrote:
> > Your change is not correct: bpp is the _physical_ bits per pixel, i.e. it's 16
> > for both color depth 15 (5/5/5 mode) and color depth 16 (5/6/5).
> > 
> > To differentiate between 5/5/5 and 5/6/5, you have to look at green.length, and
> > apply standard fbdev fit-our-round-up[*] rules.
> I don't see where this rule applies here. I searched on google, but
> did't find anything about rounding of color depth.
> 
> > Note that some hardware in addition does RGBA4444, too.
> Yes, but that nothing to do with these patches.
> 
> Sorry, I don't see, where my patches for intelfb and radonfb (as said
> before, I'm not sure about the imsttfb patch anyway) make the driver
> less correct. Where are they wrong?
> 
> Nothing about the use of bits_per_pixel is changed.
> The only change is whether 555 or 565 is default.

Which depends on the color bitmask lengths...

> If those patches are wrong, than matroxfb and rivafb are buggy, too:

Most drivers indeed don't apply the fit-our-round-up rules to the color bitmask
lengths.

My main concern is that while you touch those parts of the code, you should
make it follow the rules instead of doing some ad-hoc changes.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

