Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbTAQJRu>; Fri, 17 Jan 2003 04:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTAQJRu>; Fri, 17 Jan 2003 04:17:50 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:59407
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267440AbTAQJRt>; Fri, 17 Jan 2003 04:17:49 -0500
Date: Fri, 17 Jan 2003 04:27:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5] per-CPU task runqueues
Message-ID: <Pine.LNX.4.44.0301170415000.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply switches over to per-CPU runqueues as defined by the new 
per cpu api.

Index: linux-2.5.59/kernel/sched.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/kernel/sched.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sched.c
--- linux-2.5.59/kernel/sched.c	17 Jan 2003 02:46:29 -0000	1.1.1.1
+++ linux-2.5.59/kernel/sched.c	17 Jan 2003 08:33:12 -0000
@@ -160,9 +160,9 @@
 	atomic_t nr_iowait;
 } ____cacheline_aligned;
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU(struct runqueue, runqueues);
 
-#define cpu_rq(cpu)		(runqueues + (cpu))
+#define cpu_rq(cpu)		(&per_cpu(runqueues, cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)

-- 
function.linuxpower.ca

