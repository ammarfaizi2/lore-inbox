Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVHKPRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVHKPRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVHKPRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:17:20 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:65003 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751059AbVHKPRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:17:20 -0400
Date: Fri, 12 Aug 2005 00:17:12 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/4] mips: add TANBAC VR4131 multichip module
Message-Id: <20050812001712.77ae6495.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has added TANBAC VR4131 multichip module in arch/mips/Kconfig
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/arch/mips/Kconfig mm1/arch/mips/Kconfig
--- mm1-orig/arch/mips/Kconfig	2005-08-02 13:45:48.000000000 +0900
+++ mm1/arch/mips/Kconfig	2005-08-12 00:06:39.000000000 +0900
@@ -102,25 +102,29 @@
 	select IRQ_CPU
 	select ISA
 
-config TANBAC_TB0226
-	bool "Support for TANBAC TB0226 (Mbase)"
+config TANBAC_TB022X
+	bool "Support for TANBAC VR4131 multichip module and TANBAC VR4131DIMM"
 	depends on MACH_VR41XX
+	select CPU_LITTLE_ENDIAN
 	select DMA_NONCOHERENT
-	select HW_HAS_PCI
 	select IRQ_CPU
+	select HW_HAS_PCI
 	help
-	  The TANBAC TB0226 (Mbase) is a MIPS-based platform manufactured by TANBAC.
-	  Please refer to <http://www.tanbac.co.jp/> about Mbase.
+	  The TANBAC VR4131 multichip module(TB0225) and
+	  the TANBAC VR4131DIMM(TB0229) are MIPS-based platforms
+	  manufactured by TANBAC.
+	  Please refer to <http://www.tanbac.co.jp/>
+	  about VR4131 multichip module and VR4131DIMM.
 
-config TANBAC_TB0229
-	bool "Support for TANBAC TB0229 (VR4131DIMM)"
-	depends on MACH_VR41XX
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select IRQ_CPU
+config TANBAC_TB0226
+	bool "Support for TANBAC Mbase(TB0226)"
+	depends on TANBAC_TB022X
+	select PCI
+	select PCI_VR41XX
+	select GPIO_VR41XX
 	help
-	  The TANBAC TB0229 (VR4131DIMM) is a MIPS-based platform manufactured by TANBAC.
-	  Please refer to <http://www.tanbac.co.jp/> about VR4131DIMM.
+	  The TANBAC Mbase(TB0226) is a MIPS-based platform manufactured by TANBAC.
+	  Please refer to <http://www.tanbac.co.jp/> about Mbase.
 
 config VICTOR_MPC30X
 	bool "Support for Victor MP-C303/304"
diff -urN -X dontdiff mm1-orig/arch/mips/Makefile mm1/arch/mips/Makefile
--- mm1-orig/arch/mips/Makefile	2005-08-12 00:00:57.000000000 +0900
+++ mm1/arch/mips/Makefile	2005-08-12 00:06:39.000000000 +0900
@@ -510,14 +510,9 @@
 load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
 
 #
-# TANBAC TB0226 Mbase (VR4131)
+# TANBAC VR4131 multichip module(TB0225) and TANBAC VR4131DIMM(TB0229) (VR4131)
 #
-load-$(CONFIG_TANBAC_TB0226)	+= 0xffffffff80000000
-
-#
-# TANBAC TB0229 VR4131DIMM (VR4131)
-#
-load-$(CONFIG_TANBAC_TB0229)	+= 0xffffffff80000000
+load-$(CONFIG_TANBAC_TB022X)	+= 0xffffffff80000000
 
 #
 # SGI IP22 (Indy/Indigo2)
diff -urN -X dontdiff mm1-orig/drivers/char/Kconfig mm1/drivers/char/Kconfig
--- mm1-orig/drivers/char/Kconfig	2005-08-12 00:00:58.000000000 +0900
+++ mm1/drivers/char/Kconfig	2005-08-12 00:07:21.000000000 +0900
@@ -842,8 +842,9 @@
 
 config TANBAC_TB0219
 	tristate "TANBAC TB0219 base board support"
-	depends TANBAC_TB0229
-
+	depends TANBAC_TB022X
+	select PCI
+	select PCI_VR41XX
 
 menu "Ftape, the floppy tape device driver"
 
