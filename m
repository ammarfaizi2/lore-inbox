Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTEWNh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 09:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264078AbTEWNhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 09:37:54 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:60666 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264077AbTEWNcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 09:32:03 -0400
Date: Fri, 23 May 2003 15:44:57 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE DMA (2.4.x)
Message-ID: <Pine.GSO.4.21.0305231542290.26586-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Alan,

IDE DMA suggestions:
  - Add DMA activity test to ide_raw_build_sglist() (cfr. ide_build_sglist()).
    Does this make sense? Or should the test in ide_build_sglist() be removed?
  - Fix linuxdoc comments
  - Fix typo (probably introduced by the spelling police, thinking that
    `retune' was a typo ;-)

--- linux-2.4.x/drivers/ide/ide-dma.c.orig	Mon May  5 16:26:10 2003
+++ linux-2.4.x/drivers/ide/ide-dma.c	Thu May 15 18:19:11 2003
@@ -320,6 +320,9 @@
 	u8 *virt_addr = rq->buffer;
 	int sector_count = rq->nr_sectors;
 
+	if (hwif->sg_dma_active)
+		BUG();
+
 	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
 		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
 	else
@@ -581,7 +584,7 @@
 EXPORT_SYMBOL(__ide_dma_host_off);
 
 /**
- *	__ide_dma_host_off_quietly	-	Generic DMA kill
+ *	__ide_dma_off_quietly	-	Generic DMA kill
  *	@drive: drive to control
  *
  *	Turn off the current DMA on this IDE controller. 
@@ -597,7 +600,7 @@
 EXPORT_SYMBOL(__ide_dma_off_quietly);
 
 /**
- *	__ide_dma_host_off	-	Generic DMA kill
+ *	__ide_dma_off		-	Generic DMA kill
  *	@drive: drive to control
  *
  *	Turn off the current DMA on this IDE controller. Inform the
@@ -945,7 +948,7 @@
  *	__ide_dma_retune	-	default retune handler
  *	@drive: drive to retune
  *
- *	Default behaviour when we decide to return the IDE DMA setup.
+ *	Default behaviour when we decide to retune the IDE DMA setup.
  *	The default behaviour is "we don't"
  */
  

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

