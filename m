Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbTBQIES>; Mon, 17 Feb 2003 03:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTBQIES>; Mon, 17 Feb 2003 03:04:18 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:16542
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266932AbTBQIER>; Mon, 17 Feb 2003 03:04:17 -0500
Date: Mon, 17 Feb 2003 03:12:41 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH][2.5] set_cpus_allowed needs cpu_online_map BUG check
Message-ID: <Pine.LNX.4.50.0302170250430.18087-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to try and migrate to offline cpus, so BUG() on it.

diff -u -r1.1.1.1 sched.c
--- linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 16:04:51 -0000
@@ -2200,11 +2221,8 @@
 	migration_req_t req;
 	runqueue_t *rq;
 
-#if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	if (!(new_mask & cpu_online_map))
 		BUG();
-#endif
 
 	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;

