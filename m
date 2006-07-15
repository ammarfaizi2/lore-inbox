Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWGOFeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWGOFeV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 01:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWGOFeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 01:34:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20924 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932461AbWGOFeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 01:34:20 -0400
Date: Sat, 15 Jul 2006 01:34:18 -0400
From: Dave Jones <davej@redhat.com>
To: linux-ide@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: tighten ATA kconfig dependancies
Message-ID: <20060715053418.GA5557@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, linux-ide@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of prehistoric junk shows up on x86-64 configs.

cmd640
- no-one in their right mind would use this on x86-32, let alone x86-64.

rz1000
- doesn't exist in 64bit form.

compaq triflex
- ditto

CY82C693
- unsure, really alpha only?

CS5520/CS5530/CS5535/SC1200
- 32bit only.

NS87415
- claims to be sparc/parisc only.

Serverworks
- AFAIK, OSB4/CSB5/CSB6 never showed up in 64bit form.
  (Maybe there is a god)

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/drivers/ide/Kconfig~	2006-07-15 01:24:18.000000000 -0400
+++ linux-2.6.17.noarch/drivers/ide/Kconfig	2006-07-15 01:29:47.000000000 -0400
@@ -282,7 +282,7 @@ config IDE_GENERIC
 
 config BLK_DEV_CMD640
 	bool "CMD640 chipset bugfix/support"
-	depends on X86
+	depends on X86_32
 	---help---
 	  The CMD-Technologies CMD640 IDE chip is used on many common 486 and
 	  Pentium motherboards, usually in combination with a "Neptune" or
@@ -377,7 +377,7 @@ config BLK_DEV_OPTI621
 
 config BLK_DEV_RZ1000
 	tristate "RZ1000 chipset bugfix/support"
-	depends on PCI && BLK_DEV_IDEPCI && X86
+	depends on PCI && BLK_DEV_IDEPCI && X86_32
 	help
 	  The PC-Technologies RZ1000 IDE chip is used on many common 486 and
 	  Pentium motherboards, usually along with the "Neptune" chipset.
@@ -508,12 +508,14 @@ config BLK_DEV_CMD64X
 
 config BLK_DEV_TRIFLEX
 	tristate "Compaq Triflex IDE support"
+	depends on X86_32
 	help
 	  Say Y here if you have a Compaq Triflex IDE controller, such
 	  as those commonly found on Compaq Pentium-Pro systems
 
 config BLK_DEV_CY82C693
 	tristate "CY82C693 chipset support"
+	depends on ALPHA
 	help
 	  This driver adds detection and support for the CY82C693 chipset
 	  used on Digital's PC-Alpha 164SX boards.
@@ -523,7 +525,7 @@ config BLK_DEV_CY82C693
 
 config BLK_DEV_CS5520
 	tristate "Cyrix CS5510/20 MediaGX chipset support (VERY EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on X86_32 && EXPERIMENTAL
 	help
 	  Include support for PIO tuning and virtual DMA on the Cyrix MediaGX
 	  5510/5520 chipset. This will automatically be detected and
@@ -533,6 +535,7 @@ config BLK_DEV_CS5520
 
 config BLK_DEV_CS5530
 	tristate "Cyrix/National Semiconductor CS5530 MediaGX chipset support"
+	depends on X86_32
 	help
 	  Include support for UDMA on the Cyrix MediaGX 5530 chipset. This
 	  will automatically be detected and configured if found.
@@ -541,7 +544,7 @@ config BLK_DEV_CS5530
 
 config BLK_DEV_CS5535
 	tristate "AMD CS5535 chipset support"
-	depends on X86 && !X86_64
+	depends on X86_32
 	help
 	  Include support for UDMA on the NSC/AMD CS5535 companion chipset.
 	  This will automatically be detected and configured if found.
@@ -594,6 +597,7 @@ config BLK_DEV_HPT366
 
 config BLK_DEV_SC1200
 	tristate "National SCx200 chipset support"
+	depends on X86_32
 	help
 	  This driver adds support for the built in IDE on the National
 	  SCx200 series of embedded x86 "Geode" systems
@@ -623,6 +627,7 @@ config BLK_DEV_IT821X
 
 config BLK_DEV_NS87415
 	tristate "NS87415 chipset support"
+	depends on SPARC64 || PARISC
 	help
 	  This driver adds detection and support for the NS87415 chip
 	  (used mainly on SPARC64 and PA-RISC machines).
@@ -675,6 +680,7 @@ config BLK_DEV_PDC202XX_NEW
 
 config BLK_DEV_SVWKS
 	tristate "ServerWorks OSB4/CSB5/CSB6 chipsets support"
+	depends on X86_32
 	help
 	  This driver adds PIO/(U)DMA support for the ServerWorks OSB4/CSB5
 	  chipsets.
-- 
http://www.codemonkey.org.uk
