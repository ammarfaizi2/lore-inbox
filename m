Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbRGUQvt>; Sat, 21 Jul 2001 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267744AbRGUQva>; Sat, 21 Jul 2001 12:51:30 -0400
Received: from die-macht.oph.RWTH-Aachen.DE ([137.226.147.190]:7496 "EHLO
	die-macht") by vger.kernel.org with ESMTP id <S267743AbRGUQvO>;
	Sat, 21 Jul 2001 12:51:14 -0400
Date: Sat, 21 Jul 2001 18:51:07 +0200 (CEST)
From: Stefan Becker <stefan@oph.rwth-aachen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] init/main.c
Message-ID: <Pine.LNX.4.21.0107211840250.27803-100000@die-macht>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

The following patch against 2.4.6-ac5 does

(a) a small cleanup to profile_setup()
(b) wraps certain root_dev_names[] into #ifdefs.
    I hope I found the correct CONFIG_BLK_* variables

Compiles and boots here, but I don't have any RAID-controllers ;-)

Greetings from Aachen,
Stefan

--- linux-2.4.6-ac5/init/main.c	Sat Jul 21 18:34:15 2001
+++ linux/init/main.c	Sat Jul 21 18:36:38 2001
@@ -138,8 +138,9 @@
 
 static int __init profile_setup(char *str)
 {
-    int par;
-    if (get_option(&str,&par)) prof_shift = par;
+	int par;
+	if (get_option(&str,&par))
+		prof_shift = par;
 	return 1;
 }
 
@@ -280,6 +281,7 @@
        { "xpram30", (XPRAM_MAJOR << MINORBITS) + 30 },
        { "xpram31", (XPRAM_MAJOR << MINORBITS) + 31 },
 #endif
+#ifdef CONFIG_BLK_DEV_DAC960
 	{ "rd/c0d0p",0x3000 },
 	{ "rd/c0d1p",0x3008 },
 	{ "rd/c0d2p",0x3010 },
@@ -296,6 +298,8 @@
 	{ "rd/c0d13p",0x3068 },
 	{ "rd/c0d14p",0x3070 },
 	{ "rd/c0d15p",0x3078 },
+#endif
+#ifdef CONFIG_BLK_CPQ_DA
 	{ "ida/c0d0p",0x4800 },
 	{ "ida/c0d1p",0x4810 },
 	{ "ida/c0d2p",0x4820 },
@@ -312,6 +316,8 @@
 	{ "ida/c0d13p",0x48D0 },
 	{ "ida/c0d14p",0x48E0 },
 	{ "ida/c0d15p",0x48F0 },
+#endif
+#ifdef CONFIG_BLK_CPQ_CISS_DA
 	{ "cciss/c0d0p",0x6800 },
 	{ "cciss/c0d1p",0x6810 },
 	{ "cciss/c0d2p",0x6820 },
@@ -328,6 +334,8 @@
 	{ "cciss/c0d13p",0x68D0 },
 	{ "cciss/c0d14p",0x68E0 },
 	{ "cciss/c0d15p",0x68F0 },
+#endif
+#ifdef CONFIG_BLK_DEV_ATARAID
 	{ "ataraid/d0p",0x7200 },
 	{ "ataraid/d1p",0x7210 },
 	{ "ataraid/d2p",0x7220 },
@@ -344,6 +352,7 @@
 	{ "ataraid/d13p",0x72D0 },
 	{ "ataraid/d14p",0x72E0 },
 	{ "ataraid/d15p",0x72F0 },
+#endif
  	{ "mtdblock", 0x1f00 },
 	{ "nftla", 0x5d00 },
  	{ "nftlb", 0x5d10 },

