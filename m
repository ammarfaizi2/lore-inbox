Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVKJSci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVKJSci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVKJScK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:32:10 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:48904 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751186AbVKJScE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:32:04 -0500
Subject: [git patch review 4/7] [IB] mthca: fix posting of atomic operations
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 10 Nov 2005 18:31:55 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131647515831-8ba0b803b8214b97@cisco.com>
In-Reply-To: <1131647515831-b1175b20ec8fd319@cisco.com>
X-OriginalArrivalTime: 10 Nov 2005 18:31:56.0871 (UTC) FILETIME=[07C8DD70:01C5E625]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The size of work requests for atomic operations was computed
incorrectly in mthca: all sizeofs need to be divided by 16.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

applies-to: 308dce81364b1cbb563942a1a57146c1808e8911
62abb8416f1923f4cef50ce9ce841b919275e3fb
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 7f39af4..190c1dc 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1556,8 +1556,8 @@ int mthca_tavor_post_send(struct ib_qp *
 				}
 
 				wqe += sizeof (struct mthca_atomic_seg);
-				size += sizeof (struct mthca_raddr_seg) / 16 +
-					sizeof (struct mthca_atomic_seg);
+				size += (sizeof (struct mthca_raddr_seg) +
+					 sizeof (struct mthca_atomic_seg)) / 16;
 				break;
 
 			case IB_WR_RDMA_WRITE:
@@ -1876,8 +1876,8 @@ int mthca_arbel_post_send(struct ib_qp *
 				}
 
 				wqe += sizeof (struct mthca_atomic_seg);
-				size += sizeof (struct mthca_raddr_seg) / 16 +
-					sizeof (struct mthca_atomic_seg);
+				size += (sizeof (struct mthca_raddr_seg) +
+					 sizeof (struct mthca_atomic_seg)) / 16;
 				break;
 
 			case IB_WR_RDMA_READ:
---
0.99.9e
