Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbULLCMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbULLCMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 21:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbULLCML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 21:12:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34821 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262047AbULLCLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 21:11:12 -0500
Date: Sun, 12 Dec 2004 03:11:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] hpet: make some code static
Message-ID: <20041212021103.GO22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 arch/i386/kernel/time.c              |    2 +-
 arch/i386/kernel/time_hpet.c         |   10 +++++-----
 arch/i386/kernel/timers/timer_hpet.c |    2 +-
 arch/x86_64/kernel/time.c            |    2 +-
 include/asm-i386/hpet.h              |    2 --
 5 files changed, 8 insertions(+), 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/asm-i386/hpet.h.old	2004-12-11 23:47:52.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-i386/hpet.h	2004-12-11 23:49:41.000000000 +0100
@@ -90,7 +90,6 @@
  */
 #define HPET_MIN_PERIOD (100000UL)
 
-extern unsigned long hpet_period;	/* fsecs / HPET clock */
 extern unsigned long hpet_tick;  	/* hpet clks count per tick */
 extern unsigned long hpet_address;	/* hpet memory map physical address */
 
@@ -100,7 +99,6 @@
 extern int is_hpet_enabled(void);
 extern int is_hpet_capable(void);
 extern int hpet_readl(unsigned long a);
-extern void hpet_writel(unsigned long d, unsigned long a);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 extern int hpet_mask_rtc_irq_bit(unsigned long bit_mask);
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/time_hpet.c.old	2004-12-11 23:48:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/time_hpet.c	2004-12-11 23:50:22.000000000 +0100
@@ -23,9 +23,9 @@
 #include <asm/hpet.h>
 #include <linux/hpet.h>
 
-unsigned long hpet_period;	/* fsecs / HPET clock */
-unsigned long hpet_tick;	/* hpet clks count per tick */
-unsigned long hpet_address;	/* hpet memory map physical address */
+static unsigned long hpet_period;	/* fsecs / HPET clock */
+unsigned long hpet_tick;		/* hpet clks count per tick */
+unsigned long hpet_address;		/* hpet memory map physical address */
 
 static int use_hpet; 		/* can be used for runtime check of hpet */
 static int boot_hpet_disable; 	/* boottime override for HPET timer */
@@ -38,7 +38,7 @@
 	return readl(hpet_virt_address + a);
 }
 
-void hpet_writel(unsigned long d, unsigned long a)
+static void hpet_writel(unsigned long d, unsigned long a)
 {
 	writel(d, hpet_virt_address + a);
 }
@@ -49,7 +49,7 @@
  * comparator value and continue. Next tick can be caught by checking
  * for a change in the comparator value. Used in apic.c.
  */
-void __init wait_hpet_tick(void)
+static void __init wait_hpet_tick(void)
 {
 	unsigned int start_cmp_val, end_cmp_val;
 
--- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/time.c.old	2004-12-11 23:49:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/time.c	2004-12-11 23:49:14.000000000 +0100
@@ -58,7 +58,7 @@
 #undef HPET_HACK_ENABLE_DANGEROUS
 
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
-unsigned long hpet_period;				/* fsecs / HPET clock */
+static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 unsigned long vxtime_hz = PIT_TICK_RATE;
 int report_lost_ticks;				/* command line option */
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/timers/timer_hpet.c.old	2004-12-11 23:50:57.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/timers/timer_hpet.c	2004-12-11 23:51:07.000000000 +0100
@@ -118,7 +118,7 @@
 	write_sequnlock(&monotonic_lock);
 }
 
-void delay_hpet(unsigned long loops)
+static void delay_hpet(unsigned long loops)
 {
 	unsigned long hpet_start, hpet_end;
 	unsigned long eax;
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/time.c.old	2004-12-11 23:46:37.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/time.c	2004-12-11 23:47:02.000000000 +0100
@@ -379,7 +379,7 @@
 #ifdef CONFIG_HPET_TIMER
 extern void (*late_time_init)(void);
 /* Duplicate of time_init() below, with hpet_enable part added */
-void __init hpet_time_init(void)
+static void __init hpet_time_init(void)
 {
 	xtime.tv_sec = get_cmos_time();
 	wall_to_monotonic.tv_sec = -xtime.tv_sec;

