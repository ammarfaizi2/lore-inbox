Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWACVY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWACVY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWACVYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:24:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40079 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932530AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 27/50] m68k: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Qq-Nv@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/process.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

f7013b290c221e23786a21d2d5722a460dd4a52d
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 13d1093..3f9cb55 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -238,10 +238,9 @@ int copy_thread(int nr, unsigned long cl
 {
 	struct pt_regs * childregs;
 	struct switch_stack * childstack, *stack;
-	unsigned long stack_offset, *retp;
+	unsigned long *retp;
 
-	stack_offset = THREAD_SIZE - sizeof(struct pt_regs);
-	childregs = (struct pt_regs *) ((unsigned long) (p->thread_info) + stack_offset);
+	childregs = (struct pt_regs *) (task_stack_page(p) + THREAD_SIZE) - 1;
 
 	*childregs = *regs;
 	childregs->d0 = 0;
@@ -386,7 +385,7 @@ unsigned long get_wchan(struct task_stru
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	stack_page = (unsigned long)(p->thread_info);
+	stack_page = (unsigned long)task_stack_page(p);
 	fp = ((struct switch_stack *)p->thread.ksp)->a6;
 	do {
 		if (fp < stack_page+sizeof(struct thread_info) ||
-- 
0.99.9.GIT

