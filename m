Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWJJDuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWJJDuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWJJDuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:50:10 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:9102 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S964938AbWJJDuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:50:08 -0400
Subject: [PATCH] Fix pcie portdrv build without CONFIG_PM
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Tom Long Nguyen (tom.l.nguyen"@intel.com
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 13:49:47 +1000
Message-Id: <1160452187.32237.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new error handling code uses pcie_portdrv_restore_config() outside
of CONFIG_PM so this function must be moved outside of the #ifdef or it
will get a link error if CONFIG_PM is not set.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-cell.orig/drivers/pci/pcie/portdrv_pci.c	2006-10-06 13:48:12.000000000 +1000
+++ linux-cell/drivers/pci/pcie/portdrv_pci.c	2006-10-10 13:46:43.000000000 +1000
@@ -37,7 +37,6 @@ static int pcie_portdrv_save_config(stru
 	return pci_save_state(dev);
 }
 
-#ifdef CONFIG_PM
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
 {
 	int retval;
@@ -50,6 +49,7 @@ static int pcie_portdrv_restore_config(s
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int pcie_portdrv_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	int ret = pcie_port_device_suspend(dev, state);


