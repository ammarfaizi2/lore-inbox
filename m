Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbTEVVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTEVVwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:52:09 -0400
Received: from granite.he.net ([216.218.226.66]:43531 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263328AbTEVVvB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:51:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1053641161905@kroah.com>
Subject: Re: [PATCH] PCI changes for 2.5.69
In-Reply-To: <10536411602454@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 22 May 2003 15:06:01 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1212, 2003/05/22 14:31:07-07:00, greg@kroah.com

[PATCH] PCI: remove pci_insert_device() as no one uses it anymore.


 drivers/pci/hotplug.c |   21 ---------------------
 include/linux/pci.h   |    1 -
 2 files changed, 22 deletions(-)


diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Thu May 22 14:49:44 2003
+++ b/drivers/pci/hotplug.c	Thu May 22 14:49:44 2003
@@ -207,26 +207,6 @@
 
 #endif /* CONFIG_HOTPLUG */
 
-/**
- * pci_insert_device - insert a pci device
- * @dev: the device to insert
- * @bus: where to insert it
- *
- * Link the device to both the global PCI device chain and the 
- * per-bus list of devices, add the /proc entry.
- */
-void
-pci_insert_device(struct pci_dev *dev, struct pci_bus *bus)
-{
-	list_add_tail(&dev->bus_list, &bus->devices);
-	list_add_tail(&dev->global_list, &pci_devices);
-#ifdef CONFIG_PROC_FS
-	pci_proc_attach_device(dev);
-#endif
-	/* add sysfs device files */
-	pci_create_sysfs_dev_files(dev);
-}
-
 static void
 pci_free_resources(struct pci_dev *dev)
 {
@@ -300,7 +280,6 @@
 }
 
 #ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pci_insert_device);
 EXPORT_SYMBOL(pci_remove_bus_device);
 EXPORT_SYMBOL(pci_remove_behind_bridge);
 #endif
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu May 22 14:49:44 2003
+++ b/include/linux/pci.h	Thu May 22 14:49:44 2003
@@ -660,7 +660,6 @@
 /* New-style probing supporting hot-pluggable devices */
 int pci_register_driver(struct pci_driver *);
 void pci_unregister_driver(struct pci_driver *);
-void pci_insert_device(struct pci_dev *, struct pci_bus *);
 void pci_remove_bus_device(struct pci_dev *);
 void pci_remove_behind_bridge(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);

