Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbTGBXkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbTGBXkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:40:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:16082 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265944AbTGBXkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 19:40:52 -0400
Subject: [PATCH] linux-2.5.74_jiffies-include-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057190084.28319.381.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jul 2003 16:54:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, all,
	This patch fixes a bad declaration of jiffies in timer_tsc.c and
timer_cyclone.c, replacing it with the proper usage of jiffies.h.

Caught by gregkh.

thanks
-john

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Wed Jul  2 16:51:41 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Wed Jul  2 16:51:41 2003
@@ -11,6 +11,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/jiffies.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -18,7 +19,6 @@
 #include <asm/fixmap.h>
 
 extern spinlock_t i8253_lock;
-extern unsigned long jiffies;
 extern unsigned long calibrate_tsc(void);
 
 /* Number of usecs that the last interrupt was delayed */
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Wed Jul  2 16:51:41 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Wed Jul  2 16:51:41 2003
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/cpufreq.h>
 #include <linux/string.h>
+#include <linux/jiffies.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -21,7 +22,6 @@
 int tsc_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
-extern unsigned long jiffies;
 
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */



