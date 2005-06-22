Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVFVVQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVFVVQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVFVVN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:13:59 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:36094 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262534AbVFVVHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:07:34 -0400
Date: Wed, 22 Jun 2005 16:07:28 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Remove FSL OCP support
Message-ID: <Pine.LNX.4.61.0506221606590.3291@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the OCP device model on Freescale (FSL) PPC's is no
longer used.  All FSL PPC's that were using OCP have be converted
to using the platform device model.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 0db0912993b08ae4870aa370db5e5e6f83f2c5a3
tree 43ce59fdb048f1cfdc13972d4524d8378e2d73b3
parent 8589d0b1ac6dc3ab9aaee30eb943c2d231e28685
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 17:45:05 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 17:45:05 -0500

 arch/ppc/Kconfig.debug    |    2 +-
 include/asm-ppc/fsl_ocp.h |   54 ---------------------------------------------
 include/asm-ppc/ocp.h     |    4 ---
 3 files changed, 1 insertions(+), 59 deletions(-)

diff --git a/arch/ppc/Kconfig.debug b/arch/ppc/Kconfig.debug
--- a/arch/ppc/Kconfig.debug
+++ b/arch/ppc/Kconfig.debug
@@ -66,7 +66,7 @@ config SERIAL_TEXT_DEBUG
 
 config PPC_OCP
 	bool
-	depends on IBM_OCP || FSL_OCP || XILINX_OCP
+	depends on IBM_OCP || XILINX_OCP
 	default y
 
 endmenu
diff --git a/include/asm-ppc/fsl_ocp.h b/include/asm-ppc/fsl_ocp.h
deleted file mode 100644
--- a/include/asm-ppc/fsl_ocp.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * include/asm-ppc/fsl_ocp.h
- *
- * Definitions for the on-chip peripherals on Freescale PPC processors
- *
- * Maintainer: Kumar Gala (kumar.gala@freescale.com)
- *
- * Copyright 2004 Freescale Semiconductor, Inc
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifdef __KERNEL__
-#ifndef __ASM_FS_OCP_H__
-#define __ASM_FS_OCP_H__
-
-/* A table of information for supporting the Gianfar Ethernet Controller
- * This helps identify which enet controller we are dealing with,
- * and what type of enet controller it is
- */
-struct ocp_gfar_data {
-	uint interruptTransmit;
-	uint interruptError;
-	uint interruptReceive;
-	uint interruptPHY;
-	uint flags;
-	uint phyid;
-	uint phyregidx;
-	unsigned char mac_addr[6];
-};
-
-/* Flags in the flags field */
-#define GFAR_HAS_COALESCE		0x20
-#define GFAR_HAS_RMON			0x10
-#define GFAR_HAS_MULTI_INTR		0x08
-#define GFAR_FIRM_SET_MACADDR		0x04
-#define GFAR_HAS_PHY_INTR		0x02	/* if not set use a timer */
-#define GFAR_HAS_GIGABIT		0x01
-
-/* Data structure for I2C support.  Just contains a couple flags
- * to distinguish various I2C implementations*/
-struct ocp_fs_i2c_data {
-	uint flags;
-};
-
-/* Flags for I2C */
-#define FS_I2C_SEPARATE_DFSRR	0x02
-#define FS_I2C_CLOCK_5200	0x01
-
-#endif	/* __ASM_FS_OCP_H__ */
-#endif	/* __KERNEL__ */
diff --git a/include/asm-ppc/ocp.h b/include/asm-ppc/ocp.h
--- a/include/asm-ppc/ocp.h
+++ b/include/asm-ppc/ocp.h
@@ -202,10 +202,6 @@ static DEVICE_ATTR(name##_##field, S_IRU
 #include <asm/ibm_ocp.h>
 #endif
 
-#ifdef CONFIG_FSL_OCP
-#include <asm/fsl_ocp.h>
-#endif
-
 #endif				/* CONFIG_PPC_OCP */
 #endif				/* __OCP_H__ */
 #endif				/* __KERNEL__ */
