Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbULLT6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbULLT6q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbULLT6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:58:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9234 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262102AbULLTyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:54:14 -0500
Date: Sun, 12 Dec 2004 20:54:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: george@mvista.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/posix-timers.c: make some functions static
Message-ID: <20041212195401.GJ22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some functions without external users static.


diffstat output:
 include/linux/posix-timers.h |    4 +---
 kernel/posix-timers.c        |   15 +++++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/posix-timers.h.old	2004-12-12 03:02:00.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/posix-timers.h	2004-12-12 03:02:39.000000000 +0100
@@ -46,10 +46,8 @@
 
 void register_posix_clock(int clock_id, struct k_clock *new_clock);
 
-/* Error handlers for timer_create, nanosleep and settime */
-int do_posix_clock_notimer_create(struct k_itimer *timer);
+/* Error handler for nanosleep */
 int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec * t);
-int do_posix_clock_nosettime(struct timespec *tp);
 
 /* function to call to trigger timer event */
 int posix_timer_event(struct k_itimer *timr, int si_private);
--- linux-2.6.10-rc2-mm4-full/kernel/posix-timers.c.old	2004-12-12 03:00:09.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/posix-timers.c	2004-12-12 03:03:05.000000000 +0100
@@ -196,6 +196,8 @@
 static int do_posix_clock_process_gettime(struct timespec *tp);
 static int do_posix_clock_thread_gettime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
+static int do_posix_clock_nosettime(struct timespec *tp);
+static int do_posix_clock_notimer_create(struct k_itimer *timer);
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
 {
@@ -1215,12 +1217,13 @@
 	return 0;
 }
 
-int do_posix_clock_nosettime(struct timespec *tp)
+static int do_posix_clock_nosettime(struct timespec *tp)
 {
 	return -EINVAL;
 }
 
-int do_posix_clock_notimer_create(struct k_itimer *timer) {
+static int do_posix_clock_notimer_create(struct k_itimer *timer)
+{
 	return -EINVAL;
 }
 
@@ -1481,9 +1484,9 @@
 	up(&clock_was_set_lock);
 }
 
-long clock_nanosleep_restart(struct restart_block *restart_block);
+static long clock_nanosleep_restart(struct restart_block *restart_block);
 
-extern long do_clock_nanosleep(clockid_t which_clock, int flags,
+static long do_clock_nanosleep(clockid_t which_clock, int flags,
 			       struct timespec *t);
 
 asmlinkage long
@@ -1521,7 +1524,7 @@
 	return ret;
 }
 
-long
+static long
 do_clock_nanosleep(clockid_t which_clock, int flags, struct timespec *tsave)
 {
 	struct timespec t, dum;
@@ -1625,7 +1628,7 @@
 /*
  * This will restart clock_nanosleep.
  */
-long
+static long
 clock_nanosleep_restart(struct restart_block *restart_block)
 {
 	struct timespec t;

