Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422697AbWHEBRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWHEBRq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 21:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbWHEBRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 21:17:46 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:12917 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422693AbWHEBRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 21:17:46 -0400
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.18-rc3] RTC class, Kconfig improvements
Date: Fri, 4 Aug 2006 17:41:26 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608041741.26730.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small updates to make the RTC class Kconfig text be more informative.
This should help folk used to the drivers/char/rtc.c support, or a
single RTC, be slightly less surprised by the differences.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/Kconfig
===================================================================
--- g26.orig/drivers/rtc/Kconfig	2006-08-04 17:20:34.000000000 -0700
+++ g26/drivers/rtc/Kconfig	2006-08-04 17:38:51.000000000 -0700
@@ -45,8 +45,8 @@ config RTC_INTF_SYSFS
 	depends on RTC_CLASS && SYSFS
 	default RTC_CLASS
 	help
-	  Say yes here if you want to use your RTC using the sysfs
-	  interface, /sys/class/rtc/rtcX .
+	  Say yes here if you want to use your RTCs using sysfs interfaces,
+	  /sys/class/rtc/rtc0 through /sys/.../rtcN.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-sysfs.
@@ -56,8 +56,9 @@ config RTC_INTF_PROC
 	depends on RTC_CLASS && PROC_FS
 	default RTC_CLASS
 	help
-	  Say yes here if you want to use your RTC using the proc
-	  interface, /proc/driver/rtc .
+	  Say yes here if you want to use your first RTC through the proc
+	  interface, /proc/driver/rtc.  Other RTCs will not be available
+	  through that API.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-proc.
@@ -67,8 +68,11 @@ config RTC_INTF_DEV
 	depends on RTC_CLASS
 	default RTC_CLASS
 	help
-	  Say yes here if you want to use your RTC using the dev
-	  interface, /dev/rtc .
+	  Say yes here if you want to use your RTCs using the /dev
+	  interfaces, which "udev" sets up as /dev/rtc0 through
+	  /dev/rtcN.  You may want to set up a symbolic link so one
+	  of these can be accessed as /dev/rtc, which is the name
+	  expected by "hwclock" and some other programs.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-dev.
@@ -78,7 +82,8 @@ config RTC_INTF_DEV_UIE_EMUL
 	depends on RTC_INTF_DEV
 	help
 	  Provides an emulation for RTC_UIE if the underlaying rtc chip
-	  driver did not provide RTC_UIE ioctls.
+	  driver does not expose RTC_UIE ioctls.  Those requests generate
+	  once-per-second update interrupts, used to synchronization.
 
 comment "RTC drivers"
 	depends on RTC_CLASS
