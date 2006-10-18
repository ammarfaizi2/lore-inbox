Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWJRRYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWJRRYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWJRRYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:24:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59792 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422725AbWJRRYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:24:53 -0400
Subject: [PATCH] pata_marvell: switch to pci_iomap as Jeff asked
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 18:25:57 +0100
Message-Id: <1161192357.9363.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/drivers/ata/pata_marvell.c linux-2.6.19-rc2-mm1/drivers/ata/pata_marvell.c
--- linux.vanilla-2.6.19-rc2-mm1/drivers/ata/pata_marvell.c	2006-10-18 13:51:02.000000000 +0100
+++ linux-2.6.19-rc2-mm1/drivers/ata/pata_marvell.c	2006-10-18 13:56:55.000000000 +0100
@@ -20,7 +20,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_marvell"
-#define DRV_VERSION	"0.0.4t"
+#define DRV_VERSION	"0.0.5t"
 
 /**
  *	marvell_pre_reset	-	check for 40/80 pin
@@ -39,18 +39,17 @@
 
 	/* Check if our port is enabled */
 
-	bar5 = pci_resource_start(pdev, 5);
-	barp = ioremap(bar5, 0x10);
+	barp = pci_ioremap(pdev, 5, 0x10);
 	if (barp == NULL)
 		return -ENOMEM;
 	printk("BAR5:");
 	for(i = 0; i <= 0x0F; i++)
 		printk("%02X:%02X ", i, readb(barp + i));
 	printk("\n");
-
+	
 	devices = readl(barp + 0x0C);
-	iounmap(barp);
-
+	pci_iounmap(pdev, barp);
+	
 	if (pdev->device == 0x6145 && ap->port_no == 0 && !(devices & 0x10))	/* PATA enable ? */
 		return -ENOENT;
 

