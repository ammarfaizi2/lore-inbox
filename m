Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVDAVA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVDAVA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVDAU6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:58:07 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262906AbVDAUvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:16 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][16/27] IB/mthca: allow address handle creation in interrupt context
In-Reply-To: <2005411249.qipkNNwvZYuE2KBu@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:53 -0800
Message-Id: <2005411249.gEJosMqrkm8KOH4C@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0419 (UTC) FILETIME=[5ADF9DB0:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make address handle verbs usable from interrupt context.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_av.c	2005-03-31 19:07:01.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_av.c	2005-04-01 12:38:26.648176093 -0800
@@ -63,7 +63,7 @@
 	ah->type = MTHCA_AH_PCI_POOL;
 
 	if (dev->hca_type == ARBEL_NATIVE) {
-		ah->av   = kmalloc(sizeof *ah->av, GFP_KERNEL);
+		ah->av   = kmalloc(sizeof *ah->av, GFP_ATOMIC);
 		if (!ah->av)
 			return -ENOMEM;
 
@@ -77,7 +77,7 @@
 		if (index == -1)
 			goto on_hca_fail;
 
-		av = kmalloc(sizeof *av, GFP_KERNEL);
+		av = kmalloc(sizeof *av, GFP_ATOMIC);
 		if (!av)
 			goto on_hca_fail;
 
@@ -89,7 +89,7 @@
 on_hca_fail:
 	if (ah->type == MTHCA_AH_PCI_POOL) {
 		ah->av = pci_pool_alloc(dev->av_table.pool,
-					SLAB_KERNEL, &ah->avdma);
+					SLAB_ATOMIC, &ah->avdma);
 		if (!ah->av)
 			return -ENOMEM;
 
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-01 12:38:22.630048317 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-01 12:38:26.644176961 -0800
@@ -315,7 +315,7 @@
 	int err;
 	struct mthca_ah *ah;
 
-	ah = kmalloc(sizeof *ah, GFP_KERNEL);
+	ah = kmalloc(sizeof *ah, GFP_ATOMIC);
 	if (!ah)
 		return ERR_PTR(-ENOMEM);
 

