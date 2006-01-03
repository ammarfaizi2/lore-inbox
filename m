Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWACVVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWACVVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWACVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:20:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25999 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932556AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 10/50] i386: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PW-7W@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/i386/kernel/process.c   |    2 +-
 include/asm-i386/processor.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

ab4d196bff8397a68d48f2a74f4726cbe759415e
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
index 7765f3a..e12909b 100644
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -782,7 +782,7 @@ unsigned long get_wchan(struct task_stru
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
-	stack_page = (unsigned long)p->thread_info;
+	stack_page = (unsigned long)task_stack_page(p);
 	esp = p->thread.esp;
 	if (!stack_page || esp < stack_page || esp > top_esp+stack_page)
 		return 0;
diff --git a/include/asm-i386/processor.h b/include/asm-i386/processor.h
index 84f2fd1..f7b4983 100644
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -570,7 +570,7 @@ unsigned long get_wchan(struct task_stru
 #define task_pt_regs(task)                                             \
 ({                                                                     \
        struct pt_regs *__regs__;                                       \
-       __regs__ = (struct pt_regs *)(KSTK_TOP((task)->thread_info)-8); \
+       __regs__ = (struct pt_regs *)(KSTK_TOP(task_stack_page(task))-8); \
        __regs__ - 1;                                                   \
 })
 
-- 
0.99.9.GIT

