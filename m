Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVFIFVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVFIFVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 01:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVFIFVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 01:21:33 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:29409 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262275AbVFIFUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 01:20:45 -0400
Date: Thu, 9 Jun 2005 00:20:25 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Added support for all MPC8548 internal interrupts
Message-ID: <Pine.LNX.4.61.0506090019550.21981@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MPC8548 has 48 internal interrupts and 12 external interrupts.  The
previous generation PowerQUICC III devices only had 32 internal and 12
external interrupts on the primary interrupt controller.

Expanded the number of internal interrupts to 48 for all PowerQUICC III
processors and moved the interrupt numbers for the external after the 48
internal interrupt lines, rather than putting the 12 new internal
interrupts at the end and ifdef'ng the whole mess.  As parted of this
created a macro which represents the internal interrupt senses since
they are the same on all PQ3 processors.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit d754db8e39a79ae9a159f747511889647e46748a
tree f7985574e2307406bdfea668a937f02effbc3e2d
parent 4c239e81dc954e513ea24fd20963122cebef2bd8
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 09 Jun 2005 00:19:15 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 09 Jun 2005 00:19:15 -0500

 arch/ppc/platforms/85xx/mpc85xx_ads_common.c |   36 +-----------------
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |   41 +++------------------
 arch/ppc/platforms/85xx/sbc85xx.c            |   36 +-----------------
 arch/ppc/platforms/85xx/stx_gp3.c            |   36 +-----------------
 include/asm-ppc/irq.h                        |   28 +++++++-------
 include/asm-ppc/mpc85xx.h                    |   51 ++++++++++++++++++++++++++
 6 files changed, 77 insertions(+), 151 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
@@ -59,40 +59,8 @@ extern unsigned long total_memory;	/* in
 unsigned char __res[sizeof (bd_t)];
 
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
-
 static u_char mpc85xx_ads_openpic_initsenses[] __initdata = {
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: L2 Cache */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: ECM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PCI/PCI-X */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: RIO Inbound Port Write Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: RIO Doorbell Inbound */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: RIO Outbound Message */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: RIO Inbound Message */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 0 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 0 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 0 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 1 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 1 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 1 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Fast Ethernet */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: CPM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
+	MPC85XX_INTERNAL_IRQ_SENSES,
 	0x0,						/* External  0: */
 #if defined(CONFIG_PCI)
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 1: PCI slot 0 */
@@ -159,7 +127,7 @@ mpc85xx_ads_init_IRQ(void)
 	/* Skip reserved space and internal sources */
 	openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
 	/* Map PIC IRQs 0-11 */
