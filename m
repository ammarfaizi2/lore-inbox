Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTLHSpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLHSpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:45:47 -0500
Received: from ns.transas.com ([193.125.200.2]:61705 "EHLO
	harvester.transas.com") by vger.kernel.org with ESMTP
	id S261464AbTLHSpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:45:45 -0500
Message-ID: <2E74F312D6980D459F3A05492BA40F8D0391B0EE@clue.transas.com>
From: Andrew Volkov <Andrew.Volkov@transas.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: PROBLEM: possible proceses leak
Date: Mon, 8 Dec 2003 21:45:17 +0300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.

And same bug in kernel/sched.c in ALL *_sleep_on

Andrey

==========================================================
--- kernel/sched.c.old	2003-12-08 21:39:08.000000000 +0300
+++ kernel/sched.c	2003-12-08 21:40:19.000000000 +0300
@@ -819,10 +819,8 @@
 void interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
-
-	current->state = TASK_INTERRUPTIBLE;
-
 	SLEEP_ON_HEAD
+	current->state = TASK_INTERRUPTIBLE;
 	schedule();
 	SLEEP_ON_TAIL
 }
@@ -831,9 +829,8 @@
 {
 	SLEEP_ON_VAR
 
-	current->state = TASK_INTERRUPTIBLE;
-
 	SLEEP_ON_HEAD
+	current->state = TASK_INTERRUPTIBLE;
 	timeout = schedule_timeout(timeout);
 	SLEEP_ON_TAIL
 
@@ -844,9 +841,8 @@
 {
 	SLEEP_ON_VAR
 	
-	current->state = TASK_UNINTERRUPTIBLE;
-
 	SLEEP_ON_HEAD
+	current->state = TASK_UNINTERRUPTIBLE;
 	schedule();
 	SLEEP_ON_TAIL
 }
@@ -855,9 +851,8 @@
 {
 	SLEEP_ON_VAR
 	
-	current->state = TASK_UNINTERRUPTIBLE;
-
 	SLEEP_ON_HEAD
+	current->state = TASK_UNINTERRUPTIBLE;
 	timeout = schedule_timeout(timeout);
 	SLEEP_ON_TAIL
 
