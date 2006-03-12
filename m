Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWCLKjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWCLKjW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWCLKh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:37:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30694
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751424AbWCLKg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:36:59 -0500
Message-Id: <20060312080332.585910000@localhost.localdomain>
References: <20060312080316.826824000@localhost.localdomain>
Date: Sun, 12 Mar 2006 10:37:20 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 7/8] Remove DEFINE_KTIME and ktime_to_clock_t()
Content-Disposition: inline; filename=remove-define-ktime.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roman Zippel <zippel@linux-m68k.org>

Now that it_real_value is gone, the last user of DEFINE_KTIME and
ktime_to_clock_t are also gone, so remove it before someone starts using
it again.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/ktime.h |   20 --------------------
 1 file changed, 20 deletions(-)

Index: linux-2.6.16-updates/include/linux/ktime.h
===================================================================
--- linux-2.6.16-updates.orig/include/linux/ktime.h
+++ linux-2.6.16-updates/include/linux/ktime.h
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

--

