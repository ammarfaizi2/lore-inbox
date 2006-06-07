Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWFGSbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWFGSbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWFGSbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:31:32 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:36872 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1751218AbWFGSbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:31:31 -0400
Subject: [PATCH[ RTC: Add rtc_year_days() to calculate tm_yday
From: Andrew Victor <andrew@sanpeople.com>
To: linux-kernel@vger.kernel.org
Cc: alessandro.zummo@towertech.it, akpm@osdl.org
Content-Type: text/plain
Organization: SAN People (Pty) Ltd
Message-Id: <1149704768.20154.95.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Jun 2006 20:26:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RTC: Add exported function rtc_year_days() to calculate the tm_yday
value.


Signed-off-by: Andrew Victor <andrew@sanpeople.com>
Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>


diff -urN -x CVS linux-2.6.17-rc6/drivers/rtc/rtc-lib.c linux-2.6.17-rc/drivers/rtc/rtc-lib.c
--- linux-2.6.17-rc6/drivers/rtc/rtc-lib.c	Tue Jun  6 10:28:05 2006
+++ linux-2.6.17-rc/drivers/rtc/rtc-lib.c	Wed Jun  7 11:27:49 2006
@@ -18,15 +18,34 @@
 	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
 };
 
+static const unsigned short rtc_ydays[2][13] = {
+	/* Normal years */
+	{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365 },
+	/* Leap years */
+	{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
+}; 
+
 #define LEAPS_THRU_END_OF(y) ((y)/4 - (y)/100 + (y)/400)
 #define LEAP_YEAR(year) ((!(year % 4) && (year % 100)) || !(year % 400))
 
+/*
+ * The number of days in the month.
+ */
 int rtc_month_days(unsigned int month, unsigned int year)
 {
 	return rtc_days_in_month[month] + (LEAP_YEAR(year) && month == 1);
 }
 EXPORT_SYMBOL(rtc_month_days);
 
+/* 
+ * The number of days since January 1. (0 to 365)
+ */
+int rtc_year_days(unsigned int day, unsigned int month, unsigned int year)
+{
+	return rtc_ydays[LEAP_YEAR(year)][month] + day-1;
+}
+EXPORT_SYMBOL(rtc_year_days);
+
 /*
  * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
  */
diff -urN -x CVS linux-2.6.17-rc6/include/linux/rtc.h linux-2.6.17-rc/include/linux/rtc.h
--- linux-2.6.17-rc6/include/linux/rtc.h	Tue Jun  6 10:28:30 2006
+++ linux-2.6.17-rc/include/linux/rtc.h	Wed Jun  7 11:24:45 2006
@@ -102,6 +102,7 @@
 #include <linux/interrupt.h>
 
 extern int rtc_month_days(unsigned int month, unsigned int year);
+extern int rtc_year_days(unsigned int day, unsigned int month, unsigned int year);
 extern int rtc_valid_tm(struct rtc_time *tm);
 extern int rtc_tm_to_time(struct rtc_time *tm, unsigned long *time);
 extern void rtc_time_to_tm(unsigned long time, struct rtc_time *tm);



