Return-Path: <linux-kernel-owner+w=401wt.eu-S1423136AbWLVAK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423136AbWLVAK4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 19:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423138AbWLVAK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 19:10:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55115 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423136AbWLVAKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 19:10:55 -0500
Date: Fri, 22 Dec 2006 01:08:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch] rcu: rcutorture suspend fix
Message-ID: <20061222000813.GA4092@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] rcu: rcutorture suspend fix
From: Ingo Molnar <mingo@elte.hu>

fix suspend hang: rcutorture threads need to be nofreeze.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/rcutorture.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux/kernel/rcutorture.c
===================================================================
--- linux.orig/kernel/rcutorture.c
+++ linux/kernel/rcutorture.c
@@ -522,6 +522,7 @@ rcu_torture_writer(void *arg)
 
 	VERBOSE_PRINTK_STRING("rcu_torture_writer task started");
 	set_user_nice(current, 19);
+	current->flags |= PF_NOFREEZE;
 
 	do {
 		schedule_timeout_uninterruptible(1);
@@ -561,6 +562,7 @@ rcu_torture_fakewriter(void *arg)
 
 	VERBOSE_PRINTK_STRING("rcu_torture_fakewriter task started");
 	set_user_nice(current, 19);
+	current->flags |= PF_NOFREEZE;
 
 	do {
 		schedule_timeout_uninterruptible(1 + rcu_random(&rand)%10);
@@ -591,6 +593,7 @@ rcu_torture_reader(void *arg)
 
 	VERBOSE_PRINTK_STRING("rcu_torture_reader task started");
 	set_user_nice(current, 19);
+	current->flags |= PF_NOFREEZE;
 
 	do {
 		idx = cur_ops->readlock();
