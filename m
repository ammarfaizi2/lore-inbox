Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWCQX7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWCQX7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWCQX7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:59:30 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:34193 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751602AbWCQX7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:59:24 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <11.132654658@selenic.com>
Subject: [PATCH 10/14] RTC: Remove RTC UIP synchronization on SH03
Date: Fri, 17 Mar 2006 17:30:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on SH03

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.16-rc4-rtc/arch/sh/boards/sh03/rtc.c
===================================================================
--- 2.6.16-rc4-rtc.orig/arch/sh/boards/sh03/rtc.c	2006-02-24 15:33:43.000000000 -0600
+++ 2.6.16-rc4-rtc/arch/sh/boards/sh03/rtc.c	2006-02-24 15:41:35.000000000 -0600
@@ -48,13 +48,9 @@ extern spinlock_t rtc_lock;
 unsigned long get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int i;
 
 	spin_lock(&rtc_lock);
  again:
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (!(ctrl_inb(RTC_CTL) & RTC_BUSY))
-			break;
 	do {
 		sec  = (ctrl_inb(RTC_SEC1) & 0xf) + (ctrl_inb(RTC_SEC10) & 0x7) * 10;
 		min  = (ctrl_inb(RTC_MIN1) & 0xf) + (ctrl_inb(RTC_MIN10) & 0xf) * 10;
