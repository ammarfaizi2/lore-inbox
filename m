Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWFZNft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWFZNft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWFZNft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:35:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35204 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964847AbWFZNfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:35:48 -0400
Subject: PATCH: SC1200 debug printk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 14:51:45 +0100
Message-Id: <1151329905.27147.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill a pair of long escaped debug printk calls

Signed-off-by: Alan Cox <alan@redhat.com>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/sc1200.c linux-2.6.17/drivers/ide/pci/sc1200.c
--- linux.vanilla-2.6.17/drivers/ide/pci/sc1200.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/sc1200.c	2006-06-26 13:27:45.671877280 +0100
@@ -395,7 +395,6 @@
 {
 	ide_hwif_t	*hwif = NULL;
 
-printk("SC1200: resume\n");
 	pci_set_power_state(dev, PCI_D0);	// bring chip back from sleep state
 	dev->current_state = PM_EVENT_ON;
 	pci_enable_device(dev);
@@ -405,7 +404,6 @@
 	while ((hwif = lookup_pci_dev(hwif, dev)) != NULL) {
 		unsigned int		basereg, r, d, format;
 		sc1200_saved_state_t	*ss = (sc1200_saved_state_t *)hwif->config_data;
-printk("%s: SC1200: resume\n", hwif->name);
 
 		//
 		// Restore timing registers:  this may be unnecessary if BIOS also does it
@@ -493,7 +491,7 @@
 }
 
 static struct pci_device_id sc1200_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE), 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sc1200_pci_tbl);

