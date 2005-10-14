Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVJNSX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVJNSX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVJNSX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:23:59 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:13033
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750835AbVJNSX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:23:59 -0400
Subject: [PATCH] jiffies_64 cleanup
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 14 Oct 2005 20:25:49 +0200
Message-Id: <1129314350.1728.721.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define jiffies_64 in kernel/timer.c rather than having 24 duplicated
defines in each architecture.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 arch/alpha/kernel/time.c     |    4 ----
 arch/arm/kernel/time.c       |    4 ----
 arch/arm26/kernel/time.c     |    4 ----
 arch/cris/kernel/time.c      |    4 ----
 arch/frv/kernel/time.c       |    3 ---
 arch/h8300/kernel/time.c     |    4 ----
 arch/i386/kernel/time.c      |    4 ----
 arch/ia64/kernel/time.c      |    4 ----
 arch/m32r/kernel/time.c      |    4 ----
 arch/m68k/kernel/time.c      |    4 ----
 arch/m68knommu/kernel/time.c |    4 ----
 arch/mips/kernel/time.c      |    4 ----
 arch/parisc/kernel/time.c    |    4 ----
 arch/ppc/kernel/time.c       |    5 -----
 arch/ppc64/kernel/time.c     |    4 ----
 arch/s390/kernel/time.c      |    4 ----
 arch/sh/kernel/time.c        |    4 ----
 arch/sh64/kernel/time.c      |    2 --
 arch/sparc/kernel/time.c     |    4 ----
 arch/sparc64/kernel/time.c   |    4 ----
 arch/um/kernel/time_kern.c   |    4 ----
 arch/v850/kernel/time.c      |    4 ----
 arch/x86_64/kernel/time.c    |    4 ----
 arch/xtensa/kernel/time.c    |    3 ---
 kernel/timer.c               |    4 ++++
 25 files changed, 4 insertions(+), 93 deletions(-)

Index: linux-2.6.14-rc4-tod/arch/alpha/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/alpha/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/alpha/kernel/time.c
@@ -55,10 +55,6 @@
 #include "proto.h"
 #include "irq_impl.h"
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 extern unsigned long wall_jiffies;	/* kernel/timer.c */
 
 static int set_rtc_mmss(unsigned long);
Index: linux-2.6.14-rc4-tod/arch/arm/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/arm/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/arm/kernel/time.c
@@ -36,10 +36,6 @@
 #include <asm/thread_info.h>
 #include <asm/mach/time.h>
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 /*
  * Our system timer.
  */
Index: linux-2.6.14-rc4-tod/arch/arm26/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/arm26/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/arm26/kernel/time.c
@@ -34,10 +34,6 @@
 #include <asm/irq.h>
 #include <asm/ioc.h>
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 extern unsigned long wall_jiffies;
 
 /* this needs a better home */
Index: linux-2.6.14-rc4-tod/arch/cris/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/cris/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/cris/kernel/time.c
@@ -32,10 +32,6 @@
 #include <linux/init.h>
 #include <linux/profile.h>
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 int have_rtc;  /* used to remember if we have an RTC or not */;
 
 #define TICK_SIZE tick
Index: linux-2.6.14-rc4-tod/arch/frv/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/frv/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/frv/kernel/time.c
@@ -34,9 +34,6 @@
 
 extern unsigned long wall_jiffies;
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-EXPORT_SYMBOL(jiffies_64);
-
 unsigned long __nongprelbss __clkin_clock_speed_HZ;
 unsigned long __nongprelbss __ext_bus_clock_speed_HZ;
 unsigned long __nongprelbss __res_bus_clock_speed_HZ;
Index: linux-2.6.14-rc4-tod/arch/h8300/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/h8300/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/h8300/kernel/time.c
@@ -32,10 +32,6 @@
 
 #define	TICK_SIZE (tick_nsec / 1000)
 
-u64 jiffies_64;
-
-EXPORT_SYMBOL(jiffies_64);
-
 /*
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
Index: linux-2.6.14-rc4-tod/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/i386/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/i386/kernel/time.c
@@ -74,10 +74,6 @@ int pit_latch_buggy;              /* ext
 
 #include "do_timer.h"
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 unsigned int cpu_khz;	/* Detected as we calibrate the TSC */
 EXPORT_SYMBOL(cpu_khz);
 
Index: linux-2.6.14-rc4-tod/arch/ia64/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/ia64/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/ia64/kernel/time.c
@@ -32,10 +32,6 @@
 
 extern unsigned long wall_jiffies;
 
-u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 #define TIME_KEEPER_ID	0	/* smp_processor_id() of time-keeper */
 
 #ifdef CONFIG_IA64_DEBUG_IRQ
