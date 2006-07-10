Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWGJLO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWGJLO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWGJLO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:14:58 -0400
Received: from fitch1.uni2.net ([130.227.52.101]:7631 "EHLO fitch1.uni2.net")
	by vger.kernel.org with ESMTP id S1751353AbWGJLOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:14:50 -0400
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 4/9] -Wshadow: fix warnings caused by jiffies.h
Date: Mon, 10 Jul 2006 13:12:57 +0200
User-Agent: KMail/1.8.2
Cc: jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101312.58045.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please see the mail titled 
 "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
 for an explanation of why I'm doing this)


Fix -Wshadow warnings in include/linux/jiffies.h

This one really cuts down a lot of warnings.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 include/linux/jiffies.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.18-rc1-orig/include/linux/jiffies.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc1/include/linux/jiffies.h	2006-07-09 20:24:17.000000000 +0200
@@ -325,13 +325,13 @@ timespec_to_jiffies(const struct timespe
 }
 
 static __inline__ void
-jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
+jiffies_to_timespec(const unsigned long jiffy, struct timespec *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
 	 * one divide.
 	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC;
+	u64 nsec = (u64)jiffy * TICK_NSEC;
 	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
 }
 
@@ -363,13 +363,13 @@ timeval_to_jiffies(const struct timeval 
 }
 
 static __inline__ void
-jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
+jiffies_to_timeval(const unsigned long jiffy, struct timeval *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
 	 * one divide.
 	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC;
+	u64 nsec = (u64)jiffy * TICK_NSEC;
 	long tv_usec;
 
 	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &tv_usec);



