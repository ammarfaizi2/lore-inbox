Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVHUNAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVHUNAw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 09:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVHUNAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 09:00:52 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:27851 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1750990AbVHUNAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 09:00:51 -0400
Date: Sun, 21 Aug 2005 22:00:14 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: add more SYS_SUPPORT_*_KERNEL and
 CPU_SUPPORTS_*_KERNEL
Message-Id: <20050821220014.38578c26.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The addtion of SYS_SUPPORTS_*_KERNEL and CPU_SUPPORTS_*_KERNEL is halfway.
This patch has added more SYS_SUPPORTS_*_KERNEL and CPU_SUPPORTS_*_KERNEL to arch/mips/Kconfig.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/arch/mips/Kconfig mm1/arch/mips/Kconfig
--- mm1-orig/arch/mips/Kconfig	2005-08-21 01:38:23.000000000 +0900
+++ mm1/arch/mips/Kconfig	2005-08-21 01:46:55.000000000 +0900
@@ -8,6 +8,15 @@
 
 source "init/Kconfig"
 
+config SYS_SUPPORTS_32BIT_KERNEL
+	bool
+config SYS_SUPPORTS_64BIT_KERNEL
+	bool
+config CPU_SUPPORTS_32BIT_KERNEL
+	bool
+config CPU_SUPPORTS_64BIT_KERNEL
+	bool
+
 menu "Kernel type"
 
 choice
@@ -45,6 +54,8 @@
 	select GENERIC_ISA_DMA
 	select I8259
 	select ISA
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	help
 	 This a family of machines based on the MIPS R4030 chipset which was
 	 used by several vendors to build RISC/os and Windows NT workstations.
@@ -83,6 +94,8 @@
 
 config MACH_VR41XX
 	bool "Support for NEC VR4100 series based machines"
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 
 config NEC_CMBVR4133
 	bool "Support for NEC CMB-VR4133"
@@ -166,25 +179,28 @@
 
 config TOSHIBA_JMR3927
 	bool "Support for Toshiba JMR-TX3927 board"
-	depends on 32BIT
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
 
 config MIPS_COBALT
-	bool "Support for Cobalt Server (EXPERIMENTAL)"
+	bool "Support for Cobalt Server"
 	depends on EXPERIMENTAL
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select I8259
 	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 
 config MACH_DECSTATION
 	bool "Support for DECstations"
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
 	select IRQ_CPU
-	depends on 32BIT || EXPERIMENTAL
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	---help---
 	  This enables support for DEC's MIPS based workstations.  For details
 	  see the Linux/MIPS FAQ on <http://www.linux-mips.org/> and the
@@ -206,6 +222,8 @@
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_GT64120
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  This is an evaluation board based on the Galileo GT-64120
 	  single-chip system controller that contains a MIPS R5000 compatible
@@ -226,6 +244,8 @@
 	select MIPS_GT96100
 	select RM7000_CPU_SCACHE
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  This is an evaluation board based on the Galileo GT-96100 LAN/WAN
 	  communications controllers containing a MIPS R5000 compatible core
@@ -236,6 +256,8 @@
 	bool "Support for Globespan IVR board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	help
 	  This is an evaluation board built by Globespan to showcase thir
 	  iVR (Internet Video Recorder) design. It utilizes a QED RM5231
@@ -249,6 +271,8 @@
 	select HW_HAS_PCI
 	select MIPS_GT64120
 	select R5000_CPU_SCACHE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 
 config PICVUE
 	tristate "PICVUE LCD display driver"
@@ -270,6 +294,8 @@
 	bool "Support for ITE 8172G board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	help
 	  Ths is an evaluation board made by ITE <http://www.ite.com.tw/>
 	  with ATX form factor that utilizes a MIPS R5000 to work with its
@@ -293,6 +319,8 @@
 	select HW_HAS_PCI
 	select MIPS_GT64120
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  This enables support for the QED R5231-based MIPS Atlas evaluation
 	  board.
@@ -307,6 +335,8 @@
 	select I8259
 	select MIPS_GT64120
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  This enables support for the VR5000-based MIPS Malta evaluation
 	  board.
@@ -316,6 +346,8 @@
 	depends on EXPERIMENTAL
 	select IRQ_CPU
 	select DMA_NONCOHERENT
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 
 config MOMENCO_OCELOT
 	bool "Support for Momentum Ocelot board"
@@ -326,6 +358,8 @@
 	select MIPS_GT64120
 	select RM7000_CPU_SCACHE
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  The Ocelot is a MIPS-based Single Board Computer (SBC) made by
 	  Momentum Computer <http://www.momenco.com/>.
@@ -339,6 +373,8 @@
 	select PCI_MARVELL
 	select RM7000_CPU_SCACHE
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  The Ocelot is a MIPS-based Single Board Computer (SBC) made by
 	  Momentum Computer <http://www.momenco.com/>.
@@ -352,6 +388,8 @@
 	select PCI_MARVELL
 	select RM7000_CPU_SCACHE
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  The Ocelot is a MIPS-based Single Board Computer (SBC) made by
 	  Momentum Computer <http://www.momenco.com/>.
@@ -367,6 +405,8 @@
 	select PCI_MARVELL
 	select RM7000_CPU_SCACHE
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  The Ocelot-3 is based off Discovery III System Controller and
 	  PMC-Sierra Rm79000 core.
@@ -383,6 +423,8 @@
 	select PCI_MARVELL
 	select RM7000_CPU_SCACHE
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  The Jaguar ATX is a MIPS-based Single Board Computer (SBC) made by
 	  Momentum Computer <http://www.momenco.com/>.
