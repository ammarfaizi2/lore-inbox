Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTAAN5I>; Wed, 1 Jan 2003 08:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbTAAN5I>; Wed, 1 Jan 2003 08:57:08 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:64446 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267227AbTAAN5H>; Wed, 1 Jan 2003 08:57:07 -0500
Date: Wed, 1 Jan 2003 15:05:31 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix config dependency of proc support in the airo4500 driver
Message-ID: <20030101140531.GH14184@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_AIRONET4500_PROC is supposed to be built according to whether
CONFIG_AIRONET4500 is to be built-in or a module.  W/o the patch below
CONFIG_AIRONET4500_PROC complains it wants to be a module even when
CONFIG_AIRONET4500 is set to 'Y'.  I assume the "&& m" is a lost bit
of the good ol' times.

The patch also kills some surplus whitespace.

--
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2003-01-01 14:50:59.000000000 +0100
+++ b/drivers/net/Kconfig	2003-01-01 14:56:41.000000000 +0100
@@ -2242,7 +2242,7 @@
 	  All other parameters can be set via the proc interface.
 
 config AIRONET4500_NONCS
-	tristate "Aironet 4500/4800 ISA/PCI/PNP/365 support "
+	tristate "Aironet 4500/4800 ISA/PCI/PNP/365 support"
 	depends on AIRONET4500
 	help
 	  If you have an ISA, PCI or PCMCIA Aironet 4500/4800 wireless LAN
@@ -2256,7 +2256,7 @@
 	  <file:Documentation/modules.txt>.
 
 config AIRONET4500_PNP
-	bool "Aironet 4500/4800 PNP support "
+	bool "Aironet 4500/4800 PNP support"
 	depends on AIRONET4500_NONCS
 	help
 	  If you have an ISA Aironet 4500/4800 card which you want to use in
@@ -2265,7 +2265,7 @@
 	  board if you say Y here.
 
 config AIRONET4500_PCI
-	bool "Aironet 4500/4800 PCI support "
+	bool "Aironet 4500/4800 PCI support"
 	depends on AIRONET4500_NONCS && PCI
 	help
 	  If you have an PCI Aironet 4500/4800 card, say Y here.
@@ -2287,8 +2287,8 @@
 	  package, say Y here. This is not recommended, so say N.
 
 config AIRONET4500_PROC
-	tristate "Aironet 4500/4800 PROC interface "
-	depends on AIRONET4500 && m
+	tristate "Aironet 4500/4800 PROC interface"
+	depends on AIRONET4500
 	---help---
 	  If you say Y here (and to the "/proc file system" below), you will
 	  be able to configure your Aironet card via the
