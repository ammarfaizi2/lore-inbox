Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265925AbUAMXtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUAMXtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:49:22 -0500
Received: from peabody.ximian.com ([130.57.169.10]:3262 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S265925AbUAMXtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:49:17 -0500
Subject: Re: [PATCH] rq->curr==p not equivalent to task_running(rq,p)
From: Robert Love <rml@ximian.com>
To: joe.korty@ccur.com, akpm@digeo.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20040113230220.GA13341@tsunami.ccur.com>
References: <20040113230220.GA13341@tsunami.ccur.com>
Content-Type: text/plain
Message-Id: <1074037762.1153.887.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 13 Jan 2004 18:49:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-13 at 18:02, Joe Korty wrote:

> task_running(rq,p) is equivalent to (rq->curr == p) only for some
> architectures.  Boot tested on i386.

Oh, good catch.

Andrew, mind taking this?

Thanks, Joe.

	Robert Love


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


