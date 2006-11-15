Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030638AbWKOQQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030638AbWKOQQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030639AbWKOQQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:16:42 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14268 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030638AbWKOQQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:16:41 -0500
Date: Wed, 15 Nov 2006 16:21:30 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com, akpm@osdl.org
Subject: [PATCH] pci: Move PCI_VDEVICE from libata to core
Message-ID: <20061115162130.3c1e127f@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated diff which doesn't move the comment as per Jeff's request and
corrects the docs as per report on l/k

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/include/linux/libata.h linux-2.6.19-rc5-mm2/include/linux/libata.h
--- linux.vanilla-2.6.19-rc5-mm2/include/linux/libata.h	2006-11-15 13:27:03.000000000 +0000
+++ linux-2.6.19-rc5-mm2/include/linux/libata.h	2006-11-15 13:53:54.000000000 +0000
@@ -110,10 +110,6 @@
 #define ATA_TAG_POISON		0xfafbfcfdU
 
 /* move to PCI layer? */
-#define PCI_VDEVICE(vendor, device)		\
-	PCI_VENDOR_ID_##vendor, (device),	\
-	PCI_ANY_ID, PCI_ANY_ID, 0, 0
-
 static inline struct device *pci_dev_to_dev(struct pci_dev *pdev)
 {
 	return &pdev->dev;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/include/linux/pci.h linux-2.6.19-rc5-mm2/include/linux/pci.h
--- linux.vanilla-2.6.19-rc5-mm2/include/linux/pci.h	2006-11-15 13:27:03.000000000 +0000
+++ linux-2.6.19-rc5-mm2/include/linux/pci.h	2006-11-15 13:53:30.000000000 +0000
@@ -389,6 +389,21 @@
 	.vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
+/**
+ * PCI_VDEVICE - macro used to describe a specific pci device in short form
+ * @vendor: the vendor name
+ * @device: the 16 bit PCI Device ID
+ *
+ * This macro is used to create a struct pci_device_id that matches a
+ * specific PCI device.  The subvendor, and subdevice fields will be set
+ * to PCI_ANY_ID. The macro allows the next field to follow as the device
+ * private data.
+ */
+ 
+#define PCI_VDEVICE(vendor, device)		\
+	PCI_VENDOR_ID_##vendor, (device),	\
+	PCI_ANY_ID, PCI_ANY_ID, 0, 0
+
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
