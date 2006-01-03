Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWACVXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWACVXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWACVWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:22:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33935 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932564AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 15/50] sh: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Pk-B5@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sh/kernel/process.c |    2 +-
 arch/sh/kernel/smp.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

c19a555413fb82ae8f64754ae294bd32446c1677
diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
index 6a86fe3..830e842 100644
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -362,7 +362,7 @@ struct task_struct *__switch_to(struct t
 	 */
 	asm volatile("ldc	%0, r7_bank"
 		     : /* no output */
-		     : "r" (next->thread_info));
+		     : "r" (task_thread_info(next)));
 
 #ifdef CONFIG_MMU
 	/* If no tasks are using the UBC, we're done */
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 59e49b1..62c7d1c 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -103,7 +103,7 @@ int __cpu_up(unsigned int cpu)
 	if (IS_ERR(tsk))
 		panic("Failed forking idle task for cpu %d\n", cpu);
 	
-	tsk->thread_info->cpu = cpu;
+	task_thread_info(tsk)->cpu = cpu;
 
 	cpu_set(cpu, cpu_online_map);
 
-- 
0.99.9.GIT

