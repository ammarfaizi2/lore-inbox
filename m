Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVDLKnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVDLKnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVDLKml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:42:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:59082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262288AbVDLKds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:48 -0400
Message-Id: <200504121033.j3CAXVJ5005903@shell0.pdx.osdl.net>
Subject: [patch 185/198] IB/mthca: tweaks to mthca_cmd.c
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Minor tweaks to firmware command handling: kill off an unused get of a value,
and add a little more info to debug output.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_cmd.c~ib-mthca-tweaks-to-mthca_cmdc drivers/infiniband/hw/mthca/mthca_cmd.c
--- 25/drivers/infiniband/hw/mthca/mthca_cmd.c~ib-mthca-tweaks-to-mthca_cmdc	2005-04-12 03:21:47.424927216 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-12 03:21:47.428926608 -0700
@@ -989,7 +989,6 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 		dev_lim->hca.arbel.resize_srq = field & 1;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SG_RQ_OFFSET);
 		dev_lim->max_sg = min_t(int, field, dev_lim->max_sg);
-		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MTT_ENTRY_SZ_OFFSET);
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MPT_ENTRY_SZ_OFFSET);
 		dev_lim->mpt_entry_sz = size;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_PBL_SZ_OFFSET);
@@ -1297,8 +1296,8 @@ int mthca_MAP_ICM_page(struct mthca_dev 
 	pci_free_consistent(dev->pdev, 16, inbox, indma);
 
 	if (!err)
-		mthca_dbg(dev, "Mapped page at %llx for ICM.\n",
-			  (unsigned long long) virt);
+		mthca_dbg(dev, "Mapped page at %llx to %llx for ICM.\n",
+			  (unsigned long long) dma_addr, (unsigned long long) virt);
 
 	return err;
 }
_
