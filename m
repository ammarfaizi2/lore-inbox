Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWEPRsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWEPRsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWEPRrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:47:39 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:1617 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932453AbWEPRr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:47:26 -0400
Message-ID: <446A1023.6020108@de.ibm.com>
Date: Tue, 16 May 2006 19:47:15 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, hch@infradead.org,
       arjan@infradead.org, James.Smart@Emulex.Com,
       James.Bottomley@SteelEye.com
Subject: [RFC] [Patch 7/8] statistics infrastructure - exploitation prerequisite
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

need sched_clock for latency statistics

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

  alpha/kernel/time.c            |    1 +
  arm/kernel/time.c              |    1 +
  arm/mach-omap1/time.c          |    1 +
  arm/mach-realview/core.c       |    1 +
  arm/mach-sa1100/generic.c      |    1 +
  arm/mach-versatile/core.c      |    1 +
  arm/plat-omap/timer32k.c       |    1 +
  arm26/kernel/time.c            |    1 +
  cris/kernel/time.c             |    1 +
  frv/kernel/time.c              |    1 +
  h8300/kernel/time.c            |    3 ++-
  i386/kernel/timers/timer_tsc.c |    1 +
  m32r/kernel/time.c             |    1 +
  m68k/kernel/time.c             |    2 +-
  m68knommu/kernel/time.c        |    4 +++-
  mips/kernel/time.c             |    1 +
  parisc/kernel/time.c           |    1 +
  powerpc/kernel/time.c          |    1 +
  ppc/kernel/time.c              |    1 +
  s390/kernel/time.c             |    1 +
  sh/kernel/time.c               |    1 +
  sh64/kernel/time.c             |    2 +-
  sparc/kernel/time.c            |    1 +
  sparc64/kernel/time.c          |    1 +
  um/kernel/time_kern.c          |    1 +
  v850/kernel/time.c             |    1 +
  x86_64/kernel/time.c           |    1 +
  xtensa/kernel/time.c           |    1 +
  28 files changed, 31 insertions(+), 4 deletions(-)

