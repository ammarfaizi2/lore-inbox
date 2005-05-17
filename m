Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVEQVvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVEQVvw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVEQVvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:51:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:61851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261994AbVEQVo4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:44:56 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: add modalias sysfs file for pci devices
In-Reply-To: <1116366306935@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 17 May 2005 14:45:06 -0700
Message-Id: <11163663063114@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: add modalias sysfs file for pci devices

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9888549e0507cc95d1d7ade1595c00ff8e902659
tree 9c31d2b34ef9b747733f7f39916a8031f89c3d1e
parent c22610dadc0452b1273494f2b5157123c6cd60e1
author Greg KH <gregkh@suse.de> Thu, 05 May 2005 11:57:25 -0700
committer Greg KH <gregkh@suse.de> Tue, 17 May 2005 14:31:12 -0700

 drivers/pci/pci-sysfs.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: drivers/pci/pci-sysfs.c
===================================================================
--- 150d5315df21f02605ad5a6541ef7cb00176d023/drivers/pci/pci-sysfs.c  (mode:100644)
+++ 9c31d2b34ef9b747733f7f39916a8031f89c3d1e/drivers/pci/pci-sysfs.c  (mode:100644)
@@ -73,6 +73,17 @@
 	return (str - buf);
 }
 
+static ssize_t modalias_show(struct device *dev, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	return sprintf(buf, "pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x\n",
+		       pci_dev->vendor, pci_dev->device,
+		       pci_dev->subsystem_vendor, pci_dev->subsystem_device,
+		       (u8)(pci_dev->class >> 16), (u8)(pci_dev->class >> 8),
+		       (u8)(pci_dev->class));
+}
+
 struct device_attribute pci_dev_attrs[] = {
 	__ATTR_RO(resource),
 	__ATTR_RO(vendor),
@@ -82,6 +93,7 @@
 	__ATTR_RO(class),
 	__ATTR_RO(irq),
 	__ATTR_RO(local_cpus),
+	__ATTR_RO(modalias),
 	__ATTR_NULL,
 };
 

