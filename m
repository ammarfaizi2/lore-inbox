Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWBOLmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWBOLmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 06:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBOLmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 06:42:13 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:32717 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751039AbWBOLmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 06:42:11 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: remove on runqueue requeueing
Date: Wed, 15 Feb 2006 22:41:36 +1100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Mike Galbraith <efault@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602152241.37322.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew please apply. Thanks Mike.

Cheers,
Con
---
On runqueue time is used to elevate priority in schedule().

In the code it currently requeues tasks even if their priority is not
elevated, which would end up placing them at the end of their runqueue
array effectively delaying them instead of improving their priority.

Bug spotted by Mike Galbraith <efault@gmx.de>

This patch removes this requeueing.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 kernel/sched.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.16-rc3-mm1/kernel/sched.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/kernel/sched.c	2006-02-15 22:29:15.000000000 +1100
+++ linux-2.6.16-rc3-mm1/kernel/sched.c	2006-02-15 22:32:20.000000000 +1100
@@ -3107,8 +3107,7 @@ go_idle:
 			dequeue_task(next, array);
 			next->prio = new_prio;
 			enqueue_task(next, array);
-		} else
-			requeue_task(next, array);
+		}
 	}
 	next->sleep_type = SLEEP_NORMAL;
 switch_tasks:
