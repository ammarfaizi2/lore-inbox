Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932910AbWKQOVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbWKQOVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWKQOVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:21:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62479 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932910AbWKQOVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:21:47 -0500
Date: Fri, 17 Nov 2006 15:21:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@redhat.com>
Subject: [-mm patch] remove drivers/pci/search.c:pci_find_device_reverse()
Message-ID: <20061117142145.GX31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the no longer used pci_find_device_reverse().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pci/search.c |   38 --------------------------------------
 include/linux/pci.h  |    1 -
 2 files changed, 39 deletions(-)

--- linux-2.6.19-rc5-mm2/include/linux/pci.h.old	2006-11-17 13:52:21.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/linux/pci.h	2006-11-17 13:52:30.000000000 +0100
@@ -442,7 +442,6 @@
 /* Generic PCI functions exported to card drivers */
 
 struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
-struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
 int pci_find_next_capability (struct pci_dev *dev, u8 pos, int cap);
--- linux-2.6.19-rc5-mm2/drivers/pci/search.c.old	2006-11-17 13:52:38.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/pci/search.c	2006-11-17 13:52:52.000000000 +0100
@@ -340,43 +340,6 @@
 }
 
 /**
- * pci_find_device_reverse - begin or continue searching for a PCI device by vendor/device id
- * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
- * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
- * @from: Previous PCI device found in search, or %NULL for new search.
- *
- * Iterates through the list of known PCI devices in the reverse order of
- * pci_find_device().
- * If a PCI device is found with a matching @vendor and @device, a pointer to
- * its device structure is returned.  Otherwise, %NULL is returned.
- * A new search is initiated by passing %NULL as the @from argument.
- * Otherwise if @from is not %NULL, searches continue from previous device
- * on the global list.
- */
-struct pci_dev *
-pci_find_device_reverse(unsigned int vendor, unsigned int device, const struct pci_dev *from)
-{
-	struct list_head *n;
-	struct pci_dev *dev;
-
-	WARN_ON(in_interrupt());
-	down_read(&pci_bus_sem);
-	n = from ? from->global_list.prev : pci_devices.prev;
-
-	while (n && (n != &pci_devices)) {
-		dev = pci_dev_g(n);
-		if ((vendor == PCI_ANY_ID || dev->vendor == vendor) &&
-		    (device == PCI_ANY_ID || dev->device == device))
-			goto exit;
-		n = n->prev;
-	}
-	dev = NULL;
-exit:
-	up_read(&pci_bus_sem);
-	return dev;
-}
-
-/**
  * pci_get_class - begin or continue searching for a PCI device by class
  * @class: search for a PCI device with this class designation
  * @from: Previous PCI device found in search, or %NULL for new search.
@@ -447,7 +410,6 @@
 EXPORT_SYMBOL(pci_dev_present);
 
 EXPORT_SYMBOL(pci_find_device);
-EXPORT_SYMBOL(pci_find_device_reverse);
 EXPORT_SYMBOL(pci_find_slot);
 /* For boot time work */
 EXPORT_SYMBOL(pci_find_bus);

