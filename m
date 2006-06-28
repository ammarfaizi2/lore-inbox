Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423363AbWF1OZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423363AbWF1OZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWF1OY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:24:27 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:57552 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1161303AbWF1OXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:23:44 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FD6@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Paul Mackerras'" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Gridish Shlomi-RM96313 <gridish@freescale.com>,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
Subject: [PATCH 5/7] powerpc: Add QE library qe_lib--common headers
Date: Wed, 28 Jun 2006 22:23:37 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 include/asm-powerpc/immap_qe.h |  509 ++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/irq.h      |   11 +
 include/asm-powerpc/qe.h       |  498 +++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/qe_ic.h    |  131 ++++++++++
 include/asm-powerpc/ucc.h      |   89 +++++++
 include/asm-powerpc/ucc_fast.h |  259 ++++++++++++++++++++
 include/asm-powerpc/ucc_slow.h |  309 ++++++++++++++++++++++++
 include/asm-ppc/mpc83xx.h      |   42 +++
 include/linux/fsl_devices.h    |   39 +++
 9 files changed, 1885 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
new file mode 100644
index 0000000..a392431
--- /dev/null
+++ b/include/asm-powerpc/immap_qe.h
@@ -0,0 +1,509 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QUICC Engine (QE) Internal Memory Map.
+ * The Internal Memory Map for devices with QE on them. This
+ * is the superset of all QE devices (8360, etc.).
+ *
+ * Changelog:
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifdef __KERNEL__
+#ifndef __IMMAP_QE_H__
+#define __IMMAP_QE_H__
+
+#include <linux/kernel.h>
+
+#define QE_IMMAP_SIZE	(1024 * 1024)	/* 1MB from 1MB+IMMR */
+
+/* QE I-RAM
+*/
+typedef struct qe_iram {
+	u32 iadd;		/* I-RAM Address Register */
+	u32 idata;		/* I-RAM Data Register    */
+	u8 res0[0x78];
+} __attribute__ ((packed)) qe_iram_t;
+
+/* QE Interrupt Controller
+*/
+typedef struct qe_ic {
+	u32 qicr;
+	u32 qivec;
+	u32 qripnr;
+	u32 qipnr;
+	u32 qipxcc;
+	u32 qipycc;
+	u32 qipwcc;
+	u32 qipzcc;
+	u32 qimr;
+	u32 qrimr;
+	u32 qicnr;
+	u8 res0[0x4];
+	u32 qiprta;
+	u32 qiprtb;
+	u8 res1[0x4];
+	u32 qricr;
+	u8 res2[0x20];
+	u32 qhivec;
+	u8 res3[0x1C];
+} __attribute__ ((packed)) qe_ic_t;
+
+/* Communications Processor
+*/
+typedef struct cp_qe {
+	u32 cecr;		/* QE command register */
+	u32 ceccr;		/* QE controller configuration register */
+	u32 cecdr;		/* QE command data register */
+	u8 res0[0xA];
+	u16 ceter;		/* QE timer event register */
+	u8 res1[0x2];
+	u16 cetmr;		/* QE timers mask register */
+	u32 cetscr;		/* QE time-stamp timer control register */
+	u32 cetsr1;		/* QE time-stamp register 1 */
+	u32 cetsr2;		/* QE time-stamp register 2 */
+	u8 res2[0x8];
+	u32 cevter;		/* QE virtual tasks event register */
+	u32 cevtmr;		/* QE virtual tasks mask register */
+	u16 cercr;		/* QE RAM control register */
+	u8 res3[0x2];
+	u8 res4[0x24];
+	u16 ceexe1;		/* QE external request 1 event register */
+	u8 res5[0x2];
+	u16 ceexm1;		/* QE external request 1 mask register */
+	u8 res6[0x2];
+	u16 ceexe2;		/* QE external request 2 event register */
+	u8 res7[0x2];
+	u16 ceexm2;		/* QE external request 2 mask register */
+	u8 res8[0x2];
+	u16 ceexe3;		/* QE external request 3 event register */
+	u8 res9[0x2];
+	u16 ceexm3;		/* QE external request 3 mask register */
+	u8 res10[0x2];
+	u16 ceexe4;		/* QE external request 4 event register */
+	u8 res11[0x2];
+	u16 ceexm4;		/* QE external request 4 mask register */
+	u8 res12[0x2];
+	u8 res13[0x280];
+} __attribute__ ((packed)) cp_qe_t;
+
+/* QE Multiplexer
+*/
+typedef struct qe_mux {
+	u32 cmxgcr;		/* CMX general clock route register    */
+	u32 cmxsi1cr_l;		/* CMX SI1 clock route low register    */
+	u32 cmxsi1cr_h;		/* CMX SI1 clock route high register   */
+	u32 cmxsi1syr;		/* CMX SI1 SYNC route register         */
+	u32 cmxucr1;		/* CMX UCC1, UCC3 clock route register */
+	u32 cmxucr2;		/* CMX UCC5, UCC7 clock route register */
+	u32 cmxucr3;		/* CMX UCC2, UCC4 clock route register */
+	u32 cmxucr4;		/* CMX UCC6, UCC8 clock route register */
+	u32 cmxupcr;		/* CMX UPC clock route register        */
+	u8 res0[0x1C];
+} __attribute__ ((packed)) qe_mux_t;
+
+/* QE Timers
+*/
+typedef struct qe_timers {
+	u8 gtcfr1;		/* Timer 1 and Timer 2 global configuration 
+				   register */
+	u8 res0[0x3];
+	u8 gtcfr2;		/* Timer 3 and timer 4 global configuration
+				   register */
+	u8 res1[0xB];
+	u16 gtmdr1;		/* Timer 1 mode register */
+	u16 gtmdr2;		/* Timer 2 mode register */
+	u16 gtrfr1;		/* Timer 1 reference register */
+	u16 gtrfr2;		/* Timer 2 reference register */
+	u16 gtcpr1;		/* Timer 1 capture register */
+	u16 gtcpr2;		/* Timer 2 capture register */
+	u16 gtcnr1;		/* Timer 1 counter */
+	u16 gtcnr2;		/* Timer 2 counter */
+	u16 gtmdr3;		/* Timer 3 mode register */
+	u16 gtmdr4;		/* Timer 4 mode register */
+	u16 gtrfr3;		/* Timer 3 reference register */
+	u16 gtrfr4;		/* Timer 4 reference register */
+	u16 gtcpr3;		/* Timer 3 capture register */
+	u16 gtcpr4;		/* Timer 4 capture register */
+	u16 gtcnr3;		/* Timer 3 counter */
+	u16 gtcnr4;		/* Timer 4 counter */
+	u16 gtevr1;		/* Timer 1 event register */
+	u16 gtevr2;		/* Timer 2 event register */
+	u16 gtevr3;		/* Timer 3 event register */
+	u16 gtevr4;		/* Timer 4 event register */
+	u16 gtps;		/* Timer 1 prescale register */
+	u8 res2[0x46];
+} __attribute__ ((packed)) qe_timers_t;
+
+/* BRG
+*/
+typedef struct qe_brg {
+	u32 brgc1;		/* BRG1 configuration register  */
+	u32 brgc2;		/* BRG2 configuration register  */
+	u32 brgc3;		/* BRG3 configuration register  */
+	u32 brgc4;		/* BRG4 configuration register  */
+	u32 brgc5;		/* BRG5 configuration register  */
+	u32 brgc6;		/* BRG6 configuration register  */
+	u32 brgc7;		/* BRG7 configuration register  */
+	u32 brgc8;		/* BRG8 configuration register  */
+	u32 brgc9;		/* BRG9 configuration register  */
+	u32 brgc10;		/* BRG10 configuration register */
+	u32 brgc11;		/* BRG11 configuration register */
+	u32 brgc12;		/* BRG12 configuration register */
+	u32 brgc13;		/* BRG13 configuration register */
+	u32 brgc14;		/* BRG14 configuration register */
+	u32 brgc15;		/* BRG15 configuration register */
+	u32 brgc16;		/* BRG16 configuration register */
+	u8 res0[0x40];
+} __attribute__ ((packed)) qe_brg_t;
+
+/* SPI
+*/
+typedef struct spi {
+	u8 res0[0x20];
+	u32 spmode;		/* SPI mode register */
+	u8 res1[0x2];
+	u8 spie;		/* SPI event register */
+	u8 res2[0x1];
+	u8 res3[0x2];
+	u8 spim;		/* SPI mask register */
+	u8 res4[0x1];
+	u8 res5[0x1];
+	u8 spcom;		/* SPI command register  */
+	u8 res6[0x2];
+	u32 spitd;		/* SPI transmit data register (cpu mode) */
+	u32 spird;		/* SPI receive data register (cpu mode) */
+	u8 res7[0x8];
+} __attribute__ ((packed)) spi_t;
+
+/* SI
+*/
+typedef struct si1 {
+	u16 siamr1;		/* SI1 TDMA mode register */
+	u16 sibmr1;		/* SI1 TDMB mode register */
+	u16 sicmr1;		/* SI1 TDMC mode register */
+	u16 sidmr1;		/* SI1 TDMD mode register */
+	u8 siglmr1_h;		/* SI1 global mode register high */
+	u8 res0[0x1];
+	u8 sicmdr1_h;		/* SI1 command register high */
+	u8 res2[0x1];
+	u8 sistr1_h;		/* SI1 status register high */
+	u8 res3[0x1];
+	u16 sirsr1_h;		/* SI1 RAM shadow address register high */
+	u8 sitarc1;		/* SI1 RAM counter Tx TDMA */
+	u8 sitbrc1;		/* SI1 RAM counter Tx TDMB */
+	u8 sitcrc1;		/* SI1 RAM counter Tx TDMC */
+	u8 sitdrc1;		/* SI1 RAM counter Tx TDMD */
+	u8 sirarc1;		/* SI1 RAM counter Rx TDMA */
+	u8 sirbrc1;		/* SI1 RAM counter Rx TDMB */
+	u8 sircrc1;		/* SI1 RAM counter Rx TDMC */
+	u8 sirdrc1;		/* SI1 RAM counter Rx TDMD */
+	u8 res4[0x8];
+	u16 siemr1;		/* SI1 TDME mode register 16 bits */
+	u16 sifmr1;		/* SI1 TDMF mode register 16 bits */
+	u16 sigmr1;		/* SI1 TDMG mode register 16 bits */
+	u16 sihmr1;		/* SI1 TDMH mode register 16 bits */
+	u8 siglmg1_l;		/* SI1 global mode register low 8 bits */
+	u8 res5[0x1];
+	u8 sicmdr1_l;		/* SI1 command register low 8 bits */
+	u8 res6[0x1];
+	u8 sistr1_l;		/* SI1 status register low 8 bits */
+	u8 res7[0x1];
+	u16 sirsr1_l;		/* SI1 RAM shadow address register low 16 
+				   bits */
+	u8 siterc1;		/* SI1 RAM counter Tx TDME 8 bits */
+	u8 sitfrc1;		/* SI1 RAM counter Tx TDMF 8 bits */
+	u8 sitgrc1;		/* SI1 RAM counter Tx TDMG 8 bits */
+	u8 sithrc1;		/* SI1 RAM counter Tx TDMH 8 bits */
+	u8 sirerc1;		/* SI1 RAM counter Rx TDME 8 bits */
+	u8 sirfrc1;		/* SI1 RAM counter Rx TDMF 8 bits */
+	u8 sirgrc1;		/* SI1 RAM counter Rx TDMG 8 bits */
+	u8 sirhrc1;		/* SI1 RAM counter Rx TDMH 8 bits */
+	u8 res8[0x8];
+	u32 siml1;		/* SI1 multiframe limit register */
+	u8 siedm1;		/* SI1 extended diagnostic mode register */
+	u8 res9[0xBB];
+} __attribute__ ((packed)) si1_t;
+
+/* SI Routing Tables
+*/
+typedef struct sir {
+	u8 tx[0x400];
+	u8 rx[0x400];
+	u8 res0[0x800];
+} __attribute__ ((packed)) sir_t;
+
+/* USB Controller.
+*/
+typedef struct usb_ctlr {
+	u8 usb_usmod;
+	u8 usb_usadr;
+	u8 usb_uscom;
+	u8 res1[1];
+	u16 usb_usep1;
+	u16 usb_usep2;
+	u16 usb_usep3;
+	u16 usb_usep4;
+	u8 res2[4];
+	u16 usb_usber;
+	u8 res3[2];
+	u16 usb_usbmr;
+	u8 res4[1];
+	u8 usb_usbs;
+	u16 usb_ussft;
+	u8 res5[2];
+	u16 usb_usfrn;
+	u8 res6[0x22];
+} __attribute__ ((packed)) usb_t;
+
+/* MCC
+*/
+typedef struct mcc {
+	u32 mcce;		/* MCC event register */
+	u32 mccm;		/* MCC mask register */
+	u32 mccf;		/* MCC configuration register */
+	u32 merl;		/* MCC emergency request level register */
+	u8 res0[0xF0];
+} __attribute__ ((packed)) mcc_t;
+
+/* QE UCC Slow
+*/
+typedef struct ucc_slow {
+	u32 gumr_l;		/* UCCx general mode register (low) */
+	u32 gumr_h;		/* UCCx general mode register (high) */
+	u16 upsmr;		/* UCCx protocol-specific mode register */
+	u8 res0[0x2];
+	u16 utodr;		/* UCCx transmit on demand register */
+	u16 udsr;		/* UCCx data synchronization register */
+	u16 ucce;		/* UCCx event register */
+	u8 res1[0x2];
+	u16 uccm;		/* UCCx mask register */
+	u8 res2[0x1];
+	u8 uccs;		/* UCCx status register */
+	u8 res3[0x24];
+	u16 utpt;
+	u8 guemr;		/* UCC general extended mode register */
+	u8 res4[0x200 - 0x091];
+} __attribute__ ((packed)) ucc_slow_t;
+
+/* QE UCC Fast
+*/
+typedef struct ucc_fast {
+	u32 gumr;		/* UCCx general mode register */
+	u32 upsmr;		/* UCCx protocol-specific mode register  */
+	u16 utodr;		/* UCCx transmit on demand register  */
+	u8 res0[0x2];
+	u16 udsr;		/* UCCx data synchronization register  */
+	u8 res1[0x2];
+	u32 ucce;		/* UCCx event register */
+	u32 uccm;		/* UCCx mask register.  */
+	u8 uccs;		/* UCCx status register */
+	u8 res2[0x7];
+	u32 urfb;		/* UCC receive FIFO base */
+	u16 urfs;		/* UCC receive FIFO size */
+	u8 res3[0x2];
+	u16 urfet;		/* UCC receive FIFO emergency threshold */
+	u16 urfset;		/* UCC receive FIFO special emergency 
+				   threshold */
+	u32 utfb;		/* UCC transmit FIFO base */
+	u16 utfs;		/* UCC transmit FIFO size */
+	u8 res4[0x2];
+	u16 utfet;		/* UCC transmit FIFO emergency threshold */
+	u8 res5[0x2];
+	u16 utftt;		/* UCC transmit FIFO transmit threshold */
+	u8 res6[0x2];
+	u16 utpt;		/* UCC transmit polling timer */
+	u8 res7[0x2];
+	u32 urtry;		/* UCC retry counter register */
+	u8 res8[0x4C];
+	u8 guemr;		/* UCC general extended mode register */
+	u8 res9[0x100 - 0x091];
+} __attribute__ ((packed)) ucc_fast_t;
+
+/* QE UCC
+*/
+typedef struct ucc_common {
+	u8 res1[0x90];
+	u8 guemr;
+	u8 res2[0x200 - 0x091];
+} __attribute__ ((packed)) ucc_common_t;
+
+typedef struct ucc {
+	union {
+		ucc_slow_t slow;
+		ucc_fast_t fast;
+		ucc_common_t common;
+	};
+} __attribute__ ((packed)) ucc_t;
+
+/* MultiPHY UTOPIA POS Controllers (UPC)
+*/
+typedef struct upc {
+	u32 upgcr;		/* UTOPIA/POS general configuration register  */
+	u32 uplpa;		/* UTOPIA/POS last PHY address */
+	u32 uphec;		/* ATM HEC register */
+	u32 upuc;		/* UTOPIA/POS UCC configuration */
+	u32 updc1;		/* UTOPIA/POS device 1 configuration */
+	u32 updc2;		/* UTOPIA/POS device 2 configuration  */
+	u32 updc3;		/* UTOPIA/POS device 3 configuration */
+	u32 updc4;		/* UTOPIA/POS device 4 configuration  */
+	u32 upstpa;		/* UTOPIA/POS STPA threshold  */
+	u8 res0[0xC];
+	u32 updrs1_h;		/* UTOPIA/POS device 1 rate select  */
+	u32 updrs1_l;		/* UTOPIA/POS device 1 rate select  */
+	u32 updrs2_h;		/* UTOPIA/POS device 2 rate select  */
+	u32 updrs2_l;		/* UTOPIA/POS device 2 rate select */
+	u32 updrs3_h;		/* UTOPIA/POS device 3 rate select */
+	u32 updrs3_l;		/* UTOPIA/POS device 3 rate select */
+	u32 updrs4_h;		/* UTOPIA/POS device 4 rate select */
+	u32 updrs4_l;		/* UTOPIA/POS device 4 rate select */
+	u32 updrp1;		/* UTOPIA/POS device 1 receive priority low  */
+	u32 updrp2;		/* UTOPIA/POS device 2 receive priority low  */
+	u32 updrp3;		/* UTOPIA/POS device 3 receive priority low  */
+	u32 updrp4;		/* UTOPIA/POS device 4 receive priority low  */
+	u32 upde1;		/* UTOPIA/POS device 1 event */
+	u32 upde2;		/* UTOPIA/POS device 2 event */
+	u32 upde3;		/* UTOPIA/POS device 3 event */
+	u32 upde4;		/* UTOPIA/POS device 4 event */
+	u16 uprp1;
+	u16 uprp2;
+	u16 uprp3;
+	u16 uprp4;
+	u8 res1[0x8];
+	u16 uptirr1_0;		/* Device 1 transmit internal rate 0 */
+	u16 uptirr1_1;		/* Device 1 transmit internal rate 1 */
+	u16 uptirr1_2;		/* Device 1 transmit internal rate 2 */
+	u16 uptirr1_3;		/* Device 1 transmit internal rate 3 */
+	u16 uptirr2_0;		/* Device 2 transmit internal rate 0 */
+	u16 uptirr2_1;		/* Device 2 transmit internal rate 1 */
+	u16 uptirr2_2;		/* Device 2 transmit internal rate 2 */
+	u16 uptirr2_3;		/* Device 2 transmit internal rate 3 */
+	u16 uptirr3_0;		/* Device 3 transmit internal rate 0 */
+	u16 uptirr3_1;		/* Device 3 transmit internal rate 1 */
+	u16 uptirr3_2;		/* Device 3 transmit internal rate 2 */
+	u16 uptirr3_3;		/* Device 3 transmit internal rate 3 */
+	u16 uptirr4_0;		/* Device 4 transmit internal rate 0 */
+	u16 uptirr4_1;		/* Device 4 transmit internal rate 1 */
+	u16 uptirr4_2;		/* Device 4 transmit internal rate 2 */
+	u16 uptirr4_3;		/* Device 4 transmit internal rate 3 */
+	u32 uper1;		/* Device 1 port enable register */
+	u32 uper2;		/* Device 2 port enable register */
+	u32 uper3;		/* Device 3 port enable register */
+	u32 uper4;		/* Device 4 port enable register */
+	u8 res2[0x150];
+} __attribute__ ((packed)) upc_t;
+
+/* SDMA
+*/
+typedef struct sdma {
+	u32 sdsr;		/* Serial DMA status register */
+	u32 sdmr;		/* Serial DMA mode register */
+	u32 sdtr1;		/* SDMA system bus threshold register */
+	u32 sdtr2;		/* SDMA secondary bus threshold register */
+	u32 sdhy1;		/* SDMA system bus hysteresis register */
+	u32 sdhy2;		/* SDMA secondary bus hysteresis register */
+	u32 sdta1;		/* SDMA system bus address register */
+	u32 sdta2;		/* SDMA secondary bus address register */
+	u32 sdtm1;		/* SDMA system bus MSNUM register */
+	u32 sdtm2;		/* SDMA secondary bus MSNUM register */
+	u8 res0[0x10];
+	u32 sdaqr;		/* SDMA address bus qualify register */
+	u32 sdaqmr;		/* SDMA address bus qualify mask register */
+	u8 res1[0x4];
+	u32 sdebcr;		/* SDMA CAM entries base register */
+	u8 res2[0x38];
+} __attribute__ ((packed)) sdma_t;
+
+/* Debug Space
+*/
+typedef struct dbg {
+	u32 bpdcr;		/* Breakpoint debug command register */
+	u32 bpdsr;		/* Breakpoint debug status register */
+	u32 bpdmr;		/* Breakpoint debug mask register */
+	u32 bprmrr0;		/* Breakpoint request mode risc register 0 */
+	u32 bprmrr1;		/* Breakpoint request mode risc register 1 */
+	u8 res0[0x8];
+	u32 bprmtr0;		/* Breakpoint request mode trb register 0 */
+	u32 bprmtr1;		/* Breakpoint request mode trb register 1 */
+	u8 res1[0x8];
+	u32 bprmir;		/* Breakpoint request mode immediate register */
+	u32 bprmsr;		/* Breakpoint request mode serial register */
+	u32 bpemr;		/* Breakpoint exit mode register */
+	u8 res2[0x48];
+} __attribute__ ((packed)) dbg_t;
+
+/* RISC Special Registers (Trap and Breakpoint)
+*/
+typedef struct rsp {
+	u8 fixme[0x100];
+} __attribute__ ((packed)) rsp_t;
+
+typedef struct qe_immap {
+	qe_iram_t iram;		/* I-RAM */
+	qe_ic_t ic;		/* Interrupt Controller */
+	cp_qe_t cp;		/* Communications Processor */
+	qe_mux_t qmx;		/* QE Multiplexer */
+	qe_timers_t qet;	/* QE Timers */
+	spi_t spi[0x2];		/* spi  */
+	mcc_t mcc;		/* mcc */
+	qe_brg_t brg;		/* brg */
+	usb_t usb;		/* USB */
+	si1_t si1;		/* SI */
+	u8 res11[0x800];
+	sir_t sir;		/* SI Routing Tables  */
+	ucc_t ucc1;		/* ucc1 */
+	ucc_t ucc3;		/* ucc3 */
+	ucc_t ucc5;		/* ucc5 */
+	ucc_t ucc7;		/* ucc7 */
+	u8 res12[0x600];
+	upc_t upc1;		/* MultiPHY UTOPIA POS Controller 1 */
+	ucc_t ucc2;		/* ucc2 */
+	ucc_t ucc4;		/* ucc4 */
+	ucc_t ucc6;		/* ucc6 */
+	ucc_t ucc8;		/* ucc8 */
+	u8 res13[0x600];
+	upc_t upc2;		/* MultiPHY UTOPIA POS Controller 2 */
+	sdma_t sdma;		/* SDMA */
+	dbg_t dbg;		/* Debug Space */
+	rsp_t rsp[0x2];		/* RISC Special Registers (Trap and Breakpoint)
+				 */
+	u8 res14[0x300];
+	u8 res15[0x3A00];
+	u8 res16[0x8000];	/* 0x108000 -  0x110000 */
+	u8 muram[0xC000];	/* 0x110000 -  0x11C000 Multi-user RAM */
+	u8 res17[0x24000];	/* 0x11C000 -  0x140000 */
+	u8 res18[0xC0000];	/* 0x140000 -  0x200000 */
+} __attribute__ ((packed)) qe_map_t;
+
+extern qe_map_t *qe_immr;
+extern phys_addr_t get_qe_base(void);
+
+static inline unsigned long immrbar_virt_to_phys(volatile void * address)
+{
+	if ( ((uint)address >= (uint)qe_immr) &&
+			((uint)address < ((uint)qe_immr + QE_IMMAP_SIZE)) )
+		return (unsigned long)(address - (uint)qe_immr +
+				(uint)get_qe_base());
+	return (unsigned long)virt_to_phys(address);
+}
+                                                                                                
+static inline void * immrbar_phys_to_virt(unsigned long address)
+{
+	if ( (address >= (uint)get_qe_base()) &&
+			(address < ((uint)get_qe_base() + QE_IMMAP_SIZE)) )
+		return (void *)(address - (uint)get_qe_base() + (uint)qe_immr);
+	return (void *)phys_to_virt(address);
+}
+
+#endif				/* __IMMAP_QE_H__ */
+#endif				/* __KERNEL__ */
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 7bc6d73..3fbc01e 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -225,7 +225,16 @@ #define	mk_int_int_mask(IL) (1 << (7 - (
 #elif defined(CONFIG_83xx)
 #include <asm/mpc83xx.h>
 
