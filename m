Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422788AbWHYS1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422788AbWHYS1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbWHYSZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:36 -0400
Received: from mx.pathscale.com ([64.160.42.68]:45954 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422779AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 20 of 23] IB/ipath - allow SMA to be disabled
X-Mercurial-Node: 278073a561698a35412455e9a712227628a5e183
Message-Id: <278073a561698a354124.1156530285@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:45 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful for testing purposes.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -107,6 +107,10 @@ module_param_named(max_srq_wrs, ib_ipath
 		   uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_srq_wrs, "Maximum number of SRQ WRs support");
 
+static unsigned int ib_ipath_disable_sma;
+module_param_named(disable_sma, ib_ipath_disable_sma, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(ib_ipath_disable_sma, "Disable the SMA");
+
 const int ib_ipath_state_ops[IB_QPS_ERR + 1] = {
 	[IB_QPS_RESET] = 0,
 	[IB_QPS_INIT] = IPATH_POST_RECV_OK,
@@ -354,6 +358,9 @@ static void ipath_qp_rcv(struct ipath_ib
 	switch (qp->ibqp.qp_type) {
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
+		if (ib_ipath_disable_sma)
+			break;
+		/* FALLTHROUGH */
 	case IB_QPT_UD:
 		ipath_ud_rcv(dev, hdr, has_grh, data, tlen, qp);
 		break;
