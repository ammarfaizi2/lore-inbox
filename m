Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVCFWXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVCFWXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVCFWXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:23:12 -0500
Received: from coderock.org ([193.77.147.115]:28078 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261515AbVCFWXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:23:01 -0500
Subject: [patch 1/1] kernel/smp: replace schedule_timeout() with ssleep()
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:22:47 +0100
Message-Id: <20050306222248.254E11EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Use ssleep() instead of schedule_timeout(). The original code uses
TASK_INTERRUPTIBLE, but does not check for signals, so I believe the change to
ssleep() is appropriate.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/kernel/power/smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN kernel/power/smp.c~ssleep-kernel_power_smp kernel/power/smp.c
--- kj/kernel/power/smp.c~ssleep-kernel_power_smp	2005-03-05 16:11:19.000000000 +0100
+++ kj-domen/kernel/power/smp.c	2005-03-05 16:11:19.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <asm/atomic.h>
 #include <asm/tlbflush.h>
 
@@ -49,8 +50,7 @@ void disable_nonboot_cpus(void)
 	printk("Freezing CPUs (at %d)", smp_processor_id());
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(0));
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ);
+	ssleep(1);
 	printk("...");
 	BUG_ON(smp_processor_id() != 0);
 
_