-	openpic_set_sources(32, 12, OpenPIC_Addr + 0x10000);
+	openpic_set_sources(48, 12, OpenPIC_Addr + 0x10000);
 
 	/* we let openpic interrupts starting from an offset, to
 	 * leave space for cascading interrupts underneath.
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -73,40 +73,8 @@ static int cds_pci_slot = 2;
 static volatile u8 * cadmus;
 
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
-
 static u_char mpc85xx_cds_openpic_initsenses[] __initdata = {
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: L2 Cache */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: ECM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PCI/PCI-X */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: RIO Inbound Port Write Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: RIO Doorbell Inbound */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: RIO Outbound Message */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: RIO Inbound Message */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 0 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 0 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 0 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 1 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 1 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 1 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Fast Ethernet */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: CPM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
+	MPC85XX_INTERNAL_IRQ_SENSES,
 #if defined(CONFIG_PCI)
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 0: PCI1 slot */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 1: PCI1 slot */
@@ -182,7 +150,6 @@ void __init
 mpc85xx_cds_init_IRQ(void)
 {
 	bd_t *binfo = (bd_t *) __res;
-	int i;
 
 	/* Determine the Physical Address of the OpenPIC regs */
 	phys_addr_t OpenPIC_PAddr = binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
@@ -191,9 +158,13 @@ mpc85xx_cds_init_IRQ(void)
 	OpenPIC_NumInitSenses = sizeof (mpc85xx_cds_openpic_initsenses);
 
 	/* Skip reserved space and internal sources */
+#ifdef CONFIG_MPC8548
+	openpic_set_sources(0, 48, OpenPIC_Addr + 0x10200);
+#else
 	openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
+#endif
 	/* Map PIC IRQs 0-11 */
-	openpic_set_sources(32, 12, OpenPIC_Addr + 0x10000);
+	openpic_set_sources(48, 12, OpenPIC_Addr + 0x10000);
 
 	/* we let openpic interrupts starting from an offset, to
 	 * leave space for cascading interrupts underneath.
diff --git a/arch/ppc/platforms/85xx/sbc85xx.c b/arch/ppc/platforms/85xx/sbc85xx.c
--- a/arch/ppc/platforms/85xx/sbc85xx.c
+++ b/arch/ppc/platforms/85xx/sbc85xx.c
@@ -59,40 +59,8 @@ unsigned long pci_dram_offset = 0;
 extern unsigned long total_memory;	/* in mm/init */
 
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
-
 static u_char sbc8560_openpic_initsenses[] __initdata = {
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: L2 Cache */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: ECM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PCI/PCI-X */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: RIO Inbound Port Write Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: RIO Doorbell Inbound */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: RIO Outbound Message */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: RIO Inbound Message */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 0 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 0 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 0 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 1 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 1 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 1 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Fast Ethernet */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: CPM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
+	MPC85XX_INTERNAL_IRQ_SENSES,
 	0x0,				/* External  0: */
 	0x0,				/* External  1: */
 #if defined(CONFIG_PCI)
@@ -159,7 +127,7 @@ sbc8560_init_IRQ(void)
 	/* Skip reserved space and internal sources */
 	openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
 	/* Map PIC IRQs 0-11 */
-	openpic_set_sources(32, 12, OpenPIC_Addr + 0x10000);
+	openpic_set_sources(48, 12, OpenPIC_Addr + 0x10000);
 
 	/* we let openpic interrupts starting from an offset, to 
 	 * leave space for cascading interrupts underneath.
diff --git a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- a/arch/ppc/platforms/85xx/stx_gp3.c
+++ b/arch/ppc/platforms/85xx/stx_gp3.c
@@ -72,38 +72,7 @@ unsigned long pci_dram_offset = 0;
 
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
 static u8 gp3_openpic_initsenses[] __initdata = {
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: L2 Cache */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: ECM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PCI/PCI-X */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: RIO Inbound Port Write Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: RIO Doorbell Inbound */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: RIO Outbound Message */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: RIO Inbound Message */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 0 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 0 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 0 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 1 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 1 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 1 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Fast Ethernet */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: CPM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
+	MPC85XX_INTERNAL_IRQ_SENSES,
 	0x0,						/* External  0: */
 #if defined(CONFIG_PCI)
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 1: PCI slot 0 */
@@ -200,7 +169,6 @@ static struct irqaction cpm2_irqaction =
 static void __init
 gp3_init_IRQ(void)
 {
-	int i;
 	bd_t *binfo = (bd_t *) __res;
 
 	/*
@@ -218,7 +186,7 @@ gp3_init_IRQ(void)
 	openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
 
 	/* Map PIC IRQs 0-11 */
-	openpic_set_sources(32, 12, OpenPIC_Addr + 0x10000);
+	openpic_set_sources(48, 12, OpenPIC_Addr + 0x10000);
 
 	/*
 	 * Let openpic interrupts starting from an offset, to
diff --git a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h
+++ b/include/asm-ppc/irq.h
@@ -176,7 +176,7 @@ static __inline__ int irq_canonicalize(i
 */
 #include <asm/mpc85xx.h>
 
-/* The MPC8560 openpic has  32 internal interrupts and 12 external
+/* The MPC8548 openpic has 48 internal interrupts and 12 external
  * interrupts.
  *
  * We are "flattening" the interrupt vectors of the cascaded CPM
@@ -184,7 +184,7 @@ static __inline__ int irq_canonicalize(i
  * single integer.
  */
 #define NR_CPM_INTS	64
-#define NR_EPIC_INTS	44
+#define NR_EPIC_INTS	60
 #ifndef NR_8259_INTS
 #define NR_8259_INTS	0
 #endif
@@ -241,18 +241,18 @@ static __inline__ int irq_canonicalize(i
 #define MPC85xx_IRQ_CPM		(30 + MPC85xx_OPENPIC_IRQ_OFFSET)
 
 /* The 12 external interrupt lines */
-#define MPC85xx_IRQ_EXT0        (32 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT1        (33 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT2        (34 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT3        (35 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT4        (36 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT5        (37 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT6        (38 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT7        (39 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT8        (40 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT9        (41 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT10       (42 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT11       (43 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT0        (48 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT1        (49 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT2        (50 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT3        (51 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT4        (52 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT5        (53 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT6        (54 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT7        (55 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT8        (56 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT9        (57 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT10       (58 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT11       (59 + MPC85xx_OPENPIC_IRQ_OFFSET)
 
 /* CPM related interrupts */
 #define	SIU_INT_ERROR		((uint)0x00+CPM_IRQ_OFFSET)
diff --git a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h
+++ b/include/asm-ppc/mpc85xx.h
@@ -134,6 +134,57 @@ enum ppc_sys_devices {
 	MPC85xx_IIC2,
 };
 
+/* Internal interrupts are all Level Sensitive, and Positive Polarity */
+#define MPC85XX_INTERNAL_IRQ_SENSES \
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 32 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 33 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 34 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 35 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 36 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 37 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 38 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 39 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 40 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 41 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 42 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 43 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 44 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 45 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 46 */	\
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE)	/* Internal 47 */
+
 #endif /* CONFIG_85xx */
 #endif /* __ASM_MPC85xx_H__ */
 #endif /* __KERNEL__ */
