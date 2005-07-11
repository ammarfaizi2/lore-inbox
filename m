Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVGKTyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVGKTyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVGKTyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:54:51 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:22220 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262532AbVGKTyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:54:44 -0400
Subject: [PATCH 5/29v2] Change saving of user's send wr_id in MAD
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110274.4389.4994.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 15:47:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move saving of user's send wr_id to better match layering of received 
response handling.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 4/29.

--
 mad.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-4/drivers/infiniband/core/mad.c linux-2.6.13-rc2-mm1-5/drivers/infiniband/core/mad.c
-- linux-2.6.13-rc2-mm1-4/drivers/infiniband/core/mad.c	2005-07-11 13:35:26.000000000 -0400
+++ linux-2.6.13-rc2-mm1-5/drivers/infiniband/core/mad.c	2005-07-11 13:35:56.000000000 -0400
@@ -847,9 +847,8 @@ static int ib_send_mad(struct ib_mad_age
 	unsigned long flags;
 	int ret;
 
-	/* Replace user's WR ID with our own to find WR upon completion */
+	/* Set WR ID to find mad_send_wr upon completion */
 	qp_info = mad_agent_priv->qp_info;
-	mad_send_wr->wr_id = mad_send_wr->send_wr.wr_id;
 	mad_send_wr->send_wr.wr_id = (unsigned long)&mad_send_wr->mad_list;
 	mad_send_wr->mad_list.mad_queue = &qp_info->send_queue;
 
@@ -948,6 +947,7 @@ int ib_post_send_mad(struct ib_mad_agent
 		mad_send_wr->send_wr.sg_list = mad_send_wr->sg_list;
 		memcpy(mad_send_wr->sg_list, send_wr->sg_list,
 		       sizeof *send_wr->sg_list * send_wr->num_sge);
+		mad_send_wr->wr_id = mad_send_wr->send_wr.wr_id;
 		mad_send_wr->send_wr.next = NULL;
 		mad_send_wr->tid = send_wr->wr.ud.mad_hdr->tid;
 		mad_send_wr->agent = mad_agent;


