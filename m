Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWDXV16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWDXV16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWDXVXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:48 -0400
Received: from mx.pathscale.com ([64.160.42.68]:35779 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751294AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 9 of 13] ipath - simplify RC send posting
X-Mercurial-Node: 4eabd5fc05bbd962e64e8bcd642c4fd7e1439395
Message-Id: <4eabd5fc05bbd962e64e.1145913785@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:05 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unnecessarily complicated tests.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r fafcc38877ad -r 4eabd5fc05bb drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Mon Apr 24 14:21:04 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Mon Apr 24 14:21:04 2006 -0700
@@ -531,19 +531,12 @@ int ipath_post_rc_send(struct ipath_qp *
 	}
 	wqe->wr.num_sge = j;
 	qp->s_head = next;
-	/*
-	 * Wake up the send tasklet if the QP is not waiting
-	 * for an RNR timeout.
-	 */
-	next = qp->s_rnr_timeout;
 	spin_unlock_irqrestore(&qp->s_lock, flags);
 
-	if (next == 0) {
-		if (qp->ibqp.qp_type == IB_QPT_UC)
-			ipath_do_uc_send((unsigned long) qp);
-		else
-			ipath_do_rc_send((unsigned long) qp);
-	}
+	if (qp->ibqp.qp_type == IB_QPT_UC)
+		ipath_do_uc_send((unsigned long) qp);
+	else
+		ipath_do_rc_send((unsigned long) qp);
 
 	ret = 0;
 
