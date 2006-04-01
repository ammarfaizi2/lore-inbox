Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWDAI2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWDAI2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 03:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWDAI2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 03:28:12 -0500
Received: from mail.gmx.de ([213.165.64.20]:58077 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751468AbWDAI2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 03:28:11 -0500
X-Authenticated: #14349625
Subject: [patch 2.6.16-mm2 0/9] sched throttle tree extract
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 10:28:44 +0200
Message-Id: <1143880124.7617.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

The following 9 patches is an extraction of my scheduler throttling tree
against 2.6.16-mm2.  The patch below has already been applied, and is
only included such that anyone applying these patches to virgin source
will see no offsets.

	-Mike

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/kernel/sched.c.org	2006-03-31 09:56:37.000000000 +0200
+++ linux-2.6.16-mm2/kernel/sched.c	2006-03-31 13:32:40.000000000 +0200
@@ -820,7 +820,7 @@ static void __activate_task(task_t *p, r
 {
 	prio_array_t *target = rq->active;
 
-	if (unlikely(batch_task(p) || expired_starving(rq)))
+	if (unlikely(batch_task(p) || (expired_starving(rq) && !rt_task(p))))
 		target = rq->expired;
 	enqueue_task(p, target);
 	inc_nr_running(p, rq);


