Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbVLFAfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbVLFAfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbVLFAfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:30 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27854
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751533AbVLFAef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:35 -0500
Message-Id: <20051206000153.838762000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:34 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 08/21] Coding style and white space cleanup
Content-Disposition: inline; filename=time-h-clean-up-rest.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- style and whitespace cleanup of the rest of time.h.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/time.h |   63 +++++++++++++++++++++++++--------------------------
 1 files changed, 32 insertions(+), 31 deletions(-)

Index: linux-2.6.15-rc5/include/linux/time.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/time.h
+++ linux-2.6.15-rc5/include/linux/time.h
@@ -4,7 +4,7 @@
 #include <linux/types.h>
 
 #ifdef __KERNEL__
-#include <linux/seqlock.h>
+# include <linux/seqlock.h>
 #endif
 
 #ifndef _STRUCT_TIMESPEC
@@ -13,7 +13,7 @@ struct timespec {
 	time_t	tv_sec;		/* seconds */
 	long	tv_nsec;	/* nanoseconds */
 };
-#endif /* _STRUCT_TIMESPEC */
+#endif
 
 struct timeval {
 	time_t		tv_sec;		/* seconds */
@@ -27,16 +27,16 @@ struct timezone {
 
 #ifdef __KERNEL__
 
-/* Parameters used to convert the timespec values */
-#define MSEC_PER_SEC (1000L)
-#define USEC_PER_SEC (1000000L)
-#define NSEC_PER_SEC (1000000000L)
-#define NSEC_PER_USEC (1000L)
+/* Parameters used to convert the timespec values: */
+#define MSEC_PER_SEC		1000L
+#define USEC_PER_SEC		1000000L
+#define NSEC_PER_SEC		1000000000L
+#define NSEC_PER_USEC		1000L
 
-static __inline__ int timespec_equal(struct timespec *a, struct timespec *b) 
-{ 
+static __inline__ int timespec_equal(struct timespec *a, struct timespec *b)
+{
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
-} 
+}
 
 extern unsigned long mktime(const unsigned int year, const unsigned int mon,
 			    const unsigned int day, const unsigned int hour,
@@ -49,25 +49,26 @@ extern struct timespec wall_to_monotonic
 extern seqlock_t xtime_lock;
 
 static inline unsigned long get_seconds(void)
-{ 
+{
 	return xtime.tv_sec;
 }
 
 struct timespec current_kernel_time(void);
 
-#define CURRENT_TIME (current_kernel_time())
-#define CURRENT_TIME_SEC ((struct timespec) { xtime.tv_sec, 0 })
+#define CURRENT_TIME		(current_kernel_time())
+#define CURRENT_TIME_SEC	((struct timespec) { xtime.tv_sec, 0 })
 
 extern void do_gettimeofday(struct timeval *tv);
 extern int do_settimeofday(struct timespec *tv);
 extern int do_sys_settimeofday(struct timespec *tv, struct timezone *tz);
-extern void clock_was_set(void); // call when ever the clock is set
+extern void clock_was_set(void); // call whenever the clock is set
 extern int do_posix_clock_monotonic_gettime(struct timespec *tp);
-extern long do_utimes(char __user * filename, struct timeval * times);
+extern long do_utimes(char __user *filename, struct timeval *times);
 struct itimerval;
-extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
+extern int do_setitimer(int which, struct itimerval *value,
+			struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
-extern void getnstimeofday (struct timespec *tv);
+extern void getnstimeofday(struct timespec *tv);
 
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
 
@@ -83,24 +84,24 @@ extern struct timespec timespec_trunc(st
 
 /*
  * Names of the interval timers, and structure
- * defining a timer setting.
+ * defining a timer setting:
  */
-#define	ITIMER_REAL	0
-#define	ITIMER_VIRTUAL	1
-#define	ITIMER_PROF	2
-
-struct  itimerspec {
-        struct  timespec it_interval;    /* timer period */
-        struct  timespec it_value;       /* timer expiration */
+#define	ITIMER_REAL		0
+#define	ITIMER_VIRTUAL		1
+#define	ITIMER_PROF		2
+
+struct itimerspec {
+	struct timespec it_interval;	/* timer period */
+	struct timespec it_value;	/* timer expiration */
 };
 
-struct	itimerval {
-	struct	timeval it_interval;	/* timer interval */
-	struct	timeval it_value;	/* current value */
+struct itimerval {
+	struct timeval it_interval;	/* timer interval */
+	struct timeval it_value;	/* current value */
 };
 
 /*
- * The IDs of the various system clocks (for POSIX.1b interval timers).
+ * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
 #define CLOCK_REALTIME			0
 #define CLOCK_MONOTONIC			1
@@ -108,7 +109,7 @@ struct	itimerval {
 #define CLOCK_THREAD_CPUTIME_ID		3
 
 /*
- * The IDs of various hardware clocks
+ * The IDs of various hardware clocks:
  */
 #define CLOCK_SGI_CYCLE			10
 #define MAX_CLOCKS			16
@@ -116,7 +117,7 @@ struct	itimerval {
 #define CLOCKS_MONO			CLOCK_MONOTONIC
 
 /*
- * The various flags for setting POSIX.1b interval timers.
+ * The various flags for setting POSIX.1b interval timers:
  */
 #define TIMER_ABSTIME			0x01
 

--

