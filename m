Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbTBQIEs>; Mon, 17 Feb 2003 03:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbTBQIEr>; Mon, 17 Feb 2003 03:04:47 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:19358
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266933AbTBQIE3>; Mon, 17 Feb 2003 03:04:29 -0500
Date: Mon, 17 Feb 2003 03:12:56 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH][2.5] Don't wake up tasks on offline processors
Message-ID: <Pine.LNX.4.50.0302170254480.18087-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch stops waking up of tasks onto offline processors. We need this 
when migrating tasks from offline processors onto other online ones and to 
avert a livelock whilst doing so.

Index: linux-2.5.61-trojan/kernel/sched.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/kernel/sched.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sched.c
--- linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 16:04:51 -0000
@@ -465,7 +473,8 @@
 			 * Fast-migrate the task if it's not running or runnable
 			 * currently. Do not violate hard affinity.
 			 */
-			if (unlikely(sync && !task_running(rq, p) &&
+			if (likely(cpu_online(smp_processor_id())) &&
+				unlikely(sync && !task_running(rq, p) &&
 				(task_cpu(p) != smp_processor_id()) &&
 				(p->cpus_allowed & (1UL << smp_processor_id())))) {
 

