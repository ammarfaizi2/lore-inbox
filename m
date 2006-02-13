Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWBMBNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWBMBNd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWBMBLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:11:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:36825 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751527AbWBMBLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:11:34 -0500
Date: Mon, 13 Feb 2006 02:11:31 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] hrtimer: remove DEFINE_KTIME/ktime_to_clock_t
Message-ID: <Pine.LNX.4.61.0602130211260.23847@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that it_real_value is gone, the last user of DEFINE_KTIME and
ktime_to_clock_t are also gone, so remove it before someone starts using
it again.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/ktime.h |   20 --------------------
 1 file changed, 20 deletions(-)

Index: linux-2.6-git/include/linux/ktime.h
===================================================================
--- linux-2.6-git.orig/include/linux/ktime.h	2006-02-12 18:33:12.000000000 +0100
+++ linux-2.6-git/include/linux/ktime.h	2006-02-12 18:33:42.000000000 +0100
@@ -64,9 +64,6 @@ typedef union {
 
 #if (BITS_PER_LONG == 64) || defined(CONFIG_KTIME_SCALAR)
 
-/* Define a ktime_t variable and initialize it to zero: */
-#define DEFINE_KTIME(kt)		ktime_t kt = { .tv64 = 0 }
-
 /**
  * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
  *
@@ -107,9 +104,6 @@ static inline ktime_t ktime_set(long sec
 /* Map the ktime_t to timeval conversion to ns_to_timeval function */
 #define ktime_to_timeval(kt)		nsec_to_timeval((kt).tv64)
 
-/* Map the ktime_t to clock_t conversion to the inline in jiffies.h: */
-#define ktime_to_clock_t(kt)		nsec_to_clock_t((kt).tv64)
-
 /* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
 #define ktime_to_nsec(kt)			((kt).tv64)
 
@@ -130,9 +124,6 @@ static inline ktime_t ktime_set(long sec
  *   tv.sec < 0 and 0 >= tv.nsec < NSEC_PER_SEC
  */
 
-/* Define a ktime_t variable and initialize it to zero: */
-#define DEFINE_KTIME(kt)		ktime_t kt = { .tv64 = 0 }
-
 /* Set a ktime_t variable to a value in sec/nsec representation: */
 static inline ktime_t ktime_set(long secs, unsigned long nsecs)
 {
@@ -249,17 +240,6 @@ static inline struct timeval ktime_to_ti
 }
 
 /**
- * ktime_to_clock_t - convert a ktime_t variable to clock_t format
- * @kt:		the ktime_t variable to convert
- *
- * Returns a clock_t variable with the converted value
- */
-static inline clock_t ktime_to_clock_t(ktime_t kt)
-{
-	return nsec_to_clock_t( (u64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec);
-}
-
-/**
  * ktime_to_nsec - convert a ktime_t variable to scalar nanoseconds
  * @kt:		the ktime_t variable to convert
  *
