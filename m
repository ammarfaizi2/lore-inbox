Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWDMNuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWDMNuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWDMNuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:50:54 -0400
Received: from mail.renesas.com ([202.234.163.13]:5509 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S964937AbWDMNux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:50:53 -0400
Date: Thu, 13 Apr 2006 22:50:50 +0900 (JST)
Message-Id: <20060413.225050.189714797.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH-2.6.17-rc1-mm2] m32r: mappi3 reboot support
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to support a reboot function for M3A-2170(Mappi-III) 
evaluation board.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/process.c           |    4 ++++
 include/asm-m32r/mappi3/mappi3_pld.h |   22 +++++++++++-----------
 2 files changed, 15 insertions(+), 11 deletions(-)

Index: linux-2.6.17-rc1-mm2/arch/m32r/kernel/process.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/arch/m32r/kernel/process.c	2006-04-10 11:22:09.154152202 +0900
+++ linux-2.6.17-rc1-mm2/arch/m32r/kernel/process.c	2006-04-10 11:36:54.529211492 +0900
@@ -116,6 +116,10 @@ void cpu_idle (void)
 
 void machine_restart(char *__unused)
 {
+#if defined(CONFIG_PLAT_MAPPI3)
+	outw(1, (unsigned long)PLD_REBOOT);
+#endif
+
 	printk("Please push reset button!\n");
 	while (1)
 		cpu_relax();
Index: linux-2.6.17-rc1-mm2/include/asm-m32r/mappi3/mappi3_pld.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/asm-m32r/mappi3/mappi3_pld.h	2006-04-10 11:32:09.000000000 +0900
+++ linux-2.6.17-rc1-mm2/include/asm-m32r/mappi3/mappi3_pld.h	2006-04-10 11:32:36.564911597 +0900
@@ -53,16 +53,14 @@
 /* Power Control of MMC and CF */
 #define PLD_CPCR		__reg16(PLD_BASE + 0x14000)
 
-
-/*==== ICU ====*/
-#define  M32R_IRQ_PC104        (5)   /* INT4(PC/104) */
-#define  M32R_IRQ_I2C          (28)  /* I2C-BUS     */
-#define  PLD_IRQ_CFIREQ       (6)  /* INT5 CFC Card Interrupt */
-#define  PLD_IRQ_CFC_INSERT   (7)  /* INT6 CFC Card Insert */
-#define  PLD_IRQ_IDEIREQ      (8)  /* INT7 IDE Interrupt   */
-#define  PLD_IRQ_MMCCARD      (43)  /* MMC Card Insert */
-#define  PLD_IRQ_MMCIRQ       (44)  /* MMC Transfer Done */
-
+/* ICU */
+#define M32R_IRQ_PC104		(5)	/* INT4(PC/104) */
+#define M32R_IRQ_I2C		(28)	/* I2C-BUS */
+#define PLD_IRQ_CFIREQ		(6)	/* INT5 CFC Card Interrupt */
+#define PLD_IRQ_CFC_INSERT	(7)	/* INT6 CFC Card Insert & Eject */
+#define PLD_IRQ_IDEIREQ		(8)	/* INT7 IDE Interrupt */
+#define PLD_IRQ_MMCCARD		(43)	/* MMC Card Insert */
+#define PLD_IRQ_MMCIRQ		(44)	/* MMC Transfer Done */
 
 #if 0
 /* LED Control
@@ -97,7 +95,6 @@
 #define PLD_CRC16ADATA		__reg16(PLD_BASE + 0x18008)
 #define PLD_CRC16AINDATA	__reg16(PLD_BASE + 0x1800a)
 
-
 #if 0
 /* RTC */
 #define PLD_RTCCR		__reg16(PLD_BASE + 0x1c000)
@@ -140,4 +137,7 @@
 
 #endif
 
+/* Reset Control */
+#define PLD_REBOOT		__reg16(PLD_BASE + 0x38000)
+
 #endif	/* _MAPPI3_PLD.H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
