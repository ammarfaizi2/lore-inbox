Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWBNKN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWBNKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWBNKNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:13:11 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:41706 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030347AbWBNKM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:12:58 -0500
Date: Tue, 14 Feb 2006 11:12:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 11/12] hrtimer: rename ns to nsec
Message-ID: <Pine.LNX.4.61.0602141112470.3746@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently we have two abbreviation for nanosecond, although ns may be
more correct, nsec is already used rather widely (e.g. tv_nsec).

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/ktime.h |   18 +++++++++---------
 include/linux/time.h  |   16 ++++++++--------
 kernel/hrtimer.c      |   16 ++++++++--------
 kernel/time.c         |   10 +++++-----
 4 files changed, 30 insertions(+), 30 deletions(-)

Index: linux-2.6-git/include/linux/ktime.h
===================================================================
--- linux-2.6-git.orig/include/linux/ktime.h	2006-02-13 22:30:18.000000000 +0100
+++ linux-2.6-git/include/linux/ktime.h	2006-02-13 22:30:21.000000000 +0100
@@ -89,7 +89,7 @@ static inline ktime_t ktime_set(long sec
  * Add a ktime_t variable and a scalar nanosecond value.
  * res = kt + nsval:
  */
-#define ktime_add_ns(kt, nsval) \
+#define ktime_add_nsec(kt, nsval) \
 		({ (ktime_t){ .tv64 = (kt).tv64 + (nsval) }; })
 
 /* convert a timespec to ktime_t format: */
@@ -104,14 +104,14 @@ static inline ktime_t timeval_to_ktime(s
 	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
 }
 
-/* Map the ktime_t to timespec conversion to ns_to_timespec function */
-#define ktime_to_timespec(kt)		ns_to_timespec((kt).tv64)
+/* Map the ktime_t to timespec conversion to nsec_to_timespec function */
+#define ktime_to_timespec(kt)		nsec_to_timespec((kt).tv64)
 
 /* Map the ktime_t to timeval conversion to ns_to_timeval function */
-#define ktime_to_timeval(kt)		ns_to_timeval((kt).tv64)
+#define ktime_to_timeval(kt)		nsec_to_timeval((kt).tv64)
 
 /* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
-#define ktime_to_ns(kt)			((kt).tv64)
+#define ktime_to_nsec(kt)			((kt).tv64)
 
 #else
 
@@ -183,14 +183,14 @@ static inline ktime_t ktime_add(ktime_t 
 }
 
 /**
- * ktime_add_ns - Add a scalar nanoseconds value to a ktime_t variable
+ * ktime_add_nsec - Add a scalar nanoseconds value to a ktime_t variable
  *
  * @kt:		addend
  * @nsec:	the scalar nsec value to add
  *
  * Returns the sum of kt and nsec in ktime_t format
  */
-extern ktime_t ktime_add_ns(ktime_t kt, u64 nsec);
+extern ktime_t ktime_add_nsec(ktime_t kt, u64 nsec);
 
 /**
  * timespec_to_ktime - convert a timespec to ktime_t format
@@ -246,12 +246,12 @@ static inline struct timeval ktime_to_ti
 }
 
 /**
- * ktime_to_ns - convert a ktime_t variable to scalar nanoseconds
+ * ktime_to_nsec - convert a ktime_t variable to scalar nanoseconds
  * @kt:		the ktime_t variable to convert
  *
  * Returns the scalar nanoseconds representation of kt
  */
-static inline u64 ktime_to_ns(ktime_t kt)
+static inline u64 ktime_to_nsec(ktime_t kt)
 {
 	return (u64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec;
 }
Index: linux-2.6-git/include/linux/time.h
===================================================================
--- linux-2.6-git.orig/include/linux/time.h	2006-02-13 22:30:18.000000000 +0100
+++ linux-2.6-git/include/linux/time.h	2006-02-13 22:30:21.000000000 +0100
@@ -107,45 +107,45 @@ extern void getnstimeofday(struct timesp
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
 
 /**
- * timespec_to_ns - Convert timespec to nanoseconds
+ * timespec_to_nsec - Convert timespec to nanoseconds
  * @ts:		pointer to the timespec variable to be converted
  *
  * Returns the scalar nanosecond representation of the timespec
  * parameter.
  */
-static inline nsec_t timespec_to_ns(const struct timespec *ts)
+static inline nsec_t timespec_to_nsec(const struct timespec *ts)
 {
 	return ((nsec_t) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
 }
 
 /**
- * timeval_to_ns - Convert timeval to nanoseconds
+ * timeval_to_nsec - Convert timeval to nanoseconds
  * @ts:		pointer to the timeval variable to be converted
  *
  * Returns the scalar nanosecond representation of the timeval
  * parameter.
  */
-static inline nsec_t timeval_to_ns(const struct timeval *tv)
+static inline nsec_t timeval_to_nsec(const struct timeval *tv)
 {
 	return ((nsec_t) tv->tv_sec * NSEC_PER_SEC) +
 		tv->tv_usec * NSEC_PER_USEC;
 }
 
 /**
- * ns_to_timespec - Convert nanoseconds to timespec
+ * nsec_to_timespec - Convert nanoseconds to timespec
  * @nsec:	the nanoseconds value to be converted
  *
  * Returns the timespec representation of the nsec parameter.
  */
-extern struct timespec ns_to_timespec(nsec_t nsec);
+extern struct timespec nsec_to_timespec(nsec_t nsec);
 
 /**
- * ns_to_timeval - Convert nanoseconds to timeval
+ * nsec_to_timeval - Convert nanoseconds to timeval
  * @nsec:	the nanoseconds value to be converted
  *
  * Returns the timeval representation of the nsec parameter.
  */
-extern struct timeval ns_to_timeval(nsec_t nsec);
+extern struct timeval nsec_to_timeval(nsec_t nsec);
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-13 22:30:18.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-13 22:30:21.000000000 +0100
@@ -217,14 +217,14 @@ lock_hrtimer_base(const struct hrtimer *
 #if BITS_PER_LONG < 64
 # ifndef CONFIG_KTIME_SCALAR
 /**
- * ktime_add_ns - Add a scalar nanoseconds value to a ktime_t variable
+ * ktime_add_nsec - Add a scalar nanoseconds value to a ktime_t variable
  *
  * @kt:		addend
  * @nsec:	the scalar nsec value to add
  *
  * Returns the sum of kt and nsec in ktime_t format
  */
-ktime_t ktime_add_ns(ktime_t kt, u64 nsec)
+ktime_t ktime_add_nsec(ktime_t kt, u64 nsec)
 {
 	ktime_t tmp;
 
@@ -246,12 +246,12 @@ ktime_t ktime_add_ns(ktime_t kt, u64 nse
 /*
  * Divide a ktime value by a nanosecond value
  */
-static unsigned long ktime_divns(const ktime_t kt, nsec_t div)
+static unsigned long ktime_div_nsec(const ktime_t kt, nsec_t div)
 {
 	u64 dclc, inc, dns;
 	int sft = 0;
 
-	dclc = dns = ktime_to_ns(kt);
+	dclc = dns = ktime_to_nsec(kt);
 	inc = div;
 	/* Make sure the divisor is less than 2^32: */
 	while (div >> 32) {
@@ -265,7 +265,7 @@ static unsigned long ktime_divns(const k
 }
 
 #else /* BITS_PER_LONG < 64 */
-# define ktime_divns(kt, div)		(unsigned long)((kt).tv64 / (div))
+# define ktime_div_nsec(kt, div)	(unsigned long)((kt).tv64 / (div))
 #endif /* BITS_PER_LONG >= 64 */
 
 /*
@@ -302,10 +302,10 @@ hrtimer_forward(struct hrtimer *timer, k
 		interval.tv64 = timer->base->resolution.tv64;
 
 	if (unlikely(delta.tv64 >= interval.tv64)) {
-		nsec_t incr = ktime_to_ns(interval);
+		nsec_t incr = ktime_to_nsec(interval);
 
-		orun = ktime_divns(delta, incr);
-		timer->expires = ktime_add_ns(timer->expires, incr * orun);
+		orun = ktime_div_nsec(delta, incr);
+		timer->expires = ktime_add_nsec(timer->expires, incr * orun);
 		if (timer->expires.tv64 > now.tv64)
 			return orun;
 		/*
Index: linux-2.6-git/kernel/time.c
===================================================================
--- linux-2.6-git.orig/kernel/time.c	2006-02-13 22:30:18.000000000 +0100
+++ linux-2.6-git/kernel/time.c	2006-02-13 22:30:21.000000000 +0100
@@ -632,12 +632,12 @@ void set_normalized_timespec(struct time
 }
 
 /**
- * ns_to_timespec - Convert nanoseconds to timespec
+ * nsec_to_timespec - Convert nanoseconds to timespec
  * @nsec:       the nanoseconds value to be converted
  *
  * Returns the timespec representation of the nsec parameter.
  */
-struct timespec ns_to_timespec(nsec_t nsec)
+struct timespec nsec_to_timespec(nsec_t nsec)
 {
 	struct timespec ts;
 
@@ -652,14 +652,14 @@ struct timespec ns_to_timespec(nsec_t ns
 }
 
 /**
- * ns_to_timeval - Convert nanoseconds to timeval
+ * nsec_to_timeval - Convert nanoseconds to timeval
  * @nsec:       the nanoseconds value to be converted
  *
  * Returns the timeval representation of the nsec parameter.
  */
-struct timeval ns_to_timeval(nsec_t nsec)
+struct timeval nsec_to_timeval(nsec_t nsec)
 {
-	struct timespec ts = ns_to_timespec(nsec);
+	struct timespec ts = nsec_to_timespec(nsec);
 	struct timeval tv;
 
 	tv.tv_sec = ts.tv_sec;
