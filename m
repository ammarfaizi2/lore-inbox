Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWBZXQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWBZXQF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWBZXPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:15:54 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:30245 "EHLO
	linux") by vger.kernel.org with ESMTP id S1751428AbWBZXOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:14:50 -0500
Message-Id: <20060226231438.898233000@towertech.it>
References: <20060226231438.307751000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 27 Feb 2006 00:14:41 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
       Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 03/13] RTC subsystem, MIPS cleanup
Content-Disposition: inline; filename=rtc-mips-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the collision of rtc function name.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/mips/ddb5xxx/common/rtc_ds1386.c                      |    4 +-
 arch/mips/dec/time.c                                       |    4 +-
 arch/mips/ite-boards/generic/time.c                        |    4 +-
 arch/mips/jmr3927/common/rtc_ds1742.c                      |    4 +-
 arch/mips/kernel/time.c                                    |   22 ++++++-------
 arch/mips/lasat/setup.c                                    |    4 +-
 arch/mips/mips-boards/atlas/atlas_setup.c                  |    2 -
 arch/mips/mips-boards/malta/malta_setup.c                  |    2 -
 arch/mips/momentum/jaguar_atx/setup.c                      |    4 +-
 arch/mips/momentum/ocelot_3/setup.c                        |    4 +-
 arch/mips/momentum/ocelot_c/setup.c                        |    4 +-
 arch/mips/pmc-sierra/yosemite/setup.c                      |    4 +-
 arch/mips/sgi-ip22/ip22-time.c                             |    4 +-
 arch/mips/sgi-ip32/ip32-setup.c                            |    4 +-
 arch/mips/sibyte/swarm/setup.c                             |    8 ++--
 arch/mips/sni/setup.c                                      |    4 +-
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c |    4 +-
 arch/mips/tx4938/common/rtc_rx5c348.c                      |    4 +-
 include/asm-mips/time.h                                    |   12 +++----
 19 files changed, 51 insertions(+), 51 deletions(-)
--- linux-rtc.orig/arch/mips/ddb5xxx/common/rtc_ds1386.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/ddb5xxx/common/rtc_ds1386.c	2006-02-26 23:21:56.000000000 +0100
@@ -165,6 +165,6 @@ rtc_ds1386_init(unsigned long base)
 	WRITE_RTC(0xB, byte);
 
 	/* set the function pointers */
-	rtc_get_time = rtc_ds1386_get_time;
-	rtc_set_time = rtc_ds1386_set_time;
+	rtc_mips_get_time = rtc_ds1386_get_time;
+	rtc_mips_set_time = rtc_ds1386_set_time;
 }
