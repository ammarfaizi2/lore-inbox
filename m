Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVAMAeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVAMAeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVALWCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:02:00 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261491AbVALVsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:23 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.WsPtvzM0EMoPIX2y@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:51 -0800
Message-Id: <20051121347.GcISM37CLpmJtFzr@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][8/18] InfiniBand/core: set byte_cnt correctly in MAD completion
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:47:56.0985 (UTC) FILETIME=[609B5A90:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate Michael Tsirkin's patch to local_completion to set the WC
byte_cnt according to the IBA 1.1 spec (include the GRH size
regardless of whether it is present or not).

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/core/mad.c	(revision 1458)
+++ linux/drivers/infiniband/core/mad.c	(revision 1459)
@@ -2018,9 +2018,10 @@
 			wc.status = IB_WC_SUCCESS;
 			wc.opcode = IB_WC_RECV;
 			wc.vendor_err = 0;
-			wc.byte_len = sizeof(struct ib_mad);
+			wc.byte_len = sizeof(struct ib_mad) +
+				      sizeof(struct ib_grh);
 			wc.src_qp = IB_QP0;
-			wc.wc_flags = 0;
+			wc.wc_flags = 0;	/* No GRH */
 			wc.pkey_index = 0;
 			wc.slid = IB_LID_PERMISSIVE;
 			wc.sl = 0;

