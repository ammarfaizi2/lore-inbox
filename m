Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263816AbTDGXHh (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTDGXCV (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:02:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47232
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263783AbTDGWyk (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:54:40 -0400
Date: Tue, 8 Apr 2003 01:13:33 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080013.h380DXYf008999@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update char Kconfig for PC9800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/char/Kconfig linux-2.5.67-ac1/drivers/char/Kconfig
--- linux-2.5.67/drivers/char/Kconfig	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.67-ac1/drivers/char/Kconfig	2003-03-18 16:57:58.000000000 +0000
@@ -575,6 +575,17 @@
 	  console. This driver allows each pSeries partition to have a console
 	  which is accessed via the HMC.
 
+config PC9800_OLDLP
+	tristate "NEC PC-9800 old-style printer port support"
+	depends on X86_PC9800 && !PARPORT
+	---help---
+	  If you intend to attach a printer to the parallel port of NEC PC-9801
+	  /PC-9821 with OLD compatibility mode, Say Y.
+
+config PC9800_OLDLP_CONSOLE
+	bool "Support for console on line printer"
+	depends on PC9800_OLDLP
+
 source "drivers/i2c/Kconfig"
 
 
@@ -755,7 +766,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64
+	depends on !PPC32 && !PARISC && !IA64 && !X86_PC9800
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -814,6 +825,15 @@
 	bool "EFI Real Time Clock Services"
 	depends on IA64
 
+config RTC98
+	tristate "NEC PC-9800 Real Time Clock Support"
+	depends on X86_PC9800
+	default y
+	---help---
+	  If you say Y here and create a character special file /dev/rtc with
+	  major number 10 and minor number 135 using mknod ("man mknod"), you
+	  will get access to the real time clock (or hardware clock) built
+
 config H8
 	bool "Tadpole ANA H8 Support (OBSOLETE)"
 	depends on OBSOLETE && ALPHA_BOOK1
