Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbUKWAQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbUKWAQY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbUKWAPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:15:48 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56821 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262481AbUKWAIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 19:08:32 -0500
Message-ID: <41A27F77.9080401@mvista.com>
Date: Mon, 22 Nov 2004 17:08:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
References: <419E6900.5070001@mvista.com> <20041119155854.02af2174.akpm@osdl.org>
In-Reply-To: <20041119155854.02af2174.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040003010008000708060509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040003010008000708060509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>Anyway, I'll stick this as-is in -mm.  Feel free to send an incremental
>patch, or a replacement.
>

Here is an incremental patch [hopefully] with your concerns addressed.  
Note that the arch/ppc/boot code is not kernel code and only exists for 
a short period of time before execution jumps to the kernel.  Please let 
me know if you have any more concerns.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--


--------------040003010008000708060509
Content-Type: text/plain;
 name="mv64x60_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mv64x60_2.patch"

diff -Nru a/arch/ppc/boot/include/mpsc_defs.h b/arch/ppc/boot/include/mpsc_defs.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/boot/include/mpsc_defs.h	2004-11-22 17:03:43 -07:00
@@ -0,0 +1,146 @@
+/*
+ * drivers/serial/mpsc/mpsc_defs.h
+ * 
+ * Register definitions for the Marvell Multi-Protocol Serial Controller (MPSC),
+ * Serial DMA Controller (SDMA), and Baud Rate Generator (BRG).
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2004 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef	_PPC_BOOT_MPSC_DEFS_H__
+#define	_PPC_BOOT_MPSC_DEFS_H__
+
+#define	MPSC_NUM_CTLRS		2
+
+/*
+ *****************************************************************************
+ *
+ *	Multi-Protocol Serial Controller Interface Registers
+ *
+ *****************************************************************************
+ */
+
+/* Main Configuratino Register Offsets */
+#define	MPSC_MMCRL			0x0000
+#define	MPSC_MMCRH			0x0004
+#define	MPSC_MPCR			0x0008
+#define	MPSC_CHR_1			0x000c
+#define	MPSC_CHR_2			0x0010
+#define	MPSC_CHR_3			0x0014
+#define	MPSC_CHR_4			0x0018
+#define	MPSC_CHR_5			0x001c
+#define	MPSC_CHR_6			0x0020
+#define	MPSC_CHR_7			0x0024
+#define	MPSC_CHR_8			0x0028
+#define	MPSC_CHR_9			0x002c
+#define	MPSC_CHR_10			0x0030
+#define	MPSC_CHR_11			0x0034
+
+#define	MPSC_MPCR_CL_5			0
+#define	MPSC_MPCR_CL_6			1
+#define	MPSC_MPCR_CL_7			2
+#define	MPSC_MPCR_CL_8			3
+#define	MPSC_MPCR_SBL_1			0
+#define	MPSC_MPCR_SBL_2			3
+
+#define	MPSC_CHR_2_TEV			(1<<1)
+#define	MPSC_CHR_2_TA			(1<<7)
+#define	MPSC_CHR_2_TTCS			(1<<9)
+#define	MPSC_CHR_2_REV			(1<<17)
+#define	MPSC_CHR_2_RA			(1<<23)
+#define	MPSC_CHR_2_CRD			(1<<25)
+#define	MPSC_CHR_2_EH			(1<<31)
+#define	MPSC_CHR_2_PAR_ODD		0
+#define	MPSC_CHR_2_PAR_SPACE		1
+#define	MPSC_CHR_2_PAR_EVEN		2
+#define	MPSC_CHR_2_PAR_MARK		3
+
+/* MPSC Signal Routing */
+#define	MPSC_MRR			0x0000
+#define	MPSC_RCRR			0x0004
+#define	MPSC_TCRR			0x0008
+
+/*
+ *****************************************************************************
+ *
+ *	Serial DMA Controller Interface Registers
+ *
+ *****************************************************************************
+ */
+
+#define	SDMA_SDC			0x0000
+#define	SDMA_SDCM			0x0008
+#define	SDMA_RX_DESC			0x0800
+#define	SDMA_RX_BUF_PTR			0x0808
+#define	SDMA_SCRDP			0x0810
+#define	SDMA_TX_DESC			0x0c00
+#define	SDMA_SCTDP			0x0c10
+#define	SDMA_SFTDP			0x0c14
+
+#define	SDMA_DESC_CMDSTAT_PE		(1<<0)
+#define	SDMA_DESC_CMDSTAT_CDL		(1<<1)
+#define	SDMA_DESC_CMDSTAT_FR		(1<<3)
+#define	SDMA_DESC_CMDSTAT_OR		(1<<6)
+#define	SDMA_DESC_CMDSTAT_BR		(1<<9)
+#define	SDMA_DESC_CMDSTAT_MI		(1<<10)
+#define	SDMA_DESC_CMDSTAT_A		(1<<11)
+#define	SDMA_DESC_CMDSTAT_AM		(1<<12)
+#define	SDMA_DESC_CMDSTAT_CT		(1<<13)
+#define	SDMA_DESC_CMDSTAT_C		(1<<14)
+#define	SDMA_DESC_CMDSTAT_ES		(1<<15)
+#define	SDMA_DESC_CMDSTAT_L		(1<<16)
+#define	SDMA_DESC_CMDSTAT_F		(1<<17)
+#define	SDMA_DESC_CMDSTAT_P		(1<<18)
+#define	SDMA_DESC_CMDSTAT_EI		(1<<23)
+#define	SDMA_DESC_CMDSTAT_O		(1<<31)
+
+#define SDMA_DESC_DFLT			(SDMA_DESC_CMDSTAT_O |	\
+					SDMA_DESC_CMDSTAT_EI)
+
+#define	SDMA_SDC_RFT			(1<<0)
+#define	SDMA_SDC_SFM			(1<<1)
+#define	SDMA_SDC_BLMR			(1<<6)
+#define	SDMA_SDC_BLMT			(1<<7)
+#define	SDMA_SDC_POVR			(1<<8)
+#define	SDMA_SDC_RIFB			(1<<9)
+
+#define	SDMA_SDCM_ERD			(1<<7)
+#define	SDMA_SDCM_AR			(1<<15)
+#define	SDMA_SDCM_STD			(1<<16)
+#define	SDMA_SDCM_TXD			(1<<23)
+#define	SDMA_SDCM_AT			(1<<31)
+
+#define	SDMA_0_CAUSE_RXBUF		(1<<0)
+#define	SDMA_0_CAUSE_RXERR		(1<<1)
+#define	SDMA_0_CAUSE_TXBUF		(1<<2)
+#define	SDMA_0_CAUSE_TXEND		(1<<3)
+#define	SDMA_1_CAUSE_RXBUF		(1<<8)
+#define	SDMA_1_CAUSE_RXERR		(1<<9)
+#define	SDMA_1_CAUSE_TXBUF		(1<<10)
+#define	SDMA_1_CAUSE_TXEND		(1<<11)
+
+#define	SDMA_CAUSE_RX_MASK	(SDMA_0_CAUSE_RXBUF | SDMA_0_CAUSE_RXERR | \
+	SDMA_1_CAUSE_RXBUF | SDMA_1_CAUSE_RXERR)
+#define	SDMA_CAUSE_TX_MASK	(SDMA_0_CAUSE_TXBUF | SDMA_0_CAUSE_TXEND | \
+	SDMA_1_CAUSE_TXBUF | SDMA_1_CAUSE_TXEND)
+
+/* SDMA Interrupt registers */
+#define	SDMA_INTR_CAUSE			0x0000
+#define	SDMA_INTR_MASK			0x0080
+
+/*
+ *****************************************************************************
+ *
+ *	Baud Rate Generator Interface Registers
+ *
+ *****************************************************************************
+ */
+
+#define	BRG_BCR				0x0000
+#define	BRG_BTR				0x0004
+
+#endif /*_PPC_BOOT_MPSC_DEFS_H__ */
diff -Nru a/arch/ppc/boot/simple/mv64x60_tty.c b/arch/ppc/boot/simple/mv64x60_tty.c
--- a/arch/ppc/boot/simple/mv64x60_tty.c	2004-11-22 17:03:43 -07:00
+++ b/arch/ppc/boot/simple/mv64x60_tty.c	2004-11-22 17:03:43 -07:00
@@ -21,7 +21,7 @@
 #include <linux/serial_reg.h>
 #include <asm/serial.h>
 #include <asm/mv64x60_defs.h>
