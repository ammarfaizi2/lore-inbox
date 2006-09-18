Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWIRWr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWIRWr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWIRWr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:47:28 -0400
Received: from av2.karneval.cz ([81.27.192.122]:6427 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1751958AbWIRWr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:47:27 -0400
Message-id: <91292912129122wcf1@karneval.cz>
Subject: [PATCH 2/4] pmc551 remove unnecessary braces
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Mark Ferrell <mferrell@mvista.com>
Cc: <linux-mtd@lists.infradead.org>
Date: Tue, 19 Sep 2006 00:47:24 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pmc551 remove unnecessary braces

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit f562d858f77d4a83f55cf7fa962cd4dbef3eb0d6
tree 4d9c7f60eb2fc8c4f708953d77c11113dcbc7489
parent 60ab613754650ef2972b3d35ac155e6b154046c6
author Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 00:31:58 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 00:31:58 +0200

 drivers/mtd/devices/pmc551.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
index 6d4d5a4..0ee22ca 100644
--- a/drivers/mtd/devices/pmc551.c
+++ b/drivers/mtd/devices/pmc551.c
@@ -137,11 +137,11 @@ #endif
 
 	pmc551_point(mtd, instr->addr, instr->len, &retlen, &ptr);
 
-	if (soff_hi == eoff_hi || mtd->size == priv->asize) {
+	if (soff_hi == eoff_hi || mtd->size == priv->asize)
 		/* The whole thing fits within one access, so just one shot
 		   will do it. */
 		memset(ptr, 0xff, instr->len);
-	} else {
+	else {
 		/* We have to do multiple writes to get all the data
 		   written. */
 		while (soff_hi != eoff_hi) {
@@ -366,9 +366,8 @@ #endif
 	u8 bcmd, counter;
 
 	/* Sanity Check */
-	if (!dev) {
+	if (!dev)
 		return -ENODEV;
-	}
 
 	/*
 	 * Attempt to reset the card
@@ -383,14 +382,12 @@ #endif
 	for (i = 0; i < 10; i++) {
 		counter = 0;
 		bcmd &= ~0x80;
-		while (counter++ < 100) {
+		while (counter++ < 100)
 			pci_write_config_byte(dev, PMC551_SYS_CTRL_REG, bcmd);
-		}
 		counter = 0;
 		bcmd |= 0x80;
-		while (counter++ < 100) {
+		while (counter++ < 100)
 			pci_write_config_byte(dev, PMC551_SYS_CTRL_REG, bcmd);
-		}
 	}
 	bcmd |= (0x40 | 0x20);
 	pci_write_config_byte(dev, PMC551_SYS_CTRL_REG, bcmd);
@@ -461,14 +458,12 @@ #else
 	/*
 	 * Oops .. something went wrong
 	 */
-	if ((size &= PCI_BASE_ADDRESS_MEM_MASK) == 0) {
+	if ((size &= PCI_BASE_ADDRESS_MEM_MASK) == 0)
 		return -ENODEV;
-	}
 #endif				/* CONFIG_MTD_PMC551_BUGFIX */
 
-	if ((cfg & PCI_BASE_ADDRESS_SPACE) != PCI_BASE_ADDRESS_SPACE_MEMORY) {
+	if ((cfg & PCI_BASE_ADDRESS_SPACE) != PCI_BASE_ADDRESS_SPACE_MEMORY)
 		return -ENODEV;
-	}
 
 	/*
 	 * Precharge Dram
@@ -700,9 +695,8 @@ static int __init init_pmc551(void)
 
 		if ((PCI_Device = pci_find_device(PCI_VENDOR_ID_V3_SEMI,
 						  PCI_DEVICE_ID_V3_SEMI_V370PDC,
-						  PCI_Device)) == NULL) {
+						  PCI_Device)) == NULL)
 			break;
-		}
 
 		printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%llx\n",
 			(unsigned long long)PCI_Device->resource[0].start);
@@ -728,9 +722,8 @@ static int __init init_pmc551(void)
 			length = msize;
 			printk(KERN_NOTICE "pmc551: Using specified memory "
 				"size 0x%x\n", length);
-		} else {
+		} else
 			msize = length;
-		}
 
 		mtd = kmalloc(sizeof(struct mtd_info), GFP_KERNEL);
 		if (!mtd) {
@@ -829,10 +822,10 @@ #endif
 	if (!pmc551list) {
 		printk(KERN_NOTICE "pmc551: not detected\n");
 		return -ENODEV;
-	} else {
-		printk(KERN_NOTICE "pmc551: %d pmc551 devices loaded\n", found);
-		return 0;
 	}
+
+	printk(KERN_NOTICE "pmc551: %d pmc551 devices loaded\n", found);
+	return 0;
 }
 
 /*
