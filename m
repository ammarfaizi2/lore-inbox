Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVDLPsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVDLPsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVDLKut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:50:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:47050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262280AbVDLKdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:35 -0400
Message-Id: <200504121033.j3CAXHbq005838@shell0.pdx.osdl.net>
Subject: [patch 168/198] IB/mthca: allocate correct number of doorbell pages
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Doorbell record pages are allocated in HCA page size chunks (always 4096
bytes), so we need to divide by 4096 and not PAGE_SIZE when figuring out how
many pages we'll need space for.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/infiniband/hw/mthca/mthca_memfree.c~ib-mthca-allocate-correct-number-of-doorbell-pages drivers/infiniband/hw/mthca/mthca_memfree.c
--- 25/drivers/infiniband/hw/mthca/mthca_memfree.c~ib-mthca-allocate-correct-number-of-doorbell-pages	2005-04-12 03:21:43.467528832 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-12 03:21:43.470528376 -0700
@@ -446,7 +446,7 @@ int mthca_init_db_tab(struct mthca_dev *
 
 	init_MUTEX(&dev->db_tab->mutex);
 
-	dev->db_tab->npages     = dev->uar_table.uarc_size / PAGE_SIZE;
+	dev->db_tab->npages     = dev->uar_table.uarc_size / 4096;
 	dev->db_tab->max_group1 = 0;
 	dev->db_tab->min_group2 = dev->db_tab->npages - 1;
 
_
