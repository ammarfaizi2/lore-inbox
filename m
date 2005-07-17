Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVGQLdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVGQLdF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 07:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGQLdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 07:33:04 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:21184 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261259AbVGQLbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 07:31:42 -0400
Date: Sun, 17 Jul 2005 13:32:07 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [3/5+1] menu -> menuconfig part 1
In-Reply-To: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507171331270.6041@be1.lrz>
References: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2005, Bodo Eggert wrote:

> These patches change some menus into menuconfig options.
> 
> Reworked to apply to linux-2.6.13-rc3-git3

The APM menu.

 arch/i386/Kconfig |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

diff -rNup a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2005-07-17 08:09:33.000000000 +0200
+++ b/arch/i386/Kconfig	2005-07-17 11:18:20.000000000 +0200
@@ -987,12 +987,9 @@ source kernel/power/Kconfig
 
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
@@ -1049,9 +1046,10 @@ config APM
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
@@ -1059,7 +1057,6 @@ config APM_IGNORE_USER_SUSPEND
 
 config APM_DO_ENABLE
 	bool "Enable PM at boot time"
-	depends on APM
 	---help---
 	  Enable APM features at boot time. From page 36 of the APM BIOS
 	  specification: "When disabled, the APM BIOS does not automatically
@@ -1077,7 +1074,6 @@ config APM_DO_ENABLE
 
 config APM_CPU_IDLE
 	bool "Make CPU Idle calls when idle"
-	depends on APM
 	help
 	  Enable calls to APM CPU Idle/CPU Busy inside the kernel's idle loop.
 	  On some machines, this can activate improved power savings, such as
@@ -1089,7 +1085,6 @@ config APM_CPU_IDLE
 
 config APM_DISPLAY_BLANK
 	bool "Enable console blanking using APM"
-	depends on APM
 	help
 	  Enable console blanking using the APM. Some laptops can use this to
 	  turn off the LCD backlight when the screen blanker of the Linux
@@ -1103,7 +1098,6 @@ config APM_DISPLAY_BLANK
 
 config APM_RTC_IS_GMT
 	bool "RTC stores time in GMT"
-	depends on APM
 	help
 	  Say Y here if your RTC (Real Time Clock a.k.a. hardware clock)
 	  stores the time in GMT (Greenwich Mean Time). Say N if your RTC
@@ -1116,7 +1110,6 @@ config APM_RTC_IS_GMT
 
 config APM_ALLOW_INTS
 	bool "Allow interrupts during APM BIOS calls"
-	depends on APM
 	help
 	  Normally we disable external interrupts while we are making calls to
 	  the APM BIOS as a measure to lessen the effects of a badly behaving
@@ -1127,13 +1120,12 @@ config APM_ALLOW_INTS
 
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
I don't care about people reading in OE. It just gets bad if they
send postings, viruses, and complaints about non-existing attachements.
