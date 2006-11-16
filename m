Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424130AbWKPPEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424130AbWKPPEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424131AbWKPPEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:04:47 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:49064
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1424130AbWKPPEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:04:46 -0500
Message-Id: <455C8C72.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 16 Nov 2006 15:06:10 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <mb@bu3sch.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] allow hwrandom core to be a module
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Despite it being small, there should be the option of making it a
module...

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc5/drivers/char/hw_random/Kconfig	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-modular-rng/drivers/char/hw_random/Kconfig	2006-11-16 15:04:25.000000000 +0100
@@ -3,17 +3,20 @@
 #
 
 config HW_RANDOM
-	bool "Hardware Random Number Generator Core support"
-	default y
+	tristate "Hardware Random Number Generator Core support"
+	default m
 	---help---
 	  Hardware Random Number Generator Core infrastructure.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called rng-core.
+
 	  If unsure, say Y.
 
 config HW_RANDOM_INTEL
 	tristate "Intel HW Random Number Generator support"
 	depends on HW_RANDOM && (X86 || IA64) && PCI
-	default y
+	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on Intel i8xx-based motherboards.
@@ -26,7 +29,7 @@ config HW_RANDOM_INTEL
 config HW_RANDOM_AMD
 	tristate "AMD HW Random Number Generator support"
 	depends on HW_RANDOM && X86 && PCI
-	default y
+	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on AMD 76x-based motherboards.
@@ -39,7 +42,7 @@ config HW_RANDOM_AMD
 config HW_RANDOM_GEODE
 	tristate "AMD Geode HW Random Number Generator support"
 	depends on HW_RANDOM && X86 && PCI
-	default y
+	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on the AMD Geode LX.
@@ -52,7 +55,7 @@ config HW_RANDOM_GEODE
 config HW_RANDOM_VIA
 	tristate "VIA HW Random Number Generator support"
 	depends on HW_RANDOM && X86_32
-	default y
+	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on VIA based motherboards.
@@ -65,7 +68,7 @@ config HW_RANDOM_VIA
 config HW_RANDOM_IXP4XX
 	tristate "Intel IXP4xx NPU HW Random Number Generator support"
 	depends on HW_RANDOM && ARCH_IXP4XX
-	default y
+	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random
 	  Number Generator hardware found on the Intel IXP4xx NPU.
@@ -78,7 +81,7 @@ config HW_RANDOM_IXP4XX
 config HW_RANDOM_OMAP
 	tristate "OMAP Random Number Generator support"
 	depends on HW_RANDOM && (ARCH_OMAP16XX || ARCH_OMAP24XX)
-	default y
+	default HW_RANDOM
  	---help---
  	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on OMAP16xx and OMAP24xx multimedia
--- linux-2.6.19-rc5/drivers/char/hw_random/Makefile	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-modular-rng/drivers/char/hw_random/Makefile	2006-11-16 15:02:44.000000000 +0100
@@ -2,7 +2,8 @@
 # Makefile for HW Random Number Generator (RNG) device drivers.
 #
 
-obj-$(CONFIG_HW_RANDOM) += core.o
+obj-$(CONFIG_HW_RANDOM) += rng-core.o
+rng-core-y := core.o
 obj-$(CONFIG_HW_RANDOM_INTEL) += intel-rng.o
 obj-$(CONFIG_HW_RANDOM_AMD) += amd-rng.o
 obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o


