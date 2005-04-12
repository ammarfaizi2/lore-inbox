Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVDLKwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVDLKwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVDLKvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:51:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:38346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262270AbVDLKdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:21 -0400
Message-Id: <200504121033.j3CAXEer005827@shell0.pdx.osdl.net>
Subject: [patch 165/198] IB/mthca: fix calculation of RDB shift
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Fix calculation of rdb_shift by using original number of QPs, not
their slot in profile[] (which will be rearranged when we sort it).

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_profile.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_profile.c~ib-mthca-fix-calculation-of-rdb-shift drivers/infiniband/hw/mthca/mthca_profile.c
--- 25/drivers/infiniband/hw/mthca/mthca_profile.c~ib-mthca-fix-calculation-of-rdb-shift	2005-04-12 03:21:42.849622768 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_profile.c	2005-04-12 03:21:42.852622312 -0700
@@ -208,8 +208,7 @@ u64 mthca_make_profile(struct mthca_dev 
 			break;
 		case MTHCA_RES_RDB:
 			for (dev->qp_table.rdb_shift = 0;
-			     profile[MTHCA_RES_QP].num << dev->qp_table.rdb_shift <
-				     profile[i].num;
+			     request->num_qp << dev->qp_table.rdb_shift < profile[i].num;
 			     ++dev->qp_table.rdb_shift)
 				; /* nothing */
 			dev->qp_table.rdb_base    = (u32) profile[i].start;
_
