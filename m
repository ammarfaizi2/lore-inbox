Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWIDNnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWIDNnA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWIDNnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:43:00 -0400
Received: from server6.greatnet.de ([83.133.96.26]:28382 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751384AbWIDNm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:42:59 -0400
Message-ID: <44FC2D94.7050503@nachtwindheim.de>
Date: Mon, 04 Sep 2006 15:43:48 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] 9/10 pci_module_init() convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

This changes the pci_module_init macro into a static inline function,
which is marked as deprecated.
For use on mm only. 
At this time there are only 3 drivers with pci_module_init() in the mm tree
and this patch should help developers of new drivers to use
pci_register_driver() when their driver is tested in mm.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/include/linux/pci.h	2006-09-04 15:33:23.000000000 +0200
+++ linux/include/linux/pci.h	2006-09-04 15:33:35.000000000 +0200
@@ -384,12 +384,6 @@
 	.vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
-/*
- * pci_module_init is obsolete, this stays here till we fix up all usages of it
- * in the tree.
- */
-#define pci_module_init	pci_register_driver
-
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
@@ -549,6 +543,16 @@
 	return __pci_register_driver(driver, THIS_MODULE);
 }
 
+/*
+ * pci_module_init is obsolete, this stays here till we fix up all usages of it
+ * in the tree.
+ */
+
+static inline int __deprecated pci_module_init(struct pci_driver* drv)
+{
+	return pci_register_driver(drv);
+}
+
 void pci_unregister_driver(struct pci_driver *);
 void pci_remove_behind_bridge(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);


