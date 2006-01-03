Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWACVJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWACVJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWACVH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43919 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932572AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 38/50] sh64: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Rg-5S@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sh64/kernel/process.c |    4 ++--
 arch/sh64/lib/dbg.c        |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

9e554f8ebc7ce3339ffbb68390240499ce98a3a2
diff --git a/arch/sh64/kernel/process.c b/arch/sh64/kernel/process.c
index b95d041..acb0391 100644
--- a/arch/sh64/kernel/process.c
+++ b/arch/sh64/kernel/process.c
@@ -744,7 +744,7 @@ int copy_thread(int nr, unsigned long cl
 	}
 #endif
 	/* Copy from sh version */
-	childregs = ((struct pt_regs *)(THREAD_SIZE + (unsigned long) p->thread_info )) - 1;
+	childregs = (struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1;
 
 	*childregs = *regs;
 
@@ -752,7 +752,7 @@ int copy_thread(int nr, unsigned long cl
 		childregs->regs[15] = usp;
 		p->thread.uregs = childregs;
 	} else {
-		childregs->regs[15] = (unsigned long)p->thread_info + THREAD_SIZE;
+		childregs->regs[15] = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	}
 
 	childregs->regs[9] = 0; /* Set return value for child */
diff --git a/arch/sh64/lib/dbg.c b/arch/sh64/lib/dbg.c
index 526feda..5808733 100644
--- a/arch/sh64/lib/dbg.c
+++ b/arch/sh64/lib/dbg.c
@@ -174,7 +174,7 @@ void evt_debug(int evt, int ret_addr, in
 	struct ring_node *rr;
 
 	pid = current->pid;
-	stack_bottom = (unsigned long) current->thread_info;
+	stack_bottom = (unsigned long) task_stack_page(current);
 	asm volatile("ori r15, 0, %0" : "=r" (sp));
 	rr = event_ring + event_ptr;
 	rr->evt = evt;
-- 
0.99.9.GIT