Index: linux-2.6.14-rc4-tod/arch/m32r/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/m32r/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/m32r/kernel/time.c
@@ -39,10 +39,6 @@ extern void send_IPI_allbutself(int, int
 extern void smp_local_timer_interrupt(struct pt_regs *);
 #endif
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 extern unsigned long wall_jiffies;
 #define TICK_SIZE	(tick_nsec / 1000)
 
Index: linux-2.6.14-rc4-tod/arch/m68k/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/m68k/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/m68k/kernel/time.c
@@ -27,10 +27,6 @@
 #include <linux/timex.h>
 #include <linux/profile.h>
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 static inline int set_rtc_mmss(unsigned long nowtime)
 {
   if (mach_set_clock_mmss)
Index: linux-2.6.14-rc4-tod/arch/m68knommu/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/m68knommu/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/m68knommu/kernel/time.c
@@ -27,10 +27,6 @@
 
 #define	TICK_SIZE (tick_nsec / 1000)
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 extern unsigned long wall_jiffies;
 
 
Index: linux-2.6.14-rc4-tod/arch/mips/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/mips/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/mips/kernel/time.c
@@ -43,10 +43,6 @@
 
 #define TICK_SIZE	(tick_nsec / 1000)
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 /*
  * forward reference
  */
Index: linux-2.6.14-rc4-tod/arch/parisc/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/parisc/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/parisc/kernel/time.c
@@ -33,10 +33,6 @@
 
 #include <linux/timex.h>
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 /* xtime and wall_jiffies keep wall-clock time */
 extern unsigned long wall_jiffies;
 
Index: linux-2.6.14-rc4-tod/arch/ppc/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/ppc/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/ppc/kernel/time.c
@@ -66,11 +66,6 @@
 
 #include <asm/time.h>
 
-/* XXX false sharing with below? */
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 unsigned long disarm_decr[NR_CPUS];
 
 extern struct timezone sys_tz;
Index: linux-2.6.14-rc4-tod/arch/ppc64/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/ppc64/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/ppc64/kernel/time.c
@@ -68,10 +68,6 @@
 #include <asm/systemcfg.h>
 #include <asm/firmware.h>
 
-u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
 extern int piranha_simulator;
Index: linux-2.6.14-rc4-tod/arch/s390/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/s390/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/s390/kernel/time.c
@@ -49,10 +49,6 @@
 
 #define TICK_SIZE tick
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 static ext_int_info_t ext_int_info_cc;
 static u64 init_timer_cc;
 static u64 jiffies_timer_cc;
Index: linux-2.6.14-rc4-tod/arch/sh/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/sh/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/sh/kernel/time.c
@@ -56,10 +56,6 @@ extern unsigned long wall_jiffies;
 #define TICK_SIZE (tick_nsec / 1000)
 DEFINE_SPINLOCK(tmu0_lock);
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 /* XXX: Can we initialize this in a routine somewhere?  Dreamcast doesn't want
  * these routines anywhere... */
 #ifdef CONFIG_SH_RTC
Index: linux-2.6.14-rc4-tod/arch/sparc/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/sparc/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/sparc/kernel/time.c
@@ -45,10 +45,6 @@
 
 extern unsigned long wall_jiffies;
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 DEFINE_SPINLOCK(rtc_lock);
 enum sparc_clock_type sp_clock_typ;
 DEFINE_SPINLOCK(mostek_lock);
Index: linux-2.6.14-rc4-tod/arch/sparc64/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/sparc64/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/sparc64/kernel/time.c
@@ -55,10 +55,6 @@ unsigned long ds1287_regs = 0UL;
 
 extern unsigned long wall_jiffies;
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 static void __iomem *mstk48t08_regs;
 static void __iomem *mstk48t59_regs;
 
Index: linux-2.6.14-rc4-tod/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/um/kernel/time_kern.c
+++ linux-2.6.14-rc4-tod/arch/um/kernel/time_kern.c
@@ -22,10 +22,6 @@
 #include "mode.h"
 #include "os.h"
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 int hz(void)
 {
 	return(HZ);
Index: linux-2.6.14-rc4-tod/arch/v850/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/v850/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/v850/kernel/time.c
@@ -26,10 +26,6 @@
 
 #include "mach.h"
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 #define TICK_SIZE	(tick_nsec / 1000)
 
 /*
Index: linux-2.6.14-rc4-tod/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/x86_64/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/x86_64/kernel/time.c
@@ -42,10 +42,6 @@
 #include <asm/apic.h>
 #endif
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
-EXPORT_SYMBOL(jiffies_64);
-
 #ifdef CONFIG_CPU_FREQ
 static void cpufreq_delayed_get(void);
 #endif
Index: linux-2.6.14-rc4-tod/arch/xtensa/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/xtensa/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/xtensa/kernel/time.c
@@ -29,9 +29,6 @@
 
 extern volatile unsigned long wall_jiffies;
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-EXPORT_SYMBOL(jiffies_64);
-
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(rtc_lock);
 
Index: linux-2.6.14-rc4-tod/kernel/timer.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/kernel/timer.c
+++ linux-2.6.14-rc4-tod/kernel/timer.c
@@ -46,6 +46,10 @@ static void time_interpolator_update(lon
 #define time_interpolator_update(x)
 #endif
 
+u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
+
+EXPORT_SYMBOL(jiffies_64);
+
 /*
  * per-CPU timer vector definitions:
  */
Index: linux-2.6.14-rc4-tod/arch/sh64/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-tod.orig/arch/sh64/kernel/time.c
+++ linux-2.6.14-rc4-tod/arch/sh64/kernel/time.c
@@ -116,8 +116,6 @@
 
 extern unsigned long wall_jiffies;
 
-u64 jiffies_64 = INITIAL_JIFFIES;
-
 static unsigned long tmu_base, rtc_base;
 unsigned long cprc_base;
 


