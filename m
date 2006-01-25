Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWAYG7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWAYG7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWAYG7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:59:21 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:1004 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750739AbWAYG7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:59:20 -0500
Date: Tue, 24 Jan 2006 22:59:00 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, kaos@sgi.com, shemminger@osdl.org, dipankar@in.ibm.com
Subject: [PATCH] Fix comment to synchronize_sched()
Message-ID: <20060125065900.GA993@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Fix to broken comment to synchronize_rcu() noted by Keith Owens.
Also add sentence noting that synchronize_sched() and synchronize_rcu()
are not necessarily identical.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
CC: Keith Owens <kaos@sgi.com>
CC: Stephen Hemminger <shemminger@osdl.org>

---

diff -urpNa -X dontdiff linux-2.6.15/include/linux/rcupdate.h linux-2.6.15-RCUcomment/include/linux/rcupdate.h
--- linux-2.6.15/include/linux/rcupdate.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15-RCUcomment/include/linux/rcupdate.h	2006-01-17 18:48:33.000000000 -0800
@@ -265,11 +265,14 @@ static inline int rcu_pending(int cpu)
  * This means that all preempt_disable code sequences, including NMI and
  * hardware-interrupt handlers, in progress on entry will have completed
  * before this primitive returns.  However, this does not guarantee that
- * softirq handlers will have completed, since in some kernels
+ * softirq handlers will have completed, since in some kernels, these
+ * handlers can run in process context, and can block.
  *
  * This primitive provides the guarantees made by the (deprecated)
  * synchronize_kernel() API.  In contrast, synchronize_rcu() only
  * guarantees that rcu_read_lock() sections will have completed.
+ * In "classic RCU", these two guarantees happen to be one and
+ * the same, but can differ in realtime RCU implementations.
  */
 #define synchronize_sched() synchronize_rcu()
 