@@ -402,6 +444,8 @@
 	select IRQ_CPU_RM7K
 	select IRQ_CPU_RM9K
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  Yosemite is an evaluation board for the RM9000x2 processor
 	  manufactured by PMC-Sierra
@@ -419,6 +463,8 @@
 	select IRQ_CPU
 	select I8259
 	select ISA
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  This enables support for the VR5000-based NEC DDB Vrc-5074
 	  evaluation board.
@@ -431,6 +477,8 @@
 	select IRQ_CPU
 	select I8259
 	select ISA
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	help
 	  This enables support for the R5432-based NEC DDB Vrc-5476
 	  evaluation board.
@@ -445,6 +493,8 @@
 	select HW_HAS_PCI
 	select I8259
 	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	help
 	  This enables support for the R5432-based NEC DDB Vrc-5477,
 	  or Rockhopper/SolutionGear boards with R5432/R5500 CPUs.
@@ -484,6 +534,8 @@
 	select IP22_CPU_SCACHE
 	select IRQ_CPU
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  This are the SGI Indy, Challenge S and Indigo2, as well as certain
 	  OEM variants like the Tandem CMN B006S. To compile a Linux kernel
@@ -491,12 +543,12 @@
 
 config SGI_IP27
 	bool "Support for SGI IP27 (Origin200/2000)"
-	depends on 64BIT
 	select ARC
 	select ARC64
 	select DMA_IP27
 	select HW_HAS_PCI
 	select PCI_DOMAINS
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  This are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
 	  workstations.  To compile a Linux kernel that runs on these, say Y
@@ -559,7 +611,7 @@
 
 config SGI_IP32
 	bool "Support for SGI IP32 (O2) (EXPERIMENTAL)"
-	depends on 64BIT && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	select ARC
 	select ARC32
 	select BOOT_ELF32
@@ -569,12 +621,13 @@
 	select HW_HAS_PCI
 	select R5000_CPU_SCACHE
 	select RM7000_CPU_SCACHE
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  If you want this kernel to run on SGI O2 workstation, say Y here.
 
 config SOC_AU1X00
-	depends on 32BIT
 	bool "Support for AMD/Alchemy Au1X00 SOCs"
+	select SYS_SUPPORTS_32BIT_KERNEL
 
 choice
 	prompt "Au1X00 SOC Type"
@@ -686,6 +739,8 @@
 	select BOOT_ELF32
 	select DMA_COHERENT
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 
 choice
 	prompt "BCM1xxx SOC-based board"
@@ -905,6 +960,8 @@
 	select HW_HAS_PCI
 	select I8259
 	select ISA
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	help
 	  The SNI RM200 PCI was a MIPS-based platform manufactured by Siemens
 	  Nixdorf Informationssysteme (SNI), parent company of Pyramid
@@ -913,13 +970,14 @@
 
 config TOSHIBA_RBTX4927
 	bool "Support for Toshiba TBTX49[23]7 board"
-	depends on 32BIT
 	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
 	select I8259
 	select ISA
 	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	help
 	  This Toshiba board is based on the TX4927 processor. Say Y here to
 	  support this machine type
@@ -1173,13 +1231,16 @@
 
 config CPU_MIPS32
 	bool "MIPS32"
+	select CPU_SUPPORTS_32BIT_KERNEL
 
 config CPU_MIPS64
 	bool "MIPS64"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 
 config CPU_R3000
 	bool "R3000"
-	depends on MIPS32
+	select CPU_SUPPORTS_32BIT_KERNEL
 	help
 	  Please make sure to pick the right CPU type. Linux/MIPS is not
 	  designed to be generic, i.e. Kernels compiled for R3000 CPUs will
@@ -1190,10 +1251,12 @@
 
 config CPU_TX39XX
 	bool "R39XX"
-	depends on 32BIT
+	select CPU_SUPPORTS_32BIT_KERNEL
 
 config CPU_VR41XX
 	bool "R41xx"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 	help
 	  The options selects support for the NEC VR41xx series of processors.
 	  Only choose this option if you have one of these processors as a
@@ -1202,20 +1265,28 @@
 
 config CPU_R4300
 	bool "R4300"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 	help
 	  MIPS Technologies R4300-series processors.
 
 config CPU_R4X00
 	bool "R4x00"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 	help
 	  MIPS Technologies R4000-series processors other than 4300, including
 	  the R4000, R4400, R4600, and 4700.
 
 config CPU_TX49XX
 	bool "R49XX"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 
 config CPU_R5000
 	bool "R5000"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 	help
 	  MIPS Technologies R5000-series processors other than the Nevada.
 
@@ -1224,36 +1295,48 @@
 
 config CPU_R6000
 	bool "R6000"
-	depends on 32BIT && EXPERIMENTAL
+	depends on EXPERIMENTAL
+	select CPU_SUPPORTS_32BIT_KERNEL
 	help
 	  MIPS Technologies R6000 and R6000A series processors.  Note these
 	  processors are extremly rare and the support for them is incomplete.
 
 config CPU_NEVADA
 	bool "RM52xx"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 	help
 	  QED / PMC-Sierra RM52xx-series ("Nevada") processors.
 
 config CPU_R8000
 	bool "R8000"
-	depends on 64BIT && EXPERIMENTAL
+	depends on EXPERIMENTAL
+	select CPU_SUPPORTS_64BIT_KERNEL
 	help
 	  MIPS Technologies R8000 processors.  Note these processors are
 	  uncommon and the support for them is incomplete.
 
 config CPU_R10000
 	bool "R10000"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 	help
 	  MIPS Technologies R10000-series processors.
 
 config CPU_RM7000
 	bool "RM7000"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 
 config CPU_RM9000
 	bool "RM9000"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 
 config CPU_SB1
 	bool "SB1"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
 
 endchoice
 


