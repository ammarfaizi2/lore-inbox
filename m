Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVCCV6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVCCV6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVCCVuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:50:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5898 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262535AbVCCVrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:47:12 -0500
Date: Thu, 3 Mar 2005 22:47:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: george@mvista.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/posix-timers.c: cleanups
Message-ID: <20050303214709.GO4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make a needlessly global function static
- remove the unused global function do_posix_clock_notimer_create

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/posix-timers.h |    3 +--
 kernel/posix-timers.c        |    9 ++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

--- linux-2.6.11-rc5-mm1-full/include/linux/posix-timers.h.old	2005-03-03 16:57:39.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/include/linux/posix-timers.h	2005-03-03 16:57:51.000000000 +0100
@@ -89,8 +89,7 @@
 
 void register_posix_clock(clockid_t clock_id, struct k_clock *new_clock);
 
-/* Error handlers for timer_create, nanosleep and settime */
-int do_posix_clock_notimer_create(struct k_itimer *timer);
+/* Error handlers for nanosleep and settime */
 int do_posix_clock_nonanosleep(clockid_t, int flags, struct timespec *);
 int do_posix_clock_nosettime(clockid_t, struct timespec *tp);
 
--- linux-2.6.11-rc5-mm1-full/kernel/posix-timers.c.old	2005-03-03 16:56:44.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/posix-timers.c	2005-03-03 16:58:32.000000000 +0100
@@ -1252,11 +1252,6 @@
 	return -EINVAL;
 }
 
-int do_posix_clock_notimer_create(struct k_itimer *timer)
-{
-	return -EINVAL;
-}
-
 int do_posix_clock_nonanosleep(clockid_t clock, int flags, struct timespec *t)
 {
 #ifndef ENOTSUP
@@ -1423,7 +1418,7 @@
 	up(&clock_was_set_lock);
 }
 
-long clock_nanosleep_restart(struct restart_block *restart_block);
+static long clock_nanosleep_restart(struct restart_block *restart_block);
 
 asmlinkage long
 sys_clock_nanosleep(clockid_t which_clock, int flags,
@@ -1562,7 +1557,7 @@
 /*
  * This will restart clock_nanosleep.
  */
-long
+static long
 clock_nanosleep_restart(struct restart_block *restart_block)
 {
 	struct timespec t;

