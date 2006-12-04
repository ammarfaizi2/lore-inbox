Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936958AbWLDO4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936958AbWLDO4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936965AbWLDO4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:56:06 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46519 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936958AbWLDOzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:55:49 -0500
Date: Mon, 4 Dec 2006 15:55:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] lockdep: show held locks when showing a stackdump
Message-ID: <20061204145539.GY32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] lockdep: show held locks when showing a stackdump

Follow i386/x86_64:
lockdep can be used to print held locks when printing a
backtrace. This can be useful when debugging things like
'scheduling while atomic' asserts.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/traps.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2006-12-04 14:50:55.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2006-12-04 14:50:57.000000000 +0100
@@ -129,7 +129,7 @@ __show_trace(unsigned long sp, unsigned 
 	}
 }
 
-void show_trace(struct task_struct *task, unsigned long * stack)
+void show_trace(struct task_struct *task, unsigned long *stack)
 {
 	register unsigned long __r15 asm ("15");
 	unsigned long sp;
@@ -151,6 +151,9 @@ void show_trace(struct task_struct *task
 		__show_trace(sp, S390_lowcore.thread_info,
 			     S390_lowcore.thread_info + THREAD_SIZE);
 	printk("\n");
+	if (!task)
+		task = current;
+	debug_show_held_locks(task);
 }
 
 void show_stack(struct task_struct *task, unsigned long *sp)
