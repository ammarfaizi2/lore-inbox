Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWDXXrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWDXXrQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWDXXrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:47:16 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:38014 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932125AbWDXXrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:47:15 -0400
Message-ID: <444D637F.5040702@bigpond.net.au>
Date: Tue, 25 Apr 2006 09:47:11 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [PATCH] sched: Fix boolean expression in move_tasks()
Content-Type: multipart/mixed;
 boundary="------------080609080705010709060409"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 24 Apr 2006 23:47:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080609080705010709060409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem:

In the patch 
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
I got a the sense of a boolean expression wrong when assigning a value 
to skip_for_load.  The expression should have been negated before being 
assigned.

Solution:

Negate the expression and apply de Marcos rule to simplify it.  This 
patch is on top of 
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------080609080705010709060409
Content-Type: text/plain;
 name="smpnice-fix-boolean-expression"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-fix-boolean-expression"

Index: MM-2.6.17-rc1-mm3/kernel/sched.c
===================================================================
--- MM-2.6.17-rc1-mm3.orig/kernel/sched.c	2006-04-21 12:26:54.000000000 +1000
+++ MM-2.6.17-rc1-mm3/kernel/sched.c	2006-04-25 09:09:54.000000000 +1000
@@ -2108,7 +2108,7 @@ skip_queue:
 	 */
 	skip_for_load = tmp->load_weight > rem_load_move;
 	if (skip_for_load && idx < this_best_prio)
-		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
+		skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;
 	if (skip_for_load ||
 	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)

--------------080609080705010709060409--
