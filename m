Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUBTNMm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUBTMwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:52:43 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:41266 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261198AbUBTMsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:48:37 -0500
Date: Fri, 20 Feb 2004 13:48:21 +0100
Message-Id: <200402201248.i1KCmLcd004299@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 410] Sun-3x ESP SCSI clean up
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3x ESP SCSI: Remove obsolete cruft

--- linux-2.6.3/drivers/scsi/sun3x_esp.c	2003-07-29 18:19:12.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/sun3x_esp.c	2004-02-06 13:43:34.000000000 +0100
@@ -46,12 +46,6 @@
 static void dma_mmu_release_scsi_sgl (struct NCR_ESP *esp, Scsi_Cmnd *sp);
 static void dma_advance_sg (Scsi_Cmnd *sp);
 
-static volatile unsigned char cmd_buffer[16];
-                                /* This is where all commands are put
-                                 * before they are trasfered to the ESP chip
-                                 * via PIO.
-                                 */
-
 /* Detecting ESP chips on the machine.  This is the simple and easy
  * version.
  */
@@ -101,14 +95,8 @@
 	esp->eregs = (struct ESP_regs *)(SUN3X_ESP_BASE);
 	esp->dregs = (void *)SUN3X_ESP_DMA;
 
-#if 0
-  	esp->esp_command = (volatile unsigned char *)cmd_buffer;
- 	esp->esp_command_dvma = dvma_map((unsigned long)cmd_buffer,
- 					 sizeof (cmd_buffer));
-#else
 	esp->esp_command = (volatile unsigned char *)dvma_malloc(DVMA_PAGE_SIZE);
 	esp->esp_command_dvma = dvma_vtob((unsigned long)esp->esp_command);
-#endif
 
 	esp->irq = 2;
 	if (request_irq(esp->irq, esp_intr, SA_INTERRUPT, 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
