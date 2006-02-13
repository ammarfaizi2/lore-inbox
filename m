Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWBMBMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWBMBMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWBMBMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:12:09 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:37593 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751520AbWBMBLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:11:48 -0500
Date: Mon, 13 Feb 2006 02:11:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] hrtimer: fix multiple macro argument expansion
Message-ID: <Pine.LNX.4.61.0602130211340.23851@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For two macros the arguments were expanded twice, change them to inline
functions to avoid it.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/ktime.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6-git/include/linux/ktime.h
===================================================================
--- linux-2.6-git.orig/include/linux/ktime.h	2006-02-12 18:33:42.000000000 +0100
+++ linux-2.6-git/include/linux/ktime.h	2006-02-12 18:33:45.000000000 +0100
@@ -93,10 +93,16 @@ static inline ktime_t ktime_set(long sec
 		({ (ktime_t){ .tv64 = (kt).tv64 + (nsval) }; })
 
 /* convert a timespec to ktime_t format: */
-#define timespec_to_ktime(ts)		ktime_set((ts).tv_sec, (ts).tv_nsec)
+static inline ktime_t timespec_to_ktime(struct timespec ts)
+{
+	return ktime_set(ts.tv_sec, ts.tv_nsec);
+}
 
 /* convert a timeval to ktime_t format: */
-#define timeval_to_ktime(tv)		ktime_set((tv).tv_sec, (tv).tv_usec * 1000)
+static inline ktime_t timeval_to_ktime(struct timeval tv)
+{
+	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
+}
 
 /* Map the ktime_t to timespec conversion to nsec_to_timespec function */
 #define ktime_to_timespec(kt)		nsec_to_timespec((kt).tv64)
