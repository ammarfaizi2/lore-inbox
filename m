Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUBJO6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUBJO6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:58:17 -0500
Received: from witte.sonytel.be ([80.88.33.193]:8700 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265907AbUBJO6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:58:11 -0500
Date: Tue, 10 Feb 2004 15:57:59 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
In-Reply-To: <20040210144719.B23310@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.58.0402101556440.2261@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
 <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be>
 <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be>
 <20040210144719.B23310@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Russell King wrote:
> On Tue, Feb 10, 2004 at 03:32:47PM +0100, Geert Uytterhoeven wrote:
> > On Tue, 10 Feb 2004, Geert Uytterhoeven wrote:
> > > The dmapool code makes dma_{alloc,free}_coherent() a requirement for all
> > > platforms, breaking platforms that don't have it (e.g. m68k, and from a quick
> > > browse sparc and sparc64 probably, too).
> > >
> > > May not be that nice for a release candidate in a stable series...
> >
> > This patch seems to fix the problem (all offending platforms include
> > <asm/generic.h> if CONFIG_PCI only):
>
> Please don't - that breaks ARM.  Part of the whole point of dmapool is
> that it provides a generic DMA pool implementation, especially for
> non-PCI USB devices.

Fine, so what about this (add your favorite subsystem that _does use_ dmapool)?

--- linux-2.6.3-rc2/drivers/base/Makefile	2004-02-10 11:14:46.000000000 +0100
+++ linux-m68k-2.6.3-rc2/drivers/base/Makefile	2004-02-10 15:23:13.000000000 +0100
@@ -2,7 +2,9 @@

 obj-y			:= core.o sys.o interface.o bus.o \
 			   driver.o class.o class_simple.o platform.o \
-			   cpu.o firmware.o init.o map.o dmapool.o
+			   cpu.o firmware.o init.o map.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
+obj-$(CONFIG_PCI)	+= dmapool.o
+obj-$(CONFIG_USB)	+= dmapool.o

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
