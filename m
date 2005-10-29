Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVJ2GcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVJ2GcJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 02:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVJ2GcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 02:32:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53149 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750749AbVJ2GcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 02:32:08 -0400
Date: Sat, 29 Oct 2005 07:32:07 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing exports of do_settimeofday() variants
Message-ID: <20051029063207.GE7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	frv, sh64, ia64 and sparc64 do not have do_settimeofday() exported
(the last two are using variant in kernel/time.c).  Exports added to match
the rest of architectures.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----

NOTE: since the rest of exports are normal ones, no _GPL() lossage here.

diff -urN RC14-base/arch/frv/kernel/time.c current/arch/frv/kernel/time.c
--- RC14-base/arch/frv/kernel/time.c	2005-10-28 16:42:39.000000000 -0400
+++ current/arch/frv/kernel/time.c	2005-10-29 02:28:46.000000000 -0400
@@ -221,6 +221,7 @@
 	clock_was_set();
 	return 0;
 }
+EXPORT_SYMBOL(do_settimeofday);
 
 /*
  * Scheduler clock - returns current time in nanosec units.
diff -urN RC14-base/arch/sh64/kernel/time.c current/arch/sh64/kernel/time.c
--- RC14-base/arch/sh64/kernel/time.c	2005-10-28 16:42:40.000000000 -0400
+++ current/arch/sh64/kernel/time.c	2005-10-29 02:28:03.000000000 -0400
@@ -253,6 +253,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(do_settimeofday);
 
 static int set_rtc_time(unsigned long nowtime)
 {
diff -urN RC14-base/kernel/time.c current/kernel/time.c
--- RC14-base/kernel/time.c	2005-10-28 16:42:49.000000000 -0400
+++ current/kernel/time.c	2005-10-29 02:28:11.000000000 -0400
@@ -532,6 +532,7 @@
 	clock_was_set();
 	return 0;
 }
+EXPORT_SYMBOL(do_settimeofday);
 
 void do_gettimeofday (struct timeval *tv)
 {