--- linux-rtc.orig/arch/mips/dec/time.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/dec/time.c	2006-02-26 23:21:56.000000000 +0100
@@ -193,8 +193,8 @@ static void dec_ioasic_hpt_init(unsigned
 
 void __init dec_time_init(void)
 {
-	rtc_get_time = dec_rtc_get_time;
-	rtc_set_mmss = dec_rtc_set_mmss;
+	rtc_mips_get_time = dec_rtc_get_time;
+	rtc_mips_set_mmss = dec_rtc_set_mmss;
 
 	mips_timer_state = dec_timer_state;
 	mips_timer_ack = dec_timer_ack;
--- linux-rtc.orig/arch/mips/ite-boards/generic/time.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/ite-boards/generic/time.c	2006-02-26 23:21:56.000000000 +0100
@@ -227,8 +227,8 @@ void __init it8172_time_init(void)
 
 	local_irq_restore(flags);
 
-	rtc_get_time = it8172_rtc_get_time;
-	rtc_set_time = it8172_rtc_set_time;
+	rtc_mips_get_time = it8172_rtc_get_time;
+	rtc_mips_set_time = it8172_rtc_set_time;
 }
 
 #define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
--- linux-rtc.orig/arch/mips/jmr3927/common/rtc_ds1742.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/jmr3927/common/rtc_ds1742.c	2006-02-26 23:21:56.000000000 +0100
@@ -159,8 +159,8 @@ rtc_ds1742_init(unsigned long base)
 	db_assert((rtc_base & 0xe0000000) == KSEG1);
 
 	/* set the function pointers */
-	rtc_get_time = rtc_ds1742_get_time;
-	rtc_set_time = rtc_ds1742_set_time;
+	rtc_mips_get_time = rtc_ds1742_get_time;
+	rtc_mips_set_time = rtc_ds1742_set_time;
 
 	/* clear oscillator stop bit */
 	CMOS_WRITE(RTC_READ, RTC_CONTROL);
--- linux-rtc.orig/arch/mips/kernel/time.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/kernel/time.c	2006-02-26 23:21:56.000000000 +0100
@@ -65,9 +65,9 @@ static int null_rtc_set_time(unsigned lo
 	return 0;
 }
 
-unsigned long (*rtc_get_time)(void) = null_rtc_get_time;
-int (*rtc_set_time)(unsigned long) = null_rtc_set_time;
-int (*rtc_set_mmss)(unsigned long);
+unsigned long (*rtc_mips_get_time)(void) = null_rtc_get_time;
+int (*rtc_mips_set_time)(unsigned long) = null_rtc_set_time;
+int (*rtc_mips_set_mmss)(unsigned long);
 
 
 /* usecs per counter cycle, shifted to left by 32 bits */
@@ -437,7 +437,7 @@ irqreturn_t timer_interrupt(int irq, voi
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
-	 * CMOS clock accordingly every ~11 minutes. rtc_set_time() has to be
+	 * CMOS clock accordingly every ~11 minutes. rtc_mips_set_time() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
 	write_seqlock(&xtime_lock);
@@ -445,7 +445,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
-		if (rtc_set_mmss(xtime.tv_sec) == 0) {
+		if (rtc_mips_set_mmss(xtime.tv_sec) == 0) {
 			last_rtc_update = xtime.tv_sec;
 		} else {
 			/* do it again in 60 s */
@@ -562,7 +562,7 @@ asmlinkage void ll_local_timer_interrupt
  *      b) (optional) calibrate and set the mips_hpt_frequency
  *	    (only needed if you intended to use fixed_rate_gettimeoffset
  *	     or use cpu counter as timer interrupt source)
- * 2) setup xtime based on rtc_get_time().
+ * 2) setup xtime based on rtc_mips_get_time().
  * 3) choose a appropriate gettimeoffset routine.
  * 4) calculate a couple of cached variables for later usage
  * 5) board_timer_setup() -
@@ -630,10 +630,10 @@ void __init time_init(void)
 	if (board_time_init)
 		board_time_init();
 
-	if (!rtc_set_mmss)
-		rtc_set_mmss = rtc_set_time;
+	if (!rtc_mips_set_mmss)
+		rtc_mips_set_mmss = rtc_mips_set_time;
 
