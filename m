Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTLGVcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTLGV2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:28:24 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:6236 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264544AbTLGUzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:53 -0500
Date: Sun, 7 Dec 2003 21:51:32 +0100
Message-Id: <200312072051.hB7KpWv5000789@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 143] NCR53C9x SCSI inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NCR53C9x SCSI: Kill bogus inline

--- linux-2.4.23/drivers/scsi/NCR53C9x.h	2001-09-25 10:15:03.000000000 +0200
+++ linux-m68k-2.4.23/drivers/scsi/NCR53C9x.h	2003-11-30 12:51:50.000000000 +0100
@@ -639,8 +639,7 @@
 
 
 /* External functions */
-extern inline void esp_cmd(struct NCR_ESP *esp, struct ESP_regs *eregs,
-			   unchar cmd);
+extern void esp_cmd(struct NCR_ESP *esp, struct ESP_regs *eregs, unchar cmd);
 extern struct NCR_ESP *esp_allocate(Scsi_Host_Template *, void *);
 extern void esp_deallocate(struct NCR_ESP *);
 extern void esp_release(void);
--- linux-2.4.23/drivers/scsi/mac_esp.c	2003-10-20 23:16:45.000000000 +0200
+++ linux-m68k-2.4.23/drivers/scsi/mac_esp.c	2003-11-23 22:17:06.000000000 +0100
@@ -44,7 +44,7 @@
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