-#include "../../../../drivers/serial/mpsc_defs.h"
+#include <mpsc_defs.h>
 
 extern void udelay(long);
 static void stop_dma(int chan);
@@ -78,19 +78,19 @@
 static u32	mpsc_base[2] = { MV64x60_MPSC_0_OFFSET, MV64x60_MPSC_1_OFFSET };
 
 struct mv64x60_rx_desc {
-	volatile u16 bufsize;
-	volatile u16 bytecnt;
-	volatile u32 cmd_stat;
-	volatile u32 next_desc_ptr;
-	volatile u32 buffer;
+	u16	bufsize;
+	u16	bytecnt;
+	u32	cmd_stat;
+	u32	next_desc_ptr;
+	u32	buffer;
 };
 
 struct mv64x60_tx_desc {
-	volatile u16 bytecnt;
-	volatile u16 shadow;
-	volatile u32 cmd_stat;
-	volatile u32 next_desc_ptr;
-	volatile u32 buffer;
+	u16	bytecnt;
+	u16	shadow;
+	u32	cmd_stat;
+	u32	next_desc_ptr;
+	u32	buffer;
 };
 
 #define	MAX_RESET_WAIT	10000
@@ -121,6 +121,24 @@
 		SDMA_DESC_CMDSTAT_O;	\
 }
 
