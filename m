Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268016AbTBRSY1>; Tue, 18 Feb 2003 13:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268015AbTBRSXZ>; Tue, 18 Feb 2003 13:23:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55561 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268011AbTBRSWk>; Tue, 18 Feb 2003 13:22:40 -0500
Subject: PATCH: fix some escaped globals
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:33:02 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCYA-0006Du-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/cy82c693.c linux-2.5.61-ac2/drivers/ide/pci/cy82c693.c
--- linux-2.5.61/drivers/ide/pci/cy82c693.c	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/cy82c693.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/cy82c693.c		Version 0.40	Sep. 10, 2002
+ * linux/drivers/ide/pci/cy82c693.c		Version 0.40	Sep. 10, 2002
  *
  *  Copyright (C) 1998-2000 Andreas S. Krebs (akrebs@altavista.net), Maintainer
  *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integrater
@@ -335,7 +335,7 @@
 /*
  * this function is called during init and is used to setup the cy82c693 chip
  */
-unsigned int __init init_chipset_cy82c693(struct pci_dev *dev, const char *name)
+static unsigned int __init init_chipset_cy82c693(struct pci_dev *dev, const char *name)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
 		return 0;
@@ -387,7 +387,7 @@
 /*
  * the init function - called for each ide channel once
  */
-void __init init_hwif_cy82c693(ide_hwif_t *hwif)
+static void __init init_hwif_cy82c693(ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/cy82c693.h linux-2.5.61-ac2/drivers/ide/pci/cy82c693.h
--- linux-2.5.61/drivers/ide/pci/cy82c693.h	2003-02-10 18:38:15.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/cy82c693.h	2003-02-17 18:57:51.000000000 +0000
@@ -64,9 +64,9 @@
 	u8	time_8;		/* clocks for 8bit (0xF0=Active/data, 0x0F=Recovery) */
 } pio_clocks_t;
 
-extern unsigned int init_chipset_cy82c693(struct pci_dev *, const char *);
-extern void init_hwif_cy82c693(ide_hwif_t *);
-extern void init_iops_cy82c693(ide_hwif_t *);
+static unsigned int init_chipset_cy82c693(struct pci_dev *, const char *);
+static void init_hwif_cy82c693(ide_hwif_t *);
+static void init_iops_cy82c693(ide_hwif_t *);
 
 static ide_pci_device_t cy82c693_chipsets[] __devinitdata = {
 	{	/* 0 */
