Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWACV1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWACV1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWACV0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:26:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:32655 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932537AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 19/50] uml: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Pv-JQ@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/um/kernel/process_kern.c    |    2 +-
 arch/um/kernel/tt/process_kern.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

515b909dadbe1dcd9253970a711bf7a54ee78bd8
diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
index 34b54a3..791ea3f 100644
--- a/arch/um/kernel/process_kern.c
+++ b/arch/um/kernel/process_kern.c
@@ -108,7 +108,7 @@ void set_current(void *t)
 {
 	struct task_struct *task = t;
 
-	cpu_tasks[task->thread_info->cpu] = ((struct cpu_task) 
+	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task) 
 		{ external_pid(task), task });
 }
 
diff --git a/arch/um/kernel/tt/process_kern.c b/arch/um/kernel/tt/process_kern.c
index cfaa373..857f355 100644
--- a/arch/um/kernel/tt/process_kern.c
+++ b/arch/um/kernel/tt/process_kern.c
@@ -37,7 +37,7 @@ void switch_to_tt(void *prev, void *next
 	from = prev;
 	to = next;
 
-	cpu = from->thread_info->cpu;
+	cpu = task_thread_info(from)->cpu;
 	if(cpu == 0)
 		forward_interrupts(to->thread.mode.tt.extern_pid);
 #ifdef CONFIG_SMP
@@ -344,7 +344,7 @@ int do_proc_op(void *t, int proc_id)
 		pid = thread->request.u.exec.pid;
 		do_exec(thread->mode.tt.extern_pid, pid);
 		thread->mode.tt.extern_pid = pid;
-		cpu_tasks[task->thread_info->cpu].pid = pid;
+		cpu_tasks[task_thread_info(task)->cpu].pid = pid;
 		break;
 	case OP_FORK:
 		attach_process(thread->request.u.fork.pid);
-- 
0.99.9.GIT

