Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWBNKMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWBNKMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWBNKMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:12:01 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:39658 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030274AbWBNKLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:11:42 -0500
Date: Tue, 14 Feb 2006 11:11:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 09/12] hrtimer: remove DEFINE_KTIME/ktime_to_clock_t
Message-ID: <Pine.LNX.4.61.0602141111320.3736@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that it_real_value is gone, the last user of DEFINE_KTIME and
ktime_to_clock_t are also gone, so remove it before someone starts using
it again.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 include/linux/ktime.h |   20 --------------------
 1 file changed, 20 deletions(-)

Index: linux-2.6-git/include/linux/ktime.h
===================================================================
--- linux-2.6-git.orig/include/linux/ktime.h	2006-02-14 04:56:26.000000000 +0100
+++ linux-2.6-git/include/linux/ktime.h	2006-02-14 04:56:42.000000000 +0100
@@ -64,9 +64,6 @@ typedef union {
 
 #if (BITS_PER_LONG == 64) || defined(CONFIG_KTIME_SCALAR)
 
-/* Define a ktime_t variable and initialize it to zero: */
-#define DEFINE_KTIME(kt)		ktime_t kt = { .tv64 = 0 }
-
 /**
  * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
  *
@@ -113,9 +110,6 @@ static inline ktime_t timeval_to_ktime(s
 /* Map the ktime_t to timeval conversion to ns_to_timeval function */
 #define ktime_to_timeval(kt)		ns_to_timeval((kt).tv64)
 
-/* Map the ktime_t to clock_t conversion to the inline in jiffies.h: */
-#define ktime_to_clock_t(kt)		nsec_to_clock_t((kt).tv64)
-
 /* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
 #define ktime_to_ns(kt)			((kt).tv64)
 
@@ -136,9 +130,6 @@ static inline ktime_t timeval_to_ktime(s
  *   tv.sec < 0 and 0 >= tv.nsec < NSEC_PER_SEC
  */
 
-/* Define a ktime_t variable and initialize it to zero: */
-#define DEFINE_KTIME(kt)		ktime_t kt = { .tv64 = 0 }
-
 /* Set a ktime_t variable to a value in sec/nsec representation: */
 static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
 {
@@ -255,17 +246,6 @@ static inline struct timeval ktime_to_ti
 }
 
 /**
- * ktime_to_clock_t - convert a ktime_t variable to clock_t format
- * @kt:		the ktime_t variable to convert
- *
- * Returns a clock_t variable with the converted value
- */
-static inline clock_t ktime_to_clock_t(const ktime_t kt)
-{
-	return nsec_to_clock_t( (u64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec);
-}
-
-/**
  * ktime_to_ns - convert a ktime_t variable to scalar nanoseconds
  * @kt:		the ktime_t variable to convert
  *
