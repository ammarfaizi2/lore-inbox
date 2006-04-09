Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWDISHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWDISHu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 14:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWDISHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 14:07:50 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:53265 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750835AbWDISHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 14:07:49 -0400
Date: Sun, 9 Apr 2006 20:07:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] PCI: Use new PCI_CLASS_SERIAL_USB_* defines
Message-Id: <20060409200735.822a1c30.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We could use the recently added PCI_CLASS_SERIAL_USB_UHCI,
PCI_CLASS_SERIAL_USB_OHCI and PCI_CLASS_SERIAL_USB_EHCI defines in
more places, for slightly shorter and clearer code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 arch/powerpc/platforms/powermac/pci.c |    2 +-
 drivers/usb/host/ehci-pci.c           |    2 +-
 drivers/usb/host/ohci-pci.c           |    2 +-
 drivers/usb/host/uhci-hcd.c           |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/powermac/pci.c	2006-04-03 20:12:30.000000000 +0200
+++ linux-2.6.17-rc1/arch/powerpc/platforms/powermac/pci.c	2006-04-09 19:12:07.000000000 +0200
@@ -1097,7 +1097,7 @@
 	 * (iBook second controller)
 	 */
 	if (dev->vendor == PCI_VENDOR_ID_APPLE
-	    && (dev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x10))
+	    && dev->class == PCI_CLASS_SERIAL_USB_OHCI
 	    && !node) {
 		printk(KERN_INFO "Apple USB OHCI %s disabled by firmware\n",
 		       pci_name(dev));
--- linux-2.6.17-rc1.orig/drivers/usb/host/ehci-pci.c	2006-04-03 20:13:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/usb/host/ehci-pci.c	2006-04-09 19:12:44.000000000 +0200
@@ -350,7 +350,7 @@
 /* PCI driver selection metadata; PCI hotplugging uses this */
 static const struct pci_device_id pci_ids [] = { {
 	/* handle any USB 2.0 EHCI controller */
-	PCI_DEVICE_CLASS(((PCI_CLASS_SERIAL_USB << 8) | 0x20), ~0),
+	PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_EHCI, ~0),
 	.driver_data =	(unsigned long) &ehci_pci_hc_driver,
 	},
 	{ /* end: all zeroes */ }
--- linux-2.6.17-rc1.orig/drivers/usb/host/ohci-pci.c	2006-04-03 20:13:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/usb/host/ohci-pci.c	2006-04-09 19:12:27.000000000 +0200
@@ -206,7 +206,7 @@
 
 static const struct pci_device_id pci_ids [] = { {
 	/* handle any USB OHCI controller */
-	PCI_DEVICE_CLASS((PCI_CLASS_SERIAL_USB << 8) | 0x10, ~0),
+	PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_OHCI, ~0),
 	.driver_data =	(unsigned long) &ohci_pci_hc_driver,
 	}, { /* end: all zeroes */ }
 };
--- linux-2.6.17-rc1.orig/drivers/usb/host/uhci-hcd.c	2006-04-03 20:13:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/usb/host/uhci-hcd.c	2006-04-09 19:10:16.000000000 +0200
@@ -861,7 +861,7 @@
 
 static const struct pci_device_id uhci_pci_ids[] = { {
 	/* handle any USB UHCI controller */
-	PCI_DEVICE_CLASS(((PCI_CLASS_SERIAL_USB << 8) | 0x00), ~0),
+	PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_UHCI, ~0),
 	.driver_data =	(unsigned long) &uhci_driver,
 	}, { /* end: all zeroes */ }
 };


-- 
Jean Delvare
