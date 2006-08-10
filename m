Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWHJARC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWHJARC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWHJAPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:15:40 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14474 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932407AbWHJAPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:15:37 -0400
Message-Id: <20060810001115.794897000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:55 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 9/9] cleanup defines and comments
Content-Disposition: inline; filename=0009-NTP-cleanup-defines-and-comments.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a few unused defines and remove obsolete information from comments.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
---
 include/asm-frv/timex.h    |    5 -----
 include/asm-m32r/timex.h   |    3 ---
 include/asm-sh64/timex.h   |    3 ---
 include/asm-xtensa/timex.h |    3 ---
 include/linux/timex.h      |   13 +++----------
 5 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/include/asm-frv/timex.h b/include/asm-frv/timex.h
index 2aa562f..a89bdde 100644
--- a/include/asm-frv/timex.h
+++ b/include/asm-frv/timex.h
@@ -6,11 +6,6 @@ #define _ASM_TIMEX_H
 #define CLOCK_TICK_RATE		1193180 /* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 
-#define FINETUNE							\
-((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) *			\
-   (1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR))	\
-  << (SHIFT_SCALE-SHIFT_HZ)) / HZ)
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
diff --git a/include/asm-m32r/timex.h b/include/asm-m32r/timex.h
index e89bfd1..019441c 100644
--- a/include/asm-m32r/timex.h
+++ b/include/asm-m32r/timex.h
@@ -12,9 +12,6 @@ #define _ASM_M32R_TIMEX_H
 
 #define CLOCK_TICK_RATE	(CONFIG_BUS_CLOCK / CONFIG_TIMER_DIVIDE)
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 #ifdef __KERNEL__
 /*
diff --git a/include/asm-sh64/timex.h b/include/asm-sh64/timex.h
index af0b792..163e2b6 100644
--- a/include/asm-sh64/timex.h
+++ b/include/asm-sh64/timex.h
@@ -17,9 +17,6 @@ #define __ASM_SH64_TIMEX_H
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 
diff --git a/include/asm-xtensa/timex.h b/include/asm-xtensa/timex.h
index d14a375..c7b705e 100644
--- a/include/asm-xtensa/timex.h
+++ b/include/asm-xtensa/timex.h
@@ -31,9 +31,6 @@ #define LINUX_TIMER_MASK        (1L << L
 
 #define CLOCK_TICK_RATE 	1193180	/* (everyone is using this value) */
 #define CLOCK_TICK_FACTOR       20 /* Factor of both 10^6 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 #ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
 extern unsigned long ccount_per_jiffy;
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 9879e3c..0b2e1b5 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -75,24 +75,17 @@ #define SHIFT_FLL	2	/* FLL frequency fac
 #define MAXTC		10	/* maximum time constant (shift) */
 
 /*
- * The SHIFT_SCALE define establishes the decimal point of the time_phase
- * variable which serves as an extension to the low-order bits of the
- * system clock variable. The SHIFT_UPDATE define establishes the decimal
- * point of the time_offset variable which represents the current offset
- * with respect to standard time. The FINENSEC define represents 1 nsec in
- * scaled units.
+ * The SHIFT_UPDATE define establishes the decimal point of the
+ * time_offset variable which represents the current offset with
+ * respect to standard time.
  *
  * SHIFT_USEC defines the scaling (shift) of the time_freq and
  * time_tolerance variables, which represent the current frequency
  * offset and maximum frequency tolerance.
- *
- * FINENSEC is 1 ns in SHIFT_UPDATE units of the time_phase variable.
  */
-#define SHIFT_SCALE 22		/* phase scale (shift) */
 #define SHIFT_UPDATE (SHIFT_HZ + 1) /* time offset scale (shift) */
 #define SHIFT_USEC 16		/* frequency offset scale (shift) */
 #define SHIFT_NSEC 12		/* kernel frequency offset scale */
-#define FINENSEC (1L << (SHIFT_SCALE - 10)) /* ~1 ns in phase units */
 
 #define MAXPHASE 512000L        /* max phase error (us) */
 #define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
-- 
1.4.1

--

