Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUAAUuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUAAUti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:49:38 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:16933 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264922AbUAAUDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:39 -0500
Date: Thu, 1 Jan 2004 21:03:36 +0100
Message-Id: <200401012003.i01K3aVj031938@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 384] NCR53C9x SCSI inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NCR53C9x SCSI: Kill bogus inline

--- linux-2.6.0/drivers/scsi/NCR53C9x.h	2003-06-15 09:38:35.000000000 +0200
+++ linux-m68k-2.6.0/drivers/scsi/NCR53C9x.h	2003-11-23 21:05:59.000000000 +0100
@@ -652,8 +652,7 @@
 
 
 /* External functions */
-extern inline void esp_cmd(struct NCR_ESP *esp, struct ESP_regs *eregs,
-			   unchar cmd);
+extern void esp_cmd(struct NCR_ESP *esp, struct ESP_regs *eregs, unchar cmd);
 extern struct NCR_ESP *esp_allocate(Scsi_Host_Template *, void *);
 extern void esp_deallocate(struct NCR_ESP *);
 extern void esp_release(void);
--- linux-2.6.0/drivers/scsi/mac_esp.c	2003-10-20 23:12:46.000000000 +0200
+++ linux-m68k-2.6.0/drivers/scsi/mac_esp.c	2003-11-23 21:07:26.000000000 +0100
@@ -46,7 +46,7 @@
 #define mac_turnon_irq(x)	mac_enable_irq(x)
 #define mac_turnoff_irq(x)	mac_disable_irq(x)
 
-extern inline void esp_handle(struct NCR_ESP *esp);
+extern void esp_handle(struct NCR_ESP *esp);
 extern void mac_esp_intr(int irq, void *dev_id, struct pt_regs *pregs);
 
 static int  dma_bytes_sent(struct NCR_ESP * esp, int fifo_count);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
