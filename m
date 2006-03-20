Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWCTRTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWCTRTS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 12:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWCTRTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 12:19:18 -0500
Received: from users.ccur.com ([66.10.65.2]:11633 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S964904AbWCTRTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 12:19:16 -0500
Date: Mon, 20 Mar 2006 12:19:05 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16
Message-ID: <20060320171905.GA4228@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Git patch 52dfa9a64cfb3dd01fa1ee1150d589481e54e28e

	[PATCH] move rtc_interrupt() prototype to rtc.h

broke strace(1) builds.  The below moves the kernel-only additions lower,
under the already provided #ifdef __KERNEL__ statement.


 2.6.16-jak/include/linux/rtc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puNa include/linux/rtc.h~patch include/linux/rtc.h
--- 2.6.16/include/linux/rtc.h~patch	2006-03-20 12:07:07.000000000 -0500
+++ 2.6.16-jak/include/linux/rtc.h	2006-03-20 12:07:07.000000000 -0500
@@ -11,8 +11,6 @@
 #ifndef _LINUX_RTC_H_
 #define _LINUX_RTC_H_
 
-#include <linux/interrupt.h>
-
 /*
  * The struct used to pass data via the following ioctl. Similar to the
  * struct tm in <time.h>, but it needs to be here so that the kernel 
@@ -95,6 +93,8 @@ struct rtc_pll_info {
 
 #ifdef __KERNEL__
 
+#include <linux/interrupt.h>
+
 typedef struct rtc_task {
 	void (*func)(void *private_data);
 	void *private_data;

_
