Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWCFBxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWCFBxL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWCFBxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:53:11 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:58239 "EHLO
	linux") by vger.kernel.org with ESMTP id S1751529AbWCFBxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:53:10 -0500
Message-Id: <20060306015009.487349000@towertech.it>
References: <20060306015008.858209000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 06 Mar 2006 02:50:11 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@digeo.com, Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH 03/16] RTC subsystem, ARM Integrator cleanup
Content-Disposition: inline; filename=rtc-arm-integrator-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some namespace conflicts between the RTC subsystem and the ARM
Integrator time functions.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

---
 arch/arm/mach-integrator/time.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-rtc.orig/arch/arm/mach-integrator/time.c	2006-03-03 00:15:21.000000000 +0100
+++ linux-rtc/arch/arm/mach-integrator/time.c	2006-03-05 01:22:45.000000000 +0100
@@ -40,13 +40,13 @@ static int integrator_set_rtc(void)
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
@@ -62,7 +62,7 @@ static inline int rtc_set_alarm(struct r
 	return ret;
 }
 
-static int rtc_read_time(struct rtc_time *tm)
+static int integrator_rtc_read_time(struct rtc_time *tm)
 {
 	rtc_time_to_tm(readl(rtc_base + RTC_DR), tm);
 	return 0;
@@ -76,7 +76,7 @@ static int rtc_read_time(struct rtc_time
  * edge of the 1Hz clock, we must write the time one second
  * in advance.
  */
-static inline int rtc_set_time(struct rtc_time *tm)
+static inline int integrator_rtc_set_time(struct rtc_time *tm)
 {
 	unsigned long time;
 	int ret;
@@ -90,10 +90,10 @@ static inline int rtc_set_time(struct rt
 
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
 
 static irqreturn_t arm_rtc_interrupt(int irq, void *dev_id,

--
