Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTFSXac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTFSXaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:30:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47018 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261970AbTFSXZt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:25:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10560659721049@kroah.com>
Subject: Re: [PATCH] PCI changes and fixes for 2.5.72
In-Reply-To: <10560659712885@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jun 2003 16:39:32 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1361, 2003/06/19 16:10:44-07:00, greg@kroah.com

PCI: merge bits missed from the pci locking patch.


 drivers/pci/bus.c |    6 ++++++
 1 files changed, 6 insertions(+)


diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	Thu Jun 19 16:32:03 2003
+++ b/drivers/pci/bus.c	Thu Jun 19 16:32:03 2003
@@ -93,7 +93,11 @@
 			continue;
 
 		device_add(&dev->dev);
+
+		spin_lock(&pci_bus_lock);
 		list_add_tail(&dev->global_list, &pci_devices);
+		spin_unlock(&pci_bus_lock);
+
 		pci_proc_attach_device(dev);
 		pci_create_sysfs_dev_files(dev);
 
@@ -108,7 +112,9 @@
 		 * it and then scan for unattached PCI devices.
 		 */
 		if (dev->subordinate && list_empty(&dev->subordinate->node)) {
+			spin_lock(&pci_bus_lock);
 			list_add_tail(&dev->subordinate->node, &dev->bus->children);
+			spin_unlock(&pci_bus_lock);
 			pci_bus_add_devices(dev->subordinate);
 		}
 	}

