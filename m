Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUB1LZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 06:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUB1LZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 06:25:57 -0500
Received: from aun.it.uu.se ([130.238.12.36]:21242 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261786AbUB1LZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 06:25:56 -0500
Date: Sat, 28 Feb 2004 12:25:55 +0100 (MET)
Message-Id: <200402281125.i1SBPtxe017049@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.4-rc1] use set_task_cpu() in kthread_bind()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use set_task_cpu() instead of direct assignment to ->cpu in
kthread_bind(), as this eliminates the assignment on UP.

--- linux-2.6.4-rc1/kernel/kthread.c.~1~	2004-02-28 11:15:23.000000000 +0100
+++ linux-2.6.4-rc1/kernel/kthread.c	2004-02-28 12:02:10.000000000 +0100
@@ -131,7 +131,7 @@
 void kthread_bind(struct task_struct *k, unsigned int cpu)
 {
 	BUG_ON(k->state != TASK_INTERRUPTIBLE);
-	k->thread_info->cpu = cpu;
+	set_task_cpu(k, cpu);
 	k->cpus_allowed = cpumask_of_cpu(cpu);
 }
 
