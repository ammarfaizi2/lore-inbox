Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266180AbUAMXDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUAMXDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:03:08 -0500
Received: from mail.ccur.com ([208.248.32.212]:36876 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S266180AbUAMXCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:02:47 -0500
Date: Tue, 13 Jan 2004 18:02:20 -0500
From: Joe Korty <joe.korty@ccur.com>
To: rml@ximian.com, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rq->curr==p not equivalent to task_running(rq,p)
Message-ID: <20040113230220.GA13341@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

task_running(rq,p) is equivalent to (rq->curr == p) only for some
architectures.  Boot tested on i386.

Regards,
Joe

diff -Nua 2.6/kernel/sched.c.0 2.6/kernel/sched.c
--- 2.6/kernel/sched.c.0	2004-01-13 17:53:34.000000000 -0500
+++ 2.6/kernel/sched.c	2004-01-13 17:47:33.000000000 -0500
@@ -2062,7 +2062,7 @@
 		 * our priority decreased, or if we are not currently running on
 		 * this runqueue and our priority is higher than the current's
 		 */
-		if (rq->curr == p) {
+		if (task_running(rq, p)) {
 			if (p->prio > oldprio)
 				resched_task(rq->curr);
 		} else if (p->prio < rq->curr->prio)
