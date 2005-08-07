Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752193AbVHGPnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbVHGPnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 11:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbVHGPnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 11:43:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27396 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752190AbVHGPnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 11:43:02 -0400
Date: Sun, 7 Aug 2005 17:43:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [-mm patch] more vr4181 removal
Message-ID: <20050807154300.GC3513@stusta.de>
References: <20050807014214.45968af3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807014214.45968af3.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 01:42:14AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc4-mm1:
>...
> +mips-remove-vr4181-support.patch
>...
>  MIPS stuff
>...



Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/mips/Kconfig            |   12 +-----------
 arch/mips/Makefile           |    7 -------
 arch/mips/kernel/cpu-probe.c |    6 ------
 3 files changed, 1 insertion(+), 24 deletions(-)

--- linux-2.6.13-rc5-mm1-full/arch/mips/Kconfig.old	2005-08-07 17:31:12.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/arch/mips/Kconfig	2005-08-07 17:32:04.000000000 +0200
@@ -445,11 +445,6 @@
 	depends on DDB5477
 	default 0
 
-config NEC_OSPREY
-	bool "Support for NEC Osprey board"
-	select DMA_NONCOHERENT
-	select IRQ_CPU
-
 config SGI_IP22
 	bool "Support for SGI IP22 (Indy/Indigo2)"
 	select ARC
@@ -974,7 +969,7 @@
 
 config CPU_LITTLE_ENDIAN
 	bool "Generate little endian code"
-	default y if ACER_PICA_61 || CASIO_E55 || DDB5074 || DDB5476 || DDB5477 || MACH_DECSTATION || IBM_WORKPAD || LASAT || MIPS_COBALT || MIPS_ITE8172 || MIPS_IVR || SOC_AU1X00 || NEC_OSPREY || OLIVETTI_M700 || SNI_RM200_PCI || VICTOR_MPC30X || ZAO_CAPCELLA
+	default y if ACER_PICA_61 || CASIO_E55 || DDB5074 || DDB5476 || DDB5477 || MACH_DECSTATION || IBM_WORKPAD || LASAT || MIPS_COBALT || MIPS_ITE8172 || MIPS_IVR || SOC_AU1X00 || OLIVETTI_M700 || SNI_RM200_PCI || VICTOR_MPC30X || ZAO_CAPCELLA
 	default n if MIPS_EV64120 || MIPS_EV96100 || MOMENCO_OCELOT || MOMENCO_OCELOT_G || SGI_IP22 || SGI_IP27 || SGI_IP32 || TOSHIBA_JMR3927
 	help
 	  Some MIPS machines can be configured for either little or big endian
@@ -1091,11 +1086,6 @@
 config HAVE_STD_PC_SERIAL_PORT
 	bool
 
-config VR4181
-	bool
-	depends on NEC_OSPREY
-	default y
-
 config ARC_CONSOLE
 	bool "ARC console support"
 	depends on SGI_IP22 || SNI_RM200_PCI
--- linux-2.6.13-rc5-mm1-full/arch/mips/Makefile.old	2005-08-07 17:32:19.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/arch/mips/Makefile	2005-08-07 17:32:30.000000000 +0200
@@ -469,13 +469,6 @@
 load-$(CONFIG_LASAT)		+= 0xffffffff80000000
 
 #
-# NEC Osprey (vr4181) board
-#
-core-$(CONFIG_NEC_OSPREY)	+= arch/mips/vr4181/common/ \
-				   arch/mips/vr4181/osprey/
-load-$(CONFIG_NEC_OSPREY)	+= 0xffffffff80002000
-
-#
 # Common VR41xx
 #
 core-$(CONFIG_MACH_VR41XX)	+= arch/mips/vr41xx/common/
--- linux-2.6.13-rc5-mm1-full/arch/mips/kernel/cpu-probe.c.old	2005-08-07 17:32:45.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/arch/mips/kernel/cpu-probe.c	2005-08-07 17:33:46.000000000 +0200
@@ -229,15 +229,9 @@
 		break;
 	case PRID_IMP_VR41XX:
 		switch (c->processor_id & 0xf0) {
-#ifndef CONFIG_VR4181
 		case PRID_REV_VR4111:
 			c->cputype = CPU_VR4111;
 			break;
-#else
-		case PRID_REV_VR4181:
-			c->cputype = CPU_VR4181;
-			break;
-#endif
 		case PRID_REV_VR4121:
 			c->cputype = CPU_VR4121;
 			break;

