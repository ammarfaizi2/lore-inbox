Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbTGZTr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269291AbTGZTr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:47:57 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:4809 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S269242AbTGZTrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:47:03 -0400
Date: Sat, 26 Jul 2003 22:02:13 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] sanitize power management config menus
Message-ID: <20030726200213.GD16160@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$subj

patch against -bk3.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/arch/i386/kernel/cpu/cpufreq/Kconfig b/arch/i386/kernel/cpu/cpufreq/Kconfig
--- a/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-07-10 23:30:33.000000000 +0200
+++ b/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-07-26 21:37:13.000000000 +0200
@@ -2,10 +2,9 @@
 # CPU Frequency scaling
 #
 
-menu "CPU Frequency scaling"
-
 config CPU_FREQ
 	bool "CPU Frequency scaling"
+	depends on PM
 	help
 	  Clock scaling allows you to change the clock speed of CPUs on the
 	  fly. This is a nice method to save battery power on notebooks,
@@ -16,6 +15,8 @@
 
 	  If in doubt, say N.
 
+if CPU_FREQ
+
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_TABLE
@@ -162,4 +163,4 @@
 
 	  If in doubt, say N.
 
-endmenu
+endif
diff -urN a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig	2003-06-22 22:27:39.000000000 +0200
+++ b/drivers/acpi/Kconfig	2003-07-26 21:34:05.000000000 +0200
@@ -2,7 +2,7 @@
 # ACPI Configuration
 #
 
-menu "ACPI Support"
+if PM
 
 config ACPI
 	bool "ACPI Support" if X86
@@ -36,6 +36,8 @@
 	  available at:
 	  <http://www.acpi.info>
 
+if ACPI
+
 config ACPI_HT_ONLY
 	bool "CPU Enumeration Only"
 	depends on X86 && ACPI && X86_LOCAL_APIC
@@ -236,5 +238,6 @@
 	depends on IA64 && (!IA64_HP_SIM || IA64_SGI_SN)
 	default y
 
-endmenu
+endif
 
+endif
