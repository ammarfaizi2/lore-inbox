Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWIYTPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWIYTPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 15:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWIYTPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 15:15:48 -0400
Received: from server6.greatnet.de ([83.133.96.26]:47066 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751511AbWIYTPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 15:15:47 -0400
Message-ID: <45182AF2.30201@nachtwindheim.de>
Date: Mon, 25 Sep 2006 21:16:02 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: mark pci_module_init() as deprecated 2nd try
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Since nearly all pci_module_init()'s are removed from the tree (19 left), heres the patch for
2.6.18-git4.

In the mm-patchset it's called:
mark-pci_module_init-deprecated.patch
and can be removed if acked by greg.

Greets,
Henne

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes the pci_module_init macro into a deprecated inline function.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6/include/linux/pci.h	2006-08-01 01:31:59.000000000 +0200
+++ linux-2.6.18-git4/include/linux/pci.h	2006-09-25 21:01:47.000000000 +0200
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