diff -Nurp a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
--- a/arch/alpha/kernel/time.c	2006-05-15 12:42:07.000000000 +0200
+++ b/arch/alpha/kernel/time.c	2006-05-15 17:36:14.000000000 +0200
@@ -101,6 +101,7 @@ unsigned long long sched_clock(void)
  {
          return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);


  /*
diff -Nurp a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
--- a/arch/arm/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/arm/kernel/time.c	2006-05-15 17:36:51.000000000 +0200
@@ -84,6 +84,7 @@ unsigned long long __attribute__((weak))
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  static unsigned long next_rtc_update;

diff -Nurp a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
--- a/arch/arm/mach-omap1/time.c	2006-05-15 12:42:07.000000000 +0200
+++ b/arch/arm/mach-omap1/time.c	2006-05-15 17:37:24.000000000 +0200
@@ -220,6 +220,7 @@ unsigned long long sched_clock(void)

  	return cycles_2_ns(ticks64);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  /*
   * ---------------------------------------------------------------------------
diff -Nurp a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
--- a/arch/arm/mach-realview/core.c	2006-05-15 12:42:07.000000000 +0200
+++ b/arch/arm/mach-realview/core.c	2006-05-15 17:38:47.000000000 +0200
@@ -62,6 +62,7 @@ unsigned long long sched_clock(void)

  	return v;
  }
+EXPORT_SYMBOL_GPL(sched_clock);


  #define REALVIEW_FLASHCTRL    (__io_address(REALVIEW_SYS_BASE) + 
REALVIEW_SYS_FLASH_OFFSET)
diff -Nurp a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
--- a/arch/arm/mach-sa1100/generic.c	2006-05-15 12:42:07.000000000 +0200
+++ b/arch/arm/mach-sa1100/generic.c	2006-05-15 17:39:43.000000000 +0200
@@ -131,6 +131,7 @@ unsigned long long sched_clock(void)

  	return v;
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  /*
   * Default power-off for SA1100
diff -Nurp a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
--- a/arch/arm/mach-versatile/core.c	2006-05-15 12:42:07.000000000 +0200
+++ b/arch/arm/mach-versatile/core.c	2006-05-15 17:40:17.000000000 +0200
@@ -239,6 +239,7 @@ unsigned long long sched_clock(void)

  	return v;
  }
+EXPORT_SYMBOL_GPL(sched_clock);


  #define VERSATILE_FLASHCTRL    (__io_address(VERSATILE_SYS_BASE) + 
VERSATILE_SYS_FLASH_OFFSET)
diff -Nurp a/arch/arm/plat-omap/timer32k.c b/arch/arm/plat-omap/timer32k.c
--- a/arch/arm/plat-omap/timer32k.c	2006-05-15 12:42:07.000000000 +0200
+++ b/arch/arm/plat-omap/timer32k.c	2006-05-15 17:41:02.000000000 +0200
@@ -188,6 +188,7 @@ unsigned long long sched_clock(void)
  {
  	return omap_32k_ticks_to_nsecs(omap_32k_sync_timer_read());
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  /*
   * Timer interrupt for 32KHz timer. When dynamic tick is enabled, this
diff -Nurp a/arch/arm26/kernel/time.c b/arch/arm26/kernel/time.c
--- a/arch/arm26/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/arm26/kernel/time.c	2006-05-15 17:41:39.000000000 +0200
@@ -99,6 +99,7 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  static unsigned long next_rtc_update;

diff -Nurp a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
--- a/arch/cris/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/cris/kernel/time.c	2006-05-15 17:42:25.000000000 +0200
@@ -231,6 +231,7 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  static int
  __init init_udelay(void)
diff -Nurp a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
--- a/arch/frv/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/frv/kernel/time.c	2006-05-15 17:42:56.000000000 +0200
@@ -230,3 +230,4 @@ unsigned long long sched_clock(void)
  {
  	return jiffies_64 * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);
diff -Nurp a/arch/h8300/kernel/time.c b/arch/h8300/kernel/time.c
--- a/arch/h8300/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/h8300/kernel/time.c	2006-05-15 17:43:40.000000000 +0200
@@ -123,5 +123,6 @@ EXPORT_SYMBOL(do_settimeofday);
  unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
-
  }
+
+EXPORT_SYMBOL_GPL(sched_clock);
diff -Nurp a/arch/i386/kernel/timers/timer_tsc.c 
b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	2006-05-15 12:42:07.000000000 +0200
+++ b/arch/i386/kernel/timers/timer_tsc.c	2006-05-15 17:44:11.000000000 +0200
@@ -167,6 +167,7 @@ unsigned long long sched_clock(void)
  	/* return the value in ns */
  	return cycles_2_ns(this_offset);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  static void delay_tsc(unsigned long loops)
  {
diff -Nurp a/arch/m32r/kernel/time.c b/arch/m32r/kernel/time.c
--- a/arch/m32r/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/m32r/kernel/time.c	2006-05-15 17:44:58.000000000 +0200
@@ -304,3 +304,4 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);
diff -Nurp a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
--- a/arch/m68k/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/m68k/kernel/time.c	2006-05-15 17:45:29.000000000 +0200
@@ -177,4 +177,4 @@ unsigned long long sched_clock(void)
  {
         return (unsigned long long)jiffies*(1000000000/HZ);
  }
-
+EXPORT_SYMBOL_GPL(sched_clock);
diff -Nurp a/arch/m68knommu/kernel/time.c b/arch/m68knommu/kernel/time.c
--- a/arch/m68knommu/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/m68knommu/kernel/time.c	2006-05-15 17:46:26.000000000 +0200
@@ -180,6 +180,8 @@ int do_settimeofday(struct timespec *tv)
  	return 0;
  }

+EXPORT_SYMBOL(do_settimeofday);
+
  /*
   * Scheduler clock - returns current time in nanosec units.
   */
@@ -188,4 +190,4 @@ unsigned long long sched_clock(void)
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }

-EXPORT_SYMBOL(do_settimeofday);
+EXPORT_SYMBOL_GPL(sched_clock);
diff -Nurp a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
--- a/arch/mips/kernel/time.c	2006-05-15 12:42:07.000000000 +0200
+++ b/arch/mips/kernel/time.c	2006-05-15 17:47:00.000000000 +0200
@@ -778,3 +778,4 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies*(1000000000/HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);
diff -Nurp a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
--- a/arch/parisc/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/parisc/kernel/time.c	2006-05-15 17:47:34.000000000 +0200
@@ -211,6 +211,7 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);


  void __init time_init(void)
