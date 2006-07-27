Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWG0UlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWG0UlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWG0UlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:41:14 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:37591 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750769AbWG0UlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:41:13 -0400
Date: Thu, 27 Jul 2006 22:40:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: akpm@osdl.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Some const for linux/time.h
Message-ID: <Pine.LNX.4.61.0607272239001.14351@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


time compare functions do not modify their arguments, so they can 
be marked as const (like some of the functions in time.h are already).

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru linux-2.6.17.7~/include/linux/time.h linux-2.6.17.7+/include/linux/time.h
--- linux-2.6.17.7~/include/linux/time.h	2006-06-06 02:57:02.000000000 +0200
+++ linux-2.6.17.7+/include/linux/time.h	2006-07-27 22:35:53.308571000 +0200
@@ -33,7 +33,8 @@ struct timezone {
 #define NSEC_PER_SEC		1000000000L
 #define NSEC_PER_USEC		1000L
 
-static inline int timespec_equal(struct timespec *a, struct timespec *b)
+static inline int timespec_equal(const struct timespec *a,
+ const struct timespec *b)
 {
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
 }
@@ -43,7 +44,8 @@ static inline int timespec_equal(struct 
  * lhs == rhs: return 0
  * lhs > rhs:  return >0
  */
-static inline int timespec_compare(struct timespec *lhs, struct timespec *rhs)
+static inline int timespec_compare(const struct timespec *lhs,
+ struct timespec *rhs)
 {
 	if (lhs->tv_sec < rhs->tv_sec)
 		return -1;
@@ -52,7 +54,8 @@ static inline int timespec_compare(struc
 	return lhs->tv_nsec - rhs->tv_nsec;
 }
 
-static inline int timeval_compare(struct timeval *lhs, struct timeval *rhs)
+static inline int timeval_compare(const struct timeval *lhs,
+ const struct timeval *rhs)
 {
 	if (lhs->tv_sec < rhs->tv_sec)
 		return -1;
#<<eof>>


Jan Engelhardt
-- 
