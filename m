Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWCYE3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWCYE3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWCYE2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:28:49 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:1213 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750850AbWCYE2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:28:04 -0500
Date: Fri, 24 Mar 2006 20:27:43 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, joe.korty@ccur.com,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/20] rtc.h broke strace(1) builds
Message-ID: <20060325042743.GP21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="rtc.h-broke-strace-builds.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Joe Korty <joe.korty@ccur.com>

Git patch 52dfa9a64cfb3dd01fa1ee1150d589481e54e28e

	[PATCH] move rtc_interrupt() prototype to rtc.h

broke strace(1) builds.  The below moves the kernel-only additions lower,
under the already provided #ifdef __KERNEL__ statement.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 include/linux/rtc.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16.orig/include/linux/rtc.h
+++ linux-2.6.16/include/linux/rtc.h
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

--
