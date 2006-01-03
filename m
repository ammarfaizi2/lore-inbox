Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWACVIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWACVIX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWACVH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31887 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932547AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 18/50] sparc: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Pt-JB@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sparc/kernel/process.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

0015df0826bdd6f2aad29b05149ea3f9475d204a
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
index 7eebb08..fbb05a4 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -302,7 +302,7 @@ void show_stack(struct task_struct *tsk,
 	int count = 0;
 
 	if (tsk != NULL)
-		task_base = (unsigned long) tsk->thread_info;
+		task_base = (unsigned long) task_stack_page(tsk);
 	else
 		task_base = (unsigned long) current_thread_info();
 
@@ -392,7 +392,7 @@ void flush_thread(void)
 		/* We must fixup kregs as well. */
 		/* XXX This was not fixed for ti for a while, worked. Unused? */
 		current->thread.kregs = (struct pt_regs *)
-		    ((char *)current->thread_info + (THREAD_SIZE - TRACEREG_SZ));
+		    (task_stack_page(current) + (THREAD_SIZE - TRACEREG_SZ));
 	}
 }
 
@@ -459,7 +459,7 @@ int copy_thread(int nr, unsigned long cl
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *ti = p->thread_info;
+	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
 	char *new_stack;
 
@@ -482,7 +482,7 @@ int copy_thread(int nr, unsigned long cl
 	 *  V                      V (stk.fr.) V  (pt_regs)  { (stk.fr.) }
 	 *  +----- - - - - - ------+===========+============={+==========}+
 	 */
-	new_stack = (char*)ti + THREAD_SIZE;
+	new_stack = task_stack_page(p) + THREAD_SIZE;
 	if (regs->psr & PSR_PS)
 		new_stack -= STACKFRAME_SZ;
 	new_stack -= STACKFRAME_SZ + TRACEREG_SZ;
-- 
0.99.9.GIT

