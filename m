Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVDLSkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVDLSkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVDLSfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:35:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:8651 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262306AbVDLKeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:34:11 -0400
Message-Id: <200504121033.j3CAXJ3a005845@shell0.pdx.osdl.net>
Subject: [patch 170/198] IB/mthca: fix MR allocation error path
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mst@mellanox.co.il,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael S. Tsirkin <mst@mellanox.co.il>

Fix error handling in MR allocation for mem-free mode: mthca_free must get an
MR index, not a key.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-fix-mr-allocation-error-path drivers/infiniband/hw/mthca/mthca_mr.c
--- 25/drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-fix-mr-allocation-error-path	2005-04-12 03:21:43.875466816 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-12 03:21:43.878466360 -0700
@@ -231,7 +231,7 @@ err_out_table:
 		mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
-	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
+	mthca_free(&dev->mr_table.mpt_alloc, key);
 	kfree(mailbox);
 	return err;
 }
@@ -368,7 +368,7 @@ err_out_table:
 		mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
-	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
+	mthca_free(&dev->mr_table.mpt_alloc, key);
 	return err;
 }
 
_