diff -Nurp a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
--- a/arch/powerpc/kernel/time.c	2006-05-15 12:42:07.000000000 +0200
+++ b/arch/powerpc/kernel/time.c	2006-05-15 17:48:03.000000000 +0200
@@ -781,6 +781,7 @@ unsigned long long sched_clock(void)
  		return get_rtc();
  	return mulhdu(get_tb(), tb_to_ns_scale) << tb_to_ns_shift;
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  int do_settimeofday(struct timespec *tv)
  {
diff -Nurp a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/ppc/kernel/time.c	2006-05-15 17:48:38.000000000 +0200
@@ -445,3 +445,4 @@ unsigned long long sched_clock(void)
  	}
  	return tb;
  }
+EXPORT_SYMBOL_GPL(sched_clock);
diff -Nurp a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
--- a/arch/s390/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/s390/kernel/time.c	2006-05-15 17:49:11.000000000 +0200
@@ -63,6 +63,7 @@ unsigned long long sched_clock(void)
  {
  	return ((get_clock() - jiffies_timer_cc) * 125) >> 9;
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  /*
   * Monotonic_clock - returns # of nanoseconds passed since time_init()
diff -Nurp a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
--- a/arch/sh/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/sh/kernel/time.c	2006-05-15 17:49:42.000000000 +0200
@@ -44,6 +44,7 @@ unsigned long long __attribute__ ((weak)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  void do_gettimeofday(struct timeval *tv)
  {
diff -Nurp a/arch/sh64/kernel/time.c b/arch/sh64/kernel/time.c
--- a/arch/sh64/kernel/time.c	2006-05-15 12:42:08.000000000 +0200
+++ b/arch/sh64/kernel/time.c	2006-05-15 17:50:09.000000000 +0200
@@ -598,4 +598,4 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
-
+EXPORT_SYMBOL_GPL(sched_clock);
diff -Nurp a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
--- a/arch/sparc/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/sparc/kernel/time.c	2006-05-15 17:50:42.000000000 +0200
@@ -466,6 +466,7 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  /* Ok, my cute asm atomicity trick doesn't work anymore.
   * There are just too many variables that need to be protected
diff -Nurp a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
--- a/arch/sparc64/kernel/time.c	2006-05-15 12:42:08.000000000 +0200
+++ b/arch/sparc64/kernel/time.c	2006-05-15 17:51:19.000000000 +0200
@@ -1135,6 +1135,7 @@ unsigned long long sched_clock(void)
  	return (ticks * timer_ticks_per_nsec_quotient)
  		>> SPARC64_NSEC_PER_CYC_SHIFT;
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  static int set_rtc_mmss(unsigned long nowtime)
  {
diff -Nurp a/arch/um/kernel/time_kern.c b/arch/um/kernel/time_kern.c
--- a/arch/um/kernel/time_kern.c	2006-05-15 12:42:08.000000000 +0200
+++ b/arch/um/kernel/time_kern.c	2006-05-15 17:51:46.000000000 +0200
@@ -34,6 +34,7 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  /* Changed at early boot */
  int timer_irq_inited = 0;
diff -Nurp a/arch/v850/kernel/time.c b/arch/v850/kernel/time.c
--- a/arch/v850/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/v850/kernel/time.c	2006-05-15 17:52:11.000000000 +0200
@@ -35,6 +35,7 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  /*
   * timer_interrupt() needs to keep up the real-time clock,
diff -Nurp a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	2006-05-15 12:42:08.000000000 +0200
+++ b/arch/x86_64/kernel/time.c	2006-05-15 17:52:39.000000000 +0200
@@ -501,6 +501,7 @@ unsigned long long sched_clock(void)
  	rdtscll(a);
  	return cycles_2_ns(a);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  static unsigned long get_cmos_time(void)
  {
diff -Nurp a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
--- a/arch/xtensa/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/xtensa/kernel/time.c	2006-05-15 17:53:03.000000000 +0200
@@ -49,6 +49,7 @@ unsigned long long sched_clock(void)
  {
  	return (unsigned long long)jiffies * (1000000000 / HZ);
  }
+EXPORT_SYMBOL_GPL(sched_clock);

  static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
  static struct irqaction timer_irqaction = {

