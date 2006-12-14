Return-Path: <linux-kernel-owner+w=401wt.eu-S932840AbWLNQB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbWLNQB6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbWLNQB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:01:58 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:46309 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbWLNQB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:01:57 -0500
Subject: [PATCH -rt] wrong config option in sched.c for notick
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 11:01:33 -0500
Message-Id: <1166112093.1785.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In compiling the kernel without high res, I hit this error:

kernel/sched.c:4135: error: notick undeclared (first use in this function)
kernel/sched.c:4135: error: (Each undeclared identifier is reported only once
kernel/sched.c:4135: error: for each function it appears in.)

I'm assuming that this was meant for NO_HZ.

signed-off-by: Steven Rostedt <rostedt@goodmis.org>


Index: linux-2.6.19-rt14/kernel/sched.c
===================================================================
--- linux-2.6.19-rt14.orig/kernel/sched.c	2006-12-14 10:55:43.000000000 -0500
+++ linux-2.6.19-rt14/kernel/sched.c	2006-12-14 10:55:46.000000000 -0500
@@ -4147,7 +4147,7 @@ switch_tasks:
 		++*switch_count;
 
 		prepare_task_switch(rq, next);
-#if defined(CONFIG_HZ) && defined(CONFIG_SMP)
+#if defined(CONFIG_NO_HZ) && defined(CONFIG_SMP)
 		if (prev == rq->idle && notick.load_balancer == -1) {
 			/*
 			 * simple selection for now: Nominate the first cpu in


