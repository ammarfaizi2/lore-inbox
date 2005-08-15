Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVHOW65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVHOW65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVHOW65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:58:57 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:63756 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751097AbVHOW64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:58:56 -0400
Date: Mon, 15 Aug 2005 15:59:09 -0700
From: zach@vmware.com
Message-Id: <200508152259.j7FMx9qZ005312@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 2/6] i386 virtualization - Remove some dead debugging code
X-OriginalArrivalTime: 15 Aug 2005 22:58:50.0507 (UTC) FILETIME=[E6B78DB0:01C5A1EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code is quite dead.  Release_thread is always guaranteed that the mm has
already been released, thus dead_task->mm will always be NULL.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/process.c	2005-08-15 10:46:18.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/process.c	2005-08-15 10:48:51.000000000 -0700
@@ -421,17 +421,7 @@
 
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
 
