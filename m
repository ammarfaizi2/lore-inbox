Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWDCQH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWDCQH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWDCQH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:07:29 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:4093 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751760AbWDCQH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:07:28 -0400
Subject: [PATCH -rt] have highres runqueue adjust_prio
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 12:07:18 -0400
Message-Id: <1144080438.24581.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the low res runqueue in hrtimers calls adjust prio, but the
high res does not.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt11/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-rt11.orig/kernel/hrtimer.c	2006-03-30 08:28:18.000000000 -0500
+++ linux-2.6.16-rt11/kernel/hrtimer.c	2006-03-30 10:41:38.000000000 -0500
@@ -951,6 +951,7 @@
 			BUG_ON(hrtimer_active(timer));
 			enqueue_hrtimer(timer, base);
 		}
+		hrtimer_adjust_softirq_prio(base);
 	}
 	set_curr_timer(base, NULL);
 	spin_unlock_irq(&base->lock);