-	xtime.tv_sec = rtc_get_time();
+	xtime.tv_sec = rtc_mips_get_time();
 	xtime.tv_nsec = 0;
 
 	set_normalized_timespec(&wall_to_monotonic,
@@ -769,8 +769,8 @@ void to_tm(unsigned long tim, struct rtc
 
 EXPORT_SYMBOL(rtc_lock);
 EXPORT_SYMBOL(to_tm);
-EXPORT_SYMBOL(rtc_set_time);
-EXPORT_SYMBOL(rtc_get_time);
+EXPORT_SYMBOL(rtc_mips_set_time);
+EXPORT_SYMBOL(rtc_mips_get_time);
 
 unsigned long long sched_clock(void)
 {
--- linux-rtc.orig/arch/mips/lasat/setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/lasat/setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -174,8 +174,8 @@ void __init plat_setup(void)
 
 #ifdef CONFIG_DS1603
 	ds1603 = &ds_defs[mips_machtype];
-	rtc_get_time = ds1603_read;
-	rtc_set_time = ds1603_set;
+	rtc_mips_get_time = ds1603_read;
+	rtc_mips_set_time = ds1603_set;
 #endif
 
 #ifdef DYNAMIC_SERIAL_INIT
--- linux-rtc.orig/arch/mips/mips-boards/atlas/atlas_setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/mips-boards/atlas/atlas_setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -65,7 +65,7 @@ void __init plat_setup(void)
 
 	board_time_init = mips_time_init;
 	board_timer_setup = mips_timer_setup;
-	rtc_get_time = mips_rtc_get_time;
+	rtc_mips_get_time = mips_rtc_get_time;
 }
 
 static void __init serial_init(void)
--- linux-rtc.orig/arch/mips/mips-boards/malta/malta_setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/mips-boards/malta/malta_setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -225,5 +225,5 @@ void __init plat_setup(void)
 
 	board_time_init = mips_time_init;
 	board_timer_setup = mips_timer_setup;
-	rtc_get_time = mips_rtc_get_time;
+	rtc_mips_get_time = mips_rtc_get_time;
 }
--- linux-rtc.orig/arch/mips/momentum/jaguar_atx/setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/momentum/jaguar_atx/setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -228,8 +228,8 @@ void momenco_time_init(void)
 	mips_hpt_frequency = cpu_clock / 2;
 	board_timer_setup = momenco_timer_setup;
 
-	rtc_get_time = m48t37y_get_time;
-	rtc_set_time = m48t37y_set_time;
+	rtc_mips_get_time = m48t37y_get_time;
+	rtc_mips_set_time = m48t37y_set_time;
 }
 
 static struct resource mv_pci_io_mem0_resource = {
--- linux-rtc.orig/arch/mips/momentum/ocelot_3/setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/momentum/ocelot_3/setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -215,8 +215,8 @@ void momenco_time_init(void)
 	mips_hpt_frequency = cpu_clock / 2;
 	board_timer_setup = momenco_timer_setup;
 
-	rtc_get_time = m48t37y_get_time;
-	rtc_set_time = m48t37y_set_time;
+	rtc_mips_get_time = m48t37y_get_time;
+	rtc_mips_set_time = m48t37y_set_time;
 }
 
 /*
--- linux-rtc.orig/arch/mips/momentum/ocelot_c/setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/momentum/ocelot_c/setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -226,8 +226,8 @@ void momenco_time_init(void)
 	printk("momenco_time_init cpu_clock=%d\n", cpu_clock);
 	board_timer_setup = momenco_timer_setup;
 
-	rtc_get_time = m48t37y_get_time;
-	rtc_set_time = m48t37y_set_time;
+	rtc_mips_get_time = m48t37y_get_time;
+	rtc_mips_set_time = m48t37y_set_time;
 }
 
 void __init plat_setup(void)
--- linux-rtc.orig/arch/mips/pmc-sierra/yosemite/setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/pmc-sierra/yosemite/setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -198,8 +198,8 @@ static void __init py_rtc_setup(void)
 	if (!m48t37_base)
 		printk(KERN_ERR "Mapping the RTC failed\n");
 
-	rtc_get_time = m48t37y_get_time;
-	rtc_set_time = m48t37y_set_time;
+	rtc_mips_get_time = m48t37y_get_time;
+	rtc_mips_set_time = m48t37y_set_time;
 
 	write_seqlock(&xtime_lock);
 	xtime.tv_sec = m48t37y_get_time();
--- linux-rtc.orig/arch/mips/sgi-ip22/ip22-time.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/sgi-ip22/ip22-time.c	2006-02-26 23:21:56.000000000 +0100
@@ -212,8 +212,8 @@ static void indy_timer_setup(struct irqa
 void __init ip22_time_init(void)
 {
 	/* setup hookup functions */
-	rtc_get_time = indy_rtc_get_time;
-	rtc_set_time = indy_rtc_set_time;
+	rtc_mips_get_time = indy_rtc_get_time;
+	rtc_mips_set_time = indy_rtc_set_time;
 
 	board_time_init = indy_time_init;
 	board_timer_setup = indy_timer_setup;
