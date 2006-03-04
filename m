Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWCDWXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWCDWXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWCDWXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 17:23:46 -0500
Received: from tim.rpsys.net ([194.106.48.114]:56717 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932256AbWCDWXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 17:23:46 -0500
Subject: [PATCH -mm] RTC subsystem, Fix integrator namespace conflicts
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain
Date: Sat, 04 Mar 2006 22:23:26 +0000
Message-Id: <1141511006.10871.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some namespace conflicts between the RTC subsystem and the ARM
Integrator time functions.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/arch/arm/mach-integrator/time.c
===================================================================
--- linux-2.6.15.orig/arch/arm/mach-integrator/time.c	2006-01-03 03:21:10.000000000 +0000
+++ linux-2.6.15/arch/arm/mach-integrator/time.c	2006-02-22 11:08:12.000000000 +0000
@@ -40,13 +40,13 @@
 	return 1;
 }
 
-static int rtc_read_alarm(struct rtc_wkalrm *alrm)
+static int integrator_rtc_read_alarm(struct rtc_wkalrm *alrm)
 {
 	rtc_time_to_tm(readl(rtc_base + RTC_MR), &alrm->time);
 	return 0;
 }
 
-static inline int rtc_set_alarm(struct rtc_wkalrm *alrm)
+static inline int integrator_rtc_set_alarm(struct rtc_wkalrm *alrm)
 {
 	unsigned long time;
 	int ret;
@@ -62,7 +62,7 @@
 	return ret;
 }
 
-static int rtc_read_time(struct rtc_time *tm)
+static int integrator_rtc_read_time(struct rtc_time *tm)
 {
 	rtc_time_to_tm(readl(rtc_base + RTC_DR), tm);
 	return 0;
@@ -76,7 +76,7 @@
  * edge of the 1Hz clock, we must write the time one second
  * in advance.
  */
-static inline int rtc_set_time(struct rtc_time *tm)
+static inline int integrator_rtc_set_time(struct rtc_time *tm)
 {
 	unsigned long time;
 	int ret;
@@ -90,10 +90,10 @@
 
 static struct rtc_ops rtc_ops = {
 	.owner		= THIS_MODULE,
-	.read_time	= rtc_read_time,
-	.set_time	= rtc_set_time,
-	.read_alarm	= rtc_read_alarm,
-	.set_alarm	= rtc_set_alarm,
+	.read_time	= integrator_rtc_read_time,
+	.set_time	= integrator_rtc_set_time,
+	.read_alarm	= integrator_rtc_read_alarm,
+	.set_alarm	= integrator_rtc_set_alarm,
 };
 
 static irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)


