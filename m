Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbTDICol (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 22:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTDICol (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 22:44:41 -0400
Received: from franka.aracnet.com ([216.99.193.44]:3762 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261715AbTDICok (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 22:44:40 -0400
Date: Tue, 08 Apr 2003 19:56:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: John Hawkes <hawkes@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix sched_idle typo
Message-ID: <158580000.1049856974@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're in the idle section, so we should flag the load balance as idle.
Ooops. Pointed out by John Hawkes

diff -urpN -X /home/fletch/.diff.exclude 681-disable_preempt/kernel/sched.c 682-sched_idle/kernel/sched.c
--- 681-disable_preempt/kernel/sched.c	Tue Apr  8 18:06:11 2003
+++ 682-sched_idle/kernel/sched.c	Tue Apr  8 18:07:18 2003
@@ -1306,7 +1306,7 @@ static void rebalance_tick(runqueue_t *t
 		if (!(j % IDLE_REBALANCE_TICK)) {
 			spin_lock(&this_rq->lock);
 			schedstats[this_cpu].lb_idle++;
-			load_balance(this_rq, 0, cpu_to_node_mask(this_cpu));
+			load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
 			spin_unlock(&this_rq->lock);
 		}
 		return;

