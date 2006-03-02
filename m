Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWCBHI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWCBHI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 02:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWCBHI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 02:08:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15850 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751404AbWCBHI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 02:08:28 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Date: Wed, 01 Mar 2006 23:08:23 -0800
Message-Id: <20060302070823.15675.73067.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: remove unnecessary NULL check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Remove a no longer needed test for NULL cpuset pointer, with
a little comment explaining why the test isn't needed.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

--- 2.6.16-rc5-mm2-pre1.orig/kernel/cpuset.c	2006-03-01 20:25:52.390667963 -0800
+++ 2.6.16-rc5-mm2-pre1/kernel/cpuset.c	2006-03-01 20:30:07.730593536 -0800
@@ -2374,12 +2374,12 @@ void __cpuset_memory_pressure_bump(void)
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
  *    doesn't really matter if tsk->cpuset changes after we read it,
  *    and we take manage_mutex, keeping attach_task() from changing it
- *    anyway.
+ *    anyway.  No need to check that tsk->cpuset != NULL, thanks to the
+ *    cpuset_exit() Hack.
  */
 
 int cpuset_proc_show_path(struct seq_file *m, void *v)
 {
-	struct cpuset *cs;
 	struct task_ref *tref;
 	struct task_struct *tsk;
 	char *buf;
@@ -2398,11 +2398,8 @@ int cpuset_proc_show_path(struct seq_fil
 
 	retval = -EINVAL;
 	mutex_lock(&manage_mutex);
-	cs = tsk->cpuset;
-	if (!cs)
-		goto out_unlock;
 
-	retval = cpuset_path(cs, buf, PAGE_SIZE);
+	retval = cpuset_path(tsk->cpuset, buf, PAGE_SIZE);
 	if (retval < 0)
 		goto out_unlock;
 	seq_puts(m, buf);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
