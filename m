Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270021AbUJVHNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270021AbUJVHNE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269795AbUJSQvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:51:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:55492 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269794AbUJSQis convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:48 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <1098203784644@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:26 -0700
Message-Id: <10982037861198@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1939.1.49, 2004/09/22 16:25:38-07:00, greg@kroah.com

[PATCH] PCI: add "struct module *" to struct pci_driver to show symlink in sysfs for pci drivers.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-driver.c |    1 +
 include/linux/pci.h      |    2 ++
 2 files changed, 3 insertions(+)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-10-19 09:22:19 -07:00
+++ b/drivers/pci/pci-driver.c	2004-10-19 09:22:19 -07:00
@@ -404,6 +404,7 @@
 	drv->driver.bus = &pci_bus_type;
 	drv->driver.probe = pci_device_probe;
 	drv->driver.remove = pci_device_remove;
+	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 	pci_init_dynids(&drv->dynids);
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 09:22:19 -07:00
+++ b/include/linux/pci.h	2004-10-19 09:22:19 -07:00
@@ -631,9 +631,11 @@
 	unsigned int use_driver_data:1; /* pci_driver->driver_data is used */
 };
 
+struct module;
 struct pci_driver {
 	struct list_head node;
 	char *name;
+	struct module *owner;
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */

