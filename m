Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVATSXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVATSXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVATSUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:20:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2828 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261392AbVATSRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:17:04 -0500
Date: Thu, 20 Jan 2005 19:17:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] i386: unexport do_settimeofday
Message-ID: <20050120181703.GG3174@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any modular usage of do_settimeofday in the kernel.

Is the patch below correct?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/alpha/kernel/time.c     |    2 --
 arch/arm/kernel/time.c       |    2 --
 arch/arm26/kernel/time.c     |    2 --
 arch/cris/kernel/time.c      |    2 --
 arch/h8300/kernel/time.c     |    2 --
 arch/i386/kernel/time.c      |    2 --
 arch/m32r/kernel/time.c      |    2 --
 arch/m68k/kernel/time.c      |    2 --
 arch/m68knommu/kernel/time.c |    1 -
 arch/mips/dec/time.c         |    2 --
 arch/mips/kernel/time.c      |    2 --
 arch/parisc/kernel/time.c    |    1 -
 arch/ppc/kernel/time.c       |    2 --
 arch/ppc64/kernel/time.c     |    2 --
 arch/s390/kernel/time.c      |    2 --
 arch/sh/kernel/time.c        |    2 --
 arch/sparc/kernel/time.c     |    2 --
 arch/um/kernel/ksyms.c       |    1 -
 arch/v850/kernel/time.c      |    2 --
 arch/x86_64/kernel/time.c    |    2 --
 20 files changed, 37 deletions(-)

--- linux-2.6.11-rc1-mm2-full/arch/i386/kernel/time.c.old	2005-01-20 18:52:12.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/i386/kernel/time.c	2005-01-20 18:52:27.000000000 +0100
@@ -169,8 +169,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 static int set_rtc_mmss(unsigned long nowtime)
 {
 	int retval;
--- linux-2.6.11-rc1-mm2-full/arch/arm/kernel/time.c.old	2005-01-20 18:52:46.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/arm/kernel/time.c	2005-01-20 18:52:51.000000000 +0100
@@ -301,8 +301,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 /**
  * save_time_delta - Save the offset between system time and RTC time
  * @delta: pointer to timespec to store delta
--- linux-2.6.11-rc1-mm2-full/arch/sparc/kernel/time.c.old	2005-01-20 18:52:59.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/sparc/kernel/time.c	2005-01-20 18:53:03.000000000 +0100
@@ -530,8 +530,6 @@
 	return ret;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 static int sbus_do_settimeofday(struct timespec *tv)
 {
 	time_t wtm_sec, sec = tv->tv_sec;
--- linux-2.6.11-rc1-mm2-full/arch/ppc/kernel/time.c.old	2005-01-20 18:53:11.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/ppc/kernel/time.c	2005-01-20 18:53:15.000000000 +0100
@@ -285,8 +285,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 /* This function is only called on the boot processor */
 void __init time_init(void)
 {
--- linux-2.6.11-rc1-mm2-full/arch/mips/dec/time.c.old	2005-01-20 18:53:21.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/mips/dec/time.c	2005-01-20 18:53:25.000000000 +0100
@@ -189,8 +189,6 @@
 	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - LOG_2_HZ), RTC_REG_A);
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 void __init dec_timer_setup(struct irqaction *irq)
 {
 	setup_irq(dec_interrupt[DEC_IRQ_RTC], irq);
--- linux-2.6.11-rc1-mm2-full/arch/mips/kernel/time.c.old	2005-01-20 18:53:32.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/mips/kernel/time.c	2005-01-20 18:53:36.000000000 +0100
@@ -234,8 +234,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 /*
  * Gettimeoffset routines.  These routines returns the time duration
  * since last timer interrupt in usecs.
--- linux-2.6.11-rc1-mm2-full/arch/m68knommu/kernel/time.c.old	2005-01-20 18:53:43.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/m68knommu/kernel/time.c	2005-01-20 18:53:47.000000000 +0100
@@ -195,4 +195,3 @@
 	return (unsigned long long)jiffies * (1000000000 / HZ);
 }
 
-EXPORT_SYMBOL(do_settimeofday);
--- linux-2.6.11-rc1-mm2-full/arch/sh/kernel/time.c.old	2005-01-20 18:53:54.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/sh/kernel/time.c	2005-01-20 18:53:58.000000000 +0100
@@ -254,8 +254,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 /* last time the RTC clock got updated */
 static long last_rtc_update;
 
--- linux-2.6.11-rc1-mm2-full/arch/cris/kernel/time.c.old	2005-01-20 18:54:05.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/cris/kernel/time.c	2005-01-20 18:54:11.000000000 +0100
@@ -122,8 +122,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 
 /*
  * BUG: This routine does not handle hour overflow properly; it just
--- linux-2.6.11-rc1-mm2-full/arch/arm26/kernel/time.c.old	2005-01-20 18:54:18.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/arm26/kernel/time.c	2005-01-20 18:54:22.000000000 +0100
@@ -198,8 +198,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
         do_timer(regs);
--- linux-2.6.11-rc1-mm2-full/arch/m68k/kernel/time.c.old	2005-01-20 18:54:29.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/m68k/kernel/time.c	2005-01-20 18:54:32.000000000 +0100
@@ -175,8 +175,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 /*
  * Scheduler clock - returns current time in ns units.
  */
--- linux-2.6.11-rc1-mm2-full/arch/alpha/kernel/time.c.old	2005-01-20 18:54:44.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/alpha/kernel/time.c	2005-01-20 18:54:48.000000000 +0100
@@ -512,8 +512,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 
 /*
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be
--- linux-2.6.11-rc1-mm2-full/arch/ppc64/kernel/time.c.old	2005-01-20 18:54:56.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/ppc64/kernel/time.c	2005-01-20 18:54:59.000000000 +0100
@@ -424,8 +424,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 void __init time_init(void)
 {
 	/* This function is only called on the boot processor */
--- linux-2.6.11-rc1-mm2-full/arch/um/kernel/ksyms.c.old	2005-01-20 18:55:07.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/um/kernel/ksyms.c	2005-01-20 18:55:11.000000000 +0100
@@ -95,7 +95,6 @@
 EXPORT_SYMBOL(dump_thread);
 
 EXPORT_SYMBOL(do_gettimeofday);
-EXPORT_SYMBOL(do_settimeofday);
 
 /* This is here because UML expands open to sys_open, not to a system
  * call instruction.
--- linux-2.6.11-rc1-mm2-full/arch/parisc/kernel/time.c.old	2005-01-20 18:55:19.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/parisc/kernel/time.c	2005-01-20 18:55:23.000000000 +0100
@@ -197,7 +197,6 @@
 	clock_was_set();
 	return 0;
 }
-EXPORT_SYMBOL(do_settimeofday);
 
 /*
  * XXX: We can do better than this.
--- linux-2.6.11-rc1-mm2-full/arch/h8300/kernel/time.c.old	2005-01-20 18:55:33.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/h8300/kernel/time.c	2005-01-20 18:55:37.000000000 +0100
@@ -125,8 +125,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 unsigned long long sched_clock(void)
 {
 	return (unsigned long long)jiffies * (1000000000 / HZ);
--- linux-2.6.11-rc1-mm2-full/arch/m32r/kernel/time.c.old	2005-01-20 18:55:46.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/m32r/kernel/time.c	2005-01-20 18:55:50.000000000 +0100
@@ -181,8 +181,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 /*
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be
  * called 500 ms after the second nowtime has started, because when
--- linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/time.c.old	2005-01-20 18:55:59.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/time.c	2005-01-20 18:56:02.000000000 +0100
@@ -179,8 +179,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
--- linux-2.6.11-rc1-mm2-full/arch/s390/kernel/time.c.old	2005-01-20 18:56:11.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/s390/kernel/time.c	2005-01-20 18:56:15.000000000 +0100
@@ -148,8 +148,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 
 #ifdef CONFIG_PROFILING
 #define s390_do_profile(regs)	profile_tick(CPU_PROFILING, regs)
--- linux-2.6.11-rc1-mm2-full/arch/v850/kernel/time.c.old	2005-01-20 18:56:22.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/v850/kernel/time.c	2005-01-20 18:56:26.000000000 +0100
@@ -179,8 +179,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(do_settimeofday);
-
 static int timer_dev_id;
 static struct irqaction timer_irqaction = {
 	timer_interrupt,

