Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWDJUjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWDJUjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWDJUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:39:52 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29969 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932145AbWDJUjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:39:51 -0400
Date: Mon, 10 Apr 2006 22:39:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       rmk@arm.linux.org.uk, starvik@axis.com, dev-etrax@axis.com
Subject: [RFC: 2.6 patch] remove unused ide_init_default_hwifs()'s
Message-ID: <20060410203950.GG2408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The arm and the cris port both still contained unused 
ide_init_default_hwifs() static inline's being removed by this patch.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-arm/arch-sa1100/ide.h |   25 -------------------------
 include/asm-cris/arch-v10/ide.h   |   12 ------------
 2 files changed, 37 deletions(-)

--- linux-2.6.17-rc1-mm2-full/include/asm-arm/arch-sa1100/ide.h.old	2006-04-10 21:15:04.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/asm-arm/arch-sa1100/ide.h	2006-04-10 21:15:37.000000000 +0200
@@ -49,28 +49,3 @@
 		*irq = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-    if (machine_is_lart()) {
-#ifdef CONFIG_SA1100_LART
-        hw_regs_t hw;
-
-        /* Enable GPIO as interrupt line */
-        GPDR &= ~LART_GPIO_IDE;
-	set_irq_type(LART_IRQ_IDE, IRQT_RISING);
-
-        /* set PCMCIA interface timing */
-        MECR = 0x00060006;
-
-        /* init the interface */
-	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x0000, PCMCIA_IO_0_BASE + 0x1000, NULL);
-        hw.irq = LART_IRQ_IDE;
-        ide_register_hw(&hw);
-#endif
-    }
-}
--- linux-2.6.17-rc1-mm2-full/include/asm-cris/arch-v10/ide.h.old	2006-04-10 21:15:47.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/asm-cris/arch-v10/ide.h	2006-04-10 21:16:00.000000000 +0200
@@ -77,18 +77,6 @@
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-static inline void ide_init_default_hwifs(void)
-{
-	hw_regs_t hw;
-	int index;
-
-	for(index = 0; index < MAX_HWIFS; index++) {
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
-}
-
 /* some configuration options we don't need */
 
 #undef SUPPORT_VLB_SYNC

