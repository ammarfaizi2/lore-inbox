Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVJPUbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVJPUbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 16:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVJPUbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 16:31:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29455 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751301AbVJPUbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 16:31:42 -0400
Date: Sun, 16 Oct 2005 21:31:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: [PATCH 1/2] Fixup PCI driver shutdown
Message-ID: <20051016203135.GD14413@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a warning to pci driver registration code so that we know
whether we have drivers using the obsolete driver shutdown
method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -377,6 +377,9 @@ int pci_register_driver(struct pci_drive
 	 * the pci shutdown function, this test can go away. */
 	if (!drv->driver.shutdown)
 		drv->driver.shutdown = pci_device_shutdown;
+	else
+		printk(KERN_WARNING "Warning: PCI driver %s has a struct device_driver shutdown method, please update!\n",
+			drv->name);
 	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
