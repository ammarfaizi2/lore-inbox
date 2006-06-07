Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWFGGAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWFGGAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 02:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWFGGAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 02:00:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:8987 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750986AbWFGGAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 02:00:53 -0400
X-IronPort-AV: i="4.05,216,1146466800"; 
   d="scan'208"; a="48196580:sNHT45825843"
Message-ID: <44866B23.6000302@intel.com>
Date: Wed, 07 Jun 2006 13:58:59 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       "Zou, Nanhai" <nanhai.zou@intel.com>, linux-kernel@vger.kernel.org
CC: "bibo,mao" <bibo.mao@intel.com>
Subject: [PATCH] x86_86 msi miss one entry handler
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  In x86_64 architecture, if device driver with msi function
gets 0xee vector by assign_irq_vector() function, system will
crash if this interrupt happens. It is because 0xee interrupt
entry is empty. This patch modifies this. This patch is based
on 2.6.17-rc6.

Please help to review it, any comments is welcome

thanks
bibo,mao

--- 2.6.17-rc6.org/arch/x86_64/kernel/i8259.c	2006-06-07 12:56:01.000000000 +0800
+++ 2.6.17-rc6/arch/x86_64/kernel/i8259.c	2006-06-07 12:59:19.000000000 +0800
@@ -44,11 +44,11 @@
 	BI(x,8) BI(x,9) BI(x,a) BI(x,b) \
 	BI(x,c) BI(x,d) BI(x,e) BI(x,f)
 
-#define BUILD_14_IRQS(x) \
+#define BUILD_15_IRQS(x) \
 	BI(x,0) BI(x,1) BI(x,2) BI(x,3) \
 	BI(x,4) BI(x,5) BI(x,6) BI(x,7) \
 	BI(x,8) BI(x,9) BI(x,a) BI(x,b) \
-	BI(x,c) BI(x,d)
+	BI(x,c) BI(x,d) BI(x,e)
 
 /*
  * ISA PIC or low IO-APIC triggered (INTA-cycle or APIC) interrupts:
@@ -73,13 +73,13 @@ BUILD_16_IRQS(0x8) BUILD_16_IRQS(0x9) BU
 BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd)
 
 #ifdef CONFIG_PCI_MSI
-	BUILD_14_IRQS(0xe)
+	BUILD_15_IRQS(0xe)
 #endif
 
 #endif
 
 #undef BUILD_16_IRQS
-#undef BUILD_14_IRQS
+#undef BUILD_15_IRQS
 #undef BI
 
 
@@ -92,11 +92,11 @@ BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd)
 	IRQ(x,8), IRQ(x,9), IRQ(x,a), IRQ(x,b), \
 	IRQ(x,c), IRQ(x,d), IRQ(x,e), IRQ(x,f)
 
-#define IRQLIST_14(x) \
+#define IRQLIST_15(x) \
 	IRQ(x,0), IRQ(x,1), IRQ(x,2), IRQ(x,3), \
 	IRQ(x,4), IRQ(x,5), IRQ(x,6), IRQ(x,7), \
 	IRQ(x,8), IRQ(x,9), IRQ(x,a), IRQ(x,b), \
-	IRQ(x,c), IRQ(x,d)
+	IRQ(x,c), IRQ(x,d), IRQ(x,e)
 
 void (*interrupt[NR_IRQS])(void) = {
 	IRQLIST_16(0x0),
@@ -108,7 +108,7 @@ void (*interrupt[NR_IRQS])(void) = {
 	IRQLIST_16(0xc), IRQLIST_16(0xd)
 
 #ifdef CONFIG_PCI_MSI
-	, IRQLIST_14(0xe)
+	, IRQLIST_15(0xe)
 #endif
 
 #endif
