Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVCRXZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVCRXZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVCRXYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:24:54 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:45981 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262094AbVCRXWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:22:44 -0500
Date: Fri, 18 Mar 2005 17:22:38 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Fix CONFIG_SERIAL_TEXT_DEBUG support on 83xx
Message-ID: <Pine.LNX.4.61.0503181719250.26300@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The uart initialization for CONFIG_SERIAL_TEXT_DEBUG on 83xx was passing 
in physical addresses instead of effective.  Additional, fix the Kconfig 
support to be for all 83xx devices, not just the MPC834x SYS board.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-03-18 17:15:04 -06:00
+++ b/arch/ppc/Kconfig	2005-03-18 17:15:04 -06:00
@@ -733,7 +733,7 @@
 	depends on SANDPOINT || MCPN765 || SPRUCE || PPLUS || PCORE || \
 		PRPMC750 || K2 || PRPMC800 || LOPEC || \
 		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D || \
-		MPC834x_SYS
+		83xx
 	default y
 
 config FORCE
diff -Nru a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c	2005-03-18 17:15:04 -06:00
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c	2005-03-18 17:15:04 -06:00
@@ -243,14 +243,14 @@
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
-		p.membase = (unsigned char __iomem *)immrbar + 0x4500;
+		p.membase = (unsigned char __iomem *)(VIRT_IMMRBAR + 0x4500);
 		p.uartclk = binfo->bi_busfreq;
 
 		gen550_init(0, &p);
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
-		p.membase = (unsigned char __iomem *)immrbar + 0x4500;
+		p.membase = (unsigned char __iomem *)(VIRT_IMMRBAR + 0x4600);
 		p.uartclk = binfo->bi_busfreq;
 
 		gen550_init(1, &p);