+#ifdef CONFIG_MV64360
+static u32 cpu2mem_tab[MV64x60_CPU2MEM_WINDOWS][2] = {
+		{ MV64x60_CPU2MEM_0_BASE, MV64x60_CPU2MEM_0_SIZE },
+		{ MV64x60_CPU2MEM_1_BASE, MV64x60_CPU2MEM_1_SIZE },
+		{ MV64x60_CPU2MEM_2_BASE, MV64x60_CPU2MEM_2_SIZE },
+		{ MV64x60_CPU2MEM_3_BASE, MV64x60_CPU2MEM_3_SIZE }
+};
+
+static u32 com2mem_tab[MV64x60_CPU2MEM_WINDOWS][2] = { 
+		{ MV64360_MPSC2MEM_0_BASE, MV64360_MPSC2MEM_0_SIZE },
+		{ MV64360_MPSC2MEM_1_BASE, MV64360_MPSC2MEM_1_SIZE },
+		{ MV64360_MPSC2MEM_2_BASE, MV64360_MPSC2MEM_2_SIZE },
+		{ MV64360_MPSC2MEM_3_BASE, MV64360_MPSC2MEM_3_SIZE }
+};
+
+static u32 dram_selects[MV64x60_CPU2MEM_WINDOWS] = { 0xe, 0xd, 0xb, 0x7 };
+#endif
+
 unsigned long
 serial_init(int chan, void *ignored)
 {
@@ -180,19 +198,6 @@
 
 	/* Set up comm unit to memory mapping windows */
 	/* Note: Assumes MV64x60_CPU2MEM_WINDOWS == 4 */
-	u32	cpu2mem_tab[MV64x60_CPU2MEM_WINDOWS][2] = {
-			{ MV64x60_CPU2MEM_0_BASE, MV64x60_CPU2MEM_0_SIZE },
-			{ MV64x60_CPU2MEM_1_BASE, MV64x60_CPU2MEM_1_SIZE },
-			{ MV64x60_CPU2MEM_2_BASE, MV64x60_CPU2MEM_2_SIZE },
-			{ MV64x60_CPU2MEM_3_BASE, MV64x60_CPU2MEM_3_SIZE }
-	};
-	u32	com2mem_tab[MV64x60_CPU2MEM_WINDOWS][2] = { 
-			{ MV64360_MPSC2MEM_0_BASE, MV64360_MPSC2MEM_0_SIZE },
-			{ MV64360_MPSC2MEM_1_BASE, MV64360_MPSC2MEM_1_SIZE },
-			{ MV64360_MPSC2MEM_2_BASE, MV64360_MPSC2MEM_2_SIZE },
-			{ MV64360_MPSC2MEM_3_BASE, MV64360_MPSC2MEM_3_SIZE }
-	};
-	u32	dram_selects[MV64x60_CPU2MEM_WINDOWS] = { 0xe, 0xd, 0xb, 0x7 };
 
 	enables = MV64x60_REG_READ(MV64360_CPU_BAR_ENABLE) & 0xf;
 	prot_bits = 0;
diff -Nru a/arch/ppc/syslib/gt64260_pic.c b/arch/ppc/syslib/gt64260_pic.c
--- a/arch/ppc/syslib/gt64260_pic.c	2004-11-22 17:03:43 -07:00
+++ b/arch/ppc/syslib/gt64260_pic.c	2004-11-22 17:03:43 -07:00
@@ -294,21 +294,31 @@
 static int __init
 gt64260_register_hdlrs(void)
 {
+	int rc;
+
 	/* Register CPU interface error interrupt handler */
-	request_irq(MV64x60_IRQ_CPU_ERR, gt64260_cpu_error_int_handler,
-		    SA_INTERRUPT, CPU_INTR_STR, 0);
+	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR,
+		gt64260_cpu_error_int_handler, SA_INTERRUPT, CPU_INTR_STR, 0)))
+		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
+
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0x000000fe);
 
 	/* Register PCI 0 error interrupt handler */
-	request_irq(MV64360_IRQ_PCI0, gt64260_pci_error_int_handler,
-		    SA_INTERRUPT, PCI0_INTR_STR, (void *)0);
+	if ((rc = request_irq(MV64360_IRQ_PCI0, gt64260_pci_error_int_handler,
+		    SA_INTERRUPT, PCI0_INTR_STR, (void *)0)))
+		printk(KERN_WARNING "Can't register pci 0 error handler: %d",
+			rc);
+
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0x003c0c24);
 
 	/* Register PCI 1 error interrupt handler */
