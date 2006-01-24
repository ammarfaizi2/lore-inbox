Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWAXOFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWAXOFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 09:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWAXOFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 09:05:41 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27522 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030229AbWAXOFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 09:05:41 -0500
Subject: [PATCH RT] add set_curr_timer to high_res run_queue
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 09:05:26 -0500
Message-Id: <1138111527.6695.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Here's the cause of my crash.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.15-rt12/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rt12.orig/kernel/hrtimer.c	2006-01-23 14:00:27.000000000 -0500
+++ linux-2.6.15-rt12/kernel/hrtimer.c	2006-01-24 08:53:44.000000000 -0500
@@ -877,6 +877,7 @@
 		timer = list_entry(base->expired.next, struct hrtimer, list);
 		fn = timer->function;
 		data = timer->data;
+		set_curr_timer(base, timer);
 		timer->state = HRTIMER_RUNNING;
 		list_del(&timer->list);
 		spin_unlock_irq(&base->lock);
@@ -902,6 +903,7 @@
 		else
 			timer->state = HRTIMER_EXPIRED;
 	}
+	set_curr_timer(base, NULL);
 	spin_unlock_irq(&base->lock);
 
 	wake_up_timer_waiters(base);


