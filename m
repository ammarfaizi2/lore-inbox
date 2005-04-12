Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVDLSkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVDLSkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVDLShe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:37:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:6859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262304AbVDLKeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:34:05 -0400
Message-Id: <200504121033.j3CAXPWV005874@shell0.pdx.osdl.net>
Subject: [patch 178/198] IB/mthca: allow address handle creation in interrupt context
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Make address handle verbs usable from interrupt context.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_av.c       |    6 +++---
 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_av.c~ib-mthca-allow-address-handle-creation-in-interrupt-context drivers/infiniband/hw/mthca/mthca_av.c
--- 25/drivers/infiniband/hw/mthca/mthca_av.c~ib-mthca-allow-address-handle-creation-in-interrupt-context	2005-04-12 03:21:45.821171024 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_av.c	2005-04-12 03:21:45.826170264 -0700
@@ -63,7 +63,7 @@ int mthca_create_ah(struct mthca_dev *de
 	ah->type = MTHCA_AH_PCI_POOL;
 
 	if (dev->hca_type == ARBEL_NATIVE) {
-		ah->av   = kmalloc(sizeof *ah->av, GFP_KERNEL);
+		ah->av   = kmalloc(sizeof *ah->av, GFP_ATOMIC);
 		if (!ah->av)
 			return -ENOMEM;
 
@@ -77,7 +77,7 @@ int mthca_create_ah(struct mthca_dev *de
 		if (index == -1)
 			goto on_hca_fail;
 
-		av = kmalloc(sizeof *av, GFP_KERNEL);
+		av = kmalloc(sizeof *av, GFP_ATOMIC);
 		if (!av)
 			goto on_hca_fail;
 
@@ -89,7 +89,7 @@ int mthca_create_ah(struct mthca_dev *de
 on_hca_fail:
 	if (ah->type == MTHCA_AH_PCI_POOL) {
 		ah->av = pci_pool_alloc(dev->av_table.pool,
-					SLAB_KERNEL, &ah->avdma);
+					SLAB_ATOMIC, &ah->avdma);
 		if (!ah->av)
 			return -ENOMEM;
 
diff -puN drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-allow-address-handle-creation-in-interrupt-context drivers/infiniband/hw/mthca/mthca_provider.c
--- 25/drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-allow-address-handle-creation-in-interrupt-context	2005-04-12 03:21:45.823170720 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-12 03:21:45.827170112 -0700
@@ -315,7 +315,7 @@ static struct ib_ah *mthca_ah_create(str
 	int err;
 	struct mthca_ah *ah;
 
-	ah = kmalloc(sizeof *ah, GFP_KERNEL);
+	ah = kmalloc(sizeof *ah, GFP_ATOMIC);
 	if (!ah)
 		return ERR_PTR(-ENOMEM);
 
_
