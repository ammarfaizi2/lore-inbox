Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264979AbUGBVkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbUGBVkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbUGBVkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:40:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:30610 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264979AbUGBVkb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:40:31 -0400
X-Fake: the user-agent is fake
Subject: [PATCH] More PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <20040702213816.GA31384@kroah.com>
Date: Fri, 2 Jul 2004 14:39:11 -0700
Message-Id: <10888043512721@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1785, 2004/07/02 13:26:39-07:00, lxiep@us.ibm.com

[PATCH] PCI: export pci_scan_child_bus for the pci hotplug drivers to use

Signed-off-by: Linda Xie lxie@us.ibm.com
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/probe.c |    5 +++--
 include/linux/pci.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2004-07-02 14:25:00 -07:00
+++ b/drivers/pci/probe.c	2004-07-02 14:25:01 -07:00
@@ -326,7 +326,7 @@
 	return child;
 }
 
-static unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus);
+unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus);
 
 /*
  * If it's a bridge, configure it and scan the bus behind it.
@@ -694,7 +694,7 @@
 	return nr;
 }
 
-static unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
+unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
 {
 	unsigned int devfn, pass, max = bus->secondary;
 	struct pci_dev *dev;
@@ -801,4 +801,5 @@
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bridge);
 EXPORT_SYMBOL(pci_scan_single_device);
+EXPORT_SYMBOL_GPL(pci_scan_child_bus);
 #endif
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-07-02 14:25:00 -07:00
+++ b/include/linux/pci.h	2004-07-02 14:25:00 -07:00
@@ -659,6 +659,7 @@
 }
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev * pci_scan_single_device(struct pci_bus *bus, int devfn);
+unsigned int pci_scan_child_bus(struct pci_bus *bus);
 void pci_bus_add_devices(struct pci_bus *bus);
 void pci_name_device(struct pci_dev *dev);
 char *pci_class_name(u32 class);