-#define	NR_IRQS	(NR_IPIC_INTS)
+#ifdef CONFIG_QUICC_ENGINE
+#define QE_IRQ_OFFSET   MPC83xx_QE_IRQ_OFFSET
+#define NR_QE_IC_INTS   MPC83xx_NR_QE_IC_INTS
+#define IRQ_QE_HIGH     MPC83xx_IRQ_QE_HIGH
+#define IRQ_QE_LOW      MPC83xx_IRQ_QE_LOW
+
+#define NR_IRQS (NR_IPIC_INTS + NR_QE_IC_INTS)
+#else
+#define NR_IRQS (NR_IPIC_INTS)
+#endif /* CONFIG_QE */
 
 #elif defined(CONFIG_85xx)
 /* Now include the board configuration specific associations.
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
new file mode 100644
index 0000000..0502a51
--- /dev/null
+++ b/include/asm-powerpc/qe.h
@@ -0,0 +1,498 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QUICC Engine (QE) external definitions and structure.
+ *
+ * Changelog:
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifdef __KERNEL__
+#ifndef __QE_H__
+#define __QE_H__
+
+#include <asm/immap_qe.h>
+
+/* Multi User RAM addresses.
+ */
+#define QE_MURAM_DATAONLY_BASE	((uint)0x0)
+#define QE_MURAM_NOSPACE		((uint)0x7fffffff)
+#define QE_MURAM_DATAONLY_SIZE	((uint)(48 * 1024) - QE_MURAM_DATAONLY_BASE)
+
+static inline long IS_MURAM_ERR(const uint offset)
+{
+	return (uint) offset > (uint) - 1000L;
+}
+
+#define QE_NUM_OF_SNUM  28
+#define QE_NUM_OF_BRGS  16
+#define QE_NUM_OF_PORTS 1024
+
+/* Memory partitions
+*/
+#define MEM_PART_SYSTEM     0
+#define MEM_PART_SECONDARY  1
+#define MEM_PART_MURAM      2
+
+/* Export the base address of the communication processor registers
+ * and dual port ram.
+ */
+int qe_issue_cmd(uint cmd, uint device, u8 mcn_protocol, u32 cmd_input);
+void qe_setbrg(uint brg, uint rate);
+int qe_get_snum(void);
+void qe_put_snum(u8 snum);
+uint qe_muram_alloc(uint size, uint align);
+int qe_muram_free(uint offset);
+uint qe_muram_alloc_fixed(uint offset, uint size, uint align);
+void qe_muram_dump(void);
+void *qe_muram_addr(uint offset);
+/* Buffer descriptors.
+*/
+typedef struct qe_bd {
+	u16 status;
+	u16 length;
+	u32 buf;
+} __attribute__ ((packed)) qe_bd_t;
+
+#define QE_SIZEOF_BD       sizeof(qe_bd_t)
+
+#define BD_STATUS_MASK                      0xffff0000
+#define BD_LENGTH_MASK                      0x0000ffff
+
+#define BD_BUFFER_ARG(bd)                   ((qe_bd_t *)bd)->buf
+#define BD_BUFFER_CLEAR(bd)                 out_be32(&(BD_BUFFER_ARG(bd)), 0);
+#define BD_BUFFER(bd)                       in_be32(&(BD_BUFFER_ARG(bd)))
+#define BD_STATUS_AND_LENGTH_SET(bd, val)   out_be32((u32*)bd, val)
+#define BD_STATUS_AND_LENGTH(bd)            in_be32((u32*)bd)
+#define BD_BUFFER_SET(bd, buffer)           out_be32(&(BD_BUFFER_ARG(bd)), \
+	(u32)(buffer))
+/* Macro for retrieving the following BD.
+   example:
+   next = BD_GET_NEXT( currBd, bdStatus, bdBase, SIZEOF_MY_BD, T_W ) */
+#define BD_GET_NEXT( curr_bd, bd_status, bd_base, bd_len, last_bd ) \
+        ( (!((bd_status) & (last_bd))) ? ((curr_bd)+(bd_len)) : (bd_base) )
+
+/* Alignments
+*/
+#define QE_INTR_TABLE_ALIGN                16	/* ??? */
+#define QE_ALIGNMENT_OF_BD                 8
+#define QE_ALIGNMENT_OF_PRAM               64
+
+/* RISC allocation
+*/
+typedef enum qe_risc_allocation {
+	QE_RISC_ALLOCATION_RISC1 = 1,	/* RISC 1 */
+	QE_RISC_ALLOCATION_RISC2 = 2,	/* RISC 2 */
+	QE_RISC_ALLOCATION_RISC1_AND_RISC2 = 3	/* Dynamically choose RISC 1 or
+						   RISC 2 */
+} qe_risc_allocation_e;
+
+/* QE extended filtering Table Lookup Key Size
+*/
+typedef enum qe_fltr_tbl_lookup_key_size {
+	QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES
+		= 0x3f,		/* LookupKey parsed by the Generate LookupKey 
+				   CMD is truncated to 8  bytes */
+	QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES
+		= 0x5f,		/* LookupKey parsed by the Generate LookupKey 
+				   CMD is truncated to 16 bytes */
+} qe_fltr_tbl_lookup_key_size_e;
+
+/* QE FLTR extended filtering Largest External Table Lookup Key Size
+*/
+typedef enum qe_fltr_largest_external_tbl_lookup_key_size_ {
+	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_NONE
+		= 0x0,/* not used */
+	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_8_BYTES
+		= QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES,	/* 8  bytes */
+	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_16_BYTES
+		= QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES	/* 16 bytes */
+} qe_fltr_largest_external_tbl_lookup_key_size_e;
+
+/* structure representing QE parameter RAM
+*/
+typedef struct qe_timer_tables {
+	u16 tm_base;		/* QE timer table base adr */
+	u16 tm_ptr;		/* QE timer table pointer  */
+	u16 r_tmr;		/* QE timer mode register  */
+	u16 r_tmv;		/* QE timer valid register */
+	u32 tm_cmd;		/* QE timer cmd register   */
+	u32 tm_cnt;		/* QE timer internal cnt   */
+} __attribute__ ((packed)) qe_timer_tables_t;
+
+#define QE_FLTR_TAD_SIZE                8
+
+/* QE extended filtering Termination Action Descriptor (TAD)
+*/
+typedef struct qe_fltr_tad {
+	u8 serialized[QE_FLTR_TAD_SIZE];
+} __attribute__ ((packed)) qe_fltr_tad_t;
+
+/* Communication Direction.
+*/
+typedef enum comm_dir {
+	COMM_DIR_NONE = 0,
+	COMM_DIR_RX = 1,
+	COMM_DIR_TX = 2,
+	COMM_DIR_RX_AND_TX = 3
+} comm_dir_e;
+
+/* Clocks and GRG's
+*/
+typedef enum qe_clock {
+	QE_CLK_NONE = 0
+	    , QE_BRG1		/* Baud Rate Generator  1 */
+	    , QE_BRG2		/* Baud Rate Generator  2 */
+	    , QE_BRG3		/* Baud Rate Generator  3 */
+	    , QE_BRG4		/* Baud Rate Generator  4 */
+	    , QE_BRG5		/* Baud Rate Generator  5 */
+	    , QE_BRG6		/* Baud Rate Generator  6 */
+	    , QE_BRG7		/* Baud Rate Generator  7 */
+	    , QE_BRG8		/* Baud Rate Generator  8 */
+	    , QE_BRG9		/* Baud Rate Generator  9 */
+	    , QE_BRG10		/* Baud Rate Generator 10 */
+	    , QE_BRG11		/* Baud Rate Generator 11 */
+	    , QE_BRG12		/* Baud Rate Generator 12 */
+	    , QE_BRG13		/* Baud Rate Generator 13 */
+	    , QE_BRG14		/* Baud Rate Generator 14 */
+	    , QE_BRG15		/* Baud Rate Generator 15 */
+	    , QE_BRG16		/* Baud Rate Generator 16 */
+	    , QE_CLK1		/* Clock  1               */
+	    , QE_CLK2		/* Clock  2               */
+	    , QE_CLK3		/* Clock  3               */
+	    , QE_CLK4		/* Clock  4               */
+	    , QE_CLK5		/* Clock  5               */
+	    , QE_CLK6		/* Clock  6               */
+	    , QE_CLK7		/* Clock  7               */
+	    , QE_CLK8		/* Clock  8               */
+	    , QE_CLK9		/* Clock  9               */
+	    , QE_CLK10		/* Clock 10               */
+	    , QE_CLK11		/* Clock 11               */
+	    , QE_CLK12		/* Clock 12               */
+	    , QE_CLK13		/* Clock 13               */
+	    , QE_CLK14		/* Clock 14               */
+	    , QE_CLK15		/* Clock 15               */
+	    , QE_CLK16		/* Clock 16               */
+	    , QE_CLK17		/* Clock 17               */
+	    , QE_CLK18		/* Clock 18               */
+	    , QE_CLK19		/* Clock 19               */
+	    , QE_CLK20		/* Clock 20               */
+	    , QE_CLK21		/* Clock 21               */
+	    , QE_CLK22		/* Clock 22               */
+	    , QE_CLK23		/* Clock 23               */
+	    , QE_CLK24		/* Clock 24               */
+	    , QE_CLK_DUMMY
+} qe_clock_e;
+
+/* QE CMXUCR Registers.
+ * There are two UCCs represented in each of the four CMXUCR registers.
+ * These values are for the UCC in the LSBs
+ */
+#define QE_CMXUCR_MII_ENET_MNG              0x00007000
+#define QE_CMXUCR_MII_ENET_MNG_SHIFT        12
+#define QE_CMXUCR_GRANT                     0x00008000
+#define QE_CMXUCR_TSA                       0x00004000
+#define QE_CMXUCR_BKPT                      0x00000100
+#define QE_CMXUCR_TX_CLK_SRC_MASK           0x0000000F
+
+/* QE CMXGCR Registers.
+*/
+#define QE_CMXGCR_MII_ENET_MNG              0x00007000
+#define QE_CMXGCR_MII_ENET_MNG_SHIFT        12
+#define QE_CMXGCR_USBCS                     0x0000000f
+
+/* QE CECR Commands.
+*/
+#define QE_CR_FLG                   0x00010000
+#define QE_RESET                    0x80000000
+#define QE_INIT_TX_RX               0x00000000
+#define QE_INIT_RX                  0x00000001
+#define QE_INIT_TX                  0x00000002
+#define QE_ENTER_HUNT_MODE          0x00000003
+#define QE_STOP_TX                  0x00000004
+#define QE_GRACEFUL_STOP_TX         0x00000005
+#define QE_RESTART_TX               0x00000006
+#define QE_CLOSE_RX_BD              0x00000007
+#define QE_SWITCH_COMMAND           0x00000007
+#define QE_SET_GROUP_ADDRESS        0x00000008
+#define QE_START_IDMA               0x00000009
+#define QE_MCC_STOP_RX              0x00000009
+#define QE_ATM_TRANSMIT             0x0000000a
+#define QE_HPAC_CLEAR_ALL           0x0000000b
+#define QE_GRACEFUL_STOP_RX         0x0000001a
+#define QE_RESTART_RX               0x0000001b
+#define QE_HPAC_SET_PRIORITY        0x0000010b
+#define QE_HPAC_STOP_TX             0x0000020b
+#define QE_HPAC_STOP_RX             0x0000030b
+#define QE_HPAC_GRACEFUL_STOP_TX    0x0000040b
+#define QE_HPAC_GRACEFUL_STOP_RX    0x0000050b
+#define QE_HPAC_START_TX            0x0000060b
+#define QE_HPAC_START_RX            0x0000070b
+#define QE_USB_STOP_TX              0x0000000a
+#define QE_USB_RESTART_TX           0x0000000b
+#define QE_QMC_STOP_TX              0x0000000c
+#define QE_QMC_STOP_RX              0x0000000d
+#define QE_SS7_SU_FIL_RESET         0x0000000e
+/* jonathbr added from here down for 83xx */
+#define QE_RESET_BCS                0x0000000a
+#define QE_MCC_INIT_TX_RX_16        0x00000003
+#define QE_MCC_STOP_TX              0x00000004
+#define QE_MCC_INIT_TX_1            0x00000005
+#define QE_MCC_INIT_RX_1            0x00000006
+#define QE_MCC_RESET                0x00000007
+#define QE_SET_TIMER                0x00000008
+#define QE_RANDOM_NUMBER            0x0000000c
+#define QE_ATM_MULTI_THREAD_INIT    0x00000011
+#define QE_ASSIGN_PAGE              0x00000012
+#define QE_ADD_REMOVE_HASH_ENTRY    0x00000013
+#define QE_START_FLOW_CONTROL       0x00000014
+#define QE_STOP_FLOW_CONTROL        0x00000015
+#define QE_ASSIGN_PAGE_TO_DEVICE    0x00000016
+
+#define QE_ASSIGN_RISC		    0x00000010
+#define QE_CR_MCN_NORMAL_SHIFT      6
+#define QE_CR_MCN_USB_SHIFT         4
+#define QE_CR_MCN_RISC_ASSIGN_SHIFT 8
+#define QE_CR_SNUM_SHIFT            17
+
+/* QE CECR Sub Block - sub block of QE command.
+*/
+#define QE_CR_SUBBLOCK_INVALID      0x00000000
+#define QE_CR_SUBBLOCK_USB          0x03200000
+#define QE_CR_SUBBLOCK_UCCFAST1     0x02000000
+#define QE_CR_SUBBLOCK_UCCFAST2     0x02200000
+#define QE_CR_SUBBLOCK_UCCFAST3     0x02400000
+#define QE_CR_SUBBLOCK_UCCFAST4     0x02600000
+#define QE_CR_SUBBLOCK_UCCFAST5     0x02800000
+#define QE_CR_SUBBLOCK_UCCFAST6     0x02a00000
+#define QE_CR_SUBBLOCK_UCCFAST7     0x02c00000
+#define QE_CR_SUBBLOCK_UCCFAST8     0x02e00000
+#define QE_CR_SUBBLOCK_UCCSLOW1     0x00000000
+#define QE_CR_SUBBLOCK_UCCSLOW2     0x00200000
+#define QE_CR_SUBBLOCK_UCCSLOW3     0x00400000
+#define QE_CR_SUBBLOCK_UCCSLOW4     0x00600000
+#define QE_CR_SUBBLOCK_UCCSLOW5     0x00800000
+#define QE_CR_SUBBLOCK_UCCSLOW6     0x00a00000
+#define QE_CR_SUBBLOCK_UCCSLOW7     0x00c00000
+#define QE_CR_SUBBLOCK_UCCSLOW8     0x00e00000
+#define QE_CR_SUBBLOCK_MCC1         0x03800000
+#define QE_CR_SUBBLOCK_MCC2         0x03a00000
+#define QE_CR_SUBBLOCK_MCC3         0x03000000
+#define QE_CR_SUBBLOCK_IDMA1        0x02800000
+#define QE_CR_SUBBLOCK_IDMA2        0x02a00000
+#define QE_CR_SUBBLOCK_IDMA3        0x02c00000
+#define QE_CR_SUBBLOCK_IDMA4        0x02e00000
+#define QE_CR_SUBBLOCK_HPAC         0x01e00000
+#define QE_CR_SUBBLOCK_SPI1         0x01400000
+#define QE_CR_SUBBLOCK_SPI2         0x01600000
+#define QE_CR_SUBBLOCK_RAND         0x01c00000
+#define QE_CR_SUBBLOCK_TIMER        0x01e00000
+#define QE_CR_SUBBLOCK_GENERAL      0x03c00000
+
+/* QE CECR Protocol - For non-MCC, specifies mode for QE CECR command.
+*/
+#define QE_CR_PROTOCOL_UNSPECIFIED       0x00	/* For all other protocols */
+#define QE_CR_PROTOCOL_HDLC_TRANSPARENT  0x00
+#define QE_CR_PROTOCOL_ATM_POS           0x0A
+#define QE_CR_PROTOCOL_ETHERNET          0x0C
+#define QE_CR_PROTOCOL_L2_SWITCH         0x0D
+
+/* BMR byte order
+*/
+#define QE_BMR_BYTE_ORDER_BO_PPC  0x08	/* powerpc little endian */
+#define QE_BMR_BYTE_ORDER_BO_MOT  0x10	/* motorola big endian   */
+#define QE_BMR_BYTE_ORDER_BO_MAX  0x18
+
+/* BRG configuration register
+*/
+#define QE_BRGC_ENABLE          0x00010000
+#define QE_BRGC_DIVISOR_SHIFT   1
+#define QE_BRGC_DIVISOR_MAX     0xFFF
+#define QE_BRGC_DIV16           1
+/* QE Timers registers */
+#define QE_GTCFR1_PCAS      0x80
+#define QE_GTCFR1_STP2      0x20
+#define QE_GTCFR1_RST2      0x10
+#define QE_GTCFR1_GM2       0x08
+#define QE_GTCFR1_GM1       0x04
+#define QE_GTCFR1_STP1      0x02
+#define QE_GTCFR1_RST1      0x01
+
+/* SDMA registers */
+#define QE_SDSR_BER1            0x02000000
+#define QE_SDSR_BER2            0x01000000
+
+#define QE_SDMR_GLB_1_MSK       0x80000000
+#define QE_SDMR_ADR_SEL         0x20000000
+#define QE_SDMR_BER1_MSK        0x02000000
+#define QE_SDMR_BER2_MSK        0x01000000
+#define QE_SDMR_EB1_MSK         0x00800000
+#define QE_SDMR_ER1_MSK         0x00080000
+#define QE_SDMR_ER2_MSK         0x00040000
+#define QE_SDMR_CEN_MASK        0x0000E000
+#define QE_SDMR_SBER_1          0x00000200
+#define QE_SDMR_SBER_2          0x00000200
+#define QE_SDMR_EB1_PR_MASK     0x000000C0
+#define QE_SDMR_ER1_PR          0x00000008
+
+#define QE_SDMR_CEN_SHIFT       13
+#define QE_SDMR_EB1_PR_SHIFT    6
+
+#define QE_SDTM_MSNUM_SHIFT     24
+
+#define QE_SDEBCR_BA_MASK       0x01FFFFFF
+
+/* UPC
+*/
+#define UPGCR_PROTOCOL      0x80000000	/* protocol ul2 or pl2 */
+#define UPGCR_TMS           0x40000000	/* Transmit master/slave mode */
+#define UPGCR_RMS           0x20000000	/* Receive master/slave mode */
+#define UPGCR_ADDR          0x10000000	/* Master MPHY Addr multiplexing */
+#define UPGCR_DIAG          0x01000000	/* Diagnostic mode */
+
+/* UCC
+*/
+#define UCC_GUEMR_MODE_MASK_RX  0x02
+#define UCC_GUEMR_MODE_MASK_TX  0x01
+#define UCC_GUEMR_MODE_FAST_RX  0x02
+#define UCC_GUEMR_MODE_FAST_TX  0x01
+#define UCC_GUEMR_MODE_SLOW_RX  0x00
+#define UCC_GUEMR_MODE_SLOW_TX  0x00
+#define UCC_GUEMR_SET_RESERVED3 0x10	/* Bit 3 in the guemr is reserved but 
+					   must be set 1 */
+
+/* structure representing UCC SLOW parameter RAM
+*/
+typedef struct ucc_slow_pram {
+	u16 rbase;		/* RX BD base address       */
+	u16 tbase;		/* TX BD base address       */
+	u8 rfcr;		/* Rx function code         */
+	u8 tfcr;		/* Tx function code         */
+	u16 mrblr;		/* Rx buffer length         */
+	u32 rstate;		/* Rx internal state        */
+	u32 rptr;		/* Rx internal data pointer */
+	u16 rbptr;		/* rb BD Pointer            */
+	u16 rcount;		/* Rx internal byte count   */
+	u32 rtemp;		/* Rx temp                  */
+	u32 tstate;		/* Tx internal state        */
+	u32 tptr;		/* Tx internal data pointer */
+	u16 tbptr;		/* Tx BD pointer            */
+	u16 tcount;		/* Tx byte count            */
+	u32 ttemp;		/* Tx temp                  */
+	u32 rcrc;		/* temp receive CRC         */
+	u32 tcrc;		/* temp transmit CRC        */
+} __attribute__ ((packed)) ucc_slow_pram_t;
+
+/* General UCC SLOW Mode Register (GUMRH & GUMRL)
+*/
+#define UCC_SLOW_GUMR_H_CRC16         0x00004000
+#define UCC_SLOW_GUMR_H_CRC16CCITT    0x00000000
+#define UCC_SLOW_GUMR_H_CRC32CCITT    0x00008000
+#define UCC_SLOW_GUMR_H_REVD          0x00002000
+#define UCC_SLOW_GUMR_H_TRX           0x00001000
+#define UCC_SLOW_GUMR_H_TTX           0x00000800
+#define UCC_SLOW_GUMR_H_CDP           0x00000400
+#define UCC_SLOW_GUMR_H_CTSP          0x00000200
+#define UCC_SLOW_GUMR_H_CDS           0x00000100
+#define UCC_SLOW_GUMR_H_CTSS          0x00000080
+#define UCC_SLOW_GUMR_H_TFL           0x00000040
+#define UCC_SLOW_GUMR_H_RFW           0x00000020
+#define UCC_SLOW_GUMR_H_TXSY          0x00000010
+#define UCC_SLOW_GUMR_H_4SYNC         0x00000004
+#define UCC_SLOW_GUMR_H_8SYNC         0x00000008
+#define UCC_SLOW_GUMR_H_16SYNC        0x0000000c
+#define UCC_SLOW_GUMR_H_RTSM          0x00000002
+#define UCC_SLOW_GUMR_H_RSYN          0x00000001
+
+#define UCC_SLOW_GUMR_L_TCI           0x10000000
+#define UCC_SLOW_GUMR_L_RINV          0x02000000
+#define UCC_SLOW_GUMR_L_TINV          0x01000000
+#define UCC_SLOW_GUMR_L_TEND          0x00020000
+#define UCC_SLOW_GUMR_L_ENR           0x00000020
+#define UCC_SLOW_GUMR_L_ENT           0x00000010
+
+/* General UCC FAST Mode Register
+*/
+#define UCC_FAST_GUMR_TCI             0x20000000
+#define UCC_FAST_GUMR_TRX             0x10000000
+#define UCC_FAST_GUMR_TTX             0x08000000
+#define UCC_FAST_GUMR_CDP             0x04000000
+#define UCC_FAST_GUMR_CTSP            0x02000000
+#define UCC_FAST_GUMR_CDS             0x01000000
+#define UCC_FAST_GUMR_CTSS            0x00800000
+#define UCC_FAST_GUMR_TXSY            0x00020000
+#define UCC_FAST_GUMR_RSYN            0x00010000
+#define UCC_FAST_GUMR_RTSM            0x00002000
+#define UCC_FAST_GUMR_REVD            0x00000400
+#define UCC_FAST_GUMR_ENR             0x00000020
+#define UCC_FAST_GUMR_ENT             0x00000010
+
+/* Slow UCC Event Register (UCCE)
+*/
+#define UCC_SLOW_UCCE_GLR       0x1000
+#define UCC_SLOW_UCCE_GLT       0x0800
+#define UCC_SLOW_UCCE_DCC       0x0400
+#define UCC_SLOW_UCCE_FLG       0x0200
+#define UCC_SLOW_UCCE_AB        0x0200
+#define UCC_SLOW_UCCE_IDLE      0x0100
+#define UCC_SLOW_UCCE_GRA       0x0080
+#define UCC_SLOW_UCCE_TXE       0x0010
+#define UCC_SLOW_UCCE_RXF       0x0008
+#define UCC_SLOW_UCCE_CCR       0x0008
+#define UCC_SLOW_UCCE_RCH       0x0008
+#define UCC_SLOW_UCCE_BSY       0x0004
+#define UCC_SLOW_UCCE_TXB       0x0002
+#define UCC_SLOW_UCCE_TX        0x0002
+#define UCC_SLOW_UCCE_RX        0x0001
+#define UCC_SLOW_UCCE_GOV       0x0001
+#define UCC_SLOW_UCCE_GUN       0x0002
+#define UCC_SLOW_UCCE_GINT      0x0004
+#define UCC_SLOW_UCCE_IQOV      0x0008
+
+#define UCC_SLOW_UCCE_HDLC_SET  (UCC_SLOW_UCCE_TXE|UCC_SLOW_UCCE_BSY| \
+		UCC_SLOW_UCCE_GRA|UCC_SLOW_UCCE_TXB|UCC_SLOW_UCCE_RXF| \
+		UCC_SLOW_UCCE_DCC|UCC_SLOW_UCCE_GLT|UCC_SLOW_UCCE_GLR)
+#define UCC_SLOW_UCCE_ENET_SET  (UCC_SLOW_UCCE_TXE|UCC_SLOW_UCCE_BSY| \
+		UCC_SLOW_UCCE_GRA|UCC_SLOW_UCCE_TXB|UCC_SLOW_UCCE_RXF)
+#define UCC_SLOW_UCCE_TRANS_SET (UCC_SLOW_UCCE_TXE|UCC_SLOW_UCCE_BSY| \
+		UCC_SLOW_UCCE_GRA|UCC_SLOW_UCCE_TX |UCC_SLOW_UCCE_RX | \
+		UCC_SLOW_UCCE_DCC|UCC_SLOW_UCCE_GLT|UCC_SLOW_UCCE_GLR)
+#define UCC_SLOW_UCCE_UART_SET  (UCC_SLOW_UCCE_BSY|UCC_SLOW_UCCE_GRA| \
+		UCC_SLOW_UCCE_TXB|UCC_SLOW_UCCE_TX |UCC_SLOW_UCCE_RX | \
+		UCC_SLOW_UCCE_GLT|UCC_SLOW_UCCE_GLR)
+#define UCC_SLOW_UCCE_QMC_SET   (UCC_SLOW_UCCE_IQOV|UCC_SLOW_UCCE_GINT| \
+		UCC_SLOW_UCCE_GUN|UCC_SLOW_UCCE_GOV)
+
+#define UCC_SLOW_UCCE_OTHER     (UCC_SLOW_UCCE_TXE|UCC_SLOW_UCCE_BSY| \
+		UCC_SLOW_UCCE_GRA|UCC_SLOW_UCCE_DCC|UCC_SLOW_UCCE_GLT| \
+		UCC_SLOW_UCCE_GLR)
+
+#define UCC_SLOW_INTR_TX        UCC_SLOW_UCCE_TXB
+#define UCC_SLOW_INTR_RX        (UCC_SLOW_UCCE_RXF | UCC_SLOW_UCCE_RX)
+#define UCC_SLOW_INTR           (UCC_SLOW_INTR_TX  | UCC_SLOW_INTR_RX)
+
+/* Transmit On Demand (UTORD)
+*/
+#define UCC_SLOW_TOD            0x8000
+#define UCC_FAST_TOD            0x8000
+
+/* Function code masks.
+*/
+#define FC_GBL                             0x20
+#define FC_DTB_LCL                         0x02
+#define UCC_FAST_FUNCTION_CODE_GBL         0x20
+#define UCC_FAST_FUNCTION_CODE_DTB_LCL     0x02
+#define UCC_FAST_FUNCTION_CODE_BDB_LCL     0x01
+
+#endif				/* __QE_H__ */
+#endif				/* __KERNEL__ */
diff --git a/include/asm-powerpc/qe_ic.h b/include/asm-powerpc/qe_ic.h
new file mode 100644
index 0000000..81bbf2a
--- /dev/null
+++ b/include/asm-powerpc/qe_ic.h
@@ -0,0 +1,131 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QE IC external definitions and structure.
+ *
+ * Changelog:
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifdef __KERNEL__
+#ifndef __ASM_QE_IC_H__
+#define __ASM_QE_IC_H__
+
+#include <linux/irq.h>
+
+#define _IO_BASE        isa_io_base
+#define _ISA_MEM_BASE   isa_mem_base
+#ifdef CONFIG_PCI
+#define PCI_DRAM_OFFSET pci_dram_offset
+#else
+#define PCI_DRAM_OFFSET 0
+#endif
+
+#define NUM_OF_QE_IC_GROUPS    6
+
+/* Flags when we init the QE IC */
+#define QE_IC_SPREADMODE_GRP_W                   0x00000001
+#define QE_IC_SPREADMODE_GRP_X                   0x00000002
+#define QE_IC_SPREADMODE_GRP_Y                   0x00000004
+#define QE_IC_SPREADMODE_GRP_Z                   0x00000008
+#define QE_IC_SPREADMODE_GRP_RISCA               0x00000010
+#define QE_IC_SPREADMODE_GRP_RISCB               0x00000020
+
+#define QE_IC_LOW_SIGNAL                         0x00000100
+#define QE_IC_HIGH_SIGNAL                        0x00000200
+
+#define QE_IC_GRP_W_PRI0_DEST_SIGNAL_HIGH        0x00001000
+#define QE_IC_GRP_W_PRI1_DEST_SIGNAL_HIGH        0x00002000
+#define QE_IC_GRP_X_PRI0_DEST_SIGNAL_HIGH        0x00004000
+#define QE_IC_GRP_X_PRI1_DEST_SIGNAL_HIGH        0x00008000
+#define QE_IC_GRP_Y_PRI0_DEST_SIGNAL_HIGH        0x00010000
+#define QE_IC_GRP_Y_PRI1_DEST_SIGNAL_HIGH        0x00020000
+#define QE_IC_GRP_Z_PRI0_DEST_SIGNAL_HIGH        0x00040000
+#define QE_IC_GRP_Z_PRI1_DEST_SIGNAL_HIGH        0x00080000
+#define QE_IC_GRP_RISCA_PRI0_DEST_SIGNAL_HIGH    0x00100000
+#define QE_IC_GRP_RISCA_PRI1_DEST_SIGNAL_HIGH    0x00200000
+#define QE_IC_GRP_RISCB_PRI0_DEST_SIGNAL_HIGH    0x00400000
+#define QE_IC_GRP_RISCB_PRI1_DEST_SIGNAL_HIGH    0x00800000
+#define QE_IC_GRP_W_DEST_SIGNAL_SHIFT            (12)
+
+/*
+ * QE interrupt sources groups
+ */
+enum qe_ic_grp_id {
+	QE_IC_GRP_W = 0,	/* QE interrupt controller group W      */
+	QE_IC_GRP_X,		/* QE interrupt controller group X      */
+	QE_IC_GRP_Y,		/* QE interrupt controller group Y      */
+	QE_IC_GRP_Z,		/* QE interrupt controller group Z      */
+	QE_IC_GRP_RISCA,	/* QE interrupt controller RISC group A */
+	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
+};
+
+/*
+ * QE interrupt controller internal structure
+ */
+struct qe_ic_info {
+	u32 mask;	/* locaion of this source at the QIMR register.    */
+	int qimr;	/* TRUE is this source is mappd to QIMR,           */
+	/* otherwise - QRIMR (risc).                       */
+	u8 pri_code;	/* for grouped interrupts sources - the interrupt  */
+	/* code as appears at the group priority register. */
+};
+
+/*********************************************/
+/******   QE IC API routines             *****/
+/*********************************************/
+int qe_ic_init(phys_addr_t phys_addr,
+	       unsigned int flags, unsigned int irq_offset);
+void qe_ic_free(void);
+void qe_ic_enable_irq(unsigned int qeIntrSrc);
+void qe_ic_disable_irq(unsigned int qeIntrSrc);
+void qe_ic_disable_irq_and_ack(unsigned int irq);
+void qe_ic_end_irq(unsigned int irq);
+
+/* qe_ic_modify_highest_priority
+ * Optional, used to change default. This routine defines a single interrupt
+ * source to be highest priority. It may be called at any stage, thus enabling
+ * dynamic change of the highest priority interrupt.
+ * In default, Highest priority is XCC1 highest priority interrupt source.
+ *
+ *     irq (In) -  Interrupt source Id.
+ */
+void qe_ic_modify_highest_priority(unsigned int irq);
+
+/* qe_ic_modify_priority
+ * Optional, used to change default. May be called at run time to manipulate
+ * priorities. This routine is called to reorganize a specific group.
+ * 
+ *     qeIcGroupId (In)         - One of:
+ *                                          e_QE_IC_GRP_W
+ *                                          e_QE_IC_GRP_X
+ *                                          e_QE_IC_GRP_Y
+ *                                          e_QE_IC_GRP_Z
+ *                                          e_QE_IC_GRP_RISCA
+ *                                          e_QE_IC_GRP_RISCB
+ *     pri0, pr1,..., pri7 (In) - A list of interrupt sources (of type
+ *                                      unsigned int) in order of priority. The
+ *                                      list must include all and only sources
+ *                                      of the specified group.
+ */
+void qe_ic_modify_priority(enum qe_ic_grp_id qeIcGroupId,
+			   unsigned int pri0,
+			   unsigned int pri1,
+			   unsigned int pri2,
+			   unsigned int pri3,
+			   unsigned int pri4,
+			   unsigned int pri5,
+			   unsigned int pri6, unsigned int pri7);
+
+#endif				/* __ASM_QE_IC_H__ */
+#endif				/* __KERNEL__ */
diff --git a/include/asm-powerpc/ucc.h b/include/asm-powerpc/ucc.h
new file mode 100644
index 0000000..084c786
--- /dev/null
+++ b/include/asm-powerpc/ucc.h
@@ -0,0 +1,89 @@
+/*
+ * aopyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * Internal header file for UCC unit routines.
+ *
+ * Changelog:
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __UCC_H__
+#define __UCC_H__
+
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#define STATISTICS
+
+#define UCC_MAX_NUM     8
+
+/* Slow or fast type for UCCs.
+*/
+typedef enum ucc_speed_type {
+	UCC_SPEED_TYPE_FAST, UCC_SPEED_TYPE_SLOW
+} ucc_speed_type_e;
+
+/* Initial UCCs Parameter RAM address relative to: MEM_MAP_BASE (IMMR).
+*/
+typedef enum ucc_pram_initial_offset {
+	UCC_PRAM_OFFSET_UCC1 = 0x8400, 
+	UCC_PRAM_OFFSET_UCC2 = 0x8500, 
+	UCC_PRAM_OFFSET_UCC3 = 0x8600,
+	UCC_PRAM_OFFSET_UCC4 = 0x9000,
+	UCC_PRAM_OFFSET_UCC5 = 0x8000,
+	UCC_PRAM_OFFSET_UCC6 = 0x8100,
+	UCC_PRAM_OFFSET_UCC7 = 0x8200,
+	UCC_PRAM_OFFSET_UCC8 = 0x8300
+} ucc_pram_initial_offset_e;
+
+/* ucc_set_type
+ * Sets UCC to slow or fast mode.
+ *
+ *          ucc_num  - (In) number of UCC  (0-7).
+ *          regs     - (In) pointer to registers base for the UCC.
+ *          speed    - (In) slow or fast mode for UCC.
+ */
+int ucc_set_type(int ucc_num, struct ucc_common *regs,
+		 enum ucc_speed_type speed);
+
+/* ucc_init_guemr
+ * Init the Guemr register.
+ *
+ *          regs - (In) pointer to registers base for the UCC.
+ */
+int ucc_init_guemr(struct ucc_common *regs);
+
+int ucc_set_qe_mux_mii_mng(int ucc_num);
+
+int ucc_set_qe_mux_rxtx(int ucc_num, qe_clock_e clock, comm_dir_e mode);
+
+int ucc_mux_set_grant_tsa_bkpt(int ucc_num, int set, u32 mask);
+
+/* QE MUX clock routing for UCC 
+*/
+static inline int ucc_set_qe_mux_grant(int ucc_num, int set)
+{
+	return ucc_mux_set_grant_tsa_bkpt(ucc_num, set, QE_CMXUCR_GRANT);
+}
+
+static inline int ucc_set_qe_mux_tsa(int ucc_num, int set)
+{
+	return ucc_mux_set_grant_tsa_bkpt(ucc_num, set, QE_CMXUCR_TSA);
+}
+
+static inline int ucc_set_qe_mux_bkpt(int ucc_num, int set)
+{
+	return ucc_mux_set_grant_tsa_bkpt(ucc_num, set, QE_CMXUCR_BKPT);
+}
+
+#endif				/* __UCC_H__ */
diff --git a/include/asm-powerpc/ucc_fast.h b/include/asm-powerpc/ucc_fast.h
new file mode 100644
index 0000000..a88b97c
--- /dev/null
+++ b/include/asm-powerpc/ucc_fast.h
@@ -0,0 +1,259 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * Internal header file for UCC FAST unit routines.
+ *
+ * Changelog:
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __UCC_FAST_H__
+#define __UCC_FAST_H__
+
+#include <linux/kernel.h>
+
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include "ucc.h"
+
+/* Receive BD's status.
+*/
+#define R_E     0x80000000	/* buffer empty */
+#define R_W     0x20000000	/* wrap bit     */
+#define R_I     0x10000000	/* interrupt on reception  */
+#define R_L     0x08000000	/* last */
+#define R_F     0x04000000	/* first */
+
+/* transmit BD's status.
+*/
+#define T_R     0x80000000	/* ready bit */
+#define T_W     0x20000000	/* wrap bit */
+#define T_I     0x10000000	/* interrupt on completion */
+#define T_L     0x08000000	/* last */
+
+/* Rx Data buffer must be 4 bytes aligned in most cases.*/
+#define UCC_FAST_RX_ALIGN                  4
+#define UCC_FAST_MRBLR_ALIGNMENT           4
+#define UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT  8
+
+/* Sizes 
+*/
+#define UCC_FAST_URFS_MIN_VAL                           0x88
+#define UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR 8
+
+/* ucc_fast_channel_protocol_mode - UCC FAST mode.
+*/
+typedef enum ucc_fast_channel_protocol_mode {
+	UCC_FAST_PROTOCOL_MODE_HDLC = 0x00000000,
+	UCC_FAST_PROTOCOL_MODE_RESERVED01 = 0x00000001,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_QMC = 0x00000002,
+	UCC_FAST_PROTOCOL_MODE_RESERVED02 = 0x00000003,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_UART = 0x00000004,
+	UCC_FAST_PROTOCOL_MODE_RESERVED03 = 0x00000005,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_EX_MAC_1 = 0x00000006,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_EX_MAC_2 = 0x00000007,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_BISYNC = 0x00000008,
+	UCC_FAST_PROTOCOL_MODE_RESERVED04 = 0x00000009,
+	UCC_FAST_PROTOCOL_MODE_ATM = 0x0000000A,
+	UCC_FAST_PROTOCOL_MODE_RESERVED05 = 0x0000000B,
+	UCC_FAST_PROTOCOL_MODE_ETHERNET = 0x0000000C,
+	UCC_FAST_PROTOCOL_MODE_RESERVED06 = 0x0000000D,
+	UCC_FAST_PROTOCOL_MODE_POS = 0x0000000E,
+	UCC_FAST_PROTOCOL_MODE_RESERVED07 = 0x0000000F
+} ucc_fast_channel_protocol_mode_e;
+
+/* ucc_fast_transparent_txrx - UCC Fast Transparent TX & RX
+*/
+typedef enum ucc_fast_transparent_txrx {
+	UCC_FAST_GUMR_TRANSPARENT_TTX_TRX_NORMAL = 0x00000000,
+	UCC_FAST_GUMR_TRANSPARENT_TTX_TRX_TRANSPARENT = 0x18000000
+} ucc_fast_transparent_txrx_e;
+
+/* UCC fast diagnostic mode
+*/
+typedef enum ucc_fast_diag_mode {
+	UCC_FAST_DIAGNOSTIC_NORMAL = 0x0,
+	UCC_FAST_DIAGNOSTIC_LOCAL_LOOP_BACK = 0x40000000,
+	UCC_FAST_DIAGNOSTIC_AUTO_ECHO = 0x80000000,
+	UCC_FAST_DIAGNOSTIC_LOOP_BACK_AND_ECHO = 0xC0000000
+} ucc_fast_diag_mode_e;
+
+/* UCC fast Sync length (transparent mode only)
+*/
+typedef enum ucc_fast_sync_len {
+	UCC_FAST_SYNC_LEN_NOT_USED = 0x0,
+	UCC_FAST_SYNC_LEN_AUTOMATIC = 0x00004000,
+	UCC_FAST_SYNC_LEN_8_BIT = 0x00008000,
+	UCC_FAST_SYNC_LEN_16_BIT = 0x0000C000
+} ucc_fast_sync_len_e;
+
+/* UCC fast RTS mode
+*/
+typedef enum ucc_fast_ready_to_send {
+	UCC_FAST_SEND_IDLES_BETWEEN_FRAMES = 0x00000000,
+	UCC_FAST_SEND_FLAGS_BETWEEN_FRAMES = 0x00002000
+} ucc_fast_ready_to_send_e;
+
+/* UCC fast receiver decoding mode
+*/
+typedef enum ucc_fast_rx_decoding_method {
+	UCC_FAST_RX_ENCODING_NRZ = 0x00000000,
+	UCC_FAST_RX_ENCODING_NRZI = 0x00000800,
+	UCC_FAST_RX_ENCODING_RESERVED0 = 0x00001000,
+	UCC_FAST_RX_ENCODING_RESERVED1 = 0x00001800
+} ucc_fast_rx_decoding_method_e;
+
+/* UCC fast transmitter encoding mode
+*/
+typedef enum ucc_fast_tx_encoding_method {
+	UCC_FAST_TX_ENCODING_NRZ = 0x00000000,
+	UCC_FAST_TX_ENCODING_NRZI = 0x00000100,
+	UCC_FAST_TX_ENCODING_RESERVED0 = 0x00000200,
+	UCC_FAST_TX_ENCODING_RESERVED1 = 0x00000300
+} ucc_fast_tx_encoding_method_e;
+
+/* UCC fast CRC length
+*/
+typedef enum ucc_fast_transparent_tcrc {
+	UCC_FAST_16_BIT_CRC = 0x00000000,
+	UCC_FAST_CRC_RESERVED0 = 0x00000040,
+	UCC_FAST_32_BIT_CRC = 0x00000080,
+	UCC_FAST_CRC_RESERVED1 = 0x000000C0
+} ucc_fast_transparent_tcrc_e;
+
+/* Fast UCC initialization structure.
+*/
+typedef struct ucc_fast_info {
+	int ucc_num;
+	qe_clock_e rx_clock;
+	qe_clock_e tx_clock;
+	u32 regs;
+	int irq;
+	u32 uccm_mask;
+	int bd_mem_part;
+	int brkpt_support;
+	int grant_support;
+	int tsa;
+	int cdp;
+	int cds;
+	int ctsp;
+	int ctss;
+	int tci;
+	int txsy;
+	int rtsm;
+	int revd;
+	int rsyn;
+	u16 max_rx_buf_length;
+	u16 urfs;
+	u16 urfet;
+	u16 urfset;
+	u16 utfs;
+	u16 utfet;
+	u16 utftt;
+	u16 ufpt;
+	ucc_fast_channel_protocol_mode_e mode;
+	ucc_fast_transparent_txrx_e ttx_trx;
+	ucc_fast_tx_encoding_method_e tenc;
+	ucc_fast_rx_decoding_method_e renc;
+	ucc_fast_transparent_tcrc_e tcrc;
+	ucc_fast_sync_len_e synl;
+} ucc_fast_info_t;
+
+typedef struct ucc_fast_private {
+	ucc_fast_info_t *uf_info;
+	ucc_fast_t *uf_regs;	/* a pointer to memory map of UCC regs. */
+	u32 *p_ucce;		/* a pointer to the event register in memory. */
+	u32 *p_uccm;		/* a pointer to the mask register in memory.  */
+	int enabled_tx;		/* Whether channel is enabled for Tx (ENT)  */
+	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
+	int stopped_tx;		/* Whether channel has been stopped for Tx 
+				   (STOP_TX, etc.) */
+	int stopped_rx;		/* Whether channel has been stopped for Rx */
+	u32 ucc_fast_tx_virtual_fifo_base_offset;/* pointer to base of Tx 
+						    virtual fifo */
+	u32 ucc_fast_rx_virtual_fifo_base_offset;/* pointer to base of Rx 
+						    virtual fifo */
+#ifdef STATISTICS
+	u32 tx_frames;		/* Transmitted frames counter. */
+	u32 rx_frames;		/* Received frames counter (only frames 
+				   passed to application). */
+	u32 tx_discarded;	/* Discarded tx frames counter (frames that 
+				   were discarded by the driver due to errors).
+				   */
+	u32 rx_discarded;	/* Discarded rx frames counter (frames that 
+				   were discarded by the driver due to errors).
+				   */
+#endif				/* STATISTICS */
+	u16 mrblr;		/* maximum receive buffer length */
+} ucc_fast_private_t;
+
+/* ucc_fast_init
+ * Initializes Fast UCC according to user provided parameters.
+ *
+ *          uf_info  - (In) pointer to the fast UCC info structure.
+ *          uccf_ret - (Out) pointer to the fast UCC structure.
+ */
+int ucc_fast_init(ucc_fast_info_t * uf_info, ucc_fast_private_t ** uccf_ret);
+
+/* ucc_fast_free
+ * Frees all resources for fast UCC.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ */
+void ucc_fast_free(ucc_fast_private_t * uccf);
+
+/* ucc_fast_enable
+ * Enables a fast UCC port.
+ * This routine enables Tx and/or Rx through the General UCC Mode Register.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ *          mode - (In) TX, RX, or both.
+ */
+void ucc_fast_enable(ucc_fast_private_t * uccf, comm_dir_e mode);
+
+/* ucc_fast_disable
+ * Disables a fast UCC port.
+ * This routine disables Tx and/or Rx through the General UCC Mode Register.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ *          mode - (In) TX, RX, or both.
+ */
+void ucc_fast_disable(ucc_fast_private_t * uccf, comm_dir_e mode);
+
+/* ucc_fast_irq
+ * Handles interrupts on fast UCC.
+ * Called from the general interrupt routine to handle interrupts on fast UCC.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ */
+void ucc_fast_irq(ucc_fast_private_t * uccf);
+
+/* ucc_fast_transmit_on_demand
+ * Immediately forces a poll of the transmitter for data to be sent.
+ * Typically, the hardware performs a periodic poll for data that the
+ * transmit routine has set up to be transmitted. In cases where
+ * this polling cycle is not soon enough, this optional routine can
+ * be invoked to force a poll right away, instead. Proper use for
+ * each transmission for which this functionality is desired is to
+ * call the transmit routine and then this routine right after.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ */
+void ucc_fast_transmit_on_demand(ucc_fast_private_t * uccf);
+
+u32 ucc_fast_get_qe_cr_subblock(int uccf_num);
+
+void ucc_fast_dump_regs(ucc_fast_private_t * uccf);
+
+#endif				/* __UCC_FAST_H__ */
diff --git a/include/asm-powerpc/ucc_slow.h b/include/asm-powerpc/ucc_slow.h
new file mode 100644
index 0000000..531b87d
--- /dev/null
+++ b/include/asm-powerpc/ucc_slow.h
@@ -0,0 +1,309 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * Internal header file for UCC SLOW unit routines.
+ *
+ * Changelog:
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __UCC_SLOW_H__
+#define __UCC_SLOW_H__
+
+#include <linux/kernel.h>
+
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include "ucc.h"
+
+#define UCC_SLOW_SIZE_OF_BD QE_SIZEOF_BD
+
+/* transmit BD's status.
+*/
+#define T_R     0x80000000	/* ready bit */
+#define T_PAD   0x40000000	/* add pads to short frames */
+#define T_W     0x20000000	/* wrap bit */
+#define T_I     0x10000000	/* interrupt on completion */
+#define T_L     0x08000000	/* last */
+
+#define T_A     0x04000000	/* Address - the data transmitted as address
+				   chars */
+#define T_TC    0x04000000	/* transmit CRC */
+#define T_CM    0x02000000	/* continuous mode */
+#define T_DEF   0x02000000	/* collision on previous attempt to transmit. */
+#define T_P     0x01000000	/* Preamble - send Preamble sequence before
+				   data */
+#define T_HB    0x01000000	/* heartbeat. */
+#define T_NS    0x00800000	/* No Stop */
+#define T_LC    0x00800000	/* late collision. */
+#define T_RL    0x00400000	/* retransmission limit. */
+#define T_UN    0x00020000	/* underrun */
+#define T_CT    0x00010000	/* CTS lost */
+#define T_CSL   0x00010000	/* carrier sense lost.  */
+#define T_RC    0x003c0000	/* retry count.  */
+
+/* Receive BD's status.
+*/
+#define R_E     0x80000000	/* buffer empty */
+#define R_W     0x20000000	/* wrap bit */
+#define R_I     0x10000000	/* interrupt on reception */
+#define R_L     0x08000000	/* last */
+#define R_C     0x08000000	/* the last byte in this buffer is a cntl
+				   char */
+#define R_F     0x04000000	/* first */
+#define R_A     0x04000000	/* the first byte in this buffer is address
+				   byte */
+#define R_CM    0x02000000	/* continuous mode */
+#define R_ID    0x01000000	/* buffer close on reception of idles */
+#define R_M     0x01000000	/* Frame received because of promiscuous
+				   mode. */
+#define R_AM    0x00800000	/* Address match */
+#define R_DE    0x00800000	/* Address match */
+#define R_LG    0x00200000	/* Break received */
+#define R_BR    0x00200000	/* Frame length violation */
+#define R_NO    0x00100000	/* Rx Non Octet Aligned Packet */
+#define R_FR    0x00100000	/* Framing Error (no stop bit) character
+				   received */
+#define R_PR    0x00080000	/* Parity Error character received */
+#define R_AB    0x00080000	/* Frame Aborted */
+#define R_SH    0x00080000	/* frame is too short.  */
+#define R_CR    0x00040000	/* CRC Error */
+#define R_OV    0x00020000	/* Overrun */
+#define R_CD    0x00010000	/* CD lost */
+#define R_CL    0x00010000	/* this frame is closed because of a
+				   collision */
+
+/* Rx Data buffer must be 4 bytes aligned in most cases.*/
+#define UCC_SLOW_RX_ALIGN             4
+#define UCC_SLOW_MRBLR_ALIGNMENT      4
+#define UCC_SLOW_PRAM_SIZE            0x100
+#define ALIGNMENT_OF_UCC_SLOW_PRAM    64
+
+/* UCC Slow Channel Protocol Mode
+*/
+typedef enum ucc_slow_channel_protocol_mode {
+	UCC_SLOW_CHANNEL_PROTOCOL_MODE_QMC = 0x00000002,	/* QMC */
+	UCC_SLOW_CHANNEL_PROTOCOL_MODE_UART = 0x00000004,	/* UART */
+	UCC_SLOW_CHANNEL_PROTOCOL_MODE_BISYNC = 0x00000008	/* BISYNC */
+} ucc_slow_channel_protocol_mode_e;
+
+/* UCC Slow Transparent Transmit CRC (TCRC)
+*/
+typedef enum ucc_slow_transparent_tcrc {
+	UCC_SLOW_TRANSPARENT_TCRC_CCITT_CRC16 = 0x00000000,	/* 16-bit
+								   CCITT CRC
+								   (HDLC).
+								   (X16 + X12 
+								   + X5 + 1) */
+	UCC_SLOW_TRANSPARENT_TCRC_CRC16 = 0x00004000,	/* CRC16 (BISYNC).
+							   (X16 + X15 + X2 +
+							   1) */
+	UCC_SLOW_TRANSPARENT_TCRC_CCITT_CRC32 = 0x00008000	/* 32-bit
+								   CCITT CRC
+								   (Ethernet
+								   and HDLC). 
+								 */
+} ucc_slow_transparent_tcrc_e;
+
+/* UCC Slow oversampling rate for transmitter (TDCR)
+*/
+typedef enum ucc_slow_tx_oversampling_rate {
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_1 = 0x00000000,	/* 1x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_8 = 0x00010000,	/* 8x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_16 = 0x00020000,	/* 16x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_32 = 0x00030000	/* 32x clock
+								   mode */
+} ucc_slow_tx_oversampling_rate_e;
+
+/* UCC Slow Oversampling rate for receiver (RDCR)
+*/
+typedef enum ucc_slow_rx_oversampling_rate {
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_1 = 0x00000000,	/* 1x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_8 = 0x00004000,	/* 8x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_16 = 0x00008000,	/* 16x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_32 = 0x0000c000	/* 32x clock
+								   mode */
+} ucc_slow_rx_oversampling_rate_e;
+
+/* UCC Slow Transmitter encoding method (TENC)
+*/
+typedef enum ucc_slow_tx_encoding_method {
+	UCC_SLOW_TRANSMITTER_ENCODING_METHOD_TENC_NRZ = 0x00000000,
+	UCC_SLOW_TRANSMITTER_ENCODING_METHOD_TENC_NRZI = 0x00000100
+} ucc_slow_tx_encoding_method_e;
+
+/* UCC Slow Receiver decoding method (RENC)
+*/
+typedef enum ucc_slow_rx_decoding_method {
+	UCC_SLOW_RECEIVER_DECODING_METHOD_RENC_NRZ = 0x00000000,
+	UCC_SLOW_RECEIVER_DECODING_METHOD_RENC_NRZI = 0x00000800
+} ucc_slow_rx_decoding_method_e;
+
+/* UCC Slow Diagnostic mode (DIAG)
+*/
+typedef enum ucc_slow_diag_mode {
+	UCC_SLOW_DIAG_MODE_NORMAL = 0x00000000,
+	UCC_SLOW_DIAG_MODE_LOOPBACK = 0x00000040,
+	UCC_SLOW_DIAG_MODE_ECHO = 0x00000080,
+	UCC_SLOW_DIAG_MODE_LOOPBACK_ECHO = 0x000000c0
+} ucc_slow_diag_mode_e;
+
+typedef struct ucc_slow_info {
+	int ucc_num;
+	qe_clock_e rx_clock;
+	qe_clock_e tx_clock;
+	ucc_slow_t *us_regs;
+	int irq;
+	u16 uccm_mask;
+	int data_mem_part;
+	int init_tx;
+	int init_rx;
+	u32 tx_bd_ring_len;
+	u32 rx_bd_ring_len;
+	int rx_interrupts;
+	int brkpt_support;
+	int grant_support;
+	int tsa;
+	int cdp;
+	int cds;
+	int ctsp;
+	int ctss;
+	int rinv;
+	int tinv;
+	int rtsm;
+	int rfw;
+	int tci;
+	int tend;
+	int tfl;
+	int txsy;
+	u16 max_rx_buf_length;
+	ucc_slow_transparent_tcrc_e tcrc;
+	ucc_slow_channel_protocol_mode_e mode;
+	ucc_slow_diag_mode_e diag;
+	ucc_slow_tx_oversampling_rate_e tdcr;
+	ucc_slow_rx_oversampling_rate_e rdcr;
+	ucc_slow_tx_encoding_method_e tenc;
+	ucc_slow_rx_decoding_method_e renc;
+} ucc_slow_info_t;
+
+typedef struct ucc_slow_private {
+	ucc_slow_info_t *us_info;
+	ucc_slow_t *us_regs;	/* a pointer to memory map of UCC regs.  */
+	ucc_slow_pram_t *us_pram;	/* a pointer to the parameter RAM.  */
+	uint us_pram_offset;
+	int enabled_tx;		/* Whether channel is enabled for Tx (ENT) */
+	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
+	int stopped_tx;		/* Whether channel has been stopped for Tx
+				   (STOP_TX, etc.) */
+	int stopped_rx;		/* Whether channel has been stopped for Rx */
+	struct list_head confQ;	/* frames passed to chip waiting for tx */
+	u32 first_tx_bd_mask;	/* mask is used in Tx routine to save status
+				   and length for first BD in a frame.  */
+	uint tx_base_offset;	/* first BD in Tx BD table offset (In MURAM) */
+	uint rx_base_offset;	/* first BD in Rx BD table offset (In MURAM) */
+	u8 *confBd;		/* next BD for confirm after Tx */
+	u8 *tx_bd;		/* next BD for new Tx request */
+	u8 *rx_bd;		/* next BD to collect after Rx */
+	void *p_rx_frame;	/* accumulating receive frame */
+	u16 *p_ucce;		/* a pointer to the event register in memory. 
+				 */
+	u16 *p_uccm;		/* a pointer to the mask register in memory.
+				   */
+	u16 saved_uccm;		/* a saved mask for the RX Interrupt bits.  */
+#ifdef STATISTICS
+	u32 tx_frames;		/* Transmitted frames counters.  */
+	u32 rx_frames;		/* Received frames counters (only frames
+				   passed to application).  */
+	u32 rx_discarded;	/* Discarded frames counters (frames that
+				   were discarded by the driver due to
+				   errors). */
+#endif				/* STATISTICS */
+} ucc_slow_private_t;
+
+/* ucc_slow_init
+ * Initializes Slow UCC according to provided parameters.
+ *
+ *          us_info  - (In) pointer to the slow UCC info structure.
+ *          uccs_ret - (Out) pointer to the slow UCC structure.
+ */
+int ucc_slow_init(ucc_slow_info_t * us_info, ucc_slow_private_t ** uccs_ret);
+
+/* ucc_slow_free
+ * Frees all resources for slow UCC.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_free(ucc_slow_private_t * uccs);
+
+/* ucc_slow_enable
+ * Enables a fast UCC port.
+ * This routine enables Tx and/or Rx through the General UCC Mode Register.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ *          mode - (In) TX, RX, or both.
+ */
+void ucc_slow_enable(ucc_slow_private_t * uccs, comm_dir_e mode);
+
+/* ucc_slow_disable
+ * Disables a fast UCC port.
+ * This routine disables Tx and/or Rx through the General UCC Mode Register.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ *          mode - (In) TX, RX, or both.
+ */
+void ucc_slow_disable(ucc_slow_private_t * uccs, comm_dir_e mode);
+
+/* ucc_slow_poll_transmitter_now
+ * Immediately forces a poll of the transmitter for data to be sent.
+ * Typically, the hardware performs a periodic poll for data that the
+ * transmit routine has set up to be transmitted. In cases where
+ * this polling cycle is not soon enough, this optional routine can
+ * be invoked to force a poll right away, instead. Proper use for
+ * each transmission for which this functionality is desired is to
+ * call the transmit routine and then this routine right after.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_poll_transmitter_now(ucc_slow_private_t * uccs);
+
+/* ucc_slow_graceful_stop_tx
+ * Smoothly stops transmission on a specified slow UCC.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_graceful_stop_tx(ucc_slow_private_t * uccs);
+
+/* ucc_slow_stop_tx
+ * Stops transmission on a specified slow UCC.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_stop_tx(ucc_slow_private_t * uccs);
+
+/* ucc_slow_restart_x
+ * Restarts transmitting on a specified slow UCC.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_restart_x(ucc_slow_private_t * uccs);
+
+u32 ucc_slow_get_qe_cr_subblock(int uccs_num);
+
+#endif				/* __UCC_SLOW_H__ */
diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
index 3c23fc4..6acd82f 100644
--- a/include/asm-ppc/mpc83xx.h
+++ b/include/asm-ppc/mpc83xx.h
@@ -62,12 +62,17 @@ #define MPC83xx_IRQ_EXT4	(20 + MPC83xx_I
 #define MPC83xx_IRQ_EXT5	(21 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_EXT6	(22 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_EXT7	(23 + MPC83xx_IPIC_IRQ_OFFSET)
