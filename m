Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbVCQO7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbVCQO7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVCQO7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:59:36 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:36566 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S263083AbVCQO4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:56:19 -0500
Date: Thu, 17 Mar 2005 15:56:31 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/8] s390: add run_posix_cpu_timers to account_user_vtime.
Message-ID: <20050317145631.GC4807@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/8] s390: add run_posix_cpu_timers to account_user_vtime.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The posix-timers patch introduces a call to run_posix_cpu_timers
in update_process_times. The same call is required in the s390
private account_user_vtime function as well.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/vtime.c |    2 ++
 1 files changed, 2 insertions(+)

diff -urN linux-2.6/arch/s390/kernel/vtime.c linux-2.6-patched/arch/s390/kernel/vtime.c
--- linux-2.6/arch/s390/kernel/vtime.c	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/vtime.c	2005-03-17 15:35:59.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/notifier.h>
 #include <linux/kernel_stat.h>
 #include <linux/rcupdate.h>
+#include <linux/posix-timers.h>
 
 #include <asm/s390_ext.h>
 #include <asm/timer.h>
@@ -69,6 +70,7 @@
 	if (rcu_pending(smp_processor_id()))
 		rcu_check_callbacks(smp_processor_id(), rcu_user_flag);
 	scheduler_tick();
+ 	run_posix_cpu_timers(tsk);
 }
 
 /*
