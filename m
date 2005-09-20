Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVITWJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVITWJb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVITWJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:09:14 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:52121 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965122AbVITWI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:26 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 02/10] IB/mthca: assign ACK timeout field correctly
In-Reply-To: <2005920158.6GA97hjj1WYfaq3W@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:10 -0700
Message-Id: <2005920158.rJMu8Og0ayj9lKb3@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:12.0041 (UTC) FILETIME=[CA856F90:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware reads the ACK timeout field from the most significant 5
bits of struct mthca_qp_path's ackto field, not the least significant
bits.  This fix has the driver put the timeout in the right place.
Without this, we get a timeout that is 2^8 times too small.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6fd9dccd77024ea85b65aa3e8f1cce22caa0d578
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -687,7 +687,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_TIMEOUT) {
-		qp_context->pri_path.ackto = attr->timeout;
+		qp_context->pri_path.ackto = attr->timeout << 3;
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_ACK_TIMEOUT);
 	}
 
