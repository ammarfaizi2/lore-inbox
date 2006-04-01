Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWDAIvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWDAIvB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 03:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWDAIvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 03:51:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:40352 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750797AbWDAIvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 03:51:01 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 4/9] sched throttle tree extract - remove
	kthread barrier
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143881058.7617.24.camel@homer>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
	 <1143880683.7617.16.camel@homer>  <1143881058.7617.24.camel@homer>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 10:51:34 +0200
Message-Id: <1143881494.7617.32.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the last barrier between a normal task using dynamic
priorities and kthreads using the same.  In testing, this separation has
proven to be unnecessary.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/kernel/sched.c-3.remove_IO_barrier	2006-04-01 08:57:40.000000000 +0200
+++ linux-2.6.16-mm2/kernel/sched.c	2006-04-01 09:01:54.000000000 +0200
@@ -865,13 +865,13 @@ static int recalc_task_prio(task_t *p, u
 
 	if (likely(sleep_time > 0)) {
 		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle. They will only have their sleep_avg increased to a
+		 * Tasks that sleep a long time are categorised as idle.
+		 * They will only have their sleep_avg increased to a
 		 * level that makes them just interactive priority to stay
 		 * active yet prevent them suddenly becoming cpu hogs and
 		 * starving other processes.
 		 */
-		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
+		if (sleep_time > INTERACTIVE_SLEEP(p)) {
 				unsigned long ceiling;
 
 				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -


