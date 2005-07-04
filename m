Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVGDKYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVGDKYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVGDKYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:24:46 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:53221 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261606AbVGDKPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:15:46 -0400
Date: Mon, 4 Jul 2005 12:15:31 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig changes 3: s/menu/menuconfig/ APM menu
In-Reply-To: <Pine.LNX.4.58.0507041134410.3798@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041210190.6165@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507041134410.3798@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 3: The APM menu.

In many config submenus, the first menu option will enable the rest 
of the menu options. For these menus, It's appropriate to use the more 
convenient "menuconfig" keyword.

This patch is designed for 2.6.12; the patch for .13-rc1 will be posted
as a reply.


--- a/./arch/i386/Kconfig	2005-06-19 14:16:03.000000000 +0200
+++ b/./arch/i386/Kconfig	2005-07-04 12:01:27.000000000 +0200
@@ -949,12 +949,9 @@ source kernel/power/Kconfig
 
 source "drivers/acpi/Kconfig"
 
-menu "APM (Advanced Power Management) BIOS Support"
-depends on PM && !X86_VISWS
-
-config APM
+menuconfig APM
 	tristate "APM (Advanced Power Management) BIOS support"
-	depends on PM
+	depends on PM && !X86_VISWS
 	---help---
 	  APM is a BIOS specification for saving power using several different
 	  techniques. This is mostly useful for battery powered laptops with
@@ -1011,9 +1008,10 @@ config APM
 	  To compile this driver as a module, choose M here: the
 	  module will be called apm.
 
+if APM
+
 config APM_IGNORE_USER_SUSPEND
 	bool "Ignore USER SUSPEND"
-	depends on APM
 	help
 	  This option will ignore USER SUSPEND requests. On machines with a
 	  compliant APM BIOS, you want to say N. However, on the NEC Versa M
@@ -1021,7 +1019,6 @@ config APM_IGNORE_USER_SUSPEND
 
 config APM_DO_ENABLE
 	bool "Enable PM at boot time"
-	depends on APM
 	---help---
 	  Enable APM features at boot time. From page 36 of the APM BIOS
 	  specification: "When disabled, the APM BIOS does not automatically
@@ -1039,7 +1036,6 @@ config APM_DO_ENABLE
 
 config APM_CPU_IDLE
 	bool "Make CPU Idle calls when idle"
-	depends on APM
 	help
 	  Enable calls to APM CPU Idle/CPU Busy inside the kernel's idle loop.
 	  On some machines, this can activate improved power savings, such as
@@ -1051,7 +1047,6 @@ config APM_CPU_IDLE
 
 config APM_DISPLAY_BLANK
 	bool "Enable console blanking using APM"
-	depends on APM
 	help
 	  Enable console blanking using the APM. Some laptops can use this to
 	  turn off the LCD backlight when the screen blanker of the Linux
@@ -1065,7 +1060,6 @@ config APM_DISPLAY_BLANK
 
 config APM_RTC_IS_GMT
 	bool "RTC stores time in GMT"
-	depends on APM
 	help
 	  Say Y here if your RTC (Real Time Clock a.k.a. hardware clock)
 	  stores the time in GMT (Greenwich Mean Time). Say N if your RTC
@@ -1078,7 +1072,6 @@ config APM_RTC_IS_GMT
 
 config APM_ALLOW_INTS
 	bool "Allow interrupts during APM BIOS calls"
-	depends on APM
 	help
 	  Normally we disable external interrupts while we are making calls to
 	  the APM BIOS as a measure to lessen the effects of a badly behaving
@@ -1089,13 +1082,12 @@ config APM_ALLOW_INTS
 
 config APM_REAL_MODE_POWER_OFF
 	bool "Use real mode APM BIOS call to power off"
-	depends on APM
 	help
 	  Use real mode APM BIOS calls to switch off the computer. This is
 	  a work-around for a number of buggy BIOSes. Switch this option on if
 	  your computer crashes instead of powering off properly.
 
-endmenu
+endif
 
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"
 
-- 
"Violence is the last resort of the incompetent."    - Isaak Asimov (1920-1992)
"Damn straight. The competent don't wait that long." - Jerry Pournelle
