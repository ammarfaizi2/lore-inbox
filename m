Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWDKDvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWDKDvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 23:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWDKDvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 23:51:16 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28932 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751220AbWDKDvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 23:51:02 -0400
Date: Tue, 11 Apr 2006 05:51:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/rcupdate.c: kill synchronize_kernel()
Message-ID: <20060411035100.GD3190@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

synchronize_kernel() is both deprecated and completely unused.

Let's kill this bloat.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/RCU/whatisRCU.txt |    1 -
 include/linux/rcupdate.h        |    1 -
 kernel/rcupdate.c               |    9 ---------
 3 files changed, 11 deletions(-)

--- linux-2.6.17-rc1-mm2-full/Documentation/RCU/whatisRCU.txt.old	2006-04-11 01:23:39.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/Documentation/RCU/whatisRCU.txt	2006-04-11 01:23:45.000000000 +0200
@@ -790,7 +790,6 @@
 
 RCU grace period:
 
-	synchronize_kernel (deprecated)
 	synchronize_net
 	synchronize_sched
 	synchronize_rcu
--- linux-2.6.17-rc1-mm2-full/include/linux/rcupdate.h.old	2006-04-11 01:23:53.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/linux/rcupdate.h	2006-04-11 01:24:28.000000000 +0200
@@ -263,7 +263,6 @@
 				void (*func)(struct rcu_head *head)));
 extern void FASTCALL(call_rcu_bh(struct rcu_head *head,
 				void (*func)(struct rcu_head *head)));
-extern __deprecated_for_modules void synchronize_kernel(void);
 extern void synchronize_rcu(void);
 void synchronize_idle(void);
 extern void rcu_barrier(void);
--- linux-2.6.17-rc1-mm2-full/kernel/rcupdate.c.old	2006-04-11 01:24:36.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/kernel/rcupdate.c	2006-04-11 01:24:57.000000000 +0200
@@ -593,14 +593,6 @@
 	wait_for_completion(&rcu.completion);
 }
 
-/*
- * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
- */
-void synchronize_kernel(void)
-{
-	synchronize_rcu();
-}
-
 module_param(blimit, int, 0);
 module_param(qhimark, int, 0);
 module_param(qlowmark, int, 0);
@@ -611,4 +603,3 @@
 EXPORT_SYMBOL_GPL_FUTURE(call_rcu);	/* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL_FUTURE(call_rcu_bh);	/* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
-EXPORT_SYMBOL_GPL_FUTURE(synchronize_kernel); /* WARNING: GPL-only in April 2006. */

