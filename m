Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267877AbTBRRsc>; Tue, 18 Feb 2003 12:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267902AbTBRRsc>; Tue, 18 Feb 2003 12:48:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16649 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267877AbTBRRri>; Tue, 18 Feb 2003 12:47:38 -0500
Subject: PATCH: eliminate use of ide_ioreg_t on ARM
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 17:58:00 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lC0G-00066d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/arm/icside.c linux-2.5.61-ac2/drivers/ide/arm/icside.c
--- linux-2.5.61/drivers/ide/arm/icside.c	2003-02-10 18:38:38.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/arm/icside.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/icside.c
+ * linux/drivers/ide/arm/icside.c
  *
  * Copyright (c) 1996-2002 Russell King.
  *
@@ -813,7 +813,7 @@
 
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		hwif = &ide_hwifs[index];
-		if (hwif->io_ports[IDE_DATA_OFFSET] == (ide_ioreg_t)dataport)
+		if (hwif->io_ports[IDE_DATA_OFFSET] == dataport)
 			goto found;
 	}
 
@@ -841,8 +841,8 @@
 		memset(&hwif->hw, 0, sizeof(hw_regs_t));
 
 		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-			hwif->hw.io_ports[i] = (ide_ioreg_t)port;
-			hwif->io_ports[i] = (ide_ioreg_t)port;
+			hwif->hw.io_ports[i] = port;
+			hwif->io_ports[i] = port;
 			port += 1 << info->stepping;
 		}
 		hwif->hw.io_ports[IDE_CONTROL_OFFSET] = base + info->ctrloffset;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/arm/rapide.c linux-2.5.61-ac2/drivers/ide/arm/rapide.c
--- linux-2.5.61/drivers/ide/arm/rapide.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/arm/rapide.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/rapide.c
+ * linux/drivers/ide/arm/rapide.c
  *
  * Copyright (c) 1996-2002 Russell King.
  */
@@ -25,7 +25,7 @@
 	memset(&hw, 0, sizeof(hw));
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw.io_ports[i] = (ide_ioreg_t)port;
+		hw.io_ports[i] = port;
 		port += 1 << 4;
 	}
 	hw.io_ports[IDE_CONTROL_OFFSET] = port + 0x206;
