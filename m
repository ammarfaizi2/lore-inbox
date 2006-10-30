Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWJ3L7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWJ3L7B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWJ3L7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:59:00 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:23175 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750709AbWJ3L7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:59:00 -0500
From: "Peter Pearse" <peter.pearse@arm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC 1/7][PATCH] AMBA DMA: Provide drivers/amba/Kconfig. 
Date: Mon, 30 Oct 2006 11:58:55 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: Acb8GsaDauUbLYKcT4yhUPCvvgeT0g==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <CAM-OWA16YlkoqCDtbv00000002@cam-owa1.Emea.Arm.com>
X-OriginalArrivalTime: 30 Oct 2006 11:58:58.0814 (UTC) FILETIME=[C86661E0:01C6FC1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new file allows
- display of all AMBA peripherals on the platform
- configuration of the drivers for these.

Signed-off-by: Peter M Pearse <peter.pearse@arm.com> 

---

diff -purN origin_arm/arch/arm/Kconfig arm_amba/arch/arm/Kconfig
--- origin_arm/arch/arm/Kconfig	2006-10-17 15:51:44.000000000 +0100
+++ arm_amba/arch/arm/Kconfig	2006-10-17 16:56:34.000000000 +0100
@@ -395,8 +395,7 @@ config FORCE_MAX_ZONEORDER
 
 menu "Bus support"
 
-config ARM_AMBA
-	bool
+source "drivers/amba/Kconfig"
 
 config ISA
 	bool
diff -purN origin_arm/drivers/amba/Kconfig arm_amba/drivers/amba/Kconfig
--- origin_arm/drivers/amba/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ arm_amba/drivers/amba/Kconfig	2006-10-17 16:50:42.000000000 +0100
@@ -0,0 +1,32 @@
+#
+# This file holds details regarding the AMBA bus of the chosen platform 
+#
+config ARM_AMBA	 
+	bool "Platform has an AMBA bus"
+	depends on ARCH_AAEC2000 || ARCH_INTEGRATOR || ARCH_REALVIEW ||
ARCH_VERSATILE || ARCH_EP93XX
+	---help---
+	 This motherboard has AMBA an bus.
+
+menu 	"AMBA devices"
+	depends on ARM_AMBA
+
+comment "Any AMBA devices on the platform are shown here"
+comment "Drivers for the devices may need to be selected in the relevant
configuration section"
+
+config HAS_ARM_AMBA_PL041
+	string "AMBA PrimeCell AACI AC'97" if (ARCH_VERSATILE_PB ||
MACH_VERSATILE_AB || ARCH_REALVIEW)
+	depends on ARM_AMBA
+	---help---
+	 This board has an AMBA PrimeCell Advanced Audio Codec Interface.
+	 It's driver may be selected under sound/Advanced Linux Sound
Architecture/ALSA ARM devices.
+	 (CONFIG_SND_ARMAACI)
+
+config HAS_ARM_AMBA_PL080
+	depends on ARM_AMBA
+	string "AMBA PrimeCell DMAC PL080" if (ARCH_VERSATILE_PB ||
MACH_VERSATILE_AB || ARCH_REALVIEW)
+	---help---  
+	 This board has an AMBA PrimeCell PL080 DMA Controller.
+	 There is no driver implemented in this kernel.
+
+endmenu
+


