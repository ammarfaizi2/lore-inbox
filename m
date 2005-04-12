Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVDLKnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVDLKnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVDLKmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:42:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:39626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262271AbVDLKdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:22 -0400
Message-Id: <200504121033.j3CAXF0P005831@shell0.pdx.osdl.net>
Subject: [patch 166/198] IB/mthca: fix posting sends with immediate data
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

When posting a work request with immediate data, put the immediate data in the
immediate data field of the hardware's work request (rather than overwriting
the flags field).

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-fix-posting-sends-with-immediate-data drivers/infiniband/hw/mthca/mthca_qp.c
--- 25/drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-fix-posting-sends-with-immediate-data	2005-04-12 03:21:43.055591456 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-12 03:21:43.059590848 -0700
@@ -1465,7 +1465,7 @@ int mthca_tavor_post_send(struct ib_qp *
 			cpu_to_be32(1);
 		if (wr->opcode == IB_WR_SEND_WITH_IMM ||
 		    wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM)
-			((struct mthca_next_seg *) wqe)->flags = wr->imm_data;
+			((struct mthca_next_seg *) wqe)->imm = wr->imm_data;
 
 		wqe += sizeof (struct mthca_next_seg);
 		size = sizeof (struct mthca_next_seg) / 16;
@@ -1769,7 +1769,7 @@ int mthca_arbel_post_send(struct ib_qp *
 			cpu_to_be32(1);
 		if (wr->opcode == IB_WR_SEND_WITH_IMM ||
 		    wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM)
-			((struct mthca_next_seg *) wqe)->flags = wr->imm_data;
+			((struct mthca_next_seg *) wqe)->imm = wr->imm_data;
 
 		wqe += sizeof (struct mthca_next_seg);
 		size = sizeof (struct mthca_next_seg) / 16;
_
