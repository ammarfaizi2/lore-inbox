Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbSJQKlR>; Thu, 17 Oct 2002 06:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbSJQKkc>; Thu, 17 Oct 2002 06:40:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30983 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261348AbSJQKjf>; Thu, 17 Oct 2002 06:39:35 -0400
To: LKML <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.43-tick
Message-Id: <E18289i-0007u2-00@flint.arm.linux.org.uk>
Date: Thu, 17 Oct 2002 11:45:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.43, but applies cleanly.

On some ARM platforms, CLOCK_TICK_RATE is not a constant (it is specified
at boot time), which means that TICK_USEC/TICK_NSEC is not constant.
We therefore can not initialise static variables with these definitions;
they must be done at run time.

 kernel/timer.c |    7 +++++--
 1 files changed, 5 insertions, 2 deletions

diff -ur orig/kernel/timer.c linux/kernel/timer.c
--- orig/kernel/timer.c	Wed Oct 16 09:17:13 2002
+++ linux/kernel/timer.c	Wed Oct 16 09:15:00 2002
@@ -376,8 +376,8 @@
 /*
  * Timekeeping variables
  */
-unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
-unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+unsigned long tick_usec;	/* ACTHZ   period (usec) */
+unsigned long tick_nsec;	/* USER_HZ period (nsec) */
 
 /* The current time */
 struct timespec xtime __attribute__ ((aligned (16)));
@@ -1069,6 +1069,9 @@
 void __init init_timers(void)
 {
 	int i, j;
+
+	tick_usec = TICK_USEC;
+	tick_nsec = TICK_NSEC(TICK_USEC);
 
 	for (i = 0; i < NR_CPUS; i++) {
 		tvec_base_t *base;

