Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263091AbVFXEIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbVFXEIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbVFXEFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:05:54 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263093AbVFXEEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:22 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 05/14] IB/mthca: Set QP static rate correctly
In-Reply-To: <2005623214.8EmcOxrdtkDFLmDq@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.ZulWzVKl5lpV91f5@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:20.0730 (UTC) FILETIME=[CC7CDDA0:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix offset of static_rate in QP context.  Pointed out by Dror Goldenberg.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_qp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:04.751088766 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:05.234984039 -0700
@@ -683,7 +683,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	if (attr_mask & IB_QP_AV) {
 		qp_context->pri_path.g_mylmc     = attr->ah_attr.src_path_bits & 0x7f;
 		qp_context->pri_path.rlid        = cpu_to_be16(attr->ah_attr.dlid);
-		qp_context->pri_path.static_rate = (!!attr->ah_attr.static_rate) << 3;
+		qp_context->pri_path.static_rate = !!attr->ah_attr.static_rate;
 		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
 			qp_context->pri_path.g_mylmc |= 1 << 7;
 			qp_context->pri_path.mgid_index = attr->ah_attr.grh.sgid_index;

