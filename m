Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWFSM0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWFSM0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWFSMZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61885 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932418AbWFSMZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:09 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/15] frv: misc sparse annotations
Date: Mon, 19 Jun 2006 13:24:59 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122459.10060.85530.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/irq-routing.c   |    8 ++++----
 arch/frv/mb93090-mb00/pci-irq.c |   10 +++++-----
 include/asm-frv/highmem.h       |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/frv/kernel/irq-routing.c b/arch/frv/kernel/irq-routing.c
index d4776d1..b90b70a 100644
--- a/arch/frv/kernel/irq-routing.c
+++ b/arch/frv/kernel/irq-routing.c
@@ -112,7 +112,7 @@ struct irq_source frv_cpuuart[2] = {
 #define __CPUUART(X, A)						\
 	[X] = {							\
 		.muxname	= "uart",			\
-		.muxdata	= (volatile void __iomem *) A,	\
+		.muxdata	= (volatile void __iomem *)(unsigned long)A,\
 		.irqmask	= 1 << IRQ_CPU_UART##X,		\
 		.doirq		= frv_cpuuart_doirq,		\
 	}
@@ -136,7 +136,7 @@ struct irq_source frv_cpudma[8] = {
 #define __CPUDMA(X, A)						\
 	[X] = {							\
 		.muxname	= "dma",			\
-		.muxdata	= (volatile void __iomem *) A,	\
+		.muxdata	= (volatile void __iomem *)(unsigned long)A,\
 		.irqmask	= 1 << IRQ_CPU_DMA##X,		\
 		.doirq		= frv_cpudma_doirq,		\
 	}
@@ -164,7 +164,7 @@ struct irq_source frv_cputimer[3] = {
 #define __CPUTIMER(X)						\
 	[X] = {							\
 		.muxname	= "timer",			\
-		.muxdata	= 0,				\
+		.muxdata	= NULL,				\
 		.irqmask	= 1 << IRQ_CPU_TIMER##X,	\
 		.doirq		= frv_cputimer_doirq,		\
 	}
@@ -187,7 +187,7 @@ struct irq_source frv_cpuexternal[8] = {
 #define __CPUEXTERNAL(X)					\
 	[X] = {							\
 		.muxname	= "ext",			\
-		.muxdata	= 0,				\
+		.muxdata	= NULL,				\
 		.irqmask	= 1 << IRQ_CPU_EXTERNAL##X,	\
 		.doirq		= frv_cpuexternal_doirq,	\
 	}
diff --git a/arch/frv/mb93090-mb00/pci-irq.c b/arch/frv/mb93090-mb00/pci-irq.c
index c4a1144..45ae39d 100644
--- a/arch/frv/mb93090-mb00/pci-irq.c
+++ b/arch/frv/mb93090-mb00/pci-irq.c
@@ -32,11 +32,11 @@ #include "pci-frv.h"
  */
 
 static const uint8_t __initdata pci_bus0_irq_routing[32][4] = {
-	[0 ] {	IRQ_FPGA_MB86943_PCI_INTA },
-	[16] {	IRQ_FPGA_RTL8029_INTA },
-	[17] {	IRQ_FPGA_PCI_INTC, IRQ_FPGA_PCI_INTD, IRQ_FPGA_PCI_INTA, IRQ_FPGA_PCI_INTB },
-	[18] {	IRQ_FPGA_PCI_INTB, IRQ_FPGA_PCI_INTC, IRQ_FPGA_PCI_INTD, IRQ_FPGA_PCI_INTA },
-	[19] {	IRQ_FPGA_PCI_INTA, IRQ_FPGA_PCI_INTB, IRQ_FPGA_PCI_INTC, IRQ_FPGA_PCI_INTD },
+	[0 ] = { IRQ_FPGA_MB86943_PCI_INTA },
+	[16] = { IRQ_FPGA_RTL8029_INTA },
+	[17] = { IRQ_FPGA_PCI_INTC, IRQ_FPGA_PCI_INTD, IRQ_FPGA_PCI_INTA, IRQ_FPGA_PCI_INTB },
+	[18] = { IRQ_FPGA_PCI_INTB, IRQ_FPGA_PCI_INTC, IRQ_FPGA_PCI_INTD, IRQ_FPGA_PCI_INTA },
+	[19] = { IRQ_FPGA_PCI_INTA, IRQ_FPGA_PCI_INTB, IRQ_FPGA_PCI_INTC, IRQ_FPGA_PCI_INTD },
 };
 
 void __init pcibios_irq_init(void)
diff --git a/include/asm-frv/highmem.h b/include/asm-frv/highmem.h
index 295f74a..399e043 100644
--- a/include/asm-frv/highmem.h
+++ b/include/asm-frv/highmem.h
@@ -135,7 +135,7 @@ static inline void *kmap_atomic(struct p
 
 	default:
 		BUG();
-		return 0;
+		return NULL;
 	}
 }
 

