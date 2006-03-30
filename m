Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWC3O2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWC3O2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWC3O2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:28:17 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:22497 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932231AbWC3O2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:28:16 -0500
Subject: [PATCH -rt] spin_lock in check_monotonic_clock must be raw
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 09:28:04 -0500
Message-Id: <1143728884.26540.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

The lock in check_monotonic_clock must be a raw spinlock since it is
called from the hrtimer_interrupt.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt11/kernel/time/timeofday.c
===================================================================
--- linux-2.6.16-rt11.orig/kernel/time/timeofday.c	2006-03-30 07:10:16.000000000 -0500
+++ linux-2.6.16-rt11/kernel/time/timeofday.c	2006-03-30 09:23:07.000000000 -0500
@@ -125,7 +125,7 @@
 
 #ifdef CONFIG_PARANOID_GENERIC_TIME
 /* This will hurt performance! */
-static DEFINE_SPINLOCK(check_monotonic_lock);
+static DEFINE_RAW_SPINLOCK(check_monotonic_lock);
 static ktime_t last_monotonic_ktime;
 
 static ktime_t get_check_value(void)


