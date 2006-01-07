Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWAGA0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWAGA0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965381AbWAGAZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:25:58 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:50246 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965379AbWAGAZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:49 -0500
Subject: [git patch review 2/8] IB/mthca: fix for SQEr-to-RTS transition in
	modify QP
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 00:25:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136593542999-61fb4d9a5e85dd1e@cisco.com>
In-Reply-To: <1136593542999-4f2f4395a7bd3191@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 00:25:45.0726 (UTC) FILETIME=[E6B6D1E0:01C61320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes to SQEr->RTS transition in modify_qp:
1. The flag IB_QP_ACCESS_FLAGS is optional for UC qps
2. The SQEr state is not supported for RC qps

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

0364ffc3e8c441d4185e3eb41ecc61dbb09614e4
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index fd60cf3..623f514 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -476,9 +476,8 @@ static const struct {
 			.opt_param = {
 				[UD]  = (IB_QP_CUR_STATE             |
 					 IB_QP_QKEY),
-				[UC]  = IB_QP_CUR_STATE,
-				[RC]  = (IB_QP_CUR_STATE             |
-					 IB_QP_MIN_RNR_TIMER),
+				[UC]  = (IB_QP_CUR_STATE             |
+					 IB_QP_ACCESS_FLAGS),
 				[MLX] = (IB_QP_CUR_STATE             |
 					 IB_QP_QKEY),
 			}
-- 
0.99.9n
