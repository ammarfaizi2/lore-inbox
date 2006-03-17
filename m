Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWCQX7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWCQX7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWCQX7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:59:13 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:33169 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751523AbWCQX7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:59:12 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <14.132654658@selenic.com>
Subject: [PATCH 13/14] RTC: Fix up some RTC whitespace and style
Date: Fri, 17 Mar 2006 17:30:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up some RTC whitespace and style

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/arch/sh/boards/mpc1211/rtc.c
===================================================================
--- rtc.orig/arch/sh/boards/mpc1211/rtc.c	2006-03-16 17:23:39.000000000 -0600
+++ rtc/arch/sh/boards/mpc1211/rtc.c	2006-03-17 11:50:08.000000000 -0600
@@ -34,18 +34,21 @@ unsigned long get_cmos_time(void)
 		year = CMOS_READ(RTC_YEAR);
 	} while (sec != CMOS_READ(RTC_SECONDS));
 
-	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-	  {
-	    BCD_TO_BIN(sec);
-	    BCD_TO_BIN(min);
-	    BCD_TO_BIN(hour);
-	    BCD_TO_BIN(day);
-	    BCD_TO_BIN(mon);
-	    BCD_TO_BIN(year);
-	  }
+	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		BCD_TO_BIN(sec);
+		BCD_TO_BIN(min);
+		BCD_TO_BIN(hour);
+		BCD_TO_BIN(day);
+		BCD_TO_BIN(mon);
+		BCD_TO_BIN(year);
+	}
+
 	spin_unlock(&rtc_lock);
-	if ((year += 1900) < 1970)
+
+	year += 1900;
+	if (year < 1970)
 		year += 100;
+
 	return mktime(year, mon, day, hour, min, sec);
 }
 
Index: rtc/include/asm-i386/mach-default/mach_time.h
===================================================================
--- rtc.orig/include/asm-i386/mach-default/mach_time.h	2006-03-16 17:23:39.000000000 -0600
+++ rtc/include/asm-i386/mach-default/mach_time.h	2006-03-16 19:05:41.000000000 -0600
@@ -92,16 +92,17 @@ static inline unsigned long mach_get_cmo
 		year = CMOS_READ(RTC_YEAR);
 	} while (sec != CMOS_READ(RTC_SECONDS));
 
-	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-	  {
-	    BCD_TO_BIN(sec);
-	    BCD_TO_BIN(min);
-	    BCD_TO_BIN(hour);
-	    BCD_TO_BIN(day);
-	    BCD_TO_BIN(mon);
-	    BCD_TO_BIN(year);
-	  }
-	if ((year += 1900) < 1970)
+	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		BCD_TO_BIN(sec);
+		BCD_TO_BIN(min);
+		BCD_TO_BIN(hour);
+		BCD_TO_BIN(day);
+		BCD_TO_BIN(mon);
+		BCD_TO_BIN(year);
+	}
+
+	year += 1900;
+	if (year < 1970)
 		year += 100;
 
 	return mktime(year, mon, day, hour, min, sec);
Index: rtc/arch/ppc/platforms/chrp_time.c
===================================================================
--- rtc.orig/arch/ppc/platforms/chrp_time.c	2006-03-16 17:21:23.000000000 -0600
+++ rtc/arch/ppc/platforms/chrp_time.c	2006-03-16 19:08:38.000000000 -0600
@@ -131,16 +131,18 @@ unsigned long chrp_get_rtc_time(void)
 		year = chrp_cmos_clock_read(RTC_YEAR);
 	} while (sec != chrp_cmos_clock_read(RTC_SECONDS));
 
-	if (!(chrp_cmos_clock_read(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-	  {
-	    BCD_TO_BIN(sec);
-	    BCD_TO_BIN(min);
-	    BCD_TO_BIN(hour);
-	    BCD_TO_BIN(day);
-	    BCD_TO_BIN(mon);
-	    BCD_TO_BIN(year);
-	  }
-	if ((year += 1900) < 1970)
+	if (!(chrp_cmos_clock_read(RTC_CONTROL) & RTC_DM_BINARY)
+	    || RTC_ALWAYS_BCD) {
+		BCD_TO_BIN(sec);
+		BCD_TO_BIN(min);
+		BCD_TO_BIN(hour);
+		BCD_TO_BIN(day);
+		BCD_TO_BIN(mon);
+		BCD_TO_BIN(year);
+	}
+
+	year += 1900;
+	if (year < 1970)
 		year += 100;
 	return mktime(year, mon, day, hour, min, sec);
 }
