Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSLJOdX>; Tue, 10 Dec 2002 09:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSLJOdX>; Tue, 10 Dec 2002 09:33:23 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:11538 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S261836AbSLJOdV>; Tue, 10 Dec 2002 09:33:21 -0500
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
From: Antonino Daplas <adaplas@pol.net>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210140301.GC26361@suse.de>
References: <1039522886.1041.17.camel@localhost.localdomain>
	<20021210131143.GA26361@suse.de>
	<1039538881.2025.2.camel@localhost.localdomain> 
	<20021210140301.GC26361@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 22:34:46 +0500
Message-Id: <1039541718.2019.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 19:03, Dave Jones wrote:
> On Tue, Dec 10, 2002 at 09:47:24PM +0500, Antonino Daplas wrote:
> 
> btw, iirc you were the guy who wanted agpgart initialised sooner
> due to the way the i810 framebuffer worked ?
Yes.

> How much sooner are we talking ? What puzzles me, is looking
Here's part of dmesg:

fb: Intel(R) 810 Framebuffer Device v0.9.0, Tony Daplas
     Video RAM      : 4096K
     Mode           : 1024x768-8bpp@67Hz
     Acceleration   : enabled
     MTRR           : enabled
     External VGA   : disabled
     Video Timings  : VESA GTF (US)
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.99 (c) Dave Jones
agpgart: Detected an Intel i810 Chipset.
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: AGP aperture is 64M @ 0xe8000000


> at the link order in the makefiles, agpgart should already be
> getting initialised before the framebuffer code, but doesn't
> seem to be for reasons unknown..
>
I'm also not sure why, and even in .built-in.o.cmd, drivers/char is
before drivers/video.  Perhaps the early console_init()?  I'll try to
rebuild my kernel without the framebuffer console and let you know.
 
> Another issue on this same case, is that for this to work out,
> we'll need some kconfig magick so that if the framebuffer is 'Y'
> rather than 'M' the i810 gart module must be forced to 'Y' too.
> 
Yes, FB_I810 depends on AGP_INTEL, so the i810fb option is disabled if
agpgart is disabled.

Tony

