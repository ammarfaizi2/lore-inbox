Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268737AbUJECQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbUJECQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 22:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUJECQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 22:16:54 -0400
Received: from fmr03.intel.com ([143.183.121.5]:56789 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S268737AbUJECQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 22:16:42 -0400
Message-Id: <200410050216.i952Gb620657@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: bug in sched.c:activate_task()
Date: Mon, 4 Oct 2004 19:16:39 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSqgVi7369qDcKhR8ydScjIqZZVEA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update p->timestamp to "now" in activate_task() doesn't look right
to me at all.  p->timestamp records last time it was running on a
cpu.  activate_task shouldn't update that variable when it queues
a task on the runqueue.

This bug (and combined with others) triggers improper load balancing.

Patch against linux-2.6.9-rc3.  Didn't diff it against 2.6.9-rc3-mm2
because mm tree has so many change in sched.c.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- linux-2.6.9-rc3/kernel/sched.c.orig	2004-10-04 19:11:21.000000000 -0700
+++ linux-2.6.9-rc3/kernel/sched.c	2004-10-04 19:11:35.000000000 -0700
@@ -888,7 +888,6 @@ static void activate_task(task_t *p, run
 			p->activated = 1;
 		}
 	}
-	p->timestamp = now;

 	__activate_task(p, rq);
 }


