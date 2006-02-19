Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWBSVFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWBSVFa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWBSVFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:05:30 -0500
Received: from quark.didntduck.org ([69.55.226.66]:31422 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932088AbWBSVF3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:05:29 -0500
Message-ID: <43F8DDB0.6030700@didntduck.org>
Date: Sun, 19 Feb 2006 16:05:52 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: rmk+lkml@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add pci_device_shutdown to pci_bus_type
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The extra compatability code is not necessary.  Any code still using
the old shutdown method will trigger the warning in driver_register()
instead.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>
---

 drivers/pci/pci-driver.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0aa14c9..eb5b50c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -380,14 +380,6 @@ int __pci_register_driver(struct pci_dri
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &pci_bus_type;
-	/* FIXME, once all of the existing PCI drivers have been fixed to set
-	 * the pci shutdown function, this test can go away. */
-	if (!drv->driver.shutdown)
-		drv->driver.shutdown = pci_device_shutdown;
-	else
-		printk(KERN_WARNING "Warning: PCI driver %s has a struct "
-			"device_driver shutdown method, please update!\n",
-			drv->name);
 	drv->driver.owner = owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 
@@ -514,6 +506,7 @@ struct bus_type pci_bus_type = {
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
 	.suspend	= pci_device_suspend,
+	.shutdown	= pci_device_shutdown,
 	.resume		= pci_device_resume,
 	.dev_attrs	= pci_dev_attrs,
 };


