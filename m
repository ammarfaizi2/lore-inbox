Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbVKWWjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbVKWWjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbVKWWfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:35:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63762 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030436AbVKWWe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:34:57 -0500
Date: Wed, 23 Nov 2005 23:34:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: rolandd@cisco.com, mshefty@ichips.intel.com, halr@voltaire.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/infiniband/core/mad.c: fix a NULL pointer dereference
Message-ID: <20051123223456.GD3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this obvious NULL pointer dereference 
caused by a wrong order of the cleanups.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Nov 2005

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

