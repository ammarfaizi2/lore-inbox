Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965314AbWHOJEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965314AbWHOJEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965313AbWHOJEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:04:06 -0400
Received: from server6.greatnet.de ([83.133.96.26]:63877 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S965314AbWHOJEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:04:04 -0400
Message-ID: <44E18DE2.8020700@nachtwindheim.de>
Date: Tue, 15 Aug 2006 11:03:30 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: gregkh@suse.de
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: [PATCH] Change pci_module_init from macro to inline function marked
 as deprecated
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Replaces the pci_module_init()-macro with a inline function,
which is marked as deprecated.
This gives a warning at compile time, which may be useful for driver developers who still use
pci_module_init() on 2.6 drivers.

Signed-of-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc4/include/linux/pci.h	2006-08-11 10:10:08.000000000 +0200
+++ linux/include/linux/pci.h	2006-08-11 15:04:21.000000000 +0200
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
 
@@ -547,6 +541,16 @@
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


