Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVAHJsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVAHJsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVAHJqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:46:38 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20957 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261892AbVAHJk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:40:59 -0500
Subject: Patch 2/3: Reduce number of get_cmos_time_calls.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, John Stultz <johnstul@us.ibm.com>,
       David Shaohua <shaohua.li@intel.com>
In-Reply-To: <1105176732.5478.20.camel@desktop.cunninghams>
References: <1105176732.5478.20.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1105177184.5478.39.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 08 Jan 2005 20:42:16 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change sleep_start from signed to unsigned long. This appears to address
an issue with the clock being occasionally off by around 1 hr 10
minutes.

Signed-off-by: Nigel Cunningham <ncunningham@linuxmail.org>

diff -ruNp 912-old/arch/i386/kernel/time.c 912-new/arch/i386/kernel/time.c
--- 912-old/arch/i386/kernel/time.c	2005-01-08 19:38:33.786012992 +1100
+++ 912-new/arch/i386/kernel/time.c	2005-01-08 19:38:15.058859952 +1100
@@ -319,7 +319,8 @@ unsigned long get_cmos_time(void)
 	return retval;
 }
 
-static long clock_cmos_diff, sleep_start;
+static long clock_cmos_diff;
+static unsigned long sleep_start;
 
 static int timer_suspend(struct sys_device *dev, u32 state)
 {


