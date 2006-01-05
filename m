Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWAEOae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWAEOae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWAEOae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:30:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8202 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751010AbWAEOad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:30:33 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 2/29] Add pci_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:30:22 +0000
Message-ID: <20060105142951.13.02@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PCI bus device probe/remove methods to the bus_type
structure.  We leave the shutdown method alone since there
are compatibility issues with that.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Greg: can we move the shutdown method, or are there still drivers
which need the special handling?

---
 drivers/pci/pci-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/pci/pci-driver.c linux/drivers/pci/pci-driver.c
--- linus/drivers/pci/pci-driver.c	Fri Nov 11 07:04:15 2005
+++ linux/drivers/pci/pci-driver.c	Sun Nov 13 15:44:26 2005
@@ -380,8 +380,6 @@ int __pci_register_driver(struct pci_dri
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &pci_bus_type;
-	drv->driver.probe = pci_device_probe;
-	drv->driver.remove = pci_device_remove;
 	/* FIXME, once all of the existing PCI drivers have been fixed to set
 	 * the pci shutdown function, this test can go away. */
 	if (!drv->driver.shutdown)
@@ -513,6 +511,8 @@ struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
 	.hotplug	= pci_hotplug,
+	.probe		= pci_device_probe,
+	.remove		= pci_device_remove,
 	.suspend	= pci_device_suspend,
 	.resume		= pci_device_resume,
 	.dev_attrs	= pci_dev_attrs,
