Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266974AbTADQbS>; Sat, 4 Jan 2003 11:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbTADQbS>; Sat, 4 Jan 2003 11:31:18 -0500
Received: from picard.corpconnect.com.au ([203.34.58.3]:20580 "EHLO
	picard.corpconnect.com.au") by vger.kernel.org with ESMTP
	id <S266974AbTADQbQ>; Sat, 4 Jan 2003 11:31:16 -0500
Message-Id: <5.1.0.14.2.20030105030855.04b4ae58@pop01.corpconnect.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 05 Jan 2003 03:39:47 +1100
To: linux-kernel@vger.kernel.org
From: Richard Muratti <rmurat@attglobal.net>
Subject: [PATCH] Root Raid Support for DAC960 Driver
In-Reply-To: <20030104160255.6187.qmail@webmail28.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch below will allow for mounting of root from a DAC960 raid device
This has been submitted before (Leonard,Oliver,others), but I'll submit it 
again.

Reason:	
Needed to boot of a DAC960 raid device

Precedents/Justification for Patch:  	
Root support for compaq raid is included
Root support for ata raid is included
DAC960 driver is included but root support is not


Cheers
Rick



diff -ur linux-2.4.20/init/do_mounts.c linux/init/do_mounts.c
--- linux-2.4.20/init/do_mounts.c       Fri Nov 29 10:53:15 2002
+++ linux/init/do_mounts.c      Sat Jan  4 23:59:06 2003
@@ -164,6 +164,24 @@
         { "dasdg", (DASD_MAJOR << MINORBITS) + (6 << 2) },
         { "dasdh", (DASD_MAJOR << MINORBITS) + (7 << 2) },
  #endif
+#if defined(CONFIG_BLK_DEV_DAC960) || defined(CONFIG_BLK_DEV_DAC960_MODULE)
+       { "rd/c0d0p",0x3000 },
+       { "rd/c0d1p",0x3008 },
+       { "rd/c0d2p",0x3010 },
+       { "rd/c0d3p",0x3018 },
+       { "rd/c0d4p",0x3020 },
+       { "rd/c0d5p",0x3028 },
+       { "rd/c0d6p",0x3030 },
+       { "rd/c0d7p",0x3038 },
+       { "rd/c0d8p",0x3040 },
+       { "rd/c0d9p",0x3048 },
+       { "rd/c0d10p",0x3050 },
+       { "rd/c0d11p",0x3058 },
+       { "rd/c0d12p",0x3060 },
+       { "rd/c0d13p",0x3068 },
+       { "rd/c0d14p",0x3070 },
+       { "rd/c0d15p",0x3078 },
+#endif
  #if defined(CONFIG_BLK_CPQ_DA) || defined(CONFIG_BLK_CPQ_DA_MODULE)
         { "ida/c0d0p",0x4800 },
         { "ida/c0d1p",0x4810 },


