Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVADTem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVADTem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVADTel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:34:41 -0500
Received: from mail262.megamailservers.com ([216.251.41.82]:10681 "EHLO
	mail262.megamailservers.com") by vger.kernel.org with ESMTP
	id S261812AbVADTDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:03:06 -0500
X-Authenticated-User: jiri.gaisler.com
Message-ID: <41DAE89A.6060009@gaisler.com>
Date: Tue, 04 Jan 2005 20:03:54 +0100
From: Jiri Gaisler <jiri@gaisler.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: [1/7] LEON SPARC V8 processor support for linux-2.6.10
Content-Type: multipart/mixed;
 boundary="------------070308010002030608040901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070308010002030608040901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

linux-2.6.10: Kernel patches:

[1/7] diff2.6.10_include_asm_sparc.diff:  diff for include/asm-sparc

--------------070308010002030608040901
Content-Type: text/plain;
 name="diff2.6.10_include_asm_sparc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff2.6.10_include_asm_sparc.diff"

diff -Naur ../linux-2.6.10/include/asm-sparc/amba.h linux-2.6.10/include/asm-sparc/amba.h
--- ../linux-2.6.10/include/asm-sparc/amba.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/include/asm-sparc/amba.h	2005-01-03 16:44:05.000000000 +0100
@@ -0,0 +1,193 @@
+/* 
+ * Copyright (C) 2004 Konrad Eisele (eiselekd@web.de), Gaisler Research
+ */
+
+#ifndef _LEON3_AMBA_H__
+#define _LEON3_AMBA_H__
+
+/*
+ *  AMBA Plag & Play Bus Driver Macros
+ *
+ *  Macros used for AMBA Plug & Play bus scanning
+ *
+ *  COPYRIGHT (c) 2004.
+ *  Gaisler Research
+ *
+ *  The license and distribution terms for this file may be
+ *  found in the file LICENSE in this distribution or at
+ *  http://www.rtems.com/license/LICENSE.
+ *
+ */
+
+
+#define LEON3_IO_AREA 0xfff00000
+#define LEON3_CONF_AREA 0xff000
+#define LEON3_AHB_SLAVE_CONF_AREA (1 << 11)
+
+#define LEON3_AHB_CONF_WORDS 8
+#define LEON3_APB_CONF_WORDS 2
+#define LEON3_AHB_MASTERS 8
+#define LEON3_AHB_SLAVES 8
+#define LEON3_APB_SLAVES 16
+#define LEON3_APBUARTS 8
+
+/* Vendor codes */ 
+#define VENDOR_GAISLER   1
+#define VENDOR_PENDER    2
+#define VENDOR_ESA       4 
+#define VENDOR_OPENCORES 8 
+
+/* Gaisler Research device id's */
+#define GAISLER_LEON3    0x003
+#define GAISLER_LEON3DSU 0x004
+#define GAISLER_ETHAHB   0x005
+#define GAISLER_APBMST   0x006
+#define GAISLER_AHBUART  0x007
+#define GAISLER_SRCTRL   0x008
+#define GAISLER_SDCTRL   0x009
+#define GAISLER_APBUART  0x00C
+#define GAISLER_IRQMP    0x00D
+#define GAISLER_AHBRAM   0x00E
+#define GAISLER_GPTIMER  0x011
+#define GAISLER_PCITRG   0x012
+#define GAISLER_PCISBRG  0x013
+#define GAISLER_PCIFBRG  0x014
+#define GAISLER_PCITRACE 0x015
+#define GAISLER_PCIDMA   0x016
+#define GAISLER_AHBTRACE 0x017
+#define GAISLER_ETHDSU   0x018
+   
+#define GAISLER_L2TIME   0xffd /* internal device: leon2 timer */
+#define GAISLER_L2C      0xffe /* internal device: leon2compat */
+#define GAISLER_PLUGPLAY 0xfff /* internal device: plug & play configarea */
+
+
+#ifndef __ASSEMBLER__
+
+extern inline char *gaisler_device_str(int id) {
+  switch(id) {
+  case GAISLER_LEON3:    return "GAISLER_LEON3";
+  case GAISLER_LEON3DSU: return "GAISLER_LEON3DSU";
+  case GAISLER_ETHAHB:   return "GAISLER_ETHAHB";
+  case GAISLER_APBMST:   return "GAISLER_APBMST";
+  case GAISLER_AHBUART:  return "GAISLER_AHBUART";
+  case GAISLER_SRCTRL:   return "GAISLER_SRCTRL";  
+  case GAISLER_SDCTRL:   return "GAISLER_SDCTRL"; 
+  case GAISLER_APBUART:  return "GAISLER_APBUART"; 
+  case GAISLER_IRQMP:    return "GAISLER_IRQMP"; 
+  case GAISLER_AHBRAM:   return "GAISLER_AHBRAM"; 
+  case GAISLER_GPTIMER:  return "GAISLER_GPTIMER";
+  case GAISLER_PCITRG:   return "GAISLER_PCITRG"; 
+  case GAISLER_PCISBRG:  return "GAISLER_PCISBRG"; 
+  case GAISLER_PCIFBRG:  return "GAISLER_PCIFBRG"; 
+  case GAISLER_PCITRACE: return "GAISLER_PCITRACE"; 
+  case GAISLER_AHBTRACE: return "GAISLER_AHBTRACE";
+  case GAISLER_ETHDSU:   return "GAISLER_ETHDSU";
+ 
+  case GAISLER_L2TIME:   return "GAISLER_L2TIME";
+  case GAISLER_L2C:      return "GAISLER_L2C";
+  case GAISLER_PLUGPLAY: return "GAISLER_PLUGPLAY";
+    
+  default: break;
+  }
+  return 0;
+}
+
+#endif
+
+/* European Space Agency device id's */
+#define ESA_LEON2        0x2 
+#define ESA_MCTRL        0xF 
+
+
+#ifndef __ASSEMBLER__
+
+extern inline char *esa_device_str(int id) {
+  switch(id) {
+  case ESA_LEON2:  return "ESA_LEON2";
+  case ESA_MCTRL:  return "ESA_MCTRL";
+  default: break;
+  }
+  return 0;
+}
+
+#endif
+
+/* Opencores device id's */
+#define OPENCORES_PCIBR  0x4  
+#define OPENCORES_ETHMAC 0x5
+
+
+#ifndef __ASSEMBLER__
+
+extern inline char *opencores_device_str(int id) {
+  switch(id) {
+  case OPENCORES_PCIBR:  return "OPENCORES_PCIBR";
+  case OPENCORES_ETHMAC:  return "OPENCORES_ETHMAC";
+  default: break;
+  }
+  return 0;
+}
+
+extern inline char *device_id2str(int vendor, int id) {
+  switch(vendor) {
+  case VENDOR_GAISLER:    return gaisler_device_str(id);
+  case VENDOR_ESA:        return esa_device_str(id);
+  case VENDOR_OPENCORES:  return opencores_device_str(id);
+  case VENDOR_PENDER:
+  default: break;
+  }
+  return 0;
+}
+
+extern inline char *vendor_id2str(int vendor) {
+  switch(vendor) {
+  case VENDOR_GAISLER:    return "VENDOR_GAISLER";
+  case VENDOR_ESA:        return "VENDOR_ESA";
+  case VENDOR_OPENCORES:  return "VENDOR_OPENCORES";
+  case VENDOR_PENDER:     return "VENDOR_PENDER";
+  default: break;
+  }
+  return 0;
+}
+
+#endif
+
+/* Vendor codes */ 
+
+
+
+/* 
+ *
+ * Macros for manipulating Configuration registers  
+ *
+ */
+
+#define LEON3_BYPASS_LOAD_PA(x)	(leon_load_reg ((unsigned long)(x)))
+#define LEON3_BYPASS_STORE_PA(x,v) (leon_store_reg ((unsigned long)(x),(unsigned long)(v)))
+
+#define amba_get_confword(tab, index, word) (LEON3_BYPASS_LOAD_PA((tab).addr[(index)]+(word)))
+
+#define amba_vendor(x) (((x) >> 24) & 0xff)
+
+#define amba_device(x) (((x) >> 12) & 0xfff)
+
+#define amba_ahb_get_membar(tab, index, nr) (LEON3_BYPASS_LOAD_PA((tab).addr[(index)]+4+(nr)))
+
+#define amba_apb_get_membar(tab, index) (LEON3_BYPASS_LOAD_PA((tab).addr[(index)]+1))
+
+#define amba_membar_start(mbar) (((mbar) & 0xfff00000) & (((mbar) & 0xfff0) << 16))
+
+#define amba_iobar_start(base, iobar) ((base) | ((((iobar) & 0xfff00000)>>12) & (((iobar) & 0xfff0)<<4)) )
+
+#define amba_irq(conf) ((conf) & 0xf)
+
+#define amba_membar_type(mbar) ((mbar) & 0xf)
+
+#define AMBA_TYPE_APBIO 0x1
+#define AMBA_TYPE_MEM   0x2
+#define AMBA_TYPE_AHBIO 0x3
+
+#define AMBA_TYPE_AHBIO_ADDR(addr) (LEON3_IO_AREA | ((addr) >> 12))
+#endif
+
diff -Naur ../linux-2.6.10/include/asm-sparc/asi.h linux-2.6.10/include/asm-sparc/asi.h
--- ../linux-2.6.10/include/asm-sparc/asi.h	2004-12-24 22:34:44.000000000 +0100
+++ linux-2.6.10/include/asm-sparc/asi.h	2005-01-03 11:36:34.000000000 +0100
@@ -108,4 +108,10 @@
 
 #define ASI_M_ACTION       0x4c   /* Breakpoint Action Register (GNU/Viking) */
 
+/* FIXME: non-standard Leon ASI definition */
+#ifdef CONFIG_LEON
+#undef ASI_M_MMUREGS
+#define ASI_M_MMUREGS		0x19
+#endif /* CONFIG_LEON */
+
 #endif /* _SPARC_ASI_H */
diff -Naur ../linux-2.6.10/include/asm-sparc/leon.h linux-2.6.10/include/asm-sparc/leon.h
--- ../linux-2.6.10/include/asm-sparc/leon.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/include/asm-sparc/leon.h	2005-01-03 16:43:22.000000000 +0100
@@ -0,0 +1,270 @@
+/* 
+ * Copyright (C) 2004 Konrad Eisele (eiselekd@web.de), Gaisler Research
+ * Copyright (C) 2004 Stefan Holst (mail@s-holst.de), Uni-Stuttgart
+ */
+
+#ifndef LEON_H_INCLUDE
+#define LEON_H_INCLUDE
+
+#if defined(CONFIG_LEON) || defined(CONFIG_LEON_3)
+
+#include <linux/config.h>
+#include <asm/vaddrs.h>
+
+/* memory mapped leon control registers */
+#define LEON_PREGS	0x80000000
+#define LEON_MCFG1	0x00
+#define LEON_MCFG2	0x04
+#define LEON_ECTRL	0x08
+#define LEON_FADDR	0x0c
+#define LEON_MSTAT	0x10
+#define LEON_CCTRL	0x14
+#define LEON_PWDOWN	0x18
+#define LEON_WPROT1	0x1C
+#define LEON_WPROT2	0x20
+#define LEON_LCONF	0x24
+#define LEON_TCNT0	0x40
+#define LEON_TRLD0	0x44
+#define LEON_TCTRL0	0x48
+#define LEON_TCNT1	0x50
+#define LEON_TRLD1	0x54
+#define LEON_TCTRL1	0x58
+#define LEON_SCNT	0x60
+#define LEON_SRLD	0x64
+#define LEON_UART0	0x70
+#define LEON_UDATA0	0x70
+#define LEON_USTAT0	0x74
+#define LEON_UCTRL0	0x78
+#define LEON_USCAL0	0x7c
+#define LEON_UART1	0x80
+#define LEON_UDATA1	0x80
+#define LEON_USTAT1	0x84
+#define LEON_UCTRL1	0x88
+#define LEON_USCAL1	0x8c
+#define LEON_IMASK	0x90
+#define LEON_IPEND	0x94
+#define LEON_IFORCE	0x98
+#define LEON_ICLEAR	0x9c
+#define LEON_IOREG	0xA0
+#define LEON_IODIR	0xA4
+#define LEON_IOICONF	0xA8
+#define LEON_IPEND2	0xB0
+#define LEON_IMASK2	0xB4
+#define LEON_ISTAT2	0xB8
+#define LEON_ICLEAR2	0xBC
+
+#ifndef CONFIG_LEON_3 
+
+/* ASI codes */
+#define ASI_LEON_PCI		0x04
+#define ASI_LEON_IFLUSH		0x05
+#define ASI_LEON_DFLUSH		0x06
+#define ASI_LEON_ITAG		0x0c
+#define ASI_LEON_IDATA		0x0d
+#define ASI_LEON_DTAG		0x0e
+#define ASI_LEON_DDATA		0x0f
+#define ASI_LEON_MMUFLUSH	0x18
+#define ASI_LEON_MMUREGS	0x19
+#define ASI_LEON_BYPASS		0x1c
+#define ASI_LEON_FLUSH_PAGE	0x10
+/*
+#define ASI_LEON_FLUSH_SEGMENT	0x11
+#define ASI_LEON_FLUSH_REGION	0x12
+*/
+#define ASI_LEON_FLUSH_CTX	0x13
+#define ASI_LEON_DCTX		0x14
+#define ASI_LEON_ICTX		0x15
+#define ASI_MMU_DIAG		0x1d
+
+#else
+
+#define ASI_LEON_IFLUSH		0x10
+#define ASI_LEON_DFLUSH		0x11
+
+#define ASI_LEON_MMUFLUSH	0x18
+#define ASI_LEON_MMUREGS	0x19
+#define ASI_LEON_BYPASS		0x1c
+#define ASI_LEON_FLUSH_PAGE	0x10
+
+/*
+constant ASI_SYSR    : asi_type := "00010"; -- 0x02
+constant ASI_UINST   : asi_type := "01000"; -- 0x08
+constant ASI_SINST   : asi_type := "01001"; -- 0x09
+constant ASI_UDATA   : asi_type := "01010"; -- 0x0A
+constant ASI_SDATA   : asi_type := "01011"; -- 0x0B
+constant ASI_ITAG    : asi_type := "01100"; -- 0x0C
+constant ASI_IDATA   : asi_type := "01101"; -- 0x0D
+constant ASI_DTAG    : asi_type := "01110"; -- 0x0E
+constant ASI_DDATA   : asi_type := "01111"; -- 0x0F
+constant ASI_IFLUSH  : asi_type := "10000"; -- 0x10
+constant ASI_DFLUSH  : asi_type := "10001"; -- 0x11
+
+constant ASI_FLUSH_PAGE     : std_logic_vector(4 downto 0) := "10000";  -- 0x10 i/dcache flush page
+constant ASI_FLUSH_CTX      : std_logic_vector(4 downto 0) := "10011";  -- 0x13 i/dcache flush ctx
+
+constant ASI_DCTX           : std_logic_vector(4 downto 0) := "10100";  -- 0x14 dcache ctx
+constant ASI_ICTX           : std_logic_vector(4 downto 0) := "10101";  -- 0x15 icache ctx
+
+constant ASI_MMUFLUSHPROBE  : std_logic_vector(4 downto 0) := "11000";  -- 0x18 i/dtlb flush/(probe)
+constant ASI_MMUREGS        : std_logic_vector(4 downto 0) := "11001";  -- 0x19 mmu regs access
+constant ASI_MMU_BP         : std_logic_vector(4 downto 0) := "11100";  -- 0x1c mmu Bypass 
+constant ASI_MMU_DIAG       : std_logic_vector(4 downto 0) := "11101";  -- 0x1d mmu diagnostic 
+constant ASI_MMU_DSU        : std_logic_vector(4 downto 0) := "11111";  -- 0x1f mmu diagnostic 
+*/
+#endif
+
+/* mmu register access, ASI_LEON_MMUREGS */
+#define LEON_CNR_CTRL		0x000
+#define LEON_CNR_CTXP		0x100
+#define LEON_CNR_CTX		0x200
+#define LEON_CNR_F		0x300
+#define LEON_CNR_FADDR		0x400
+
+#define LEON_CNR_CTX_NCTX	256	/*number of MMU ctx*/
+
+#define LEON_CNR_CTRL_TLBDIS	0x80000000
+
+#define LEON_MMUTLB_ENT_MAX	64
+
+/*
+ * diagnostic access from mmutlb.vhd:
+ * 0: pte address
+ * 4: pte
+ * 8: additional flags
+ */
+#define LEON_DIAGF_LVL		0x3
+#define LEON_DIAGF_WR		0x8
+#define LEON_DIAGF_WR_SHIFT	3
+#define LEON_DIAGF_HIT		0x10
+#define LEON_DIAGF_HIT_SHIFT	4
+#define LEON_DIAGF_CTX		0x1fe0
+#define LEON_DIAGF_CTX_SHIFT	5
+#define LEON_DIAGF_VALID	0x2000
+#define LEON_DIAGF_VALID_SHIFT	13
+
+
+/*
+ *  Interrupt Sources
+ *
+ *  The interrupt source numbers directly map to the trap type and to 
+ *  the bits used in the Interrupt Clear, Interrupt Force, Interrupt Mask,
+ *  and the Interrupt Pending Registers.
+ */
+#define LEON_INTERRUPT_CORRECTABLE_MEMORY_ERROR	1
+#define LEON_INTERRUPT_UART_1_RX_TX		2
+#define LEON_INTERRUPT_UART_0_RX_TX		3
+#define LEON_INTERRUPT_EXTERNAL_0		4
+#define LEON_INTERRUPT_EXTERNAL_1		5
+#define LEON_INTERRUPT_EXTERNAL_2		6
+#define LEON_INTERRUPT_EXTERNAL_3		7
+#define LEON_INTERRUPT_TIMER1			8
+#define LEON_INTERRUPT_TIMER2			9
+#define LEON_INTERRUPT_EMPTY1			10
+#define LEON_INTERRUPT_EMPTY2			11
+#define LEON_INTERRUPT_OPEN_ETH			12
+#define LEON_INTERRUPT_EMPTY4			13
+#define LEON_INTERRUPT_EMPTY5			14
+#define LEON_INTERRUPT_EMPTY6			15
+
+/* irq masks */
+#define LEON_HARD_INT(x)	(1 << (x)) /* irq 0-15 */
+#define LEON_IRQMASK_R		0x0000fffe /* bit 15- 1 of lregs.irqmask */
+#define LEON_IRQPRIO_R		0xfffe0000 /* bit 31-17 of lregs.irqmask */
+
+/* leon uart register definitions */
+#define LEON_OFF_UDATA	0x0
+#define LEON_OFF_USTAT	0x4
+#define LEON_OFF_UCTRL	0x8
+#define LEON_OFF_USCAL	0xc
+
+#define LEON_UCTRL_RE	0x01
+#define LEON_UCTRL_TE	0x02
+#define LEON_UCTRL_RI	0x04
+#define LEON_UCTRL_TI	0x08
+#define LEON_UCTRL_PS	0x10
+#define LEON_UCTRL_PE	0x20
+#define LEON_UCTRL_FL	0x40
+#define LEON_UCTRL_LB	0x80
+
+#define LEON_USTAT_DR	0x01
+#define LEON_USTAT_TS	0x02
+#define LEON_USTAT_TH	0x04
+#define LEON_USTAT_BR	0x08
+#define LEON_USTAT_OV	0x10
+#define LEON_USTAT_PE	0x20
+#define LEON_USTAT_FE	0x40
+
+#define LEON_MCFG2_SRAMDIS		0x00002000
+#define LEON_MCFG2_SDRAMEN		0x00004000
+#define LEON_MCFG2_SRAMBANKSZ		0x00001e00	/* [12-9] */
+#define LEON_MCFG2_SRAMBANKSZ_SHIFT	9
+#define LEON_MCFG2_SDRAMBANKSZ		0x03800000	/* [25-23] */
+#define LEON_MCFG2_SDRAMBANKSZ_SHIFT	23
+
+#define LEON_TCNT0_MASK	0x7fffff
+
+#define LEON_USTAT_ERROR (LEON_USTAT_OV|LEON_USTAT_PE|LEON_USTAT_FE) /*no break yet*/
+
+#ifdef CONFIG_OPEN_ETH
+#define LEON_ETH_BASE_ADD ((unsigned long)LEON_VA_ETHERMAC)
+/* map leon on ethermac adress space at pa 0xb0000000 */
+#define LEON_VA_ETHERMAC     DVMA_VADDR 
+#endif
+
+#ifndef __ASSEMBLY__
+ 
+/* do a physical address bypass write, i.e. for 0x80000000 */
+static __inline__ void leon_store_reg(unsigned long paddr,unsigned long value)
+{
+	__asm__ __volatile__("sta %0, [%1] %2\n\t": :
+			     "r" (value), "r" (paddr),
+			     "i" (ASI_LEON_BYPASS) : "memory");
+}
+
+/* do a physical address bypass load, i.e. for 0x80000000 */
+static __inline__ unsigned long leon_load_reg(unsigned long paddr)
+{
+	unsigned long retval;
+	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+			     "=r" (retval) :
+			     "r" (paddr), "i" (ASI_LEON_BYPASS));
+	return retval;
+}
+
+extern __inline__ void leon_srmmu_disabletlb(void)
+{
+	unsigned int retval;
+	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r" (retval) : "r" (0), "i" (ASI_LEON_MMUREGS));
+	retval |= LEON_CNR_CTRL_TLBDIS;
+	__asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r" (retval), "r" (0), "i" (ASI_LEON_MMUREGS) : "memory");
+}
+
+extern __inline__ void leon_srmmu_enabletlb(void)
+{
+	unsigned int retval;
+	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r" (retval) : "r" (0), "i" (ASI_LEON_MMUREGS));
+	retval = retval & ~LEON_CNR_CTRL_TLBDIS;
+	__asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r" (retval), "r" (0), "i" (ASI_LEON_MMUREGS) : "memory");
+}
+
+#define LEON_BYPASS_LOAD_PA(x)		leon_load_reg ((unsigned long)(x))
+#define LEON_BYPASS_STORE_PA(x,v)	leon_store_reg((unsigned long)(x),(unsigned long)(v))
+#define LEON_REGLOAD_PA(x)		leon_load_reg ((unsigned long)(x)+LEON_PREGS)
+#define LEON_REGSTORE_PA(x,v)		leon_store_reg((unsigned long)(x)+LEON_PREGS,(unsigned long)(v))
+#define LEON_REGSTORE_OR_PA(x,v)	LEON_REGSTORE_PA(x,LEON_REGLOAD_PA(x)|(unsigned long)(v))
+#define LEON_REGSTORE_AND_PA(x,v)	LEON_REGSTORE_PA(x,LEON_REGLOAD_PA(x)&(unsigned long)(v))
+
+extern unsigned long srmmu_swprobe(unsigned long vaddr,unsigned long *paddr);
+extern void leon_inherit_prom_mappings(unsigned long start,unsigned long end);
+
+#define LEONSETUP_MEM_BASEADDR 0x40000000
+
+#endif /* !ASM */
+
+#ifdef CONFIG_LEON_3
+#include <asm/leon3.h>
+#endif
+
+#endif //defined(CONFIG_LEON) || defined(CONFIG_LEON_3)
+
+#endif
diff -Naur ../linux-2.6.10/include/asm-sparc/leon3.h linux-2.6.10/include/asm-sparc/leon3.h
--- ../linux-2.6.10/include/asm-sparc/leon3.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/include/asm-sparc/leon3.h	2005-01-03 16:44:11.000000000 +0100
@@ -0,0 +1,123 @@
+/* 
+ * Copyright (C) 2004 Konrad Eisele (eiselekd@web.de), Gaisler Research
+ */
+
+#ifndef _INCLUDE_LEON_3_h_
+#define _INCLUDE_LEON_3_h_
+
+#include <asm/amba.h>
+
+#ifndef __ASSEMBLER__
+
+/*
+ *  The following defines the bits in the LEON UART Status Registers.
+ */
+
+#define LEON_REG_UART_STATUS_DR   0x00000001 /* Data Ready */
+#define LEON_REG_UART_STATUS_TSE  0x00000002 /* TX Send Register Empty */
+#define LEON_REG_UART_STATUS_THE  0x00000004 /* TX Hold Register Empty */
+#define LEON_REG_UART_STATUS_BR   0x00000008 /* Break Error */
+#define LEON_REG_UART_STATUS_OE   0x00000010 /* RX Overrun Error */
+#define LEON_REG_UART_STATUS_PE   0x00000020 /* RX Parity Error */
+#define LEON_REG_UART_STATUS_FE   0x00000040 /* RX Framing Error */
+#define LEON_REG_UART_STATUS_ERR  0x00000078 /* Error Mask */
+
+ 
+/*
+ *  The following defines the bits in the LEON UART Ctrl Registers.
+ */
+
+#define LEON_REG_UART_CTRL_RE     0x00000001 /* Receiver enable */
+#define LEON_REG_UART_CTRL_TE     0x00000002 /* Transmitter enable */
+#define LEON_REG_UART_CTRL_RI     0x00000004 /* Receiver interrupt enable */
+#define LEON_REG_UART_CTRL_TI     0x00000008 /* Transmitter interrupt enable */
+#define LEON_REG_UART_CTRL_PS     0x00000010 /* Parity select */
+#define LEON_REG_UART_CTRL_PE     0x00000020 /* Parity enable */
+#define LEON_REG_UART_CTRL_FL     0x00000040 /* Flow control enable */
+#define LEON_REG_UART_CTRL_LB     0x00000080 /* Loop Back enable */
+
+#define LEON3_GPTIMER_EN 1
+#define LEON3_GPTIMER_RL 2
+#define LEON3_GPTIMER_LD 4
+#define LEON3_GPTIMER_IRQEN 8
+
+
+typedef struct {
+  volatile unsigned int ilevel;
+  volatile unsigned int ipend;
+  volatile unsigned int iforce;
+  volatile unsigned int iclear;
+  volatile unsigned int notused00;
+  volatile unsigned int notused01;
+  volatile unsigned int notused02;
+  volatile unsigned int notused03;
+  volatile unsigned int notused10;
+  volatile unsigned int notused11;
+  volatile unsigned int notused12;
+  volatile unsigned int notused13;
+  volatile unsigned int notused20;
+  volatile unsigned int notused21;
+  volatile unsigned int notused22;
+  volatile unsigned int notused23;
+  volatile unsigned int mask[16];
+} LEON3_IrqCtrl_Regs_Map; 
+
+typedef struct {
+  volatile unsigned int data;
+  volatile unsigned int status;
+  volatile unsigned int ctrl;
+  volatile unsigned int scaler;
+} LEON3_APBUART_Regs_Map;
+
+
+typedef struct {
+  volatile unsigned int val;
+  volatile unsigned int rld;
+  volatile unsigned int ctrl;
+  volatile unsigned int unused;
+} LEON3_GpTimerElem_Regs_Map; 
+
+typedef struct {
+  volatile unsigned int scalar;
+  volatile unsigned int scalar_reload;
+  volatile unsigned int config;
+  volatile unsigned int unused;
+  volatile LEON3_GpTimerElem_Regs_Map e[8];
+} LEON3_GpTimer_Regs_Map; 
+
+/*
+ *  Types and structure used for AMBA Plug & Play bus scanning 
+ */
+
+typedef struct amba_device_table {
+  int            devnr;           /* numbrer of devices on AHB or APB bus */
+  unsigned int   *addr[16];       /* addresses to the devices configuration tables */
+  unsigned int   allocbits[1];       /* 0=unallocated, 1=allocated driver */
+} amba_device_table;
+
+typedef struct amba_confarea_type {
+  amba_device_table ahbmst;
+  amba_device_table ahbslv;
+  amba_device_table apbslv;
+  unsigned int      apbmst;
+} amba_confarea_type;
+
+extern unsigned long amba_find_apbslv_addr(unsigned long vendor, unsigned long device, unsigned long *irq);
+
+// collect apb slaves
+typedef struct amba_apb_device {
+  unsigned int   start, irq;
+} amba_apb_device;
+extern int amba_get_free_apbslv_devices (int vendor, int device, amba_apb_device *dev,int nr);
+
+// collect ahb slaves
+typedef struct amba_ahb_device {
+  unsigned int   start[4], irq;
+} amba_ahb_device;
+extern int amba_get_free_ahbslv_devices (int vendor, int device, amba_ahb_device *dev,int nr);
+
+#endif //!__ASSEMBLER__
+
+
+#endif 
+
diff -Naur ../linux-2.6.10/include/asm-sparc/machines.h linux-2.6.10/include/asm-sparc/machines.h
--- ../linux-2.6.10/include/asm-sparc/machines.h	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10/include/asm-sparc/machines.h	2005-01-03 11:36:34.000000000 +0100
@@ -15,7 +15,7 @@
 /* Current number of machines we know about that has an IDPROM
  * machtype entry including one entry for the 0x80 OBP machines.
  */
