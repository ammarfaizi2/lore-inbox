Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263634AbUJ2WID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbUJ2WID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbUJ2WFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:05:45 -0400
Received: from fmr12.intel.com ([134.134.136.15]:12501 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S263632AbUJ2VhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:37:00 -0400
Date: Fri, 29 Oct 2004 14:36:52 -0700 (PDT)
From: Richard Griffiths <richardx.a.griffiths@intel.com>
X-X-Sender: richardg@mingus.co.intel.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Disable sync of RTC during boot 2.6.10-rc1
Message-ID: <Pine.LNX.4.61.0410291416230.4048@mingus.co.intel.com>
ReplyTo: "Richard Griffiths" <richardx.a.griffiths@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The get_cmos_time routine syncs during the read of the Real Time Clock by 
doing a busy loop, this can take up to a full second. By passing an 
argument to get_cmos_time, the sync can be skipped, thus speeding up the
kernel boot. All other calls to get_cmos_time enable the sync unless 
multiple calls are made from within the same function such as 
time_suspend(), time_resume().

The patch modifies get_cmos_time() for all architectures, but I've only 
tested it on i386.

Richard

  Signed-off-by: Richard Griffiths <richardx.a.griffiths@intel.com>

# arch/cris/kernel/crisksyms.c              |    2 +-
# arch/cris/kernel/time.c                   |    5 +++--
# arch/i386/kernel/apm.c                    |    8 +++++---
# arch/i386/kernel/i386_ksyms.c             |    2 +-
# arch/i386/kernel/time.c                   |   20 ++++++++++++--------
# arch/sh/boards/mpc1211/rtc.c              |   20 +++++++++++---------
# arch/x86_64/kernel/time.c                 |   21 +++++++++++++--------
# arch/x86_64/kernel/x8664_ksyms.c          |    2 +-
# include/asm-i386/mach-default/mach_time.h |   18 ++++++++++--------
# 9 files changed, 57 insertions(+), 41 deletions(-)
#
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/29 13:51:27-07:00 richardg@mingus.co.intel.com 
#   get_cmos_time attempt to sync with the RTC by looping for up to 1 second to
#   to catch the UIP flag changing. By passing an argument to disable the 
#   sync when called from time_init during boot, the time to read the RTC is cut
#   to a few microseconds. The sync is enabled for most other calls to 
#   get_cmos_time.  The code has been done for all architectures, but has only
#   been tested on i386.
# 
# include/asm-i386/mach-default/mach_time.h
#   2004/10/29 13:51:14-07:00 richardg@mingus.co.intel.com +10 -8
#   added an arg to cmos_get_time routines to enable or disable the sync which
#   can take up to one second. Disabled during boot - enabled for most calls.
# 
# arch/x86_64/kernel/x8664_ksyms.c
#   2004/10/29 13:51:14-07:00 richardg@mingus.co.intel.com +1 -1
#   added an arg to cmos_get_time routines to enable or disable the sync which
#   can take up to one second. Disabled during boot - enabled for most calls.
# 
# arch/x86_64/kernel/time.c
#   2004/10/29 13:51:14-07:00 richardg@mingus.co.intel.com +13 -8
#   added an arg to cmos_get_time routines to enable or disable the sync which
#   can take up to one second. Disabled during boot - enabled for most calls.
# 
# arch/sh/boards/mpc1211/rtc.c
#   2004/10/29 13:51:14-07:00 richardg@mingus.co.intel.com +11 -9
#   added an arg to cmos_get_time routines to enable or disable the sync which
#   can take up to one second. Disabled during boot - enabled for most calls.
# 
# arch/i386/kernel/time.c
#   2004/10/29 13:51:14-07:00 richardg@mingus.co.intel.com +12 -8
#   added an arg to cmos_get_time routines to enable or disable the sync which
#   can take up to one second. Disabled during boot - enabled for most calls.
# 
# arch/i386/kernel/i386_ksyms.c
#   2004/10/29 13:51:14-07:00 richardg@mingus.co.intel.com +1 -1
#   added an arg to cmos_get_time routines to enable or disable the sync which
#   can take up to one second. Disabled during boot - enabled for most calls.
# 
# BitKeeper/etc/ignore
#   2004/10/29 13:51:14-07:00 richardg@mingus.co.intel.com +2 -0
#   Added rtcnosync-2.6.10-rc1.patch rtcnosync.patch to the ignore list
# 
# arch/i386/kernel/apm.c
#   2004/10/29 13:51:13-07:00 richardg@mingus.co.intel.com +5 -3
#   added an arg to cmos_get_time routines to enable or disable the sync which
#   can take up to one second. Disabled during boot - enabled for most calls.
# 
# arch/cris/kernel/time.c
#   2004/10/29 13:51:13-07:00 richardg@mingus.co.intel.com +3 -2
#   added an arg to cmos_get_time routines to enable or disable the sync which
#   can take up to one second. Disabled during boot - enabled for most calls.
# 
# arch/cris/kernel/crisksyms.c
#   2004/10/29 13:51:13-07:00 richardg@mingus.co.intel.com +1 -1
#   added an arg to cmos_get_time routines to enable or disable the sync which
#   can take up to one second. Disabled during boot - enabled for most calls.
# 
diff -Nru a/arch/cris/kernel/crisksyms.c b/arch/cris/kernel/crisksyms.c
--- a/arch/cris/kernel/crisksyms.c	2004-10-29 13:52:40 -07:00
+++ b/arch/cris/kernel/crisksyms.c	2004-10-29 13:52:40 -07:00
@@ -22,7 +22,7 @@
  #include <asm/fasttimer.h>

  extern void dump_thread(struct pt_regs *, struct user *);
-extern unsigned long get_cmos_time(void);
+extern unsigned long get_cmos_time(int);
  extern void __Udiv(void);
  extern void __Umod(void);
  extern void __Div(void);
diff -Nru a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
--- a/arch/cris/kernel/time.c	2004-10-29 13:52:40 -07:00
+++ b/arch/cris/kernel/time.c	2004-10-29 13:52:40 -07:00
@@ -173,7 +173,7 @@
  /* grab the time from the RTC chip */

  unsigned long
-get_cmos_time(void)
+get_cmos_time(sync_read)
  {
  	unsigned int year, mon, day, hour, min, sec;

@@ -208,8 +208,9 @@
  void
  update_xtime_from_cmos(void)
  {
+	int sync_read = 0; /* unused */
  	if(have_rtc) {
-		xtime.tv_sec = get_cmos_time();
+		xtime.tv_sec = get_cmos_time(sync_read);
  		xtime.tv_nsec = 0;
  	}
  }
diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	2004-10-29 13:52:40 -07:00
+++ b/arch/i386/kernel/apm.c	2004-10-29 13:52:40 -07:00
@@ -232,7 +232,7 @@
  #include "io_ports.h"

  extern spinlock_t i8253_lock;
-extern unsigned long get_cmos_time(void);
+extern unsigned long get_cmos_time(int);
  extern void machine_real_restart(unsigned char *, int);

  #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
@@ -1147,8 +1147,9 @@

  static void set_time(void)
  {
+	int sync_read = 1;
  	if (got_clock_diff) {	/* Must know time zone in order to set clock */
-		xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
+		xtime.tv_sec = get_cmos_time(sync_read) + clock_cmos_diff;
  		xtime.tv_nsec = 0;
  	}
  }
@@ -1156,10 +1157,11 @@
  static void get_time_diff(void)
  {
  #ifndef CONFIG_APM_RTC_IS_GMT
+	int sync_read = 1;
  	/*
  	 * Estimate time zone so that set_time can update the clock
  	 */
-	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff = -get_cmos_time(sync_read);
  	clock_cmos_diff += get_seconds();
  	got_clock_diff = 1;
  #endif
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	2004-10-29 13:52:40 -07:00
+++ b/arch/i386/kernel/i386_ksyms.c	2004-10-29 13:52:40 -07:00
@@ -57,7 +57,7 @@
  #endif

  extern unsigned long cpu_khz;
-extern unsigned long get_cmos_time(void);
+extern unsigned long get_cmos_time(int);

  /* platform dependent support */
  EXPORT_SYMBOL(boot_cpu_data);
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2004-10-29 13:52:40 -07:00
+++ b/arch/i386/kernel/time.c	2004-10-29 13:52:40 -07:00
@@ -303,7 +303,7 @@
  }

  /* not static: needed by APM */
-unsigned long get_cmos_time(void)
+unsigned long get_cmos_time(int sync_read)
  {
  	unsigned long retval;

@@ -312,7 +312,7 @@
  	if (efi_enabled)
  		retval = efi_get_time();
  	else
-		retval = mach_get_cmos_time();
+		retval = mach_get_cmos_time(sync_read);

  	spin_unlock(&rtc_lock);

@@ -323,20 +323,22 @@

  static int time_suspend(struct sys_device *dev, u32 state)
  {
+	int sync_read = 1;
  	/*
  	 * Estimate time zone so that set_time can update the clock
  	 */
-	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff = -get_cmos_time(sync_read);
  	clock_cmos_diff += get_seconds();
-	sleep_start = get_cmos_time();
+	sleep_start = get_cmos_time(sync_read = 0);
  	return 0;
  }

  static int time_resume(struct sys_device *dev)
  {
+	int sync_read = 1;
  	unsigned long flags;
-	unsigned long sec = get_cmos_time() + clock_cmos_diff;
-	unsigned long sleep_length = get_cmos_time() - sleep_start;
+	unsigned long sec = get_cmos_time(sync_read) + clock_cmos_diff;
+	unsigned long sleep_length = get_cmos_time(sync_read = 0) - sleep_start;

  	write_seqlock_irqsave(&xtime_lock, flags);
  	xtime.tv_sec = sec;
@@ -374,7 +376,8 @@
  /* Duplicate of time_init() below, with hpet_enable part added */
  void __init hpet_time_init(void)
  {
-	xtime.tv_sec = get_cmos_time();
+	int sync_read = 0;
+	xtime.tv_sec = get_cmos_time(sync_read);
  	wall_to_monotonic.tv_sec = -xtime.tv_sec;
  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
  	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
@@ -392,6 +395,7 @@

  void __init time_init(void)
  {
+	int sync_read = 0;
  #ifdef CONFIG_HPET_TIMER
  	if (is_hpet_capable()) {
  		/*
@@ -402,7 +406,7 @@
  		return;
  	}
  #endif
-	xtime.tv_sec = get_cmos_time();
+	xtime.tv_sec = get_cmos_time(sync_read);
  	wall_to_monotonic.tv_sec = -xtime.tv_sec;
  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
  	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
diff -Nru a/arch/sh/boards/mpc1211/rtc.c b/arch/sh/boards/mpc1211/rtc.c
--- a/arch/sh/boards/mpc1211/rtc.c	2004-10-29 13:52:40 -07:00
+++ b/arch/sh/boards/mpc1211/rtc.c	2004-10-29 13:52:40 -07:00
@@ -20,7 +20,7 @@
  #endif

  /* arc/i386/kernel/time.c */
-unsigned long get_cmos_time(void)
+unsigned long get_cmos_time(sync_read))
  {
  	unsigned int year, mon, day, hour, min, sec;
  	int i;
@@ -32,12 +32,14 @@
  	 * Let's hope other operating systems interpret the RTC the same way.
  	 */
  	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
+	if(sync_read){
+		for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
+			if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
+				break;
+		for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
+			if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
+				break;
+	}
  	do { /* Isn't this overkill ? UIP above should guarantee consistency */
  		sec = CMOS_READ(RTC_SECONDS);
  		min = CMOS_READ(RTC_MINUTES);
@@ -63,8 +65,8 @@

  void mpc1211_rtc_gettimeofday(struct timeval *tv)
  {
-
-	tv->tv_sec = get_cmos_time();
+	int sync_read = 1;
+	tv->tv_sec = get_cmos_time(sync_read);
  	tv->tv_usec = 0;
  }

diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	2004-10-29 13:52:40 -07:00
+++ b/arch/x86_64/kernel/time.c	2004-10-29 13:52:40 -07:00
@@ -499,7 +499,7 @@
  	return cycles_2_ns(a);
  }

-unsigned long get_cmos_time(void)
+unsigned long get_cmos_time(sync_read))
  {
  	unsigned int timeout, year, mon, day, hour, min, sec;
  	unsigned char last, this;
@@ -518,10 +518,12 @@
  	timeout = 1000000;
  	last = this = 0;

-	while (timeout && last && !this) {
-		last = this;
-		this = CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP;
-		timeout--;
+	if(sync_read){
+		while (timeout && last && !this) {
+			last = this;
+			this = CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP;
+			timeout--;
+		}
  	}

  /*
@@ -858,6 +860,7 @@
  void __init time_init(void)
  {
  	char *timename;
+	int sync_read = 0;

  #ifdef HPET_HACK_ENABLE_DANGEROUS
          if (!vxtime.hpet_address) {
@@ -874,7 +877,7 @@
  	if (nohpet)
  		vxtime.hpet_address = 0;

-	xtime.tv_sec = get_cmos_time();
+	xtime.tv_sec = get_cmos_time(sync_read);
  	xtime.tv_nsec = 0;

  	set_normalized_timespec(&wall_to_monotonic,
@@ -943,18 +946,20 @@

  static int time_suspend(struct sys_device *dev, u32 state)
  {
+	int sync_read = 1;
  	/*
  	 * Estimate time zone so that set_time can update the clock
  	 */
-	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff = -get_cmos_time(sync_read);
  	clock_cmos_diff += get_seconds();
  	return 0;
  }

  static int time_resume(struct sys_device *dev)
  {
+	int sync_read = 1;
  	unsigned long flags;
-	unsigned long sec = get_cmos_time() + clock_cmos_diff;
+	unsigned long sec = get_cmos_time(sync_read) + clock_cmos_diff;
  	write_seqlock_irqsave(&xtime_lock,flags);
  	xtime.tv_sec = sec;
  	xtime.tv_nsec = 0;
diff -Nru a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
--- a/arch/x86_64/kernel/x8664_ksyms.c	2004-10-29 13:52:40 -07:00
+++ b/arch/x86_64/kernel/x8664_ksyms.c	2004-10-29 13:52:40 -07:00
@@ -45,7 +45,7 @@
  EXPORT_SYMBOL(drive_info);
  #endif

-extern unsigned long get_cmos_time(void);
+extern unsigned long get_cmos_time(int);

  /* platform dependent support */
  EXPORT_SYMBOL(boot_cpu_data);
diff -Nru a/include/asm-i386/mach-default/mach_time.h b/include/asm-i386/mach-default/mach_time.h
--- a/include/asm-i386/mach-default/mach_time.h	2004-10-29 13:52:40 -07:00
+++ b/include/asm-i386/mach-default/mach_time.h	2004-10-29 13:52:40 -07:00
@@ -79,7 +79,7 @@
  	return retval;
  }

-static inline unsigned long mach_get_cmos_time(void)
+static inline unsigned long mach_get_cmos_time(int sync_read)
  {
  	unsigned int year, mon, day, hour, min, sec;
  	int i;
@@ -89,13 +89,15 @@
  	 * RTC registers show the second which has precisely just started.
  	 * Let's hope other operating systems interpret the RTC the same way.
  	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
+	if(sync_read) {
+		/* read RTC exactly on falling edge of update flag */
+		for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
+			if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
+				break;
+		for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
+			if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
+				break;
+	}
  	do { /* Isn't this overkill ? UIP above should guarantee consistency */
  		sec = CMOS_READ(RTC_SECONDS);
  		min = CMOS_READ(RTC_MINUTES);