+#ifdef CONFIG_QUICC_ENGINE
+#define MPC83xx_IRQ_QE_HIGH	(32 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_QE_LOW	(33 + MPC83xx_IPIC_IRQ_OFFSET)
+#else
 #define MPC83xx_IRQ_TSEC1_TX	(32 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_TSEC1_RX	(33 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_TSEC1_ERROR	(34 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_TSEC2_TX	(35 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_TSEC2_RX	(36 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_TSEC2_ERROR	(37 + MPC83xx_IPIC_IRQ_OFFSET)
+#endif
 #define MPC83xx_IRQ_USB2_DR	(38 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_USB2_MPH	(39 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_EXT0	(48 + MPC83xx_IPIC_IRQ_OFFSET)
@@ -93,6 +98,29 @@ #define MPC83xx_IRQ_GTM7	(85 + MPC83xx_I
 #define MPC83xx_IRQ_GTM1	(90 + MPC83xx_IPIC_IRQ_OFFSET)
 #define MPC83xx_IRQ_GTM5	(91 + MPC83xx_IPIC_IRQ_OFFSET)
 
+#ifdef CONFIG_QUICC_ENGINE
+/* Internal IRQs on MPC83xx QE IC */
+/* Not all of these exist on all MPC83xx QE implementations */
+
+#ifndef MPC83xx_QE_IRQ_OFFSET
+#define MPC83xx_QE_IRQ_OFFSET   NR_IPIC_INTS
+#endif /* MPC83xx_QE_IRQ_OFFSET */
+
+#define MPC83xx_NR_QE_IC_INTS 64
+
+#define MPC83xx_QE_IRQ_SPI2             (1 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_SPI1             (2 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_USB              (11 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_UCC1             (32 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_UCC2             (33 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_UCC3             (34 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_UCC4             (35 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_UCC5             (40 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_UCC6             (41 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_UCC7             (42 + MPC83xx_QE_IRQ_OFFSET)
+#define MPC83xx_QE_IRQ_UCC8             (43 + MPC83xx_QE_IRQ_OFFSET)
+#endif /* CONFIG_QE */
+
 #define MPC83xx_CCSRBAR_SIZE	(1024*1024)
 
 /* Let modules/drivers get at immrbar (physical) */
