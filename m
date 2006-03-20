Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWCTEk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWCTEk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWCTEk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:40:29 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:52239 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751468AbWCTEk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:40:26 -0500
Date: Mon, 20 Mar 2006 04:39:53 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       netdev@vger.kernel.org
Subject: [PATCH 5/12] [NET] Bring declance.c in sync with linux-mips tree
Message-ID: <20060320043953.GE20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are three changes between the Linus' and linux-mips git trees
regarding the declaner driver.  Two are cosmetic and one fixes a
call to the wrong function.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org>


--- linux-2.6/drivers/net/declance.c	2006-03-05 19:35:04.000000000 +0000
+++ mips.git/drivers/net/declance.c	2006-03-05 18:51:15.000000000 +0000
@@ -704,8 +704,8 @@
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t
-lance_interrupt(const int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t lance_interrupt(const int irq, void *dev_id,
+				   struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct lance_private *lp = netdev_priv(dev);
@@ -1255,7 +1255,7 @@
 	return 0;
 
 err_out_free_dev:
-	kfree(dev);
+	free_netdev(dev);
 
 err_out:
 	return ret;
@@ -1301,6 +1301,7 @@
 	while (root_lance_dev) {
 		struct net_device *dev = root_lance_dev;
 		struct lance_private *lp = netdev_priv(dev);
+
 		unregister_netdev(dev);
 #ifdef CONFIG_TC
 		if (lp->slot >= 0)

-- 
Martin Michlmayr
http://www.cyrius.com/
