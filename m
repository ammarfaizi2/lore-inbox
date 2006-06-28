Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWF1Q7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWF1Q7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWF1Qyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:54:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36868 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751436AbWF1Qyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:46 -0400
Date: Wed, 28 Jun 2006 18:54:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/rcutorture.c: make code static
Message-ID: <20060628165445.GQ13915@stusta.de>
References: <20060627015211.ce480da6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/rcutorture.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.17-mm3-full/kernel/rcutorture.c.old	2006-06-27 17:59:20.000000000 +0200
+++ linux-2.6.17-mm3-full/kernel/rcutorture.c	2006-06-27 18:01:00.000000000 +0200
@@ -105,11 +105,11 @@
 static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch) =
 	{ 0 };
 static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1];
-atomic_t n_rcu_torture_alloc;
-atomic_t n_rcu_torture_alloc_fail;
-atomic_t n_rcu_torture_free;
-atomic_t n_rcu_torture_mberror;
-atomic_t n_rcu_torture_error;
+static atomic_t n_rcu_torture_alloc;
+static atomic_t n_rcu_torture_alloc_fail;
+static atomic_t n_rcu_torture_free;
+static atomic_t n_rcu_torture_mberror;
+static atomic_t n_rcu_torture_error;
 
 /*
  * Allocate an element from the rcu_tortures pool.
@@ -338,7 +338,7 @@
 	}
 }
 
-int srcu_torture_stats(char *page)
+static int srcu_torture_stats(char *page)
 {
 	int cnt = 0;
 	int cpu;
@@ -567,7 +567,7 @@
 /* Shuffle tasks such that we allow @rcu_idle_cpu to become idle. A special case
  * is when @rcu_idle_cpu = -1, when we allow the tasks to run on all CPUs.
  */
-void rcu_torture_shuffle_tasks(void)
+static void rcu_torture_shuffle_tasks(void)
 {
 	cpumask_t tmp_mask = CPU_MASK_ALL;
 	int i;

