Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUGaI5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUGaI5U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 04:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbUGaI5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 04:57:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18423 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261724AbUGaI5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 04:57:17 -0400
Date: Sat, 31 Jul 2004 14:24:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] RCU - cpu-offline-cleanup [1/3]
Message-ID: <20040731085402.GA4612@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

There is a series of patches in my tree and these 3 are the first
ones that should probably be merged down the road. Descriptions are on 
top of the patches. Please include them in -mm.

A lot of RCU code will be cleaned up later in order to support
call_rcu_bh(), the separate RCU interface that considers softirq
handler completion a quiescent state.

Thanks
Dipankar



Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>

Minor cleanup of the hotplug code to remove #ifdef in cpu
event notifier handler. If CONFIG_HOTPLUG_CPU is not defined,
CPU_DEAD case will be optimized off.


 kernel/rcupdate.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN kernel/rcupdate.c~cpu-offline-cleanup kernel/rcupdate.c
--- linux-2.6.8-rc2-rcu/kernel/rcupdate.c~cpu-offline-cleanup	2004-07-29 13:35:18.000000000 +0530
+++ linux-2.6.8-rc2-rcu-dipankar/kernel/rcupdate.c	2004-07-29 13:41:18.000000000 +0530
@@ -242,6 +242,12 @@ unlock:
 	tasklet_kill_immediate(&RCU_tasklet(cpu), cpu);
 }
 
+#else
+
+static void rcu_offline_cpu(int cpu)
+{
+}
+
 #endif
 
 void rcu_restart_cpu(int cpu)
@@ -325,11 +331,9 @@ static int __devinit rcu_cpu_notify(stru
 	case CPU_UP_PREPARE:
 		rcu_online_cpu(cpu);
 		break;
-#ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:
 		rcu_offline_cpu(cpu);
 		break;
-#endif
 	default:
 		break;
 	}

_
