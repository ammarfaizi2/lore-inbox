Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVAMAeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVAMAeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVALWBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:01:48 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261493AbVALVs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:26 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.GcISM37CLpmJtFzr@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:56 -0800
Message-Id: <20051121347.GID20pY2t5GaCSiw@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][9/18] InfiniBand/core: add QP number to work completion struct
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:47:58.0563 (UTC) FILETIME=[618C2330:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

InfiniBand spec rev 1.2 compliance: add local qp number to
work completion structure.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/include/ib_verbs.h	(revision 1466)
+++ linux/drivers/infiniband/include/ib_verbs.h	(revision 1468)
@@ -352,6 +352,7 @@
 	u32			vendor_err;
 	u32			byte_len;
 	__be32			imm_data;
+	u32			qp_num;
 	u32			src_qp;
 	int			wc_flags;
 	u16			pkey_index;
--- linux/drivers/infiniband/core/mad.c	(revision 1466)
+++ linux/drivers/infiniband/core/mad.c	(revision 1468)
@@ -2026,6 +2026,7 @@
 			wc.slid = IB_LID_PERMISSIVE;
 			wc.sl = 0;
 			wc.dlid_path_bits = 0;
+			wc.qp_num = IB_QP0;
 			local->mad_priv->header.recv_wc.wc = &wc;
 			local->mad_priv->header.recv_wc.mad_len =
 						sizeof(struct ib_mad);
--- linux/drivers/infiniband/hw/mthca/mthca_cq.c	(revision 1466)
+++ linux/drivers/infiniband/hw/mthca/mthca_cq.c	(revision 1468)
@@ -444,6 +444,8 @@
 		spin_lock(&(*cur_qp)->lock);
 	}
 
+	entry->qp_num = (*cur_qp)->qpn;
+
 	if (is_send) {
 		wq = &(*cur_qp)->sq;
 		wqe_index = ((be32_to_cpu(cqe->wqe) - (*cur_qp)->send_wqe_offset)

