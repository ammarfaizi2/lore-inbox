Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbVKCUXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbVKCUXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 15:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVKCUXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 15:23:51 -0500
Received: from s14.s14avahost.net ([66.98.146.55]:51867 "EHLO
	s14.s14avahost.net") by vger.kernel.org with ESMTP id S1030466AbVKCUXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 15:23:50 -0500
Message-ID: <436A71CF.5090309@katalix.com>
Date: Thu, 03 Nov 2005 20:23:43 +0000
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Michael Burian <dynmail1@gassner-waagen.at>
Subject: [PATCH 2.6.14] i2c chips: ds1337 2/2
Content-Type: multipart/mixed;
 boundary="------------010503010508000708030304"
X-PopBeforeSMTPSenders: jchapman@katalix.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s14.s14avahost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - katalix.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010503010508000708030304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch for ds1337 i2c driver:

Fix BCD value errors when month=9, moving the increment inside the
BIN2BCD macro.
Fix similar code for the weekday value, just for consistency.

This bug was reported by Michael Burian <dynmail1@gassner-waagen.at>.

Signed-off-by: James Chapman <jchapman@katalix.com>

-- 
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development



--------------010503010508000708030304
Content-Type: text/plain;
 name="ds1337-bcd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ds1337-bcd.patch"

Fix BCD value errors when month=9, moving the increment inside the
BIN2BCD macro.
Fix similar code for the weekday value, just for consistency.

This bug was reported by Michael Burian <dynmail1@gassner-waagen.at>.

Signed-off-by: James Chapman <jchapman@katalix.com>

Index: linux-2.6.14/drivers/i2c/chips/ds1337.c
===================================================================
--- linux-2.6.14.orig/drivers/i2c/chips/ds1337.c	2005-11-02 19:38:49.000000000 +0000
+++ linux-2.6.14/drivers/i2c/chips/ds1337.c	2005-11-02 19:38:58.000000000 +0000
@@ -177,9 +177,9 @@
 	buf[1] = BIN2BCD(dt->tm_sec);
 	buf[2] = BIN2BCD(dt->tm_min);
 	buf[3] = BIN2BCD(dt->tm_hour);
-	buf[4] = BIN2BCD(dt->tm_wday) + 1;
+	buf[4] = BIN2BCD(dt->tm_wday + 1);
 	buf[5] = BIN2BCD(dt->tm_mday);
-	buf[6] = BIN2BCD(dt->tm_mon) + 1;
+	buf[6] = BIN2BCD(dt->tm_mon + 1);
 	val = dt->tm_year;
 	if (val >= 100) {
 		val -= 100;

--------------010503010508000708030304--
