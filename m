Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTFJVgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTFJVgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:36:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39836 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263786AbTFJShH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709662296@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709662961@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1340, 2003/06/09 15:50:31-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/saa9730.c


 drivers/net/saa9730.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)


diff -Nru a/drivers/net/saa9730.c b/drivers/net/saa9730.c
--- a/drivers/net/saa9730.c	Tue Jun 10 11:20:50 2003
+++ b/drivers/net/saa9730.c	Tue Jun 10 11:20:50 2003
@@ -1050,31 +1050,30 @@
 static int __init saa9730_probe(void)
 {
 	struct net_device *dev = NULL;
+	struct pci_dev *pdev = NULL;
 
-	if (pci_present()) {
-		struct pci_dev *pdev = NULL;
-		if (lan_saa9730_debug > 1)
-			printk
-			    ("saa9730.c: PCI bios is present, checking for devices...\n");
+	if (lan_saa9730_debug > 1)
+		printk
+		    ("saa9730.c: PCI bios is present, checking for devices...\n");
 
-		while ((pdev = pci_find_device(PCI_VENDOR_ID_PHILIPS,
-					       PCI_DEVICE_ID_PHILIPS_SAA9730,
-					       pdev))) {
-			unsigned int pci_ioaddr;
+	while ((pdev = pci_find_device(PCI_VENDOR_ID_PHILIPS,
+				       PCI_DEVICE_ID_PHILIPS_SAA9730,
+				       pdev))) {
+		unsigned int pci_ioaddr;
 
-			pci_irq_line = pdev->irq;
-			/* LAN base address in located at BAR 1. */
+		pci_irq_line = pdev->irq;
+		/* LAN base address in located at BAR 1. */
 
-			pci_ioaddr = pci_resource_start(pdev, 1);
-			pci_set_master(pdev);
+		pci_ioaddr = pci_resource_start(pdev, 1);
+		pci_set_master(pdev);
 
-			printk("Found SAA9730 (PCI) at %#x, irq %d.\n",
-			       pci_ioaddr, pci_irq_line);
-			if (!lan_saa9730_init
-			    (dev, pci_ioaddr, pci_irq_line)) return 0;
-			else
-				printk("Lan init failed.\n");
-		}
+		printk("Found SAA9730 (PCI) at %#x, irq %d.\n",
+		       pci_ioaddr, pci_irq_line);
+		if (!lan_saa9730_init
+		    (dev, pci_ioaddr, pci_irq_line))
+			return 0;
+		else
+			printk("Lan init failed.\n");
 	}
 
 	return -ENODEV;

