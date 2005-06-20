Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVFUFn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVFUFn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVFTWl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:41:57 -0400
Received: from coderock.org ([193.77.147.115]:26779 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262285AbVFTWFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:05:23 -0400
Message-Id: <20050620215711.827061000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:57:12 +0200
From: domen@coderock.org
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Pavel Machek <pavel@ucw.cz>, domen@coderock.org
Subject: [patch 1/2] kernel/smp: replace schedule_timeout() with ssleep()
Content-Disposition: inline; filename=ssleep-kernel_power_smp.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use ssleep() instead of schedule_timeout(). The original code uses
TASK_INTERRUPTIBLE, but does not check for signals, so I believe the change to
ssleep() is appropriate.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt/kernel/power/smp.c
===================================================================
--- quilt.orig/kernel/power/smp.c
+++ quilt/kernel/power/smp.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <asm/atomic.h>
 #include <asm/tlbflush.h>
 
@@ -49,8 +50,7 @@ void disable_nonboot_cpus(void)
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(0));
 	printk("Freezing CPUs (at %d)", _smp_processor_id());
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ);
+	ssleep(1);
 	printk("...");
 	BUG_ON(_smp_processor_id() != 0);
 

--
