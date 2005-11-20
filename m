Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVKTXOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVKTXOM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVKTXOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:14:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35088 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932110AbVKTXOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:14:11 -0500
Date: Mon, 21 Nov 2005 00:14:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rolandd@cisco.com, mshefty@ichips.intel.com, halr@voltaire.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [2.6 patch] drivers/infiniband/core/mad.c: fix a NULL pointer dereference
Message-ID: <20051120231411.GF16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this obvious NULL pointer dereference 
caused by a wrong order of the cleanups.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm2-full/drivers/infiniband/core/mad.c.old	2005-11-20 22:04:36.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/infiniband/core/mad.c	2005-11-20 22:05:17.000000000 +0100
@@ -355,9 +355,9 @@
 	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
 	kfree(reg_req);
 error3:
-	kfree(mad_agent_priv);
-error2:
 	ib_dereg_mr(mad_agent_priv->agent.mr);
+error2:
+	kfree(mad_agent_priv);
 error1:
 	return ret;
 }

