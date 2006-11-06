Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753455AbWKFRKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbWKFRKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbWKFRKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:10:14 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:49570 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1753455AbWKFRKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:10:11 -0500
Message-Id: <20061106170336.737688000@mvista.com>
User-Agent: quilt/0.45-1
Date: Mon, 06 Nov 2006 09:03:36 -0800
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
CC: johnstul@us.ibm.com
Subject: [PATCH] clocksource: small cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly changing alignment. Just some general cleanup.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>
Acked-by: John Stultz <johnstul@us.ibm.com>

---
 include/linux/clocksource.h |    2 +-
 kernel/time/clocksource.c   |    6 +++---
 kernel/timer.c              |   13 ++++++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

Index: linux-2.6.18/include/linux/clocksource.h
===================================================================
--- linux-2.6.18.orig/include/linux/clocksource.h
+++ linux-2.6.18/include/linux/clocksource.h
@@ -159,7 +159,7 @@ static inline s64 cyc2ns(struct clocksou
  * Unless you're the timekeeping code, you should not be using this!
  */
 static inline void clocksource_calculate_interval(struct clocksource *c,
-						unsigned long length_nsec)
+					  	  unsigned long length_nsec)
 {
 	u64 tmp;
 
Index: linux-2.6.18/kernel/time/clocksource.c
===================================================================
--- linux-2.6.18.orig/kernel/time/clocksource.c
+++ linux-2.6.18/kernel/time/clocksource.c
@@ -156,7 +156,7 @@ int clocksource_register(struct clocksou
 	/* check if clocksource is already registered */
 	if (is_registered_source(c)) {
 		printk("register_clocksource: Cannot register %s. "
-			"Already registered!", c->name);
+		       "Already registered!", c->name);
 		ret = -EBUSY;
 	} else {
 		/* register it */
@@ -275,10 +275,10 @@ sysfs_show_available_clocksources(struct
  * Sysfs setup bits:
  */
 static SYSDEV_ATTR(current_clocksource, 0600, sysfs_show_current_clocksources,
-			sysfs_override_clocksource);
+		   sysfs_override_clocksource);
 
 static SYSDEV_ATTR(available_clocksource, 0600,
-			sysfs_show_available_clocksources, NULL);
+		   sysfs_show_available_clocksources, NULL);
 
 static struct sysdev_class clocksource_sysclass = {
 	set_kset_name("clocksource"),
Index: linux-2.6.18/kernel/timer.c
===================================================================
--- linux-2.6.18.orig/kernel/timer.c
+++ linux-2.6.18/kernel/timer.c
@@ -786,7 +786,7 @@ static int change_clocksource(void)
 		clock = new;
 		clock->cycle_last = now;
 		printk(KERN_INFO "Time: %s clocksource has been installed.\n",
-					clock->name);
+		       clock->name);
 		return 1;
 	} else if (clock->update_callback) {
 		return clock->update_callback();
@@ -794,7 +794,7 @@ static int change_clocksource(void)
 	return 0;
 }
 #else
-#define change_clocksource() (0)
+#define change_clocksource()	do { 0; } while(0)
 #endif
 
 /**
@@ -927,7 +927,8 @@ device_initcall(timekeeping_init_device)
  * If the error is already larger, we look ahead even further
  * to compensate for late or lost adjustments.
  */
-static __always_inline int clocksource_bigadjust(s64 error, s64 *interval, s64 *offset)
+static __always_inline int clocksource_bigadjust(s64 error, s64 *interval,
+						 s64 *offset)
 {
 	s64 tick_error, i;
 	u32 look_ahead, adj;
@@ -951,7 +952,8 @@ static __always_inline int clocksource_b
 	 * Now calculate the error in (1 << look_ahead) ticks, but first
 	 * remove the single look ahead already included in the error.
 	 */
-	tick_error = current_tick_length() >> (TICK_LENGTH_SHIFT - clock->shift + 1);
+	tick_error = current_tick_length() >>
+		(TICK_LENGTH_SHIFT - clock->shift + 1);
 	tick_error -= clock->xtime_interval >> 1;
 	error = ((error - tick_error) >> look_ahead) + tick_error;
 
@@ -1003,7 +1005,8 @@ static void clocksource_adjust(struct cl
 	clock->mult += adj;
 	clock->xtime_interval += interval;
 	clock->xtime_nsec -= offset;
-	clock->error -= (interval - offset) << (TICK_LENGTH_SHIFT - clock->shift);
+	clock->error -= (interval - offset) <<
+			(TICK_LENGTH_SHIFT - clock->shift);
 }
 
 /**
--

