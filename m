Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268077AbTAJApJ>; Thu, 9 Jan 2003 19:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268079AbTAJApI>; Thu, 9 Jan 2003 19:45:08 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23971 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268077AbTAJApD>;
	Thu, 9 Jan 2003 19:45:03 -0500
Subject: [PATCH] linux-2.5.55_timer-none_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042159743.1046.280.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Jan 2003 16:49:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All,

	Just a re-sync against 2.5.55. This patch creates an empty timer_opt
structure (timer_none) which is then used as a default initializer to
the timer pointer. This lets us avoid having to check before
dereferencing the timer in future code. 

Please apply.

thanks
-john

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Thu Jan  9 15:21:21 2003
+++ b/arch/i386/kernel/time.c	Thu Jan  9 15:21:21 2003
@@ -78,7 +78,8 @@
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(i8253_lock);
 
-struct timer_opts* timer;
+extern struct timer_opts timer_none;
+struct timer_opts* timer = &timer_none;
 
 /*
  * This version of gettimeofday has microsecond resolution
diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- a/arch/i386/kernel/timers/Makefile	Thu Jan  9 15:21:21 2003
+++ b/arch/i386/kernel/timers/Makefile	Thu Jan  9 15:21:21 2003
@@ -2,6 +2,6 @@
 # Makefile for x86 timers
 #
 
-obj-y := timer.o timer_tsc.o timer_pit.o
+obj-y := timer.o timer_none.o timer_tsc.o timer_pit.o
 
 obj-$(CONFIG_X86_CYCLONE)	+= timer_cyclone.o
diff -Nru a/arch/i386/kernel/timers/timer_none.c b/arch/i386/kernel/timers/timer_none.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timers/timer_none.c	Thu Jan  9 15:21:21 2003
@@ -0,0 +1,24 @@
+#include <asm/timer.h>
+
+static int init_none(void)
+{
+	return 0;
+}
+
+static void mark_offset_none(void)
+{
+	/* nothing needed */
+}
+
+static unsigned long get_offset_none(void)
+{
+	return 0;
+}
+
+
+/* tsc timer_opts struct */
+struct timer_opts timer_none = {
+	.init =		init_none, 
+	.mark_offset =	mark_offset_none, 
+	.get_offset =	get_offset_none,
+};



