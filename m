Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWA0Ww5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWA0Ww5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWA0Wws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:52:48 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:63883 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422656AbWA0WwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:52:22 -0500
Date: Sat, 28 Jan 2006 00:52:21 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/11] sh: drop maskpos from make_ipr_irq(), remove duplicate irq definitions.
Message-ID: <20060127225221.GG30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some of the subtype IRQ definitions for IPR IRQ, and
consolidate the make_ipr_irq() definitions by dropping maskpos.
SH-4A was the only thing interested in the maskpos, and this
should be handled through INTC2 rather than IPR.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/kernel/cpu/irq/ipr.c |   59 +++++++++++++++++++++---------------------
 include/asm-sh/irq-sh73180.h |   36 +-------------------------
 include/asm-sh/irq-sh7780.h  |   23 ----------------
 include/asm-sh/irq.h         |   10 ++++++-
 4 files changed, 38 insertions(+), 90 deletions(-)

f8f931cba083eba8848230eb02d3e815009daec9
diff --git a/arch/sh/kernel/cpu/irq/ipr.c b/arch/sh/kernel/cpu/irq/ipr.c
index fdbd718..e55150e 100644
--- a/arch/sh/kernel/cpu/irq/ipr.c
+++ b/arch/sh/kernel/cpu/irq/ipr.c
@@ -108,8 +108,7 @@ static void end_ipr_irq(unsigned int irq
 		enable_ipr_irq(irq);
 }
 
