Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267979AbTBRSCh>; Tue, 18 Feb 2003 13:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267986AbTBRSCR>; Tue, 18 Feb 2003 13:02:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34825 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267979AbTBRSBh>; Tue, 18 Feb 2003 13:01:37 -0500
Subject: PATCH: fix the rest of the names/ide_ioreg_t in ide legacy
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:11:56 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCDk-00069o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/macide.c linux-2.5.61-ac2/drivers/ide/legacy/macide.c
--- linux-2.5.61/drivers/ide/legacy/macide.c	2003-02-10 18:37:54.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/macide.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/macide.c -- Macintosh IDE Driver
+ *  linux/drivers/ide/legacy/macide.c -- Macintosh IDE Driver
  *
  *     Copyright (C) 1998 by Michael Schmitz
  *
@@ -98,21 +98,21 @@
 
 	switch (macintosh_config->ide_type) {
 	case MAC_IDE_QUADRA:
-		ide_setup_ports(&hw, (ide_ioreg_t)IDE_BASE, macide_offsets,
+		ide_setup_ports(&hw, IDE_BASE, macide_offsets,
 				0, 0, macide_ack_intr,
 //				quadra_ide_iops,
 				IRQ_NUBUS_F);
 		index = ide_register_hw(&hw, NULL);
 		break;
 	case MAC_IDE_PB:
-		ide_setup_ports(&hw, (ide_ioreg_t)IDE_BASE, macide_offsets,
+		ide_setup_ports(&hw, IDE_BASE, macide_offsets,
 				0, 0, macide_ack_intr,
 //				macide_pb_iops,
 				IRQ_NUBUS_C);
 		index = ide_register_hw(&hw, NULL);
 		break;
 	case MAC_IDE_BABOON:
-		ide_setup_ports(&hw, (ide_ioreg_t)BABOON_BASE, macide_offsets,
+		ide_setup_ports(&hw, BABOON_BASE, macide_offsets,
 				0, 0, NULL,
 //				macide_baboon_iops,
 				IRQ_BABOON_1);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/pdc4030.c linux-2.5.61-ac2/drivers/ide/legacy/pdc4030.c
--- linux-2.5.61/drivers/ide/legacy/pdc4030.c	2003-02-10 18:38:38.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/pdc4030.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*  -*- linux-c -*-
- *  linux/drivers/ide/pdc4030.c		Version 0.90  May 27, 1999
+ *  linux/drivers/ide/legacy/pdc4030.c		Version 0.90  May 27, 1999
  *
  *  Copyright (C) 1995-2002  Linus Torvalds & authors (see below)
  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/pdc4030.h linux-2.5.61-ac2/drivers/ide/legacy/pdc4030.h
--- linux-2.5.61/drivers/ide/legacy/pdc4030.h	2003-02-10 18:38:48.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/pdc4030.h	2003-02-17 18:54:52.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pdc4030.h
+ *  linux/drivers/ide/legacy/pdc4030.h
  *
  *  Copyright (C) 1995-1998  Linus Torvalds & authors
  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/q40ide.c linux-2.5.61-ac2/drivers/ide/legacy/q40ide.c
--- linux-2.5.61/drivers/ide/legacy/q40ide.c	2003-02-10 18:37:59.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/q40ide.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/q40ide.c -- Q40 I/O port IDE Driver
+ *  linux/drivers/ide/legacy/q40ide.c -- Q40 I/O port IDE Driver
  *
  *     (c) Richard Zidlicky
  *
@@ -82,7 +82,7 @@
     for (i = 0; i < Q40IDE_NUM_HWIFS; i++) {
 	hw_regs_t hw;
 
-	ide_setup_ports(&hw,(ide_ioreg_t) pcide_bases[i], (int *)pcide_offsets, 
+	ide_setup_ports(&hw,(unsigned long) pcide_bases[i], (int *)pcide_offsets, 
 			pcide_bases[i]+0x206, 
 			0, NULL,
 //			pcide_iops,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/qd65xx.c linux-2.5.61-ac2/drivers/ide/legacy/qd65xx.c
--- linux-2.5.61/drivers/ide/legacy/qd65xx.c	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/qd65xx.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/qd65xx.c		Version 0.07	Sep 30, 2001
+ *  linux/drivers/ide/legacy/qd65xx.c		Version 0.07	Sep 30, 2001
  *
  *  Copyright (C) 1996-2001  Linus Torvalds & author (see below)
  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/qd65xx.h linux-2.5.61-ac2/drivers/ide/legacy/qd65xx.h
--- linux-2.5.61/drivers/ide/legacy/qd65xx.h	2003-02-10 18:39:14.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/qd65xx.h	2003-02-17 18:55:15.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/qd65xx.h
+ * linux/drivers/ide/legacy/qd65xx.h
  *
  * Copyright (c) 2000	Linus Torvalds & authors
  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/umc8672.c linux-2.5.61-ac2/drivers/ide/legacy/umc8672.c
--- linux-2.5.61/drivers/ide/legacy/umc8672.c	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/umc8672.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/umc8672.c		Version 0.05	Jul 31, 1996
+ *  linux/drivers/ide/legacy/umc8672.c		Version 0.05	Jul 31, 1996
  *
  *  Copyright (C) 1995-1996  Linus Torvalds & author (see below)
  */
