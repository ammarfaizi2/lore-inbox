Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTLGVcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTLGV2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:28:16 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:278 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S264542AbTLGUzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:52 -0500
Date: Sun, 7 Dec 2003 21:51:36 +0100
Message-Id: <200312072051.hB7Kpa3l000813@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 147] Amiga Buddha/CatWeasel IDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddha/CatWeasel IDE: Make sure the core IDE driver doesn't try to request the
MMIO ports a second time, since this will fail.

--- linux-2.4.23/drivers/ide/legacy/buddha.c	2003-02-27 10:15:46.000000000 +0100
+++ linux-m68k-2.4.23/drivers/ide/legacy/buddha.c	2003-12-07 10:42:43.000000000 +0100
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