-void make_ipr_irq(unsigned int irq, unsigned int addr, int pos,
-		  int priority, int maskpos)
+void make_ipr_irq(unsigned int irq, unsigned int addr, int pos, int priority)
 {
 	disable_irq_nosync(irq);
 	ipr_data[irq].addr = addr;
@@ -123,44 +122,44 @@ void make_ipr_irq(unsigned int irq, unsi
 void __init init_IRQ(void)
 {
 #ifndef CONFIG_CPU_SUBTYPE_SH7780
-	make_ipr_irq(TIMER_IRQ, TIMER_IPR_ADDR, TIMER_IPR_POS, TIMER_PRIORITY, 0);
-	make_ipr_irq(TIMER1_IRQ, TIMER1_IPR_ADDR, TIMER1_IPR_POS, TIMER1_PRIORITY, 0);
+	make_ipr_irq(TIMER_IRQ, TIMER_IPR_ADDR, TIMER_IPR_POS, TIMER_PRIORITY);
+	make_ipr_irq(TIMER1_IRQ, TIMER1_IPR_ADDR, TIMER1_IPR_POS, TIMER1_PRIORITY);
 #if defined(CONFIG_SH_RTC)
-	make_ipr_irq(RTC_IRQ, RTC_IPR_ADDR, RTC_IPR_POS, RTC_PRIORITY, 0);
+	make_ipr_irq(RTC_IRQ, RTC_IPR_ADDR, RTC_IPR_POS, RTC_PRIORITY);
 #endif
 
 #ifdef SCI_ERI_IRQ
-	make_ipr_irq(SCI_ERI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY, 0);
-	make_ipr_irq(SCI_RXI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY, 0);
-	make_ipr_irq(SCI_TXI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY, 0);
+	make_ipr_irq(SCI_ERI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY);
+	make_ipr_irq(SCI_RXI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY);
+	make_ipr_irq(SCI_TXI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY);
 #endif
 
 #ifdef SCIF1_ERI_IRQ
-	make_ipr_irq(SCIF1_ERI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY, 0);
-	make_ipr_irq(SCIF1_RXI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY, 0);
-	make_ipr_irq(SCIF1_BRI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY, 0);
-	make_ipr_irq(SCIF1_TXI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY, 0);
+	make_ipr_irq(SCIF1_ERI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY);
+	make_ipr_irq(SCIF1_RXI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY);
+	make_ipr_irq(SCIF1_BRI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY);
+	make_ipr_irq(SCIF1_TXI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY);
 #endif
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7300)
-	make_ipr_irq(SCIF0_IRQ, SCIF0_IPR_ADDR, SCIF0_IPR_POS, SCIF0_PRIORITY, 0);
-	make_ipr_irq(DMTE2_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY, 0);
-	make_ipr_irq(DMTE3_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY, 0);
-	make_ipr_irq(VIO_IRQ, VIO_IPR_ADDR, VIO_IPR_POS, VIO_PRIORITY, 0);
+	make_ipr_irq(SCIF0_IRQ, SCIF0_IPR_ADDR, SCIF0_IPR_POS, SCIF0_PRIORITY);
+	make_ipr_irq(DMTE2_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY);
+	make_ipr_irq(DMTE3_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY);
+	make_ipr_irq(VIO_IRQ, VIO_IPR_ADDR, VIO_IPR_POS, VIO_PRIORITY);
 #endif
 
 #ifdef SCIF_ERI_IRQ
-	make_ipr_irq(SCIF_ERI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY, 0);
-	make_ipr_irq(SCIF_RXI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY, 0);
-	make_ipr_irq(SCIF_BRI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY, 0);
-	make_ipr_irq(SCIF_TXI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY, 0);
+	make_ipr_irq(SCIF_ERI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY);
+	make_ipr_irq(SCIF_RXI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY);
+	make_ipr_irq(SCIF_BRI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY);
+	make_ipr_irq(SCIF_TXI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY);
 #endif
 
 #ifdef IRDA_ERI_IRQ
-	make_ipr_irq(IRDA_ERI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY, 0);
-	make_ipr_irq(IRDA_RXI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY, 0);
-	make_ipr_irq(IRDA_BRI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY, 0);
-	make_ipr_irq(IRDA_TXI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY, 0);
+	make_ipr_irq(IRDA_ERI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY);
+	make_ipr_irq(IRDA_RXI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY);
+	make_ipr_irq(IRDA_BRI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY);
+	make_ipr_irq(IRDA_TXI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY);
 #endif
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709) || \
@@ -175,12 +174,12 @@ void __init init_IRQ(void)
 	 * You should set corresponding bits of PFC to "00"
 	 * to enable these interrupts.
 	 */
-	make_ipr_irq(IRQ0_IRQ, IRQ0_IPR_ADDR, IRQ0_IPR_POS, IRQ0_PRIORITY, 0);
-	make_ipr_irq(IRQ1_IRQ, IRQ1_IPR_ADDR, IRQ1_IPR_POS, IRQ1_PRIORITY, 0);
-	make_ipr_irq(IRQ2_IRQ, IRQ2_IPR_ADDR, IRQ2_IPR_POS, IRQ2_PRIORITY, 0);
-	make_ipr_irq(IRQ3_IRQ, IRQ3_IPR_ADDR, IRQ3_IPR_POS, IRQ3_PRIORITY, 0);
-	make_ipr_irq(IRQ4_IRQ, IRQ4_IPR_ADDR, IRQ4_IPR_POS, IRQ4_PRIORITY, 0);
-	make_ipr_irq(IRQ5_IRQ, IRQ5_IPR_ADDR, IRQ5_IPR_POS, IRQ5_PRIORITY, 0);
+	make_ipr_irq(IRQ0_IRQ, IRQ0_IPR_ADDR, IRQ0_IPR_POS, IRQ0_PRIORITY);
+	make_ipr_irq(IRQ1_IRQ, IRQ1_IPR_ADDR, IRQ1_IPR_POS, IRQ1_PRIORITY);
+	make_ipr_irq(IRQ2_IRQ, IRQ2_IPR_ADDR, IRQ2_IPR_POS, IRQ2_PRIORITY);
+	make_ipr_irq(IRQ3_IRQ, IRQ3_IPR_ADDR, IRQ3_IPR_POS, IRQ3_PRIORITY);
+	make_ipr_irq(IRQ4_IRQ, IRQ4_IPR_ADDR, IRQ4_IPR_POS, IRQ4_PRIORITY);
+	make_ipr_irq(IRQ5_IRQ, IRQ5_IPR_ADDR, IRQ5_IPR_POS, IRQ5_PRIORITY);
 #endif
 #endif
 
diff --git a/include/asm-sh/irq-sh73180.h b/include/asm-sh/irq-sh73180.h
index bf2e431..d705252 100644
--- a/include/asm-sh/irq-sh73180.h
+++ b/include/asm-sh/irq-sh73180.h
@@ -25,11 +25,6 @@
 #undef DMA_IPR_POS
 #undef DMA_PRIORITY
 
-#undef NR_IRQS
-
-#undef __irq_demux
-#undef irq_demux
-
 #undef INTC_IMCR0
 #undef INTC_IMCR1
 #undef INTC_IMCR2
@@ -229,33 +224,6 @@
 #define SIU_IPR_POS	1
 #define SIU_PRIORITY	3
 
-
-/* ONCHIP_NR_IRQS */
-#define NR_IRQS 109
-
-/* In a generic kernel, NR_IRQS is an upper bound, and we should use
- * ACTUAL_NR_IRQS (which uses the machine vector) to get the correct value.
- */
-#define ACTUAL_NR_IRQS NR_IRQS
-
-
-extern void disable_irq(unsigned int);
-extern void disable_irq_nosync(unsigned int);
-extern void enable_irq(unsigned int);
-
-/*
- * Simple Mask Register Support
- */
-extern void make_maskreg_irq(unsigned int irq);
-extern unsigned short *irq_mask_register;
-
-/*
- * Function for "on chip support modules".
- */
-extern void make_ipr_irq(unsigned int irq, unsigned int addr,
-			 int pos,  int priority);
-extern void make_imask_irq(unsigned int irq);
-
 #define PORT_PACR	0xA4050100UL
 #define PORT_PBCR	0xA4050102UL
 #define PORT_PCCR	0xA4050104UL
@@ -343,8 +311,6 @@ extern void make_imask_irq(unsigned int 
 #define IRQ6_PRIORITY	1
 #define IRQ7_PRIORITY	1
 
-extern int shmse_irq_demux(int irq);
-#define __irq_demux(irq) shmse_irq_demux(irq)
-#define irq_demux(irq) __irq_demux(irq)
+int shmse_irq_demux(int irq);
 
 #endif /* __ASM_SH_IRQ_SH73180_H */
diff --git a/include/asm-sh/irq-sh7780.h b/include/asm-sh/irq-sh7780.h
index 8c8ca12..7f90315 100644
--- a/include/asm-sh/irq-sh7780.h
+++ b/include/asm-sh/irq-sh7780.h
@@ -299,29 +299,6 @@
 #define	GPIO_IPR_POS	2
 #define	GPIO_PRIORITY	3
 
-/* ONCHIP_NR_IRQS */
-#define NR_IRQS 150	/* 111 + 16 */
-
-/* In a generic kernel, NR_IRQS is an upper bound, and we should use
- * ACTUAL_NR_IRQS (which uses the machine vector) to get the correct value.
- */
-#define ACTUAL_NR_IRQS NR_IRQS
-
-extern void disable_irq(unsigned int);
-extern void disable_irq_nosync(unsigned int);
-extern void enable_irq(unsigned int);
-
-/*
- * Simple Mask Register Support
- */
-extern void make_maskreg_irq(unsigned int irq);
-extern unsigned short *irq_mask_register;
-
-/*
- * Function for "on chip support modules".
- */
-extern void make_imask_irq(unsigned int irq);
-
 #define	INTC_TMU0_MSK	0
 #define	INTC_TMU3_MSK	1
 #define	INTC_RTC_MSK	2
diff --git a/include/asm-sh/irq.h b/include/asm-sh/irq.h
index 060ec3c..42b8394 100644
--- a/include/asm-sh/irq.h
+++ b/include/asm-sh/irq.h
@@ -245,6 +245,7 @@
 #endif /* ST40STB1 */
 
 #endif /* 775x / SH4-202 / ST40STB1 */
+#endif /* 7780 */
 
 /* NR_IRQS is made from three components:
  *   1. ONCHIP_NR_IRQS - number of IRLS + on-chip peripherial modules
@@ -274,8 +275,11 @@
 # define ONCHIP_NR_IRQS 72
 #elif defined(CONFIG_CPU_SUBTYPE_ST40STB1)
 # define ONCHIP_NR_IRQS 144
-#elif defined(CONFIG_CPU_SUBTYPE_SH7300)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7300) || \
+      defined(CONFIG_CPU_SUBTYPE_SH73180)
 # define ONCHIP_NR_IRQS 109
+#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
+# define ONCHIP_NR_IRQS 111
 #elif defined(CONFIG_SH_UNKNOWN)	/* Most be last */
 # define ONCHIP_NR_IRQS 144
 #endif
@@ -306,6 +310,8 @@
 # define OFFCHIP_NR_IRQS 96
 #elif defined (CONFIG_SH_TITAN)
 # define OFFCHIP_NR_IRQS 4
+#elif defined(CONFIG_SH_R7780RP)
+# define OFFCHIP_NR_IRQS 16
 #elif defined(CONFIG_SH_UNKNOWN)
 # define OFFCHIP_NR_IRQS 16	/* Must also be last */
 #else
@@ -550,7 +556,7 @@ extern int ipr_irq_demux(int irq);
 #define INTC_ICR_IRLM	(1<<7)
 #endif
 
-#else
+#ifdef CONFIG_CPU_SUBTYPE_SH7780
 #include <asm/irq-sh7780.h>
 #endif
 
