Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSKHNkE>; Fri, 8 Nov 2002 08:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSKHNkE>; Fri, 8 Nov 2002 08:40:04 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:16600 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261963AbSKHNkD>;
	Fri, 8 Nov 2002 08:40:03 -0500
Date: Fri, 8 Nov 2002 14:46:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: [PATCH] SCSI on non-ISA systems
Message-ID: <Pine.GSO.4.21.0211081443590.23267-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since 2.5.31, the compilation of kernel/dma.c is conditional on
CONFIG_GENERIC_ISA_DMA. However, drivers/scsi/hosts.c unconditionally calls
free_dma(), which breaks machines with SCSI that don't have ISA.

Please apply!

--- linux-2.5.46/drivers/scsi/hosts.c	Thu Oct 31 10:15:33 2002
+++ linux-m68k-2.5.46/drivers/scsi/hosts.c	Fri Nov  8 14:27:59 2002
@@ -27,6 +27,7 @@
  *  hosts currently present in the system.
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/blk.h>
 #include <linux/kernel.h>
@@ -98,8 +99,10 @@
 {
 	if (shost->irq)
 		free_irq(shost->irq, NULL);
+#ifdef CONFIG_GENERIC_ISA_DMA
 	if (shost->dma_channel != 0xff)
 		free_dma(shost->dma_channel);
+#endif
 	if (shost->io_port && shost->n_io_port)
 		release_region(shost->io_port, shost->n_io_port);
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

