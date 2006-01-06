Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752325AbWAFATp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbWAFATp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbWAFATp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:19:45 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:845 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750941AbWAFATo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:19:44 -0500
X-IronPort-AV: i="3.99,336,1131350400"; 
   d="scan'208"; a="247400739:sNHT31876132"
Subject: [git patch review 1/4] IB/mthca: fix WQE size calculation in
	create-srq
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 06 Jan 2006 00:19:41 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136506781419-a5fabee982034082@cisco.com>
X-OriginalArrivalTime: 06 Jan 2006 00:19:42.0857 (UTC) FILETIME=[E403A790:01C61256]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thinko: 64 bytes is the minimum SRQ WQE size (not the maximum).

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_srq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

1d7d2f6f476cf7aa65f9f740a6c932fb75608110
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index f7d2342..e7e153d 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -201,7 +201,7 @@ int mthca_alloc_srq(struct mthca_dev *de
 	if (mthca_is_memfree(dev))
 		srq->max = roundup_pow_of_two(srq->max + 1);
 
-	ds = min(64UL,
+	ds = max(64UL,
 		 roundup_pow_of_two(sizeof (struct mthca_next_seg) +
 				    srq->max_gs * sizeof (struct mthca_data_seg)));
 	srq->wqe_shift = long_log2(ds);
-- 
0.99.9n
