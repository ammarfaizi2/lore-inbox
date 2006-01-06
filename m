Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWAFAUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWAFAUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWAFATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:19:47 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:845 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1752323AbWAFATp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:19:45 -0500
X-IronPort-AV: i="3.99,336,1131350400"; 
   d="scan'208"; a="247400751:sNHT30212378"
Subject: [git patch review 3/4] IB/mthca: check port validity in modify_qp
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 06 Jan 2006 00:19:41 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136506781419-5ed071c9c7a80e29@cisco.com>
In-Reply-To: <1136506781419-2b71405b820f1e9d@cisco.com>
X-OriginalArrivalTime: 06 Jan 2006 00:19:43.0482 (UTC) FILETIME=[E46305A0:01C61256]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify_qp should check that the physical port number provided
is a legal value.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

38d1e793471d95728219f500bbb8bd25658d73b0
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index d786ef4..ea45fa4 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -621,6 +621,12 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		return -EINVAL;
 	}
 
+	if ((attr_mask & IB_QP_PORT) &&
+	    (attr->port_num == 0 || attr->port_num > dev->limits.num_ports)) {
+		mthca_dbg(dev, "Port number (%u) is invalid\n", attr->port_num);
+		return -EINVAL;
+	}
+
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
 	    attr->max_rd_atomic > dev->limits.max_qp_init_rdma) {
 		mthca_dbg(dev, "Max rdma_atomic as initiator %u too large (max is %d)\n",
-- 
0.99.9n
