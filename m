Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWIONyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWIONyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWIONyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:54:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44196 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751480AbWIONyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:54:24 -0400
Subject: [PATCH] sis5513: Switch to pci refcounting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:18:07 +0100
Message-Id: <1158329887.29932.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mirrors the drivers/ata version, hold a reference to the host bridge
while we are doing setup.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/sis5513.c linux-2.6.18-rc6-mm1/drivers/ide/pci/sis5513.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/sis5513.c	2006-09-11 17:00:09.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/ide/pci/sis5513.c	2006-09-14 17:19:58.000000000 +0100
@@ -739,7 +739,7 @@
 
 	for (i = 0; i < ARRAY_SIZE(SiSHostChipInfo) && !chipset_family; i++) {
 
-		host = pci_find_device(PCI_VENDOR_ID_SI, SiSHostChipInfo[i].host_id, NULL);
+		host = pci_get_device(PCI_VENDOR_ID_SI, SiSHostChipInfo[i].host_id, NULL);
 
 		if (!host)
 			continue;
@@ -753,6 +753,7 @@
 			if (hostrev >= 0x30)
 				chipset_family = ATA_100a;
 		}
+		pci_dev_put(host);
 	
 		printk(KERN_INFO "SIS5513: %s %s controller\n",
 			 SiSHostChipInfo[i].name, chipset_capability[chipset_family]);

