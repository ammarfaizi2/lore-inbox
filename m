Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWHDDZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWHDDZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWHDDZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:25:38 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:10185 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030312AbWHDDZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:25:36 -0400
Message-Id: <20060804032520.756138000@mvista.com>
References: <20060804032414.304636000@mvista.com>
User-Agent: quilt/0.45-1
Date: Thu, 03 Aug 2006 20:24:16 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 02/10] -mm  clocksource: small cleanup
Content-Disposition: inline; filename=clocksource_cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/clocksource.h |    2 +-
 kernel/time/clocksource.c   |    6 +++---
 kernel/timer.c              |    7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.17/include/linux/clocksource.h
===================================================================
--- linux-2.6.17.orig/include/linux/clocksource.h
+++ linux-2.6.17/include/linux/clocksource.h
@@ -159,7 +159,7 @@ static inline s64 cyc2ns(struct clocksou
  * Unless you're the timekeeping code, you should not be using this!
  */
 static inline void clocksource_calculate_interval(struct clocksource *c,
-						unsigned long length_nsec)
+					  	  unsigned long length_nsec)
 {
 	u64 tmp;
 
Index: linux-2.6.17/kernel/time/clocksource.c
===================================================================
--- linux-2.6.17.orig/kernel/time/clocksource.c
+++ linux-2.6.17/kernel/time/clocksource.c
@@ -143,7 +143,7 @@ int clocksource_register(struct clocksou
 	/* check if clocksource is already registered */
 	if (is_registered_source(c)) {
 		printk("register_clocksource: Cannot register %s. "
-			"Already registered!", c->name);
+		       "Already registered!", c->name);
 		ret = -EBUSY;
 	} else {
 		/* register it */
@@ -262,10 +262,10 @@ sysfs_show_available_clocksources(struct
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
Index: linux-2.6.17/kernel/timer.c
===================================================================
--- linux-2.6.17.orig/kernel/timer.c
+++ linux-2.6.17/kernel/timer.c
@@ -924,7 +924,7 @@ static int change_clocksource(void)
 		clock = new;
 		clock->cycle_last = now;
 		printk(KERN_INFO "Time: %s clocksource has been installed.\n",
-					clock->name);
+		       clock->name);
 		return 1;
 	} else if (clock->update_callback) {
 		return clock->update_callback();
@@ -932,7 +932,7 @@ static int change_clocksource(void)
 	return 0;
 }
 #else
-#define change_clocksource() (0)
+#define change_clocksource()	do { 0; } while(0)
 #endif
 
 /**
@@ -1149,7 +1149,8 @@ static void update_wall_time(void)
 
 		/* accumulate error between NTP and clock interval */
 		clock->error += current_tick_length();
-		clock->error -= clock->xtime_interval << (TICK_LENGTH_SHIFT - clock->shift);
+		clock->error -= clock->xtime_interval <<
+				(TICK_LENGTH_SHIFT - clock->shift);
 	}
 
 	/* correct the clock when NTP error is too big */

--
