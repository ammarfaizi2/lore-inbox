Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbULaS7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbULaS7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 13:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbULaS7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 13:59:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24744 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262136AbULaS7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 13:59:12 -0500
Message-ID: <41D5A17D.6070606@sgi.com>
Date: Fri, 31 Dec 2004 12:59:09 -0600
From: Josh Aas <josha@sgi.com>
Reply-To: josha@sgi.com
Organization: Silicon Graphics, Inc.
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove outdated/misleading CPU scheduler comments
Content-Type: multipart/mixed;
 boundary="------------070909010806060704080509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070909010806060704080509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes two outdated/misleading comments from the CPU scheduler.

1) The first comment removed is simply incorrect. The function it 
comments on is not used for what the comments says it is anymore.
2) The second comment is a leftover from when the "if" block it comments 
on contained a goto. It does not any more, and the comment doesn't make 
sense.

There isn't really a reason to add different comments, though someone 
might feel differently in the case of the second one. I'll leave adding 
a comment to anybody who wants to - more important to just get rid of 
them now.

Signed-off-by: Josh Aas <josha@sgi.com>

-- 
Josh Aas
Linux System Software
Silicon Graphics, Inc. (SGI)


--------------070909010806060704080509
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="sched_comments.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched_comments.patch"

--- a/kernel/sched.c	Fri Dec 24 15:35:24 2004
+++ b/kernel/sched.c	Fri Dec 31 12:28:09 2004
@@ -580,11 +580,6 @@ static void enqueue_task(struct task_str
 	p->array = array;
 }
 
-/*
- * Used by the migration code - we pull tasks from the head of the
- * remote queue so we want these tasks to show up at the head of the
- * local queue:
- */
 static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
 {
 	list_add(&p->run_list, array->queue + p->prio);
@@ -2585,10 +2580,7 @@ need_resched_nonpreemptible:
 
 	if (unlikely(current->flags & PF_DEAD))
 		current->state = EXIT_DEAD;
-	/*
-	 * if entering off of a kernel preemption go straight
-	 * to picking the next task.
-	 */
+
 	switch_count = &prev->nivcsw;
 	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
 		switch_count = &prev->nvcsw;

--------------070909010806060704080509--
