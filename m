Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVHEOzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVHEOzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVHEOxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:55 -0400
Received: from fep19.inet.fi ([194.251.242.244]:8167 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S262272AbVHEOut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:50:49 -0400
Subject: [PATCH 1/8] IA64: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ikr7ik.g8r0if.7zlmvh7aipic7kgaf0b9j68ie.beaver@cs.helsinki.fi>
In-Reply-To: <ikr7i5.scnqnt.cy0lwg6fxw1fxjszsav6l2tlz.beaver@cs.helsinki.fi>
Date: Fri, 5 Aug 2005 17:50:45 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 kernel/io_init.c     |    2 +-
 kernel/tiocx.c       |    2 +-
 pci/tioca_provider.c |    8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: 2.6/arch/ia64/sn/kernel/io_init.c
===================================================================
--- 2.6.orig/arch/ia64/sn/kernel/io_init.c
+++ 2.6/arch/ia64/sn/kernel/io_init.c
@@ -408,7 +408,7 @@ void sn_bus_store_sysdata(struct pci_dev
 {
 	struct sysdata_el *element;
 
-	element = kcalloc(1, sizeof(struct sysdata_el), GFP_KERNEL);
+	element = kzalloc(sizeof(struct sysdata_el), GFP_KERNEL);
 	if (!element) {
 		dev_dbg(dev, "%s: out of memory!\n", __FUNCTION__);
 		return;
Index: 2.6/arch/ia64/sn/kernel/tiocx.c
===================================================================
--- 2.6.orig/arch/ia64/sn/kernel/tiocx.c
+++ 2.6/arch/ia64/sn/kernel/tiocx.c
@@ -191,7 +191,7 @@ cx_device_register(nasid_t nasid, int pa
 {
 	struct cx_dev *cx_dev;
 
-	cx_dev = kcalloc(1, sizeof(struct cx_dev), GFP_KERNEL);
+	cx_dev = kzalloc(sizeof(struct cx_dev), GFP_KERNEL);
 	DBG("cx_dev= 0x%p\n", cx_dev);
 	if (cx_dev == NULL)
 		return -ENOMEM;
Index: 2.6/arch/ia64/sn/pci/tioca_provider.c
===================================================================
--- 2.6.orig/arch/ia64/sn/pci/tioca_provider.c
+++ 2.6/arch/ia64/sn/pci/tioca_provider.c
@@ -148,7 +148,7 @@ tioca_gart_init(struct tioca_kernel *tio
 	tioca_kern->ca_pcigart_entries =
 	    tioca_kern->ca_pciap_size / tioca_kern->ca_ap_pagesize;
 	tioca_kern->ca_pcigart_pagemap =
-	    kcalloc(1, tioca_kern->ca_pcigart_entries / 8, GFP_KERNEL);
+	    kzalloc(tioca_kern->ca_pcigart_entries / 8, GFP_KERNEL);
 	if (!tioca_kern->ca_pcigart_pagemap) {
 		free_pages((unsigned long)tioca_kern->ca_gart,
 			   get_order(tioca_kern->ca_gart_size));
@@ -392,7 +392,7 @@ tioca_dma_mapped(struct pci_dev *pdev, u
 	 * allocate a map struct
 	 */
 
-	ca_dmamap = kcalloc(1, sizeof(struct tioca_dmamap), GFP_ATOMIC);
+	ca_dmamap = kzalloc(sizeof(struct tioca_dmamap), GFP_ATOMIC);
 	if (!ca_dmamap)
 		goto map_return;
 
@@ -600,7 +600,7 @@ tioca_bus_fixup(struct pcibus_bussoft *p
 	 * Allocate kernel bus soft and copy from prom.
 	 */
 
-	tioca_common = kcalloc(1, sizeof(struct tioca_common), GFP_KERNEL);
+	tioca_common = kzalloc(sizeof(struct tioca_common), GFP_KERNEL);
 	if (!tioca_common)
 		return NULL;
 
@@ -609,7 +609,7 @@ tioca_bus_fixup(struct pcibus_bussoft *p
 
 	/* init kernel-private area */
 
-	tioca_kern = kcalloc(1, sizeof(struct tioca_kernel), GFP_KERNEL);
+	tioca_kern = kzalloc(sizeof(struct tioca_kernel), GFP_KERNEL);
 	if (!tioca_kern) {
 		kfree(tioca_common);
 		return NULL;
