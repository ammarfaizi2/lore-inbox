Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTFYPPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTFYPPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:15:53 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:24743 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S264538AbTFYPPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:15:46 -0400
Subject: [PATCH] 2.4.22-pre2 add nine Configure.help entries from 2.5
	Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1056554975.2042.10.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 25 Jun 2003 09:29:35 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following nine CONFIG options exist in [Cc]onfig.in files,
but do not have corresponding Configure.help entries.

CONFIG_BLK_DEV_TRIFLEX
CONFIG_BLK_DEV_SC1200
CONFIG_FB_MATROX_G100A
CONFIG_ATM_HE_USE_SUNI
CONFIG_FUSION_MAX_SGE
CONFIG_DRM_I830
CONFIG_CHECKING
CONFIG_CHASSIS_LCD_LED
CONFIG_GART_IOMMU

The help texts were borrowed from the Kconfig files in 2.5, and
modified as necessary.

There are quite a few more of these, so more will come when I find
the time.

Patch is against the current 2.4 bk tree.

Steven

--- testing-2.4/Documentation/Configure.help.orig	Wed Jun 25 07:27:25 2003
+++ testing-2.4/Documentation/Configure.help	Wed Jun 25 08:52:27 2003
@@ -1129,6 +1129,15 @@
   Say Y here if you have an IDE controller which uses any of these
   chipsets: CMD643, CMD646 and CMD648.
 
+Compaq Triflex IDE support
+CONFIG_BLK_DEV_TRIFLEX
+  Say Y here if you have a Compaq Triflex IDE controller, such
+  as those commonly found on Compaq Pentium-Pro systems
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  The module will be called
+  triflex.o.
+
 CY82C693 chipset support
 CONFIG_BLK_DEV_CY82C693
   This driver adds detection and support for the CY82C693 chipset
@@ -1198,6 +1207,15 @@
   This is a driver for the OPTi 82C621 EIDE controller.
   Please read the comments at the top of <file:drivers/ide/pci/opti621.c>.
 
+National SCx200 chipset support
+CONFIG_BLK_DEV_SC1200
+  This driver adds support for the built in IDE on the National
+  SCx200 series of embedded x86 "Geode" systems
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  The module will be called
+  sc1200.o.
+
 ServerWorks OSB4/CSB5 chipset support
 CONFIG_BLK_DEV_SVWKS
   This driver adds PIO/(U)DMA support for the ServerWorks OSB4/CSB5
@@ -4812,6 +4830,19 @@
   If you need support for G450 or G550 secondary head, say Y to
   "Matrox G450/G550 second head support" below.
 
+G100/G200/G400 support
+CONFIG_FB_MATROX_G100A
+  Say Y here if you have a Matrox G100, G200 or G400 based
+  video card. If you select "Advanced lowlevel driver options", you
+  should check 8 bpp packed pixel, 16 bpp packed pixel, 24 bpp packed
+  pixel and 32 bpp packed pixel. You can also use font widths
+  different from 8.
+
+  If you need support for G400 secondary head, you must first say Y to
+  "I2C support" and "I2C bit-banging support" in the character devices
+  section, and then to "Matrox I2C support" and "G400 second head
+  support" here in the framebuffer section.
+
 Matrox I2C support
 CONFIG_FB_MATROX_I2C
   This drivers creates I2C buses which are needed for accessing the
@@ -6648,6 +6679,11 @@
   need that capability don't include S-UNI support (it's not needed to
   make the card work).
 
+Use S/UNI PHY driver
+CONFIG_ATM_HE_USE_SUNI
+  Support for the S/UNI-Ultra and S/UNI-622 found in the ForeRunner
+  HE cards.  This driver provides carrier detection some statistics.
+
 Use IDT77015 PHY driver (25Mbps)
 CONFIG_ATM_NICSTAR_USE_IDT77105
   Support for the PHYsical layer chip in ForeRunner LE25 cards. In
@@ -6960,6 +6996,16 @@
   architecture is based on LSI Logic's Message Passing Interface (MPI)
   specification.
 
+Maximum number of scatter gather entries
+CONFIG_FUSION_MAX_SGE
+  This option allows you to specify the maximum number of scatter-
+  gather entries per I/O. The driver defaults to 40, a reasonable number
+  for most systems. However, the user may increase this up to 128.
+  Increasing this parameter will require significantly more memory
+  on a per controller instance. Increasing the parameter is not
+  necessary (or recommended) unless the user will be running
+  large I/O's via the raw interface.
+
 Fusion MPT enhanced SCSI error reporting [optional] module
 CONFIG_FUSION_ISENSE
   The isense module (roughly stands for Interpret SENSE data) is
@@ -18425,6 +18471,13 @@
   selected, the module will be called i810.o.  AGP support is required
   for this driver to work.
 
+Intel 830M, 845G, 852GM, 855GM, 865G
+CONFIG_DRM_I830
+  Choose this option if you have a system that has Intel 830M, 845G,
+  852GM, 855GM or 865G integrated graphics.  If M is selected, the
+  module will be called i830.o.  AGP support is required for this driver
+  to work.
+
 Matrox G200/G400/G450
 CONFIG_DRM_MGA
   Choose this option if you have a Matrox G200, G400 or G450 graphics
@@ -26054,6 +26107,11 @@
   best used in conjunction with the NMI watchdog so that spinlock
   deadlocks are also debuggable.
 
+Additional run-time checks
+CONFIG_CHECKING
+  Enables some internal consistency checks for kernel debugging.
+  You should normally say N.
+
 Read-write spinlock debugging
 CONFIG_DEBUG_RWLOCK
   If you say Y here then read-write lock processing will count how many
@@ -26767,6 +26825,24 @@
   kernel tree does. Such modules that use library CRC32 functions
   require that you say M or Y here.
 
+Chassis LCD and LED support
+CONFIG_CHASSIS_LCD_LED
+  Say Y here if you want to enable support for the Heartbeat,
+  Disk/Network activities LEDs on some PA-RISC machines,
+  or support for the LCD that can be found on recent material.
+
+  This has nothing to do with LED State support for A, J and E class.
+
+  If unsure, say Y.
+
+IOMMU support
+CONFIG_GART_IOMMU
+  Support the K8 IOMMU. Needed to run systems with more than 4GB of memory
+  properly with 32-bit PCI devices that do not support DAC (Double Address
+  Cycle). The IOMMU can be turned off at runtime with the iommu=off parameter.
+  Normally the kernel will take the right choice by itself.
+  If unsure say Y
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,




