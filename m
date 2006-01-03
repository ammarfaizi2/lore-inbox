Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWACV3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWACV3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWACV2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:28:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24207 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932522AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 01/50] missing helper - task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PC-3o@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

new helper - task_stack_page(task).  Returns pointer to the memory object
containing task stack; usually thread_info of task sits in the beginning
of that object.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/thread_info.h |    1 +
 include/linux/sched.h          |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

51a180569d2190fe1d57d2ff077b3a832a408782
diff --git a/include/asm-m68k/thread_info.h b/include/asm-m68k/thread_info.h
index 9532ca3..c4d622a 100644
--- a/include/asm-m68k/thread_info.h
+++ b/include/asm-m68k/thread_info.h
@@ -37,6 +37,7 @@ struct thread_info {
 #define init_stack		(init_thread_union.stack)
 
 #define task_thread_info(tsk)	(&(tsk)->thread.info)
+#define task_stack_page(tsk)	((void *)(tsk)->thread_info)
 #define current_thread_info()	task_thread_info(current)
 
 #define __HAVE_THREAD_FUNCTIONS
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b0ad6f3..0d303f8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1234,6 +1234,7 @@ static inline void task_unlock(struct ta
 #ifndef __HAVE_THREAD_FUNCTIONS
 
 #define task_thread_info(task) (task)->thread_info
+#define task_stack_page(task) ((void*)((task)->thread_info))
 
 static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
 {
-- 
0.99.9.GIT

