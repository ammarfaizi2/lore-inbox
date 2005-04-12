Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVDLKjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVDLKjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVDLKjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:39:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:43466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262118AbVDLKd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:29 -0400
Message-Id: <200504121033.j3CAXIJw005842@shell0.pdx.osdl.net>
Subject: [patch 169/198] IB/mthca: clean up mthca_dereg_mr()
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com,
       mst@mellanox.co.il
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

It's cleaner to kfree mthca_mr, and not rely on the fact that ib_mr is the
first field in mthca_mr.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-clean-up-mthca_dereg_mr drivers/infiniband/hw/mthca/mthca_provider.c
--- 25/drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-clean-up-mthca_dereg_mr	2005-04-12 03:21:43.671497824 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-12 03:21:43.674497368 -0700
@@ -568,8 +568,9 @@ static struct ib_mr *mthca_reg_phys_mr(s
 
 static int mthca_dereg_mr(struct ib_mr *mr)
 {
-	mthca_free_mr(to_mdev(mr->device), to_mmr(mr));
-	kfree(mr);
+	struct mthca_mr *mmr = to_mmr(mr);
+	mthca_free_mr(to_mdev(mr->device), mmr);
+	kfree(mmr);
 	return 0;
 }
 
_
