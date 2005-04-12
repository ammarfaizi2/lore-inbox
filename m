Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVDMESI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVDMESI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVDLTE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:04:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:57801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262218AbVDLKck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:40 -0400
Message-Id: <200504121032.j3CAWX1w005625@shell0.pdx.osdl.net>
Subject: [patch 122/198] swsusp: SMP fix
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, alexn@dsv.su.se
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Alexander Nyberg <alexn@dsv.su.se>

Fix some smp_processor_id-in-preemptible warnings

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/power/smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN kernel/power/smp.c~swsusp-smp-fix kernel/power/smp.c
--- 25/kernel/power/smp.c~swsusp-smp-fix	2005-04-12 03:21:32.984122552 -0700
+++ 25-akpm/kernel/power/smp.c	2005-04-12 03:21:32.987122096 -0700
@@ -46,13 +46,13 @@ static cpumask_t oldmask;
 
 void disable_nonboot_cpus(void)
 {
-	printk("Freezing CPUs (at %d)", smp_processor_id());
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(0));
+	printk("Freezing CPUs (at %d)", _smp_processor_id());
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(HZ);
 	printk("...");
-	BUG_ON(smp_processor_id() != 0);
+	BUG_ON(_smp_processor_id() != 0);
 
 	/* FIXME: for this to work, all the CPUs must be running
 	 * "idle" thread (or we deadlock). Is that guaranteed? */
_
