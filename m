Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTDZRPa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 13:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbTDZRP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 13:15:28 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:6277 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262609AbTDZRPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 13:15:25 -0400
Date: Sat, 26 Apr 2003 13:21:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] more menu reorg for dependency cleanup
Message-ID: <Pine.LNX.4.44.0304261320590.1825-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Nru curr/arch/i386/Kconfig rday/arch/i386/Kconfig
--- curr/arch/i386/Kconfig	2003-04-26 13:07:28.000000000 -0400
+++ rday/arch/i386/Kconfig	2003-04-26 13:14:39.000000000 -0400
@@ -989,6 +989,11 @@
 	depends on (X86_VISWS || SMP) && !X86_VOYAGER
 	default y
 
+config X86_IO_APIC
+	bool
+	depends on SMP && !(X86_VISWS || X86_VOYAGER)
+	default y
+
 config PCI
 	bool "PCI support" if !X86_VISWS
 	depends on !X86_VOYAGER
@@ -1004,11 +1009,6 @@
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
-config X86_IO_APIC
-	bool
-	depends on SMP && !(X86_VISWS || X86_VOYAGER)
-	default y
-
 choice
 	prompt "PCI access mode"
 	depends on PCI && !X86_VISWS
@@ -1048,18 +1048,6 @@
  	depends on PCI && ((PCI_GODIRECT || PCI_GOANY) || X86_VISWS)
 	default y
 
-config SCx200
-	tristate "NatSemi SCx200 support"
-	depends on !X86_VOYAGER
-	help
-	  This provides basic support for the National Semiconductor SCx200 
-	  processor.  Right now this is just a driver for the GPIO pins.
-
-	  If you don't know what to do here, say N.
-
-	  This support is also available as a module.  If compiled as a
-	  module, it will be called scx200.
-
 source "drivers/pci/Kconfig"
 
 config ISA
@@ -1105,6 +1093,18 @@
 
 source "drivers/mca/Kconfig"
 
+config SCx200
+	tristate "NatSemi SCx200 support"
+	depends on !X86_VOYAGER
+	help
+	  This provides basic support for the National Semiconductor SCx200 
+	  processor.  Right now this is just a driver for the GPIO pins.
+
+	  If you don't know what to do here, say N.
+
+	  This support is also available as a module.  If compiled as a
+	  module, it will be called scx200.
+
 config HOTPLUG
 	bool "Support for hot-pluggable devices"
 	---help---

