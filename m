Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273282AbRINE0O>; Fri, 14 Sep 2001 00:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273281AbRINE0D>; Fri, 14 Sep 2001 00:26:03 -0400
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:23302 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S273280AbRINEZz>;
	Fri, 14 Sep 2001 00:25:55 -0400
Date: Thu, 13 Sep 2001 21:26:17 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: missing break? linux/drivers/video/riva/fbdev.c
Message-ID: <20010913212617.A3946@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed this in the 2.4.10-pre patches.

It looks like an obvious missing break on after rc =15;

diff -u --recursive --new-file v2.4.9/linux/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- v2.4.9/linux/drivers/video/riva/fbdev.c	Wed Jul 25 17:10:24 2001
+++ linux/drivers/video/riva/fbdev.c	Fri Sep  7 09:28:38 2001
@@ -260,7 +260,7 @@
 #endif
 
 #ifndef MODULE
-static const char *mode_option __initdata = NULL;
+static char *mode_option __initdata = NULL;
 #else
 static char *font = NULL;
 #endif
@@ -1109,6 +1109,8 @@
 		break;
 #endif
 #ifdef FBCON_HAS_CFB16
+	case 15:
+		rc = 15;	/* fix for 15 bpp depths on Riva 128 based cards */
 	case 16:
 		rc = 16;	/* directcolor... 16 entries SW palette */
 		break;		/* Mystique: truecolor, 16 entries SW palette, HW palette hardwired into 1:1 mapping */
@@ -1119,7 +1121,6 @@

