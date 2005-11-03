Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbVKCXLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbVKCXLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbVKCXLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:11:35 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22347 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030523AbVKCXLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:11:20 -0500
Subject: [git patch review 7/7] [IB] mthca: check P_Key index in modify QP
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 03 Nov 2005 23:10:59 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131059459423-4e378ef68b019b7e@cisco.com>
In-Reply-To: <1131059459423-5367bfddb028b876@cisco.com>
X-OriginalArrivalTime: 03 Nov 2005 23:11:01.0417 (UTC) FILETIME=[DB6B9190:01C5E0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the P_Key index passed into mthca_modify_qp() is
within the device's P_Key table.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

applies-to: b974a31452cb645f063589262bde09b6c5b05701
d09e32764176b61c4afee9fd5e7fe04713bfa56f
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 62ff091..8b0b935 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -582,6 +582,13 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		return -EINVAL;
 	}
 
+	if ((attr_mask & IB_QP_PKEY_INDEX) && 
+	     attr->pkey_index >= dev->limits.pkey_table_len) {
+		mthca_dbg(dev, "PKey index (%u) too large. max is %d\n",
+			  attr->pkey_index,dev->limits.pkey_table_len-1); 
+		return -EINVAL;
+	}
+
 	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
---
0.99.9
