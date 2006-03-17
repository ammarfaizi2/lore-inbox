Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWCQXar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWCQXar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWCQXar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:30:47 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:41627 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751399AbWCQXar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:30:47 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <4.132654658@selenic.com>
Subject: [PATCH 3/14] RTC: Remove RTC UIP synchronization on Sparc64
Date: Fri, 17 Mar 2006 17:30:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on Sparc64

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/arch/sparc64/kernel/time.c
===================================================================
--- rtc.orig/arch/sparc64/kernel/time.c	2006-03-16 16:48:37.000000000 -0600
+++ rtc/arch/sparc64/kernel/time.c	2006-03-17 11:51:53.000000000 -0600
@@ -632,23 +632,8 @@ static void __init set_system_time(void)
 		mon = MSTK_REG_MONTH(mregs);
 		year = MSTK_CVT_YEAR( MSTK_REG_YEAR(mregs) );
 	} else {
-		int i;
-
 		/* Dallas 12887 RTC chip. */
 
-		/* Stolen from arch/i386/kernel/time.c, see there for
-		 * credits and descriptive comments.
-		 */
-		for (i = 0; i < 1000000; i++) {
-			if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-				break;
-			udelay(10);
-		}
-		for (i = 0; i < 1000000; i++) {
-			if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-				break;
-			udelay(10);
-		}
 		do {
 			sec  = CMOS_READ(RTC_SECONDS);
 			min  = CMOS_READ(RTC_MINUTES);
@@ -657,6 +642,7 @@ static void __init set_system_time(void)
 			mon  = CMOS_READ(RTC_MONTH);
 			year = CMOS_READ(RTC_YEAR);
 		} while (sec != CMOS_READ(RTC_SECONDS));
+
 		if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
 			BCD_TO_BIN(sec);
 			BCD_TO_BIN(min);
