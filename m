Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVJZUzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVJZUzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVJZUzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:55:03 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:3532 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S964927AbVJZUyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:54:43 -0400
X-Mailbox-Line: From laurent@antares.localdomain mer oct 26 22:49:10 2005
Message-Id: <20051026204909.995658000@antares.localdomain>
References: <20051026204802.123045000@antares.localdomain>
Date: Wed, 26 Oct 2005 22:48:05 +0200
From: Laurent riffard <laurent.riffard@free.fr>
To: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [RFC patch 3/3] remove pci_driver.owner and .name fields
Content-Disposition: inline; filename=remove_pci_driver_owner_name-final_cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the final cleanup : deletion of pci_driver.name and .owner
happens now. 

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/pci/pci-driver.c |    5 -----
 include/linux/pci.h      |    8 --------
 2 files changed, 13 deletions(-)

Index: linux-2.6-stable/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6-stable.orig/drivers/pci/pci-driver.c
+++ linux-2.6-stable/drivers/pci/pci-driver.c
@@ -339,11 +339,6 @@
 	int error;
 
 	/* initialize common driver fields */
-	if (drv->name) {
-		/* backward compatibility until all pci_driver are converted to
-		 * use pci_driver.driver.name instead of pci_driver.name */
-		drv->driver.name = drv->name;
-	}
 	drv->driver.bus = &pci_bus_type;
 	drv->driver.probe = pci_device_probe;
 	drv->driver.remove = pci_device_remove;
Index: linux-2.6-stable/include/linux/pci.h
===================================================================
--- linux-2.6-stable.orig/include/linux/pci.h
+++ linux-2.6-stable/include/linux/pci.h
@@ -664,14 +664,6 @@
 struct module;
 struct pci_driver {
 	struct list_head node;
-	/*
-	 * Please do not use the 2 following fields, they are planned for
-	 * deletion.
-	 * Use driver.name instead of .name.
-	 * The field driver.owner will be set by pci_register_driver.
-	 */
-	char *name;
-	struct module *owner;
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */

--

