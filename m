Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268697AbTBZTId>; Wed, 26 Feb 2003 14:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268699AbTBZTId>; Wed, 26 Feb 2003 14:08:33 -0500
Received: from fmr06.intel.com ([134.134.136.7]:28668 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S268697AbTBZTIc>; Wed, 26 Feb 2003 14:08:32 -0500
Subject: [2.5.63 PATCH][TRIVIAL]Change rtc.c ioport extend from 10h to 8h
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: p_gortmaker@yahoo.com, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Feb 2003 11:09:57 -0800
Message-Id: <1046286599.4093.3.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The real time clock only needs 8 bytes, but rtc.c is reserving 10h bytes.
This conflicts with zt55XX cpci compute blades that use one of those
extra bytes (port 79h) to control a watchdog timer.

I raised this issue before on LKML and everyone seemed to be ok with changing
the extent of rtc.c to 0x8:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104478057030481&w=2

I have been running the following patch on three of my Linux servers for 
the last couple of weeks with no problems, and two of those server were 
testing the watchdog timer that uses port 79h.

Please apply this patch.

    --rustyl

--- drivers/char/rtc.c.orig	2003-02-26 11:00:50.000000000 -0800
+++ drivers/char/rtc.c	2003-02-26 11:00:43.000000000 -0800
@@ -47,7 +47,7 @@
 
 #define RTC_VERSION		"1.11"
 
-#define RTC_IO_EXTENT	0x10	/* Only really two ports, but...	*/
+#define RTC_IO_EXTENT	0x8
 
 /*
  *	Note that *all* calls to CMOS_READ and CMOS_WRITE are done with



