Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUKKXKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUKKXKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbUKKXJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:09:02 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:36741 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262292AbUKKXFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:05:35 -0500
Subject: [PATCH 3/3] Fix sysdev time support
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1100213485.6031.18.camel@desktop.cunninghams>
References: <1100213485.6031.18.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1100213867.6031.33.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 12 Nov 2004 09:59:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix type of sleep_start, so as to eliminate clock skew due to math errors.

diff -ruN 992-old/arch/i386/kernel/time.c 992-new/arch/i386/kernel/time.c
--- 992-old/arch/i386/kernel/time.c	2004-11-12 09:19:22.219857040 +1100
+++ 992-new/arch/i386/kernel/time.c	2004-11-12 09:13:12.000000000 +1100
@@ -319,7 +319,8 @@
 	return retval;
 }
 
-static long clock_cmos_diff, sleep_start;
+static long clock_cmos_diff;
+static unsigned long sleep_start;
 
 static int time_suspend(struct sys_device *dev, u32 state)
 {

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

