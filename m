Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTKSJua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 04:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263926AbTKSJua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 04:50:30 -0500
Received: from witte.sonytel.be ([80.88.33.193]:55982 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263923AbTKSJu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 04:50:28 -0500
Date: Wed, 19 Nov 2003 10:50:22 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ronald Lembcke <es186@fen-net.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: bugfix =?iso-8859-1?Q?f=FC?= =?iso-8859-1?Q?r?= RadeonFB
 (against 2.4.22-ac4, bug in 2.6.0-test9, too)
In-Reply-To: <20031105225724.GA21030@defiant.crash>
Message-ID: <Pine.GSO.4.21.0311191043110.7852-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003, Ronald Lembcke wrote:
> The following patches make a few framebuffer-drivers behave (imho) more
> sensible: (Matrox and Riva allready behave like this)
> 
> When selecting a video mode with bits_per_pixel == 16 is selected, but
> green.length != 6 (... 0 because the calling programm made no assumtion
> if the mode is 5/6/5 or maybe 6/5/5 or whatever) a 15 bpp mode is
> selected with 5/5/5. 
> That's not nice ... when 16 bpp were requested.

Your change is not correct: bpp is the _physical_ bits per pixel, i.e. it's 16
for both color depth 15 (5/5/5 mode) and color depth 16 (5/6/5).

To differentiate between 5/5/5 and 5/6/5, you have to look at green.length, and
apply standard fbdev fit-our-round-up[*] rules.

Note that some hardware in addition does RGBA4444, too.

Gr{oetje,eeting}s,

						Geert

[*] If a value doesn't fit, try to round it _up_. If that fails, return an
    error.
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