-	request_irq(MV64360_IRQ_PCI1, gt64260_pci_error_int_handler,
-		    SA_INTERRUPT, PCI1_INTR_STR, (void *)1);
+	if ((rc = request_irq(MV64360_IRQ_PCI1, gt64260_pci_error_int_handler,
+		    SA_INTERRUPT, PCI1_INTR_STR, (void *)1)))
+		printk(KERN_WARNING "Can't register pci 1 error handler: %d",
+			rc);
+
 	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0);
 	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0x003c0c24);
 
diff -Nru a/arch/ppc/syslib/mv64360_pic.c b/arch/ppc/syslib/mv64360_pic.c
--- a/arch/ppc/syslib/mv64360_pic.c	2004-11-22 17:03:43 -07:00
+++ b/arch/ppc/syslib/mv64360_pic.c	2004-11-22 17:03:43 -07:00
@@ -367,16 +367,20 @@
 mv64360_register_hdlrs(void)
 {
 	u32	mask;
+	int	rc;
 
 	/* Register CPU interface error interrupt handler */
-	request_irq(MV64x60_IRQ_CPU_ERR, mv64360_cpu_error_int_handler,
-		    SA_INTERRUPT, CPU_INTR_STR, 0);
+	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR,
+		mv64360_cpu_error_int_handler, SA_INTERRUPT, CPU_INTR_STR, 0)))
+		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
+
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0x000000ff);
 
 	/* Register internal SRAM error interrupt handler */
-	request_irq(MV64360_IRQ_SRAM_PAR_ERR, mv64360_sram_error_int_handler,
-		    SA_INTERRUPT, SRAM_INTR_STR, 0);
+	if ((rc = request_irq(MV64360_IRQ_SRAM_PAR_ERR,
+		mv64360_sram_error_int_handler,SA_INTERRUPT,SRAM_INTR_STR, 0)))
+		printk(KERN_WARNING "Can't register SRAM error handler: %d",rc);
 
 	/*
 	 * Bit 0 reserved on 64360 and erratum FEr PCI-#11 (PCI internal
@@ -390,14 +394,20 @@
 		mask |= 0x1;	/* enable DPErr on 64460 */
 
 	/* Register PCI 0 error interrupt handler */
-	request_irq(MV64360_IRQ_PCI0, mv64360_pci_error_int_handler,
-		    SA_INTERRUPT, PCI0_INTR_STR, (void *)0);
+	if ((rc = request_irq(MV64360_IRQ_PCI0, mv64360_pci_error_int_handler,
+		    SA_INTERRUPT, PCI0_INTR_STR, (void *)0)))
+		printk(KERN_WARNING "Can't register pci 0 error handler: %d",
+			rc);
+
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, mask);
 
 	/* Register PCI 1 error interrupt handler */
-	request_irq(MV64360_IRQ_PCI1, mv64360_pci_error_int_handler,
-		    SA_INTERRUPT, PCI1_INTR_STR, (void *)1);
+	if ((rc = request_irq(MV64360_IRQ_PCI1, mv64360_pci_error_int_handler,
+		    SA_INTERRUPT, PCI1_INTR_STR, (void *)1)))
+		printk(KERN_WARNING "Can't register pci 1 error handler: %d",
+			rc);
+
 	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0);
 	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, mask);
 
diff -Nru a/arch/ppc/syslib/mv64x60.c b/arch/ppc/syslib/mv64x60.c
--- a/arch/ppc/syslib/mv64x60.c	2004-11-22 17:03:43 -07:00
+++ b/arch/ppc/syslib/mv64x60.c	2004-11-22 17:03:43 -07:00
@@ -192,7 +192,7 @@
 	.num_resources	= ARRAY_SIZE(mv64x60_mpsc_shared_resources),
 	.resource	= mv64x60_mpsc_shared_resources,
 	.dev = {
-		.driver_data = (void *)&mv64x60_mpsc_shared_pd_dd,
+		.driver_data = &mv64x60_mpsc_shared_pd_dd,
 	},
 };
 
@@ -248,7 +248,7 @@
 	.num_resources	= ARRAY_SIZE(mv64x60_mpsc0_resources),
 	.resource	= mv64x60_mpsc0_resources,
 	.dev = {
-		.driver_data = (void *)&mv64x60_mpsc0_pd_dd,
+		.driver_data = &mv64x60_mpsc0_pd_dd,
 	},
 };
 
@@ -305,7 +305,7 @@
 	.num_resources	= ARRAY_SIZE(mv64x60_mpsc1_resources),
 	.resource	= mv64x60_mpsc1_resources,
 	.dev = {
-		.driver_data = (void *)&mv64x60_mpsc1_pd_dd,
+		.driver_data = &mv64x60_mpsc1_pd_dd,
 	},
 };
 #endif
@@ -537,6 +537,7 @@
 			val = map_to_field(val, size_bits);
 			mv64x60_write(bh, size_reg, val);
 		}
+
 		(void)mv64x60_read(bh, base_reg); /* Flush FIFO */
 	}
 
