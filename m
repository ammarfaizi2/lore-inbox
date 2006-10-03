Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030669AbWJCXRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030669AbWJCXRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbWJCXRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:17:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10946 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030669AbWJCXRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:17:39 -0400
Subject: [PATCH] quirks: switch quirks code offender to use pci_get API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 00:43:06 +0100
Message-Id: <1159918986.17553.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/pci/quirks.c linux-2.6.18-mm3/drivers/pci/quirks.c
--- linux.vanilla-2.6.18-mm3/drivers/pci/quirks.c	2006-10-03 19:23:10.043227664 +0100
+++ linux-2.6.18-mm3/drivers/pci/quirks.c	2006-10-03 23:31:40.653470360 +0100
@@ -1840,7 +1787,7 @@
 	/* check HT MSI cap on this chipset and the root one.
 	 * a single one having MSI is enough to be sure that MSI are supported.
 	 */
-	pdev = pci_find_slot(dev->bus->number, 0);
+	pdev = pci_get_slot(dev->bus, 0);
 	if (dev->subordinate && !msi_ht_cap_enabled(dev)
 	    && !msi_ht_cap_enabled(pdev)) {
 		printk(KERN_WARNING "PCI: MSI quirk detected. "
@@ -1848,6 +1795,7 @@
 		       pci_name(dev));
 		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 	}
+	pci_dev_put(pdev);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 			quirk_nvidia_ck804_msi_ht_cap);

