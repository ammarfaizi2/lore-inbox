Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933026AbWF2WE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026AbWF2WE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933025AbWF2WEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:04:13 -0400
Received: from mx.pathscale.com ([64.160.42.68]:30607 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932839AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 39] IB/ipath - fix an indenting problem
X-Mercurial-Node: c93c2b42d279e047acdf347921a046d740be3116
Message-Id: <c93c2b42d279e047acdf.1151617255@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:40:55 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r ebf646d10db0 -r c93c2b42d279 drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1053,32 +1053,32 @@ static inline void ipath_rc_rcv_resp(str
 			goto ack_done;
 		}
 	rdma_read:
-	if (unlikely(qp->s_state != OP(RDMA_READ_REQUEST)))
-		goto ack_done;
-	if (unlikely(tlen != (hdrsize + pmtu + 4)))
-		goto ack_done;
-	if (unlikely(pmtu >= qp->s_len))
-		goto ack_done;
-	/* We got a response so update the timeout. */
-	if (unlikely(qp->s_last == qp->s_tail ||
-		     get_swqe_ptr(qp, qp->s_last)->wr.opcode !=
-		     IB_WR_RDMA_READ))
-		goto ack_done;
-	spin_lock(&dev->pending_lock);
-	if (qp->s_rnr_timeout == 0 && !list_empty(&qp->timerwait))
-		list_move_tail(&qp->timerwait,
-			       &dev->pending[dev->pending_index]);
-	spin_unlock(&dev->pending_lock);
-	/*
-	 * Update the RDMA receive state but do the copy w/o holding the
-	 * locks and blocking interrupts.  XXX Yet another place that
-	 * affects relaxed RDMA order since we don't want s_sge modified.
-	 */
-	qp->s_len -= pmtu;
-	qp->s_last_psn = psn;
-	spin_unlock_irqrestore(&qp->s_lock, flags);
-	ipath_copy_sge(&qp->s_sge, data, pmtu);
-	goto bail;
+		if (unlikely(qp->s_state != OP(RDMA_READ_REQUEST)))
+			goto ack_done;
+		if (unlikely(tlen != (hdrsize + pmtu + 4)))
+			goto ack_done;
+		if (unlikely(pmtu >= qp->s_len))
+			goto ack_done;
+		/* We got a response so update the timeout. */
+		if (unlikely(qp->s_last == qp->s_tail ||
+			     get_swqe_ptr(qp, qp->s_last)->wr.opcode !=
+			     IB_WR_RDMA_READ))
+			goto ack_done;
+		spin_lock(&dev->pending_lock);
+		if (qp->s_rnr_timeout == 0 && !list_empty(&qp->timerwait))
+			list_move_tail(&qp->timerwait,
+				       &dev->pending[dev->pending_index]);
+		spin_unlock(&dev->pending_lock);
+		/*
+		 * Update the RDMA receive state but do the copy w/o holding the
+		 * locks and blocking interrupts.  XXX Yet another place that
+		 * affects relaxed RDMA order since we don't want s_sge modified.
+		 */
+		qp->s_len -= pmtu;
+		qp->s_last_psn = psn;
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		ipath_copy_sge(&qp->s_sge, data, pmtu);
+		goto bail;
 
 	case OP(RDMA_READ_RESPONSE_LAST):
 		/* ACKs READ req. */
