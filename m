Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVGKO0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVGKO0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVGKOXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:23:55 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:20166 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261803AbVGKOV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:21:58 -0400
Subject: [PATCH 11/27] Simplify calling of list_del in MAD
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089115.4389.4527.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 10:14:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify calling of list_del. 
Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 10/27.

-- 
 mad.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband10/core/mad.c linux-2.6.13-rc2-mm1/drivers/infiniband11/core/mad.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband10/core/mad.c	2005-07-09 17:25:28.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband11/core/mad.c	2005-07-09 17:41:24.000000000 -0400
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