--- linux-rtc.orig/arch/mips/sgi-ip32/ip32-setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/sgi-ip32/ip32-setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -91,8 +91,8 @@ void __init plat_setup(void)
 {
 	board_be_init = ip32_be_init;
 
-	rtc_get_time = mc146818_get_cmos_time;
-	rtc_set_mmss = mc146818_set_rtc_mmss;
+	rtc_mips_get_time = mc146818_get_cmos_time;
+	rtc_mips_set_mmss = mc146818_set_rtc_mmss;
 
 	board_time_init = ip32_time_init;
 	board_timer_setup = ip32_timer_setup;
--- linux-rtc.orig/arch/mips/sibyte/swarm/setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/sibyte/swarm/setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -114,14 +114,14 @@ void __init plat_setup(void)
 
 	if (xicor_probe()) {
 		printk("swarm setup: Xicor 1241 RTC detected.\n");
-		rtc_get_time = xicor_get_time;
-		rtc_set_time = xicor_set_time;
+		rtc_mips_get_time = xicor_get_time;
+		rtc_mips_set_time = xicor_set_time;
 	}
 
 	if (m41t81_probe()) {
 		printk("swarm setup: M41T81 RTC detected.\n");
-		rtc_get_time = m41t81_get_time;
-		rtc_set_time = m41t81_set_time;
+		rtc_mips_get_time = m41t81_get_time;
+		rtc_mips_set_time = m41t81_set_time;
 	}
 
 	printk("This kernel optimized for "
--- linux-rtc.orig/arch/mips/sni/setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/sni/setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -164,8 +164,8 @@ static struct pci_controller sni_control
 
 static inline void sni_pcimt_time_init(void)
 {
-	rtc_get_time = mc146818_get_cmos_time;
-	rtc_set_time = mc146818_set_rtc_mmss;
+	rtc_mips_get_time = mc146818_get_cmos_time;
+	rtc_mips_set_time = mc146818_set_rtc_mmss;
 }
 
 void __init plat_setup(void)
--- linux-rtc.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2006-02-26 23:21:56.000000000 +0100
@@ -1036,8 +1036,8 @@ toshiba_rbtx4927_time_init(void)
 
 #ifdef CONFIG_RTC_DS1742
 
-	rtc_get_time = rtc_ds1742_get_time;
-	rtc_set_time = rtc_ds1742_set_time;
+	rtc_mips_get_time = rtc_ds1742_get_time;
+	rtc_mips_set_time = rtc_ds1742_set_time;
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
 				       ":rtc_ds1742_init()-\n");
--- linux-rtc.orig/arch/mips/tx4938/common/rtc_rx5c348.c	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/arch/mips/tx4938/common/rtc_rx5c348.c	2006-02-26 23:21:56.000000000 +0100
@@ -197,6 +197,6 @@ rtc_rx5c348_init(int chipid)
 		srtc_24h = 1;
 
 	/* set the function pointers */
-	rtc_get_time = rtc_rx5c348_get_time;
-	rtc_set_time = rtc_rx5c348_set_time;
+	rtc_mips_get_time = rtc_rx5c348_get_time;
+	rtc_mips_set_time = rtc_rx5c348_set_time;
 }
--- linux-rtc.orig/include/asm-mips/time.h	2006-02-26 23:19:44.000000000 +0100
+++ linux-rtc/include/asm-mips/time.h	2006-02-26 23:21:56.000000000 +0100
@@ -26,14 +26,14 @@ extern spinlock_t rtc_lock;
 
 /*
  * RTC ops.  By default, they point to no-RTC functions.
- *	rtc_get_time - mktime(year, mon, day, hour, min, sec) in seconds.
- *	rtc_set_time - reverse the above translation and set time to RTC.
- *	rtc_set_mmss - similar to rtc_set_time, but only min and sec need
+ *	rtc_mips_get_time - mktime(year, mon, day, hour, min, sec) in seconds.
+ *	rtc_mips_set_time - reverse the above translation and set time to RTC.
+ *	rtc_mips_set_mmss - similar to rtc_set_time, but only min and sec need
  *			to be set.  Used by RTC sync-up.
  */
-extern unsigned long (*rtc_get_time)(void);
-extern int (*rtc_set_time)(unsigned long);
-extern int (*rtc_set_mmss)(unsigned long);
+extern unsigned long (*rtc_mips_get_time)(void);
+extern int (*rtc_mips_set_time)(unsigned long);
+extern int (*rtc_mips_set_mmss)(unsigned long);
 
 /*
  * Timer interrupt functions.

--
