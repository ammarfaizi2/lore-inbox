Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVKJArT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVKJArT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVKJArT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:47:19 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:36357 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751140AbVKJArS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:47:18 -0500
Date: Wed, 9 Nov 2005 16:47:17 -0800
Message-Id: <200511100047.jAA0lHu2028408@zach-dev.vmware.com>
Subject: [PATCH 10/10] Deprecate useless bug
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:47:17.0963 (UTC) FILETIME=[4CFD09B0:01C5E590]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the "temporary debugging check" which has managed to live for quite
some time, and is clearly unneeded.  The mm can never be live at this point,
so clearly checking the LDT in the mm->context is redundant as well.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/process.c	2005-11-09 01:46:41.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/process.c	2005-11-09 06:39:22.000000000 -0800
@@ -415,17 +415,7 @@
 
 void release_thread(struct task_struct *dead_task)
 {
-	if (dead_task->mm) {
-		// temporary debugging check
-		if (dead_task->mm->context.size) {
-			printk("WARNING: dead process %8s still has LDT? <%p/%d>\n",
-					dead_task->comm,
-					dead_task->mm->context.ldt,
-					dead_task->mm->context.size);
-			BUG();
-		}
-	}
-
+	BUG_ON(dead_task->mm);
 	release_vm86_irqs(dead_task);
 }
 
