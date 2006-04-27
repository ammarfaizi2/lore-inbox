Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWD0IL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWD0IL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWD0IL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:11:59 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:8686 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964970AbWD0IL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:11:58 -0400
Date: Thu, 27 Apr 2006 10:11:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch] RCU: add comments to rcu_pending/rcu_needs_cpu
Message-ID: <20060427081156.GB9457@osiris.boeblingen.de.ibm.com>
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org> <20060425052721.GA9458@osiris.boeblingen.de.ibm.com> <20060425114656.GA16719@us.ibm.com> <20060425115226.GA9421@osiris.boeblingen.de.ibm.com> <20060425120854.GF16719@us.ibm.com> <20060425122706.GB9421@osiris.boeblingen.de.ibm.com> <20060426141205.58675763.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426141205.58675763.akpm@osdl.org>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add some comments to rcu_pending() and rcu_needs_cpu().

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Wording might be poor, but probably better than no comments at all.

 kernel/rcupdate.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff -purN a/kernel/rcupdate.c b/kernel/rcupdate.c
--- a/kernel/rcupdate.c	2006-04-27 09:30:23.000000000 +0200
+++ b/kernel/rcupdate.c	2006-04-27 09:56:51.000000000 +0200
@@ -479,12 +479,30 @@ static int __rcu_pending(struct rcu_ctrl
 	return 0;
 }
 
+/**
+ * rcu_pending - Check for pending RCU work on cpu.
+ * @cpu: cpu to check.
+ *
+ * Does RCU have some work pending on the specified cpu, so that there is a
+ * need to invoke rcu_check_callbacks() on the cpu?
+ */
 int rcu_pending(int cpu)
 {
 	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
 		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
 
+/**
+ * rcu_needs_cpu - Determine if cpu will still be needed by RCU.
+ * @cpu: cpu to check.
+ *
+ * Determine whether the specified cpu will still be needed by RCU, or whether
+ * it can be turned off (e.g. by entering a tickless idle state).
+ * Note the difference to rcu_pending() which checks if there is some work to
+ * do that can be done immediately. While this function in addition checks if
+ * there would be some work to do if e.g. a different cpu finished working on
+ * the current batch.
+ */
 int rcu_needs_cpu(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
