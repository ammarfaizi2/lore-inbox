Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268492AbTCFW4U>; Thu, 6 Mar 2003 17:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268496AbTCFW4T>; Thu, 6 Mar 2003 17:56:19 -0500
Received: from palrel11.hp.com ([156.153.255.246]:4824 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S268492AbTCFW4L>;
	Thu, 6 Mar 2003 17:56:11 -0500
Date: Thu, 6 Mar 2003 15:06:43 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200303062306.h26N6hrd008442@napali.hpl.hp.com>
To: george@mvista.com
Cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: POSIX timer syscalls
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Syscall stubs must be declared to return "long", to ensure things work
properly on all 64-bit platforms (see earlier discussion on this
topic).  Patch below.

On a related note: as far as I can see, timer_t is declared as "int"
on all platforms (both by kernel and glibc).  Yet if my reading of the
kernel code is right, it's supposed to be "long" (and allegedly some
standard claims that timer_t should be the "widest" integer on a
platform).  But then again, I'm not familiar with the POSIX timer
interface myself, so perhaps I'm completely off base here.

	--david

diff -Nru a/kernel/posix-timers.c b/kernel/posix-timers.c
--- a/kernel/posix-timers.c	Thu Mar  6 14:59:46 2003
+++ b/kernel/posix-timers.c	Thu Mar  6 14:59:46 2003
@@ -423,7 +423,7 @@
 
 /* Create a POSIX.1b interval timer. */
 
-asmlinkage int
+asmlinkage long
 sys_timer_create(clockid_t which_clock,
 		 struct sigevent *timer_event_spec, timer_t * created_timer_id)
 {
@@ -663,7 +663,7 @@
 	}
 }
 /* Get the time remaining on a POSIX.1b interval timer. */
-asmlinkage int
+asmlinkage long
 sys_timer_gettime(timer_t timer_id, struct itimerspec *setting)
 {
 	struct k_itimer *timr;
@@ -695,7 +695,7 @@
 
  */
 
-asmlinkage int
+asmlinkage long
 sys_timer_getoverrun(timer_t timer_id)
 {
 	struct k_itimer *timr;
@@ -848,7 +848,7 @@
 }
 
 /* Set a POSIX.1b interval timer */
-asmlinkage int
+asmlinkage long
 sys_timer_settime(timer_t timer_id, int flags,
 		  const struct itimerspec *new_setting,
 		  struct itimerspec *old_setting)
@@ -922,7 +922,7 @@
 }
 
 /* Delete a POSIX.1b interval timer. */
-asmlinkage int
+asmlinkage long
 sys_timer_delete(timer_t timer_id)
 {
 	struct k_itimer *timer;
@@ -1054,7 +1054,7 @@
 	return -EINVAL;
 }
 
-asmlinkage int
+asmlinkage long
 sys_clock_settime(clockid_t which_clock, const struct timespec *tp)
 {
 	struct timespec new_tp;
@@ -1069,7 +1069,7 @@
 	new_tp.tv_nsec /= NSEC_PER_USEC;
 	return do_sys_settimeofday((struct timeval *) &new_tp, NULL);
 }
-asmlinkage int
+asmlinkage long
 sys_clock_gettime(clockid_t which_clock, struct timespec *tp)
 {
 	struct timespec rtn_tp;
@@ -1088,7 +1088,7 @@
 	return error;
 
 }
-asmlinkage int
+asmlinkage long
 sys_clock_getres(clockid_t which_clock, struct timespec *tp)
 {
 	struct timespec rtn_tp;
