Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVA2WTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVA2WTf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVA2WT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:19:27 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:24495 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261574AbVA2WS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:18:57 -0500
Date: Sat, 29 Jan 2005 23:18:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: acpi-devel@lists.sourceforge.net
Subject: [PATCH 1/8] Kconfig: cleanup ACPI menu
Message-ID: <Pine.LNX.4.61.0501292318310.7614@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This properly indents the ACPI menu.
Hide ACPI_BLACKLIST_YEAR when not needed.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 Kconfig |   36 +++++++++++++-----------------------
 1 files changed, 13 insertions(+), 23 deletions(-)

Index: linux-2.6.11/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/acpi/Kconfig	2005-01-29 22:50:43.609910902 +0100
+++ linux-2.6.11/drivers/acpi/Kconfig	2005-01-29 22:55:05.068877064 +0100
@@ -40,21 +40,23 @@ config ACPI
 	  available at:
 	  <http://www.acpi.info>
 
+if ACPI
+
 config ACPI_BOOT
 	bool
-	depends on ACPI || X86_HT
+	depends on X86_HT
 	default y
 
 config ACPI_INTERPRETER
 	bool
-	depends on ACPI
 	depends on !IA64_SGI_SN
 	default y
 
+if ACPI_INTERPRETER
+
 config ACPI_SLEEP
 	bool "Sleep States (EXPERIMENTAL)"
-	depends on X86 && ACPI
-	depends on ACPI_INTERPRETER
+	depends on X86
 	depends on EXPERIMENTAL && PM
 	default y
 	---help---
@@ -81,7 +83,6 @@ config ACPI_SLEEP_PROC_FS
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86
-	depends on ACPI_INTERPRETER
 	default m
 	help
 	  This driver adds support for the AC Adapter object, which indicates
@@ -91,7 +92,6 @@ config ACPI_AC
 config ACPI_BATTERY
 	tristate "Battery"
 	depends on X86
-	depends on ACPI_INTERPRETER
 	default m
 	help
 	  This driver adds support for battery information through
@@ -100,7 +100,6 @@ config ACPI_BATTERY
 
 config ACPI_BUTTON
 	tristate "Button"
-	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default m
 	help
@@ -112,7 +111,6 @@ config ACPI_BUTTON
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on ACPI_INTERPRETER
 	depends on EXPERIMENTAL
 	depends on !IA64_SGI_SN
 	default m
@@ -127,7 +125,6 @@ config ACPI_VIDEO
 
 config ACPI_FAN
 	tristate "Fan"
-	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default m
 	help
@@ -136,7 +133,6 @@ config ACPI_FAN
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default m
 	help
@@ -165,7 +161,6 @@ config ACPI_THERMAL
 
 config ACPI_NUMA
 	bool "NUMA support"
-	depends on ACPI_INTERPRETER
 	depends on NUMA
 	depends on (IA64 || X86_64)
 	default y if IA64_GENERIC || IA64_SGI_SN2
@@ -173,7 +168,6 @@ config ACPI_NUMA
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
-	depends on ACPI_INTERPRETER
 	default m
         ---help---
           This driver provides support for extra features of ACPI-compatible
@@ -203,7 +197,6 @@ config ACPI_ASUS
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
-	depends on ACPI_INTERPRETER
 	default m
 	---help---
 	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
@@ -217,7 +210,6 @@ config ACPI_IBM
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
-	depends on ACPI_INTERPRETER
 	default m
 	---help---
 	  This driver adds support for access to certain system settings
@@ -244,7 +236,7 @@ config ACPI_TOSHIBA
 
 config ACPI_CUSTOM_DSDT
 	bool "Include Custom DSDT"
-	depends on ACPI_INTERPRETER && !STANDALONE
+	depends on !STANDALONE
 	default n 
 	help
 	  Thist option is to load a custom ACPI DSDT
@@ -270,7 +262,6 @@ config ACPI_BLACKLIST_YEAR
 
 config ACPI_DEBUG
 	bool "Debug Statements"
-	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default n
 	help
@@ -280,14 +271,12 @@ config ACPI_DEBUG
 
 config ACPI_BUS
 	bool
-	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default y
 
 config ACPI_EC
 	bool
 	depends on X86
-	depends on ACPI_INTERPRETER
 	default y
 	help
 	  This driver is required on some systems for the proper operation of
@@ -296,28 +285,27 @@ config ACPI_EC
 
 config ACPI_POWER
 	bool
-	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default y
 
 config ACPI_PCI
 	bool
-	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default PCI
 
 config ACPI_SYSTEM
 	bool
-	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
 	default y
 	help
 	  This driver will enable your system to shut down using ACPI, and
 	  dump your ACPI DSDT table using /proc/acpi/dsdt.
 
+endif	# ACPI_INTERPRETER
+
 config X86_PM_TIMER
 	bool "Power Management Timer Support"
-	depends on X86 && ACPI
+	depends on X86
 	depends on ACPI_BOOT && EXPERIMENTAL
 	depends on !X86_64
 	default n
@@ -336,10 +324,12 @@ config X86_PM_TIMER
 
 config ACPI_CONTAINER
 	tristate "ACPI0004,PNP0A05 and PNP0A06 Container Driver (EXPERIMENTAL)"
-	depends on ACPI && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU || ACPI_HOTPLUG_IO)
 	 ---help---
 	 	This is the ACPI generic container driver which supports
 		ACPI0004, PNP0A05 and PNP0A06 devices
 
+endif	# ACPI
+
 endmenu
