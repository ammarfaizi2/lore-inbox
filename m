Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270139AbUJSXfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270139AbUJSXfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270143AbUJSXdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:33:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:10890 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270139AbUJSWqe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:34 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257382525@kroah.com>
Date: Tue, 19 Oct 2004 15:42:18 -0700
Message-Id: <1098225738411@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.47, 2004/10/06 13:44:01-07:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI: Hot-plug driver updates due to MSI change

In kernel 2.6.8, MSI has been updated.  This patch updates the two
hot-plug drivers to call pci_disable_msi() per MSI change to undo the
effect of pci_enable_msi() when the driver is unloading.

Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/pciehp_hpc.c |    2 ++
 drivers/pci/hotplug/shpchp_hpc.c |    1 +
 2 files changed, 3 insertions(+)


diff -Nru a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
--- a/drivers/pci/hotplug/pciehp_hpc.c	2004-10-19 15:23:23 -07:00
+++ b/drivers/pci/hotplug/pciehp_hpc.c	2004-10-19 15:23:23 -07:00
@@ -741,6 +741,8 @@
 		if (php_ctlr->irq) {
 			free_irq(php_ctlr->irq, ctrl);
 			php_ctlr->irq = 0;
+			if (!pcie_mch_quirk) 
+				pci_disable_msi(php_ctlr->pci_dev);
 		}
 	}
 	if (php_ctlr->pci_dev) 
diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:23:23 -07:00
+++ b/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:23:23 -07:00
@@ -792,6 +792,7 @@
 		if (php_ctlr->irq) {
 			free_irq(php_ctlr->irq, ctrl);
 			php_ctlr->irq = 0;
+			pci_disable_msi(php_ctlr->pci_dev);
 		}
 	}
 	if (php_ctlr->pci_dev) {

