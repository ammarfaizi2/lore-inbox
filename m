Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265309AbUFBBYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUFBBYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 21:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbUFBBYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 21:24:37 -0400
Received: from holomorphy.com ([207.189.100.168]:60819 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265309AbUFBBYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 21:24:34 -0400
Date: Tue, 1 Jun 2004 18:24:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com, linux-aio@kvack.org
Subject: [1/2] use const in time.h unit conversion functions
Message-ID: <20040602012429.GV2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	suparna@in.ibm.com, linux-aio@kvack.org
References: <20040601021539.413a7ad7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601021539.413a7ad7.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
> - NFS server udpates
> - md updates
> - big x86 dmi_scan.c cleanup
> - merged perfctr.  No documentation though :(
> - cris architecture update

The time conversion functions may have const args, which is in fact
useful for when they are passed const variables as arguments so as
to avoid discarding qualifiers from pointer types warnings. This is
a preparatory cleanup for a minor aio bugfix.

Index: timer-2.6.7-rc2/include/linux/time.h
===================================================================
--- timer-2.6.7-rc2.orig/include/linux/time.h	2004-05-29 23:26:19.000000000 -0700
+++ timer-2.6.7-rc2/include/linux/time.h	2004-06-01 16:02:01.000000000 -0700
@@ -184,7 +184,7 @@
  * Avoid unnecessary multiplications/divisions in the
  * two most common HZ cases:
  */
-static inline unsigned int jiffies_to_msecs(unsigned long j)
+static inline unsigned int jiffies_to_msecs(const unsigned long j)
 {
 #if HZ <= 1000 && !(1000 % HZ)
 	return (1000 / HZ) * j;
@@ -194,7 +194,7 @@
 	return (j * 1000) / HZ;
 #endif
 }
-static inline unsigned long msecs_to_jiffies(unsigned int m)
+static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
 #if HZ <= 1000 && !(1000 % HZ)
 	return (m + (1000 / HZ) - 1) / (1000 / HZ);
@@ -217,7 +217,7 @@
  * value to a scaled second value.
  */
 static __inline__ unsigned long
-timespec_to_jiffies(struct timespec *value)
+timespec_to_jiffies(const struct timespec *value)
 {
 	unsigned long sec = value->tv_sec;
 	long nsec = value->tv_nsec + TICK_NSEC - 1;
@@ -233,7 +233,7 @@
 }
 
 static __inline__ void
-jiffies_to_timespec(unsigned long jiffies, struct timespec *value)
+jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
@@ -256,7 +256,7 @@
  * instruction above the way it was done above.
  */
 static __inline__ unsigned long
-timeval_to_jiffies(struct timeval *value)
+timeval_to_jiffies(const struct timeval *value)
 {
 	unsigned long sec = value->tv_sec;
 	long usec = value->tv_usec;
@@ -271,7 +271,7 @@
 }
 
 static __inline__ void
-jiffies_to_timeval(unsigned long jiffies, struct timeval *value)
+jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
