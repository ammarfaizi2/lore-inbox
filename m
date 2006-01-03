Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWACVWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWACVWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWACVWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:22:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:30095 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932573AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 16/50] sh: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Pm-E7@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sh/kernel/process.c |    2 +-
 include/asm-sh/ptrace.h  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

743f991f32205d964a644b5d256695fa9f252950
diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
index 830e842..e2854ca 100644
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -270,7 +270,7 @@ int copy_thread(int nr, unsigned long cl
 	if (user_mode(regs)) {
 		childregs->regs[15] = usp;
 	} else {
-		childregs->regs[15] = (unsigned long)p->thread_info + THREAD_SIZE;
+		childregs->regs[15] = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	}
         if (clone_flags & CLONE_SETTLS) {
 		childregs->gbr = childregs->regs[0];
diff --git a/include/asm-sh/ptrace.h b/include/asm-sh/ptrace.h
index 85aa0f4..792fc35 100644
--- a/include/asm-sh/ptrace.h
+++ b/include/asm-sh/ptrace.h
@@ -93,11 +93,11 @@ extern void show_regs(struct pt_regs *);
 
 #ifdef CONFIG_SH_DSP
 #define task_pt_regs(task) \
-	((struct pt_regs *) ((unsigned long)(task)->thread_info + THREAD_SIZE \
+	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE \
 		 - sizeof(struct pt_dspregs) - sizeof(unsigned long)) - 1)
 #else
 #define task_pt_regs(task) \
-	((struct pt_regs *) ((unsigned long)(task)->thread_info + THREAD_SIZE \
+	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE \
 		 - sizeof(unsigned long)) - 1)
 #endif
 
-- 
0.99.9.GIT

