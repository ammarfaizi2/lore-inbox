Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWC2JLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWC2JLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWC2JLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:11:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46533 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750782AbWC2JLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:11:17 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Date: Wed, 29 Mar 2006 01:11:08 -0800
Message-Id: <20060329091108.14612.84403.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 01/03] Cpuset: task_lock comment fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Fix cpuset comment involving case of a tasks cpuset
pointer being NULL.  Thanks to "the_top_cpuset_hack",
this code no longer sees NULL task->cpuset pointers.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- 2.6.16-mm1.orig/kernel/cpuset.c	2006-03-27 08:44:45.794087744 -0800
+++ 2.6.16-mm1/kernel/cpuset.c	2006-03-28 16:06:02.862014854 -0800
@@ -616,12 +616,10 @@ static void guarantee_online_mems(const 
  * current->cpuset if a task has its memory placement changed.
  * Do not call this routine if in_interrupt().
  *
- * Call without callback_mutex or task_lock() held.  May be called
- * with or without manage_mutex held.  Doesn't need task_lock to guard
- * against another task changing a non-NULL cpuset pointer to NULL,
- * as that is only done by a task on itself, and if the current task
- * is here, it is not simultaneously in the exit code NULL'ing its
- * cpuset pointer.  This routine also might acquire callback_mutex and
+ * Call without callback_mutex or task_lock() held.  May be
+ * called with or without manage_mutex held.  Thanks in part to
+ * 'the_top_cpuset_hack', the tasks cpuset pointer will never
+ * be NULL.  This routine also might acquire callback_mutex and
  * current->mm->mmap_sem during call.
  *
  * Reading current->cpuset->mems_generation doesn't need task_lock

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
