Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWB0Ga6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWB0Ga6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWB0Ga6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:30:58 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:59024 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751562AbWB0Ga5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:30:57 -0500
Message-ID: <44029C9B.10507@bigpond.net.au>
Date: Mon, 27 Feb 2006 17:30:51 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       npiggin@suse.de, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       John Hawkes <hawkes@sgi.com>
Subject: [PATCH] sched: smpnice - fix average load per run queue calculations
Content-Type: multipart/mixed;
 boundary="------------040100040006020108040105"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 27 Feb 2006 06:30:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040100040006020108040105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The logical value to use for the average load per task on a run queue 
without any runnable tasks is the "default" load for a nice==0 task. 
Failure to do this may lead to anomalies in try_to_wake_up(), etc.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------040100040006020108040105
Content-Type: text/plain;
 name="fix-avg-load-per-rq"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-avg-load-per-rq"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-02-27 17:18:12.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-02-27 17:19:52.000000000 +1100
@@ -1058,7 +1058,7 @@ static inline unsigned long cpu_avg_load
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long n = rq->nr_running;
 
-	return n ?  rq->raw_weighted_load / n : rq->raw_weighted_load;
+	return n ?  rq->raw_weighted_load / n : SCHED_LOAD_SCALE;
 }
 
 /*

--------------040100040006020108040105--
