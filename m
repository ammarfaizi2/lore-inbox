Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWDRLtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWDRLtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWDRLtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:49:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32198 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932208AbWDRLtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:49:40 -0400
Date: Tue, 18 Apr 2006 12:45:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] cond-resched-might-sleep-fix.patch
Message-ID: <20060418104554.GA2395@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

add the __might_sleep() check back to cond_resched().

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/sched.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -4072,6 +4072,9 @@ asmlinkage long sys_sched_yield(void)
 
 static inline void __cond_resched(void)
 {
+#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
+	__might_sleep(__FILE__, __LINE__);
+#endif
 	/*
 	 * The BKS might be reacquired before we have dropped
 	 * PREEMPT_ACTIVE, which could trigger a second
