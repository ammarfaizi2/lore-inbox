Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVCOSMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVCOSMi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVCOSKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:10:54 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39065 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261703AbVCOSJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:09:20 -0500
Date: Tue, 15 Mar 2005 11:09:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ppc32: Better comment arch/ppc/syslib/cpc700.h
Message-ID: <20050315180918.GT8345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds better comments to arch/ppc/syslib/cpc700.h

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff -urN linux-2.6.11/arch/ppc/syslib/cpc700.h linuxppc-2.6.11/arch/ppc/syslib/cpc700.h
--- linux-2.6.11/arch/ppc/syslib/cpc700.h	2005-03-02 00:37:54.000000000 -0700
+++ linuxppc-2.6.11/arch/ppc/syslib/cpc700.h	2005-03-15 08:56:45.000000000 -0700
@@ -17,13 +17,14 @@
  * memory controller, PIC, UARTs, IIC, and Timers.
  */
 
-#ifndef	_ASMPPC_CPC700_H
-#define	_ASMPPC_CPC700_H
+#ifndef	__PPC_SYSLIB_CPC700_H__
+#define	__PPC_SYSLIB_CPC700_H__
 
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/init.h>
 
+/* XXX no barriers? not even any volatiles?  -- paulus */
 #define CPC700_OUT_32(a,d)  (*(u_int *)a = d)
 #define CPC700_IN_32(a)     (*(u_int *)a)
 
@@ -33,21 +34,26 @@
 #define CPC700_PCI_CONFIG_ADDR          0xfec00000
 #define CPC700_PCI_CONFIG_DATA          0xfec00004
 
-#define CPC700_PMM0_LOCAL		0xff400000
-#define CPC700_PMM0_MASK_ATTR		0xff400004
-#define CPC700_PMM0_PCI_LOW		0xff400008
-#define CPC700_PMM0_PCI_HIGH		0xff40000c
+/* CPU -> PCI memory window 0 */
+#define CPC700_PMM0_LOCAL		0xff400000	/* CPU physical addr */
+#define CPC700_PMM0_MASK_ATTR		0xff400004	/* size and attrs */
+#define CPC700_PMM0_PCI_LOW		0xff400008	/* PCI addr, low word */
+#define CPC700_PMM0_PCI_HIGH		0xff40000c	/* PCI addr, high wd */
+/* CPU -> PCI memory window 1 */
 #define CPC700_PMM1_LOCAL		0xff400010
 #define CPC700_PMM1_MASK_ATTR		0xff400014
 #define CPC700_PMM1_PCI_LOW		0xff400018
 #define CPC700_PMM1_PCI_HIGH		0xff40001c
+/* CPU -> PCI memory window 2 */
 #define CPC700_PMM2_LOCAL		0xff400020
 #define CPC700_PMM2_MASK_ATTR		0xff400024
 #define CPC700_PMM2_PCI_LOW		0xff400028
 #define CPC700_PMM2_PCI_HIGH		0xff40002c
-#define CPC700_PTM1_MEMSIZE		0xff400030
-#define CPC700_PTM1_LOCAL		0xff400034
-#define CPC700_PTM2_MEMSIZE		0xff400038
+/* PCI memory -> CPU window 1 */
+#define CPC700_PTM1_MEMSIZE		0xff400030	/* window size */
+#define CPC700_PTM1_LOCAL		0xff400034	/* CPU phys addr */
+/* PCI memory -> CPU window 2 */
+#define CPC700_PTM2_MEMSIZE		0xff400038	/* size and enable */
 #define CPC700_PTM2_LOCAL		0xff40003c
 
 /*
@@ -89,4 +95,4 @@
 extern void __init cpc700_init_IRQ(void);
 extern int cpc700_get_irq(struct pt_regs *);
 
-#endif	/* _ASMPPC_CPC700_H */
+#endif	/* __PPC_SYSLIB_CPC700_H__ */

-- 
Tom Rini
http://gate.crashing.org/~trini/
