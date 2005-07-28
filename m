Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVG1QAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVG1QAW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVG1P74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:59:56 -0400
Received: from witte.sonytel.be ([80.88.33.193]:46311 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261593AbVG1P7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:59:45 -0400
Date: Thu, 28 Jul 2005 17:59:15 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
In-Reply-To: <42E8F0CD.6070500@gmail.com>
Message-ID: <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
 <9e473391050728060741040424@mail.gmail.com> <42E8F0CD.6070500@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Antonino A. Daplas wrote:
> Jon Smirl wrote:
> > On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, 27 Jul 2005, Linux Kernel Mailing List wrote:
> > 
> > There are a couple of ways to fix this. 
> > 1) Add a check to limit use of the sysfs attributes to 256 entries. If
> > you want more you have to use /dev/fb0 and the ioctl. More is an
> > uncommon case.
> > 2) Switch this to a binary parameter. Now you have to use tools like
> > hexdump instead of cat to work with the data. It was nice to be able
> > to use cat to see the current map.
> > 
> > Does anyone have preferences for which way to fix it?
> 
> Or...
> 
>  3) Add another file in sysfs which specifies at what index and how many
> entries will be read or written from or to the cmap. With this additional
> sysfs file, it should be able to handle any reasonable cmap length, but
> it will take more than one reading of the color_map file. Another
> advantage is that the entire color map need not be read or written if
> only one field needs to be changed.
> 
> I've attached a test patch.  Let me know what you think.

I like it! ... But, a disadvantages is that it needs to store state between two
non-atomic operations. E.g. imagine two processes doing this at the same time.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