@@ -836,15 +837,19 @@
 {
 	struct mv64x60_handle	bh;
 	u32			mem_windows[MV64x60_CPU2MEM_WINDOWS][2];
+	u32			rc = 0;
 
 	memset(&bh, 0, sizeof(bh));
 
 	bh.type = chip_type;
 	bh.v_base = bridge_base;
 
-	(void)mv64x60_setup_for_chip(&bh);
-	mv64x60_get_mem_windows(&bh, mem_windows);
-	return mv64x60_calc_mem_size(&bh, mem_windows);
+	if (!mv64x60_setup_for_chip(&bh)) {
+		mv64x60_get_mem_windows(&bh, mem_windows);
+		rc = mv64x60_calc_mem_size(&bh, mem_windows);
+	}
+
+	return rc;
 }
 
 /*
@@ -900,20 +905,22 @@
  *
  * Configure CPU->Memory windows on the bridge.
  */
+static u32 prot_tab[] __initdata = {
+	MV64x60_CPU_PROT_0_WIN, MV64x60_CPU_PROT_1_WIN,
+	MV64x60_CPU_PROT_2_WIN, MV64x60_CPU_PROT_3_WIN
+};
+
+static u32 cpu_snoop_tab[] __initdata = {
+	MV64x60_CPU_SNOOP_0_WIN, MV64x60_CPU_SNOOP_1_WIN,
+	MV64x60_CPU_SNOOP_2_WIN, MV64x60_CPU_SNOOP_3_WIN
+};
+
 void __init
 mv64x60_config_cpu2mem_windows(struct mv64x60_handle *bh,
 	struct mv64x60_setup_info *si,
 	u32 mem_windows[MV64x60_CPU2MEM_WINDOWS][2])
 {
 	u32	i, win;
-	u32	prot_tab[] = {
-			MV64x60_CPU_PROT_0_WIN, MV64x60_CPU_PROT_1_WIN,
-			MV64x60_CPU_PROT_2_WIN, MV64x60_CPU_PROT_3_WIN
-		};
-	u32	cpu_snoop_tab[] = {
-			MV64x60_CPU_SNOOP_0_WIN, MV64x60_CPU_SNOOP_1_WIN,
-			MV64x60_CPU_SNOOP_2_WIN, MV64x60_CPU_SNOOP_3_WIN
-		};
 
 	/* Set CPU protection & snoop windows */
 	for (win=MV64x60_CPU2MEM_0_WIN,i=0;win<=MV64x60_CPU2MEM_3_WIN;win++,i++)
@@ -942,29 +949,25 @@
  *
  * Configure the CPU->PCI windows for one of the PCI buses.
  */
+static u32 win_tab[2][4] __initdata = {
+	{ MV64x60_CPU2PCI0_IO_WIN, MV64x60_CPU2PCI0_MEM_0_WIN,
+	  MV64x60_CPU2PCI0_MEM_1_WIN, MV64x60_CPU2PCI0_MEM_2_WIN },
+	{ MV64x60_CPU2PCI1_IO_WIN, MV64x60_CPU2PCI1_MEM_0_WIN,
+	  MV64x60_CPU2PCI1_MEM_1_WIN, MV64x60_CPU2PCI1_MEM_2_WIN },
+};
+
+static u32 remap_tab[2][4] __initdata = {
+	{ MV64x60_CPU2PCI0_IO_REMAP_WIN, MV64x60_CPU2PCI0_MEM_0_REMAP_WIN,
+	  MV64x60_CPU2PCI0_MEM_1_REMAP_WIN, MV64x60_CPU2PCI0_MEM_2_REMAP_WIN },
+	{ MV64x60_CPU2PCI1_IO_REMAP_WIN, MV64x60_CPU2PCI1_MEM_0_REMAP_WIN,
+	  MV64x60_CPU2PCI1_MEM_1_REMAP_WIN, MV64x60_CPU2PCI1_MEM_2_REMAP_WIN }
+};
+
 void __init
 mv64x60_config_cpu2pci_windows(struct mv64x60_handle *bh,
 	struct mv64x60_pci_info *pi, u32 bus)
 {
 	int	i;
-	u32	win_tab[2][4] = {
-			{ MV64x60_CPU2PCI0_IO_WIN, MV64x60_CPU2PCI0_MEM_0_WIN,
-			  MV64x60_CPU2PCI0_MEM_1_WIN,
-			  MV64x60_CPU2PCI0_MEM_2_WIN },
-			{ MV64x60_CPU2PCI1_IO_WIN, MV64x60_CPU2PCI1_MEM_0_WIN,
-			  MV64x60_CPU2PCI1_MEM_1_WIN,
-			  MV64x60_CPU2PCI1_MEM_2_WIN },
-		};
-	u32	remap_tab[2][4] = {
-			{ MV64x60_CPU2PCI0_IO_REMAP_WIN,
-			  MV64x60_CPU2PCI0_MEM_0_REMAP_WIN,
-			  MV64x60_CPU2PCI0_MEM_1_REMAP_WIN,
-			  MV64x60_CPU2PCI0_MEM_2_REMAP_WIN },
-			{ MV64x60_CPU2PCI1_IO_REMAP_WIN,
-			  MV64x60_CPU2PCI1_MEM_0_REMAP_WIN,
-			  MV64x60_CPU2PCI1_MEM_1_REMAP_WIN,
-			  MV64x60_CPU2PCI1_MEM_2_REMAP_WIN }
-		};
 
 	if (pi->pci_io.size > 0) {
 		mv64x60_set_32bit_window(bh, win_tab[bus][0],
@@ -1004,38 +1007,33 @@
  *
  * Configure the PCI->Memory windows on the bridge.
  */
+static u32 pci_acc_tab[2][4] __initdata = {
+	{ MV64x60_PCI02MEM_ACC_CNTL_0_WIN, MV64x60_PCI02MEM_ACC_CNTL_1_WIN,
+	  MV64x60_PCI02MEM_ACC_CNTL_2_WIN, MV64x60_PCI02MEM_ACC_CNTL_3_WIN },
+	{ MV64x60_PCI12MEM_ACC_CNTL_0_WIN, MV64x60_PCI12MEM_ACC_CNTL_1_WIN,
+	  MV64x60_PCI12MEM_ACC_CNTL_2_WIN, MV64x60_PCI12MEM_ACC_CNTL_3_WIN }
+};
+
+static u32 pci_snoop_tab[2][4] __initdata = {
+	{ MV64x60_PCI02MEM_SNOOP_0_WIN, MV64x60_PCI02MEM_SNOOP_1_WIN,
+	  MV64x60_PCI02MEM_SNOOP_2_WIN, MV64x60_PCI02MEM_SNOOP_3_WIN },
+	{ MV64x60_PCI12MEM_SNOOP_0_WIN, MV64x60_PCI12MEM_SNOOP_1_WIN,
+	  MV64x60_PCI12MEM_SNOOP_2_WIN, MV64x60_PCI12MEM_SNOOP_3_WIN }
+};
+
+static u32 pci_size_tab[2][4] __initdata = {
+	{ MV64x60_PCI0_MEM_0_SIZE, MV64x60_PCI0_MEM_1_SIZE,
+	  MV64x60_PCI0_MEM_2_SIZE, MV64x60_PCI0_MEM_3_SIZE },
+	{ MV64x60_PCI1_MEM_0_SIZE, MV64x60_PCI1_MEM_1_SIZE,
+	  MV64x60_PCI1_MEM_2_SIZE, MV64x60_PCI1_MEM_3_SIZE }
+};
+
 void __init
 mv64x60_config_pci2mem_windows(struct mv64x60_handle *bh,
 	struct pci_controller *hose, struct mv64x60_pci_info *pi,
 	u32 bus, u32 mem_windows[MV64x60_CPU2MEM_WINDOWS][2])
 {
 	u32	i, win;
-	u32	pci_acc_tab[2][4] = {
-			{ MV64x60_PCI02MEM_ACC_CNTL_0_WIN,
-			  MV64x60_PCI02MEM_ACC_CNTL_1_WIN,
-			  MV64x60_PCI02MEM_ACC_CNTL_2_WIN,
-			  MV64x60_PCI02MEM_ACC_CNTL_3_WIN },
-			{ MV64x60_PCI12MEM_ACC_CNTL_0_WIN,
-			  MV64x60_PCI12MEM_ACC_CNTL_1_WIN,
-			  MV64x60_PCI12MEM_ACC_CNTL_2_WIN,
-			  MV64x60_PCI12MEM_ACC_CNTL_3_WIN }
-		};
-	u32	pci_snoop_tab[2][4] = {
-			{ MV64x60_PCI02MEM_SNOOP_0_WIN,
-			  MV64x60_PCI02MEM_SNOOP_1_WIN,
-			  MV64x60_PCI02MEM_SNOOP_2_WIN,
-			  MV64x60_PCI02MEM_SNOOP_3_WIN },
-			{ MV64x60_PCI12MEM_SNOOP_0_WIN,
-			  MV64x60_PCI12MEM_SNOOP_1_WIN,
-			  MV64x60_PCI12MEM_SNOOP_2_WIN,
-			  MV64x60_PCI12MEM_SNOOP_3_WIN }
-		};
-	u32	pci_size_tab[2][4] = {
-			{ MV64x60_PCI0_MEM_0_SIZE, MV64x60_PCI0_MEM_1_SIZE,
-			  MV64x60_PCI0_MEM_2_SIZE, MV64x60_PCI0_MEM_3_SIZE },
-			{ MV64x60_PCI1_MEM_0_SIZE, MV64x60_PCI1_MEM_1_SIZE,
-			  MV64x60_PCI1_MEM_2_SIZE, MV64x60_PCI1_MEM_3_SIZE }
-		};
 
 	/*
 	 * Set the access control, snoop, BAR size, and window base addresses.
@@ -1345,13 +1343,14 @@
  * The PCI->MEM window registers are actually in PCI config space so need
  * to set them by setting the correct config space BARs.
  */
+static u32 gt64260_reg_addrs[2][4] __initdata = {
+	{ 0x10, 0x14, 0x18, 0x1c }, { 0x90, 0x94, 0x98, 0x9c }
+};
+
 static void __init
 gt64260_set_pci2mem_window(struct pci_controller *hose, u32 bus, u32 window,
 	u32 base)
 {
-	u32	reg_addrs[2][4] = {
-			{ 0x10, 0x14, 0x18, 0x1c }, { 0x90, 0x94, 0x98, 0x9c }
-		};
 	u8	save_exclude;
 
 	pr_debug("set pci->mem window: %d, hose: %d, base: 0x%x\n", window,
@@ -1360,7 +1359,7 @@
 	save_exclude = mv64x60_pci_exclude_bridge;
 	mv64x60_pci_exclude_bridge = 0;
 	early_write_config_dword(hose, 0, PCI_DEVFN(0, 0),
-		reg_addrs[bus][window], mv64x60_mask(base, 20) | 0x8);
+		gt64260_reg_addrs[bus][window], mv64x60_mask(base, 20) | 0x8);
 	mv64x60_pci_exclude_bridge = save_exclude;
 
 	return;
@@ -1371,11 +1370,12 @@
  *
  * Set where the bridge's registers appear in PCI MEM space.
  */
+static u32 gt64260_offset[2] __initdata = {0x20, 0xa0};
+
 static void __init
 gt64260_set_pci2regs_window(struct mv64x60_handle *bh,
 	struct pci_controller *hose, u32 bus, u32 base)
 {
-	u32	offset[2] = {0x20, 0xa0};
 	u8	save_exclude;
 
 	pr_debug("set pci->internal regs hose: %d, base: 0x%x\n", hose->index,
@@ -1383,7 +1383,7 @@
 
 	save_exclude = mv64x60_pci_exclude_bridge;
 	mv64x60_pci_exclude_bridge = 0;
-	early_write_config_dword(hose, 0, PCI_DEVFN(0,0), offset[bus],
+	early_write_config_dword(hose, 0, PCI_DEVFN(0,0), gt64260_offset[bus],
 		(base << 16));
 	mv64x60_pci_exclude_bridge = save_exclude;
 
@@ -1778,20 +1778,21 @@
  * The PCI->MEM window registers are actually in PCI config space so need
  * to set them by setting the correct config space BARs.
  */
+struct {
+	u32	fcn;
+	u32	base_hi_bar;
+	u32	base_lo_bar;
+} static mv64360_reg_addrs[2][4] __initdata = {
+	{{ 0, 0x14, 0x10 }, { 0, 0x1c, 0x18 },
+	 { 1, 0x14, 0x10 }, { 1, 0x1c, 0x18 }},
+	{{ 0, 0x94, 0x90 }, { 0, 0x9c, 0x98 },
+	 { 1, 0x94, 0x90 }, { 1, 0x9c, 0x98 }}
+};
+
 static void __init
 mv64360_set_pci2mem_window(struct pci_controller *hose, u32 bus, u32 window,
 	u32 base)
 {
-	struct {
-		u32	fcn;
-		u32	base_hi_bar;
-		u32	base_lo_bar;
-	} reg_addrs[2][4] = {
-		{{ 0, 0x14, 0x10 }, { 0, 0x1c, 0x18 },
-		 { 1, 0x14, 0x10 }, { 1, 0x1c, 0x18 }},
-		{{ 0, 0x94, 0x90 }, { 0, 0x9c, 0x98 },
-		 { 1, 0x94, 0x90 }, { 1, 0x9c, 0x98 }}
-	};
 	u8 save_exclude;
 
 	pr_debug("set pci->mem window: %d, hose: %d, base: 0x%x\n", window,
@@ -1800,11 +1801,12 @@
 	save_exclude = mv64x60_pci_exclude_bridge;
 	mv64x60_pci_exclude_bridge = 0;
 	early_write_config_dword(hose, 0,
-		PCI_DEVFN(0, reg_addrs[bus][window].fcn),
-		reg_addrs[bus][window].base_hi_bar, 0);
+		PCI_DEVFN(0, mv64360_reg_addrs[bus][window].fcn),
+		mv64360_reg_addrs[bus][window].base_hi_bar, 0);
 	early_write_config_dword(hose, 0,
-		PCI_DEVFN(0, reg_addrs[bus][window].fcn),
-		reg_addrs[bus][window].base_lo_bar,mv64x60_mask(base,20) | 0xc);
+		PCI_DEVFN(0, mv64360_reg_addrs[bus][window].fcn),
+		mv64360_reg_addrs[bus][window].base_lo_bar,
+		mv64x60_mask(base,20) | 0xc);
 	mv64x60_pci_exclude_bridge = save_exclude;
 
 	return;
@@ -1815,11 +1817,12 @@
  *
  * Set where the bridge's registers appear in PCI MEM space.
  */
+static u32 mv64360_offset[2][2] __initdata = {{0x20, 0x24}, {0xa0, 0xa4}};
+
 static void __init
 mv64360_set_pci2regs_window(struct mv64x60_handle *bh,
 	struct pci_controller *hose, u32 bus, u32 base)
 {
-	u32	offset[2][2] = {{0x20, 0x24}, {0xa0, 0xa4}};
 	u8	save_exclude;
 
 	pr_debug("set pci->internal regs hose: %d, base: 0x%x\n", hose->index,
@@ -1827,9 +1830,10 @@
 
 	save_exclude = mv64x60_pci_exclude_bridge;
 	mv64x60_pci_exclude_bridge = 0;
-	early_write_config_dword(hose, 0, PCI_DEVFN(0,0), offset[bus][0],
-		(base << 16));
-	early_write_config_dword(hose, 0, PCI_DEVFN(0,0), offset[bus][1], 0);
+	early_write_config_dword(hose, 0, PCI_DEVFN(0,0),
+		mv64360_offset[bus][0], (base << 16));
+	early_write_config_dword(hose, 0, PCI_DEVFN(0,0),
+		mv64360_offset[bus][1], 0);
 	mv64x60_pci_exclude_bridge = save_exclude;
 
 	return;
@@ -2110,28 +2114,32 @@
  * ENET, MPSC, and IDMA ctlrs on the MV64[34]60 have separate windows that
  * must be set up so that the respective ctlr can access system memory.
  */
+static u32 enet_tab[MV64x60_CPU2MEM_WINDOWS] __initdata = {
+	MV64x60_ENET2MEM_0_WIN, MV64x60_ENET2MEM_1_WIN,
+	MV64x60_ENET2MEM_2_WIN, MV64x60_ENET2MEM_3_WIN,
+};
+
+static u32 mpsc_tab[MV64x60_CPU2MEM_WINDOWS] __initdata = {
+	MV64x60_MPSC2MEM_0_WIN, MV64x60_MPSC2MEM_1_WIN,
+	MV64x60_MPSC2MEM_2_WIN, MV64x60_MPSC2MEM_3_WIN,
+};
+
+static u32 idma_tab[MV64x60_CPU2MEM_WINDOWS] __initdata = {
+	MV64x60_IDMA2MEM_0_WIN, MV64x60_IDMA2MEM_1_WIN,
+	MV64x60_IDMA2MEM_2_WIN, MV64x60_IDMA2MEM_3_WIN,
+};
+
+static u32 dram_selects[MV64x60_CPU2MEM_WINDOWS] __initdata =
+	{ 0xe, 0xd, 0xb, 0x7 };
+
 static void __init
 mv64360_config_io2mem_windows(struct mv64x60_handle *bh,
 	struct mv64x60_setup_info *si,
 	u32 mem_windows[MV64x60_CPU2MEM_WINDOWS][2])
 {
 	u32	i, win;
-	u32	enet_tab[MV64x60_CPU2MEM_WINDOWS] = {
-			MV64x60_ENET2MEM_0_WIN, MV64x60_ENET2MEM_1_WIN,
-			MV64x60_ENET2MEM_2_WIN, MV64x60_ENET2MEM_3_WIN,
-		};
-	u32	mpsc_tab[MV64x60_CPU2MEM_WINDOWS] = {
-			MV64x60_MPSC2MEM_0_WIN, MV64x60_MPSC2MEM_1_WIN,
-			MV64x60_MPSC2MEM_2_WIN, MV64x60_MPSC2MEM_3_WIN,
-		};
-	u32	idma_tab[MV64x60_CPU2MEM_WINDOWS] = {
-			MV64x60_IDMA2MEM_0_WIN, MV64x60_IDMA2MEM_1_WIN,
-			MV64x60_IDMA2MEM_2_WIN, MV64x60_IDMA2MEM_3_WIN,
-		};
-	u32	dram_selects[MV64x60_CPU2MEM_WINDOWS] = { 0xe, 0xd, 0xb, 0x7 };
 
 	pr_debug("config_io2regs_windows: enet, mpsc, idma -> bridge regs\n");
-
 
 	mv64x60_write(bh, MV64360_ENET2MEM_ACC_PROT_0, 0);
 	mv64x60_write(bh, MV64360_ENET2MEM_ACC_PROT_1, 0);

--------------040003010008000708060509--

