Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbVDAWjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVDAWjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVDAWjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:39:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262931AbVDAWjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:39:19 -0500
Date: Fri, 1 Apr 2005 14:39:07 -0800
Message-Id: <200504012239.j31Md7H3032185@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Show thread_info->flags in /proc/PID/status
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It comes up as useful in debugging to be able to see task->thread_info->flags
along with signal information and such.  There is no way currently to
elicit these bits from the kernel via sysrq or /proc (AFAIK).
This patch adds the field to /proc/PID/status.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>


--- linux-2.6/fs/proc/array.c
+++ linux-2.6/fs/proc/array.c
@@ -287,6 +287,12 @@ static inline char *task_cap(struct task
 			    cap_t(p->cap_effective));
 }
 
+static inline char *task_tif(struct task_struct *p, char *buffer)
+{
+	return buffer + sprintf(buffer, "ThreadInfoFlags:\t%lu\n",
+				(unsigned long) p->thread_info->flags);
+}
+
 int proc_pid_status(struct task_struct *task, char * buffer)
 {
 	char * orig = buffer;
@@ -294,6 +300,7 @@ int proc_pid_status(struct task_struct *
 
 	buffer = task_name(task, buffer);
 	buffer = task_state(task, buffer);
+	buffer = task_tif(task, buffer);
  
 	if (mm) {
 		buffer = task_mem(mm, buffer);
