Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbTI2Ii4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbTI2Ih7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:37:59 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:28760 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262887AbTI2Ihu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:37:50 -0400
Date: Mon, 29 Sep 2003 10:39:07 +0200
Message-Id: <200309290839.h8T8d7rR003670@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 301] Sun-3 SCSI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3 SCSI updates (from Sam Creasey):
  - Define sun3scsi_release() in sun3_scsi and sun3_scsi_vme so that the
    drivers will actually be loaded by the SCSI subsystem.
  - Remove some warnings.

--- linux-2.6.0-test6/drivers/scsi/sun3_scsi.c	Tue Jul 29 18:19:12 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/sun3_scsi.c	Mon Sep  1 13:50:47 2003
@@ -308,7 +308,6 @@
 	return 1;
 }
 
-#ifdef MODULE
 int sun3scsi_release (struct Scsi_Host *shpnt)
 {
 	if (shpnt->irq != SCSI_IRQ_NONE)
@@ -318,7 +317,6 @@
 
 	return 0;
 }
-#endif
 
 #ifdef RESET_BOOT
 /*
--- linux-2.6.0-test6/drivers/scsi/sun3_scsi.h	Tue Sep  9 10:13:08 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/sun3_scsi.h	Tue Sep  9 14:57:07 2003
@@ -52,11 +52,7 @@
 static const char *sun3scsi_info (struct Scsi_Host *);
 static int sun3scsi_bus_reset(Scsi_Cmnd *);
 static int sun3scsi_queue_command (Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-#ifdef MODULE
 static int sun3scsi_release (struct Scsi_Host *);
-#else
-#define sun3scsi_release NULL
-#endif
 
 #ifndef CMD_PER_LUN
 #define CMD_PER_LUN 2
--- linux-2.6.0-test6/drivers/scsi/sun3_scsi_vme.c	Tue Jul 29 18:19:12 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/sun3_scsi_vme.c	Mon Sep  1 13:50:47 2003
@@ -140,7 +140,7 @@
  
 static int sun3scsi_detect(Scsi_Host_Template * tpnt)
 {
-	unsigned long ioaddr, irq;
+	unsigned long ioaddr, irq = 0;
 	static int called = 0;
 	struct Scsi_Host *instance;
 	int i;
@@ -277,17 +277,15 @@
 	return 1;
 }
 
-#ifdef MODULE
 int sun3scsi_release (struct Scsi_Host *shpnt)
 {
 	if (shpnt->irq != SCSI_IRQ_NONE)
 		free_irq (shpnt->irq, NULL);
 
-	iounmap(sun3_scsi_regp);
+	iounmap((void *)sun3_scsi_regp);
 
 	return 0;
 }
-#endif
 
 #ifdef RESET_BOOT
 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
