Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVDAWGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVDAWGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbVDAUyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:54:06 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262895AbVDAUvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:03 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][4/27] IB/mthca: fix posting sends with immediate data
In-Reply-To: <2005411249.ETBNcLeftemLukfd@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.dKg4ijljsqXo1Rt6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0403 (UTC) FILETIME=[5A449630:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When posting a work request with immediate data, put the immediate
data in the immediate data field of the hardware's work request
(rather than overwriting the flags field).

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-31 19:06:41.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:21.580276194 -0800
@@ -1465,7 +1465,7 @@
 			cpu_to_be32(1);
 		if (wr->opcode == IB_WR_SEND_WITH_IMM ||
 		    wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM)
-			((struct mthca_next_seg *) wqe)->flags = wr->imm_data;
+			((struct mthca_next_seg *) wqe)->imm = wr->imm_data;
 
 		wqe += sizeof (struct mthca_next_seg);
 		size = sizeof (struct mthca_next_seg) / 16;
@@ -1769,7 +1769,7 @@
 			cpu_to_be32(1);
 		if (wr->opcode == IB_WR_SEND_WITH_IMM ||
 		    wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM)
-			((struct mthca_next_seg *) wqe)->flags = wr->imm_data;
+			((struct mthca_next_seg *) wqe)->imm = wr->imm_data;
 
 		wqe += sizeof (struct mthca_next_seg);
 		size = sizeof (struct mthca_next_seg) / 16;

