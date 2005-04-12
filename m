Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVDLRkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVDLRkD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVDLKih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:38:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:43978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262277AbVDLKda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:30 -0400
Message-Id: <200504121033.j3CAXLoD005856@shell0.pdx.osdl.net>
Subject: [patch 173/198] IB/mthca: only free doorbell records in mem-free mode
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

On error path, only free doorbell records if we're in mem-free mode.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_cq.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_cq.c~ib-mthca-only-free-doorbell-records-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_cq.c
--- 25/drivers/infiniband/hw/mthca/mthca_cq.c~ib-mthca-only-free-doorbell-records-in-mem-free-mode	2005-04-12 03:21:44.685343696 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_cq.c	2005-04-12 03:21:44.688343240 -0700
@@ -817,10 +817,12 @@ err_out_free_mr:
 err_out_mailbox:
 	kfree(mailbox);
 
-	mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM, cq->arm_db_index);
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM, cq->arm_db_index);
 
 err_out_ci:
-	mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
 
 err_out_icm:
 	mthca_table_put(dev, dev->cq_table.table, cq->cqn);
_
