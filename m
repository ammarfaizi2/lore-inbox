Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270120AbUJSXQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270120AbUJSXQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270114AbUJSXM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:12:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:24202 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270179AbUJSWqp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:45 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225739969@kroah.com>
Date: Tue, 19 Oct 2004 15:42:19 -0700
Message-Id: <1098225739230@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.62, 2004/10/06 14:08:21-07:00, greg@kroah.com

[PATCH] PCI: pci_module_init() is identical to pci_register_driver() so just make it a #define

It needs to stay this way until all usages of pci_module_init() are purged
from the tree.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci.h |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:21:49 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:21:49 -07:00
@@ -674,6 +674,12 @@
 	.vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
+/* 
+ * pci_module_init is obsolete, this stays here till we fix up all usages of it
+ * in the tree.
+ */
+#define pci_module_init	pci_register_driver
+
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
@@ -894,7 +900,6 @@
 static inline void pci_set_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
-static inline int pci_module_init(struct pci_driver *drv) { return -ENODEV; }
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
@@ -913,19 +918,6 @@
 #define	isa_bridge	((struct pci_dev *)NULL)
 
 #else
-
-/*
- * a helper function which helps ensure correct pci_driver
- * setup and cleanup for commonly-encountered hotplug/modular cases
- *
- * This MUST stay in a header, as it checks for -DMODULE
- */
-static inline int pci_module_init(struct pci_driver *drv)
-{
-	int rc = pci_register_driver (drv);
-
-	return rc < 0 ? rc : 0;
-}
 
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),

