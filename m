Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUCBQJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 11:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUCBQJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 11:09:44 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:15315 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261407AbUCBQJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 11:09:43 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix put_compat_timespec prototype
Date: Tue, 2 Mar 2004 17:03:19 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403021703.19174.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The wrong argument in put_compat_timespec is marked const,
causing unnecessary compiler warnings.

===== include/linux/compat.h 1.18 vs edited =====
--- 1.18/include/linux/compat.h	Mon Feb 23 01:34:04 2004
+++ edited/include/linux/compat.h	Mon Feb 23 21:10:42 2004
@@ -57,7 +57,7 @@
 
 extern int cp_compat_stat(struct kstat *, struct compat_stat *);
 extern int get_compat_timespec(struct timespec *, const struct compat_timespec *);
-extern int put_compat_timespec(struct timespec *, const struct compat_timespec *);
+extern int put_compat_timespec(const struct timespec *, struct compat_timespec *);
 
 struct compat_iovec {
 	compat_uptr_t	iov_base;
===== kernel/compat.c 1.25 vs edited =====
--- 1.25/kernel/compat.c	Mon Feb 23 01:34:41 2004
+++ edited/kernel/compat.c	Mon Feb 23 21:10:19 2004
@@ -30,7 +30,7 @@
 			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
 
-int put_compat_timespec(struct timespec *ts, const struct compat_timespec *cts)
+int put_compat_timespec(const struct timespec *ts, struct compat_timespec *cts)
 {
 	return (verify_area(VERIFY_WRITE, cts, sizeof(*cts)) ||
 			__put_user(ts->tv_sec, &cts->tv_sec) ||
