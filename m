Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUAAUzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUAAUzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:55:08 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:2398 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264933AbUAAUDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:48 -0500
Date: Thu, 1 Jan 2004 21:03:45 +0100
Message-Id: <200401012003.i01K3jc7031963@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 390] Amiga Buddha/CatWeasel IDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddha/CatWeasel IDE: Make sure the core IDE driver doesn't try to request the
MMIO ports a second time, since this will fail.

--- linux-2.6.0/drivers/ide/legacy/buddha.c	2003-02-25 10:21:12.000000000 +0100
+++ linux-m68k-2.6.0/drivers/ide/legacy/buddha.c	2003-12-07 10:44:56.000000000 +0100
@@ -146,6 +146,7 @@
 void __init buddha_init(void)
 {
 	hw_regs_t hw;
+	ide_hwif_t *hwif;
 	int i, index;
 
 	struct zorro_dev *z = NULL;
@@ -212,8 +213,9 @@
 						IRQ_AMIGA_PORTS);
 			}	
 			
-			index = ide_register_hw(&hw, NULL);
+			index = ide_register_hw(&hw, &hwif);
 			if (index != -1) {
+				hwif->mmio = 2;
 				printk("ide%d: ", index);
 				switch(type) {
 				case BOARD_BUDDHA:

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
