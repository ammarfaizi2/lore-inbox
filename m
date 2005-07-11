Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVGKX6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVGKX6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVGKUSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:18:40 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:60876 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262571AbVGKUSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:18:04 -0400
Subject: [PATCH 11/29v2] Simplify calling of list_del in MAD
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110302.4389.5006.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 16:10:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify calling of list_del.


Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 10/29.

--
 mad.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/mad.c linux-2.6.13-rc2-mm1-11/drivers/infiniband/core/mad.c
-- linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/mad.c	2005-07-11 13:37:54.000000000 -0400
+++ linux-2.6.13-rc2-mm1-11/drivers/infiniband/core/mad.c	2005-07-11 13:38:06.000000000 -0400
@@ -2188,7 +2188,6 @@ static int retry_send(struct ib_mad_send
 
 	if (!ret) {
 		mad_send_wr->refcount++;
-		list_del(&mad_send_wr->agent_list);
 		list_add_tail(&mad_send_wr->agent_list,
 			      &mad_send_wr->mad_agent_priv->send_list);
 	}
@@ -2223,10 +2222,10 @@ static void timeout_sends(void *data)
 			break;
 		}
 
+		list_del(&mad_send_wr->agent_list);
 		if (!retry_send(mad_send_wr))
 			continue;
 
-		list_del(&mad_send_wr->agent_list);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 		mad_send_wc.wr_id = mad_send_wr->wr_id;


