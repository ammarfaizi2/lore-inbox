Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUBRC7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUBRC7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:59:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:39890 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261967AbUBRC7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:59:03 -0500
Date: Tue, 17 Feb 2004 18:58:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Adrian Bunk <bunk@fs.tum.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, GCS <gcs@lsc.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, vandrove@vc.cvut.cz
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <Pine.LNX.4.58.0402180337100.7851@serv>
Message-ID: <Pine.LNX.4.58.0402171856410.2686@home.osdl.org>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
 <20040217200545.GP1308@fs.tum.de> <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
 <20040217225905.GQ1308@fs.tum.de> <Pine.LNX.4.58.0402180337100.7851@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Roman Zippel wrote:
> 
> Linus, I think that's the best solution for now. I have to think a bit
> more about the problem, how a boolean symbol should select a tristate
> symbol.

Hmm.. I already rewrote it the way you suggested earlier, ie like the 
appended. A quick (but ny no means exhaustive) test implied that 
this works fine too.

		Linus

----
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1646  -> 1.1647 
#	drivers/video/Kconfig	1.38    -> 1.39   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/17	torvalds@home.osdl.org	1.1647
# Fix the dependency chain for I2C_ALGOBIT from the FB
# drivers that need it. 
# 
# This allows us to have I2C as a module iff the FB driver
# that needs it is a module.
# --------------------------------------------
#
diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	Tue Feb 17 18:57:36 2004
+++ b/drivers/video/Kconfig	Tue Feb 17 18:57:36 2004
@@ -462,6 +462,7 @@
 config FB_MATROX
 	tristate "Matrox acceleration"
 	depends on FB && PCI
+	select I2C_ALGOBIT if FB_MATROX_I2C
 	---help---
 	  Say Y here if you have a Matrox Millennium, Matrox Millennium II,
 	  Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
@@ -549,7 +550,6 @@
 config FB_MATROX_I2C
 	tristate "Matrox I2C support"
 	depends on FB_MATROX && I2C
-	select I2C_ALGOBIT
 	---help---
 	  This drivers creates I2C buses which are needed for accessing the
 	  DDC (I2C) bus present on all Matroxes, an I2C bus which
@@ -627,6 +627,7 @@
 config FB_RADEON
 	tristate "ATI Radeon display support"
 	depends on FB && PCI
+	select I2C_ALGOBIT if FB_RADEON_I2C
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You
@@ -645,7 +646,6 @@
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
 	depends on FB_RADEON && I2C
-	select I2C_ALGOBIT
 	default y
 	help
 	  Say Y here if you want DDC/I2C support for your Radeon board. 
