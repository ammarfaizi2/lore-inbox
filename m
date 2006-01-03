Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWACV0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWACV0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWACV0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:26:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36495 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932533AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 26/50] frv: task_thread_info(), task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Qo-NX@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/frv/kernel/process.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

b6d605c424ad62db9f709d51d2c0ab425d26809b
diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
index 54a4521..61628b6 100644
--- a/arch/frv/kernel/process.c
+++ b/arch/frv/kernel/process.c
@@ -204,7 +204,7 @@ int copy_thread(int nr, unsigned long cl
 
 	regs0 = __kernel_frame0_ptr;
 	childregs0 = (struct pt_regs *)
-		((unsigned long) p->thread_info + THREAD_SIZE - USER_CONTEXT_SIZE);
+		(task_stack_page(p) + THREAD_SIZE - USER_CONTEXT_SIZE);
 	childregs = childregs0;
 
 	/* set up the userspace frame (the only place that the USP is stored) */
@@ -220,7 +220,7 @@ int copy_thread(int nr, unsigned long cl
 		*childregs = *regs;
 		childregs->sp = (unsigned long) childregs0;
 		childregs->next_frame = childregs0;
-		childregs->gr15 = (unsigned long) p->thread_info;
+		childregs->gr15 = (unsigned long) task_thread_info(p);
 		childregs->gr29 = (unsigned long) p;
 	}
 
-- 
0.99.9.GIT

