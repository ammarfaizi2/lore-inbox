Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVGFPnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVGFPnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 11:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVGFPnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 11:43:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:55215 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262247AbVGFLX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 07:23:59 -0400
Date: Wed, 6 Jul 2005 13:23:54 +0200
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: [PATCH] Fix 2.6.13rc2 compilation without CONFIG_HOTPLUG
Message-ID: <20050706112354.GE21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Otherwise PCI won't compile.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/drivers/pci/pci-driver.c
===================================================================
--- linux.orig/drivers/pci/pci-driver.c
+++ linux/drivers/pci/pci-driver.c
@@ -145,12 +145,15 @@ const struct pci_device_id *pci_match_de
 					     struct pci_dev *dev)
 {
 	const struct pci_device_id *id;
+#ifdef CONFIG_HOTPLUG  /* A kingdom for C99 */
 	struct pci_dynid *dynid;
+#endif
 
 	id = pci_match_id(drv->id_table, dev);
 	if (id)
 		return id;
 
+#ifdef CONFIG_HOTPLUG
 	/* static ids didn't match, lets look at the dynamic ones */
 	spin_lock(&drv->dynids.lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
@@ -160,6 +163,7 @@ const struct pci_device_id *pci_match_de
 		}
 	}
 	spin_unlock(&drv->dynids.lock);
+#endif
 	return NULL;
 }
 
