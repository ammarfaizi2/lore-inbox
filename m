Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWCSI5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWCSI5x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 03:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWCSI5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 03:57:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:12417 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751451AbWCSI5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 03:57:52 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Simon.Derr@bull.net,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Date: Sun, 19 Mar 2006 00:57:43 -0800
Message-Id: <20060319085743.18841.45970.sendpatchset@jackhammer.engr.sgi.com>
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

--- 2.6.16-rc6-mm2.orig/kernel/cpuset.c	2006-03-18 22:15:33.912350380 -0800
+++ 2.6.16-rc6-mm2/kernel/cpuset.c	2006-03-18 22:15:43.681994273 -0800
@@ -2375,12 +2375,12 @@ void __cpuset_memory_pressure_bump(void)
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
  *    doesn't really matter if tsk->cpuset changes after we read it,
  *    and we take manage_mutex, keeping attach_task() from changing it
- *    anyway.
+ *    anyway.  No need to check that tsk->cpuset != NULL, thanks to the
+ *    cpuset_exit() Hack.
  */
 
 static int proc_cpuset_show(struct seq_file *m, void *v)
 {
-	struct cpuset *cs;
 	struct pid *pid;
 	struct task_struct *tsk;
 	char *buf;
@@ -2399,11 +2399,8 @@ static int proc_cpuset_show(struct seq_f
 
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