@@ -109,6 +137,20 @@ enum ppc_sys_devices {
 	MPC83xx_USB2_MPH,
 	MPC83xx_MDIO,
 	NUM_PPC_SYS_DEVS,
+#ifdef CONFIG_QUICC_ENGINE
+	MPC83xx_QE_UCC1,
+	MPC83xx_QE_UCC2,
+	MPC83xx_QE_UCC3,
+	MPC83xx_QE_UCC4,
+	MPC83xx_QE_UCC5,
+	MPC83xx_QE_UCC6,
+	MPC83xx_QE_UCC7,
+	MPC83xx_QE_UCC8,
+	MPC83xx_QE_SPI1,
+	MPC83xx_QE_SPI2,
+	MPC83xx_QE_USB,
+#endif /* CONFIG_QE */
+
 };
 
 #endif /* CONFIG_83xx */
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index a3a0e07..532211c 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -83,7 +83,6 @@ struct fsl_i2c_platform_data {
 #define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
 #define FSL_I2C_DEV_CLOCK_5200		0x00000002
 
-
 enum fsl_usb2_operating_modes {
 	FSL_USB2_MPH_HOST,
 	FSL_USB2_DR_HOST,
@@ -110,5 +109,43 @@ struct fsl_usb2_platform_data {
 #define FSL_USB2_PORT0_ENABLED	0x00000001
 #define FSL_USB2_PORT1_ENABLED	0x00000002
 
+/* Ethernet interface (phy management and speed)
+*/
+typedef enum enet_interface {
+	ENET_10_MII,		/* 10 Base T,   MII interface */
+	ENET_10_RMII,		/* 10 Base T,  RMII interface */
+	ENET_10_RGMII,		/* 10 Base T, RGMII interface */
+	ENET_100_MII,		/* 100 Base T,   MII interface */
+	ENET_100_RMII,		/* 100 Base T,  RMII interface */
+	ENET_100_RGMII,		/* 100 Base T, RGMII interface */
+	ENET_1000_GMII,		/* 1000 Base T,  GMII interface */
+	ENET_1000_RGMII,	/* 1000 Base T, RGMII interface */
+	ENET_1000_TBI,		/* 1000 Base T,   TBI interface */
+	ENET_1000_RTBI		/* 1000 Base T,  RTBI interface */
+} enet_interface_e;
+
+struct ucc_geth_platform_data {
+	/* device specific information */
+	u32 device_flags;
+	u32 phy_reg_addr;
+
+	/* board specific information */
+	u32 board_flags;
+	u8 rx_clock;
+	u8 tx_clock;
+	u32 phy_id;
+	enet_interface_e phy_interface;
+	u32 phy_interrupt;
+	u8 mac_addr[6];
+};
+
+/* Flags related to UCC Gigabit Ethernet device features */
+#define FSL_UGETH_DEV_HAS_GIGABIT		0x00000001
+#define FSL_UGETH_DEV_HAS_COALESCE		0x00000002
+#define FSL_UGETH_DEV_HAS_RMON			0x00000004
+
+/* Flags in ucc_geth_platform_data */
+#define FSL_UGETH_BRD_HAS_PHY_INTR		0x00000001	/* if not set use a timer */
+
 #endif				/* _FSL_DEVICE_H_ */
 #endif				/* __KERNEL__ */
