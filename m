Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWCSPFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWCSPFs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWCSPFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:05:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:21391 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751083AbWCSPFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:05:47 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Simon.Derr@bull.net,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Date: Sun, 19 Mar 2006 07:05:38 -0800
Message-Id: <20060319150538.16855.53670.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: remove unnecessary NULL check comment fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Make the comments referring to the (ab)use of the top_cpuset
during a tasks exit more explicit - hopefully clearer.
This is now called "the_top_cpuset_hack", instead of the "Hack."

Signed-off-by: Paul Jackson <pj@sgi.com>

---

Andrew - this goes right after "cpuset-remove-unnecessary-NULL-check".

 kernel/cpuset.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

--- 2.6.16-rc6-mm2.orig/kernel/cpuset.c	2006-03-19 06:45:00.600257470 -0800
+++ 2.6.16-rc6-mm2/kernel/cpuset.c	2006-03-19 06:49:27.495730165 -0800
@@ -2023,7 +2023,7 @@ void cpuset_fork(struct task_struct *chi
  * because tsk is already marked PF_EXITING, so attach_task() won't
  * mess with it, or task is a failed fork, never visible to attach_task.
  *
- * Hack:
+ * the_top_cpuset_hack:
  *
  *    Set the exiting tasks cpuset to the root cpuset (top_cpuset).
  *
@@ -2062,7 +2062,7 @@ void cpuset_exit(struct task_struct *tsk
 	struct cpuset *cs;
 
 	cs = tsk->cpuset;
-	tsk->cpuset = &top_cpuset;	/* Hack - see comment above */
+	tsk->cpuset = &top_cpuset;	/* the_top_cpuset_hack - see above */
 
 	if (notify_on_release(cs)) {
 		char *pathbuf = NULL;
@@ -2375,8 +2375,9 @@ void __cpuset_memory_pressure_bump(void)
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
  *    doesn't really matter if tsk->cpuset changes after we read it,
  *    and we take manage_mutex, keeping attach_task() from changing it
- *    anyway.  No need to check that tsk->cpuset != NULL, thanks to the
- *    cpuset_exit() Hack.
+ *    anyway.  No need to check that tsk->cpuset != NULL, thanks to
+ *    the_top_cpuset_hack in cpuset_exit(), which sets an exiting tasks
+ *    cpuset to top_cpuset.
  */
 
 static int proc_cpuset_show(struct seq_file *m, void *v)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