-#define NUM_SUN_MACHINES   15
+#define NUM_SUN_MACHINES   16
 
 extern struct Sun_Machine_Models Sun_Machines[NUM_SUN_MACHINES];
 
@@ -32,6 +32,7 @@
 
 #define SM_ARCH_MASK  0xf0
 #define SM_SUN4       0x20
+#define  M_LEON2      0x30
 #define SM_SUN4C      0x50
 #define SM_SUN4M      0x70
 #define SM_SUN4M_OBP  0x80
@@ -43,6 +44,9 @@
 #define SM_4_330      0x03    /* Sun 4/300 series */
 #define SM_4_470      0x04    /* Sun 4/400 series */
 
+/* Leon machines */
+#define M_LEON2_SOC   0x01    /* Leon2 SoC */
+
 /* Sun4c machines                Full Name              - PROM NAME */
 #define SM_4C_SS1     0x01    /* Sun4c SparcStation 1   - Sun 4/60  */
 #define SM_4C_IPC     0x02    /* Sun4c SparcStation IPC - Sun 4/40  */
diff -Naur ../linux-2.6.10/include/asm-sparc/system.h linux-2.6.10/include/asm-sparc/system.h
--- ../linux-2.6.10/include/asm-sparc/system.h	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10/include/asm-sparc/system.h	2005-01-03 11:36:34.000000000 +0100
@@ -29,6 +29,7 @@
   sun4u       = 0x05, /* V8 ploos ploos */
   sun_unknown = 0x06,
   ap1000      = 0x07, /* almost a sun4m */
+  sparc_leon  = 0x08, /* Leon2 SoC */
 };
 
 /* Really, userland should not be looking at any of this... */
diff -Naur ../linux-2.6.10/include/asm-sparc/vaddrs.h linux-2.6.10/include/asm-sparc/vaddrs.h
--- ../linux-2.6.10/include/asm-sparc/vaddrs.h	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10/include/asm-sparc/vaddrs.h	2005-01-03 16:38:41.000000000 +0100
@@ -17,7 +17,11 @@
 #define SRMMU_NOCACHE_VADDR	(KERNBASE + SRMMU_MAXMEM)
 				/* = 0x0fc000000 */
 /* XXX Empiricals - this needs to go away - KMW */
+#if defined(CONFIG_LEON) || defined(CONFIG_LEON_3)
+#define SRMMU_MIN_NOCACHE_PAGES (128)
+#else
 #define SRMMU_MIN_NOCACHE_PAGES (550)
+#endif
 #define SRMMU_MAX_NOCACHE_PAGES	(1280)
 
 /* The following constant is used in mm/srmmu.c::srmmu_nocache_calcsize()

--------------070308010002030608040901--
