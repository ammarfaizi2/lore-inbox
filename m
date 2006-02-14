Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWBNKLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWBNKLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWBNKK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:10:58 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:31466 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030274AbWBNKK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:10:57 -0500
Date: Tue, 14 Feb 2006 11:10:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 02/12] hrtimer: fix multiple macro argument expansion
Message-ID: <Pine.LNX.4.61.0602141110450.3700@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For two macros the arguments were expanded twice, change them to inline
functions to avoid it.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 include/linux/ktime.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6-git/include/linux/ktime.h
===================================================================
--- linux-2.6-git.orig/include/linux/ktime.h	2006-02-14 04:56:22.000000000 +0100
+++ linux-2.6-git/include/linux/ktime.h	2006-02-14 04:56:26.000000000 +0100
@@ -96,10 +96,16 @@ static inline ktime_t ktime_set(const lo
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
 
 /* Map the ktime_t to timespec conversion to ns_to_timespec function */
 #define ktime_to_timespec(kt)		ns_to_timespec((kt).tv64)
