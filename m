Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbTFECDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTFECCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:02:11 -0400
Received: from granite.he.net ([216.218.226.66]:55302 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264385AbTFECB6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:01:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787461884@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787464095@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:46 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1254.4.2, 2003/06/03 16:41:07-07:00, greg@kroah.com

[PATCH] PCI: make pci_setup_device(), pci_alloc_primary_bus() and pci_alloc_primary_bus_parented() static

No one is calling these functions.


 drivers/pci/probe.c |    5 ++---
 include/linux/pci.h |    6 ------
 2 files changed, 2 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Wed Jun  4 18:12:20 2003
+++ b/drivers/pci/probe.c	Wed Jun  4 18:12:20 2003
@@ -396,7 +396,7 @@
  * Returns 0 on success and -1 if unknown type of device (not normal, bridge
  * or CardBus).
  */
-int pci_setup_device(struct pci_dev * dev)
+static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
 
@@ -641,7 +641,7 @@
 	return 0;
 }
 
-struct pci_bus * __devinit pci_alloc_primary_bus_parented(struct device *parent, int bus)
+static struct pci_bus * __devinit pci_alloc_primary_bus_parented(struct device *parent, int bus)
 {
 	struct pci_bus *b;
 
@@ -692,7 +692,6 @@
 EXPORT_SYMBOL(pci_root_buses);
 
 #ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pci_setup_device);
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Wed Jun  4 18:12:20 2003
+++ b/include/linux/pci.h	Wed Jun  4 18:12:20 2003
@@ -546,11 +546,6 @@
 {
 	return pci_scan_bus_parented(NULL, bus, ops, sysdata);
 }
-struct pci_bus *pci_alloc_primary_bus_parented(struct device * parent, int bus);
-static inline struct pci_bus *pci_alloc_primary_bus(int bus)
-{
-	return pci_alloc_primary_bus_parented(NULL, bus);
-}
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 void pci_bus_add_devices(struct pci_bus *bus);
 int pci_proc_attach_device(struct pci_dev *dev);
@@ -561,7 +556,6 @@
 char *pci_class_name(u32 class);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev, struct resource *res);
-int pci_setup_device(struct pci_dev *dev);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 extern struct pci_dev *pci_get_dev(struct pci_dev *dev);
 extern void pci_put_dev(struct pci_dev *dev);

