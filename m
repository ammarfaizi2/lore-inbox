Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVA2WXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVA2WXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVA2WXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:23:22 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:26799 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261580AbVA2WUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:20:10 -0500
Date: Sat, 29 Jan 2005 23:20:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] Kconfig: cleanup various driver menus
Message-ID: <Pine.LNX.4.61.0501292319550.7649@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This properly indents various driver menus.
Remove PARPORT_PC_CML1.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 mtd/Kconfig     |   18 +++++++++---------
 parport/Kconfig |   12 +++---------
 video/Kconfig   |   29 ++++++++++++++---------------
 3 files changed, 26 insertions(+), 33 deletions(-)

Index: linux-2.6.11/drivers/parport/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/parport/Kconfig	2005-01-29 22:50:43.242974099 +0100
+++ linux-2.6.11/drivers/parport/Kconfig	2005-01-29 22:55:31.785275067 +0100
@@ -46,15 +46,9 @@ config PARPORT_PC
 
 	  If unsure, say Y.
 
-config PARPORT_PC_CML1
-	tristate
-	depends on PARPORT!=n && PARPORT_PC!=n
-	default PARPORT_PC if SERIAL_8250=y
-	default m if SERIAL_8250=m
-
 config PARPORT_SERIAL
 	tristate "Multi-IO cards (parallel and serial)"
-	depends on SERIAL_8250!=n && PARPORT_PC_CML1 && PCI
+	depends on SERIAL_8250 && PARPORT_PC && PCI
 	help
 	  This adds support for multi-IO PCI cards that have parallel and
 	  serial ports.  You should say Y or M here.  If you say M, the module
@@ -118,8 +112,8 @@ config PARPORT_ATARI
 
 config PARPORT_GSC
 	tristate
-	depends on GSC
-	default PARPORT
+	default GSC
+	depends on PARPORT
 
 config PARPORT_SUNBPP
 	tristate "Sparc hardware (EXPERIMENTAL)"
Index: linux-2.6.11/drivers/mtd/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/mtd/Kconfig	2005-01-29 22:50:43.242974099 +0100
+++ linux-2.6.11/drivers/mtd/Kconfig	2005-01-29 22:55:31.786274895 +0100
@@ -27,6 +27,15 @@ config MTD_DEBUG_VERBOSE
 	help
 	  Determines the verbosity level of the MTD debugging messages.
 
+config MTD_CONCAT
+	tristate "MTD concatenating support"
+	depends on MTD
+	help
+	  Support for concatenating several MTD devices into a single
+	  (virtual) one. This allows you to have -for example- a JFFS(2)
+	  file system spanning multiple physical flash chips. If unsure,
+	  say 'Y'.
+
 config MTD_PARTITIONS
 	bool "MTD partitioning support"
 	depends on MTD
@@ -40,15 +49,6 @@ config MTD_PARTITIONS
 	  devices. Partitioning on NFTL 'devices' is a different - that's the
 	  'normal' form of partitioning used on a block device.
 
-config MTD_CONCAT
-	tristate "MTD concatenating support"
-	depends on MTD
-	help
-	  Support for concatenating several MTD devices into a single
-	  (virtual) one. This allows you to have -for example- a JFFS(2)
-	  file system spanning multiple physical flash chips. If unsure,
-	  say 'Y'.
-
 config MTD_REDBOOT_PARTS
 	tristate "RedBoot partition table parsing"
 	depends on MTD_PARTITIONS
Index: linux-2.6.11/drivers/video/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/video/Kconfig	2005-01-29 22:50:43.242974099 +0100
+++ linux-2.6.11/drivers/video/Kconfig	2005-01-29 22:55:31.787274723 +0100
@@ -1062,7 +1062,7 @@ config FB_G364
 
 config FB_68328
 	bool "Motorola 68328 native frame buffer support"
-	depends on (M68328 || M68EZ328 || M68VZ328)
+	depends on FB && (M68328 || M68EZ328 || M68VZ328)
 	help
 	  Say Y here if you want to support the built-in frame buffer of
 	  the Motorola 68328 CPU family.
@@ -1081,22 +1081,8 @@ config FB_PXA
 
 	  If unsure, say N.
 
-config FB_W100
-	tristate "W100 frame buffer support"
-	depends on FB && PXA_SHARPSL
-	---help---
-	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted and removed from the running kernel whenever you want). The
-	  module will be called vfb. If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  If unsure, say N.
-
 config FB_PXA_PARAMETERS
 	bool "PXA LCD command line parameters"
-	default n
 	depends on FB_PXA
 	---help---
 	  Enable the use of kernel command line or module parameters
@@ -1111,6 +1097,19 @@ config FB_PXA_PARAMETERS
 
 	  <file:Documentation/fb/pxafb.txt> describes the available parameters.
 
+config FB_W100
+	tristate "W100 frame buffer support"
+	depends on FB && PXA_SHARPSL
+	---help---
+	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted and removed from the running kernel whenever you want). The
+	  module will be called vfb. If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
