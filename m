Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVKHEfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVKHEfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVKHEfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:35:10 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:32787 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030289AbVKHEfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:35:09 -0500
Date: Mon, 7 Nov 2005 20:35:07 -0800
Message-Id: <200511080435.jA84Z7ZZ009927@zach-dev.vmware.com>
Subject: [PATCH 15/21] i386 Deprecate useless bug
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:35:07.0498 (UTC) FILETIME=[CBD70CA0:01C5E41D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the "temporary debugging check" which has managed to live for quite
some time, and is clearly unneeded.  The mm can never be live at this point,
so clearly checking the LDT in the mm->context is redundant as well.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/process.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-zach-work/arch/i386/kernel/process.c	2005-11-05 00:28:06.000000000 -0800
@@ -417,17 +417,7 @@ void flush_thread(void)
 
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
 
