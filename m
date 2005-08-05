Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbVHEPDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbVHEPDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVHEOxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:46 -0400
Received: from fep16.inet.fi ([194.251.242.241]:25231 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S261817AbVHEOvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:51:35 -0400
Subject: [PATCH 5/8] PCI: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ikr7js.czjdww.9wbed36gfob4o2kzq2itotq1c.beaver@cs.helsinki.fi>
In-Reply-To: <ikr7je.odev85.el9izpk1g38nfy240a6ur3v2s.beaver@cs.helsinki.fi>
Date: Fri, 5 Aug 2005 17:51:34 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 hotplug/sgi_hotplug.c |    2 +-
 pci-sysfs.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: 2.6/drivers/pci/hotplug/sgi_hotplug.c
===================================================================
--- 2.6.orig/drivers/pci/hotplug/sgi_hotplug.c
+++ 2.6/drivers/pci/hotplug/sgi_hotplug.c
@@ -142,7 +142,7 @@ static int sn_hp_slot_private_alloc(stru
 
 	pcibus_info = SN_PCIBUS_BUSSOFT_INFO(pci_bus);
 
-	bss_hotplug_slot->private = kcalloc(1, sizeof(struct slot),
+	bss_hotplug_slot->private = kzalloc(sizeof(struct slot),
 					    GFP_KERNEL);
 	if (!bss_hotplug_slot->private)
 		return -ENOMEM;
Index: 2.6/drivers/pci/pci-sysfs.c
===================================================================
--- 2.6.orig/drivers/pci/pci-sysfs.c
+++ 2.6/drivers/pci/pci-sysfs.c
@@ -356,7 +356,7 @@ pci_create_resource_files(struct pci_dev
 			continue;
 
 		/* allocate attribute structure, piggyback attribute name */
-		res_attr = kcalloc(1, sizeof(*res_attr) + 10, GFP_ATOMIC);
+		res_attr = kzalloc(sizeof(*res_attr) + 10, GFP_ATOMIC);
 		if (res_attr) {
 			char *res_attr_name = (char *)(res_attr + 1);
 
