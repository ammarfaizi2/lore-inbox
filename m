Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUKIGST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUKIGST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 01:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUKIFzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:55:33 -0500
Received: from motgate8.mot.com ([129.188.136.8]:46570 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261396AbUKIFZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:25:48 -0500
Date: Mon, 8 Nov 2004 23:25:29 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Added MPC8555/8541 security block infrastructure
Message-ID: <Pine.LNX.4.61.0411082319080.13565@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch adds OCP, interrupt, and memory offset details for the security 
block on MPC8555/8541 to support drivers.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/platforms/85xx/mpc8555.c b/arch/ppc/platforms/85xx/mpc8555.c
--- a/arch/ppc/platforms/85xx/mpc8555.c	2004-11-08 21:33:21 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8555.c	2004-11-08 21:33:21 -06:00
@@ -77,6 +77,13 @@
            .pm           = OCP_CPM_NA,
          },
          { .vendor       = OCP_VENDOR_FREESCALE,
+          .function     = OCP_FUNC_SEC2,
+          .index        = 0,
+          .paddr        = MPC85xx_SEC2_OFFSET,
+          .irq          = MPC85xx_IRQ_SEC2,
+          .pm           = OCP_CPM_NA,
+        },
+        { .vendor       = OCP_VENDOR_FREESCALE,
            .function     = OCP_FUNC_PERFMON,
            .index        = 0,
            .paddr        = MPC85xx_PERFMON_OFFSET,
diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h	2004-11-08 21:33:21 -06:00
+++ b/include/asm-ppc/mpc85xx.h	2004-11-08 21:33:21 -06:00
@@ -81,6 +81,7 @@
  #define MPC85xx_IRQ_DUART	(26 + MPC85xx_OPENPIC_IRQ_OFFSET)
  #define MPC85xx_IRQ_IIC1	(27 + MPC85xx_OPENPIC_IRQ_OFFSET)
  #define MPC85xx_IRQ_PERFMON	(28 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_SEC2	(29 + MPC85xx_OPENPIC_IRQ_OFFSET)
  #define MPC85xx_IRQ_CPM		(30 + MPC85xx_OPENPIC_IRQ_OFFSET)

  /* The 12 external interrupt lines */
@@ -120,6 +121,8 @@
  #define MPC85xx_PCI2_SIZE	(0x01000)
  #define MPC85xx_PERFMON_OFFSET	(0xe1000)
  #define MPC85xx_PERFMON_SIZE	(0x01000)
+#define MPC85xx_SEC2_OFFSET	(0x30000)
+#define MPC85xx_SEC2_SIZE	(0x10000)
  #define MPC85xx_UART0_OFFSET	(0x04500)
  #define MPC85xx_UART0_SIZE	(0x00100)
  #define MPC85xx_UART1_OFFSET	(0x04600)
diff -Nru a/include/asm-ppc/ocp_ids.h b/include/asm-ppc/ocp_ids.h
--- a/include/asm-ppc/ocp_ids.h	2004-11-08 21:33:21 -06:00
+++ b/include/asm-ppc/ocp_ids.h	2004-11-08 21:33:21 -06:00
@@ -61,6 +61,7 @@
  #define OCP_FUNC_PERFMON	0x00D2	/* Performance Monitor */
  #define OCP_FUNC_RGMII		0x00D3
  #define OCP_FUNC_TAH		0x00D4
+#define OCP_FUNC_SEC2		0x00D5	/* Crypto/Security 2.0 */

  /* Network 0x0200 - 0x02FF */
  #define OCP_FUNC_EMAC		0x0200
