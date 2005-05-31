Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVEaQCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVEaQCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVEaQCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:02:36 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:62946 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261891AbVEaQBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:01:37 -0400
Date: Tue, 31 May 2005 11:01:16 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Added support for new MPC8548 family of PowerQUICC
 III processors
Message-ID: <Pine.LNX.4.61.0505311058090.29294@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added descriptions of the new MPC8548 family processors, e500 core and 
peripherals.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit bcaf8337eca3e379a44b110ac28e06c4da07893a
tree d4095240ac6e9edbd6b011f5d84cd282c1787a0d
parent 5e485b7975472ba4a408523deb6541e70c451842
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 31 May 2005 10:46:57 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 31 May 2005 10:46:57 -0500

 arch/ppc/kernel/cputable.c        |   14 +++
 arch/ppc/syslib/mpc85xx_devices.c |  185 +++++++++++++++++++++++++++++++++++++
 arch/ppc/syslib/mpc85xx_sys.c     |  105 +++++++++++++++++++++
 include/asm-ppc/irq.h             |    6 +
 include/asm-ppc/mpc85xx.h         |    7 +
 include/linux/fsl_devices.h       |    8 +
 6 files changed, 323 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -907,6 +907,20 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 	},
+	{ 	/* e500v2 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80210000,
+		.cpu_name		= "e500v2",
+		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB | CPU_FTR_BIG_PHYS,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_SPE_COMP |
+			PPC_FEATURE_HAS_EFP_SINGLE | PPC_FEATURE_HAS_EFP_DOUBLE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+	},
 #endif
 #if !CLASSIC_PPC
 	{	/* default match */
diff --git a/arch/ppc/syslib/mpc85xx_devices.c b/arch/ppc/syslib/mpc85xx_devices.c
--- a/arch/ppc/syslib/mpc85xx_devices.c
+++ b/arch/ppc/syslib/mpc85xx_devices.c
@@ -40,6 +40,42 @@ static struct gianfar_platform_data mpc8
 	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
 };
 
+static struct gianfar_platform_data mpc85xx_etsec1_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
+	    FSL_GIANFAR_DEV_HAS_CSUM | FSL_GIANFAR_DEV_HAS_VLAN |
+	    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH,
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
+static struct gianfar_platform_data mpc85xx_etsec2_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
+	    FSL_GIANFAR_DEV_HAS_CSUM | FSL_GIANFAR_DEV_HAS_VLAN |
+	    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH,
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
+static struct gianfar_platform_data mpc85xx_etsec3_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
+	    FSL_GIANFAR_DEV_HAS_CSUM | FSL_GIANFAR_DEV_HAS_VLAN |
+	    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH,
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
+static struct gianfar_platform_data mpc85xx_etsec4_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
+	    FSL_GIANFAR_DEV_HAS_CSUM | FSL_GIANFAR_DEV_HAS_VLAN |
+	    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH,
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
 static struct gianfar_platform_data mpc85xx_fec_pdata = {
 	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
 };
@@ -48,6 +84,10 @@ static struct fsl_i2c_platform_data mpc8
 	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
 };
 
+static struct fsl_i2c_platform_data mpc85xx_fsl_i2c2_pdata = {
+	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
+};
+
 static struct plat_serial8250_port serial_platform_data[] = {
 	[0] = {
 		.mapbase	= 0x4500,
@@ -536,6 +576,151 @@ struct platform_device ppc_sys_platform_
 		},
 	},
 #endif /* CONFIG_CPM2 */
+	[MPC85xx_eTSEC1] = {
+		.name = "fsl-gianfar",
+		.id	= 1,
+		.dev.platform_data = &mpc85xx_etsec1_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET1_OFFSET,
+				.end	= MPC85xx_ENET1_OFFSET +
+						MPC85xx_ENET1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC1_TX,
+				.end	= MPC85xx_IRQ_TSEC1_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC1_RX,
+				.end	= MPC85xx_IRQ_TSEC1_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC1_ERROR,
+				.end	= MPC85xx_IRQ_TSEC1_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_eTSEC2] = {
+		.name = "fsl-gianfar",
+		.id	= 2,
+		.dev.platform_data = &mpc85xx_etsec2_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET2_OFFSET,
+				.end	= MPC85xx_ENET2_OFFSET +
+						MPC85xx_ENET2_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC2_TX,
+				.end	= MPC85xx_IRQ_TSEC2_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC2_RX,
+				.end	= MPC85xx_IRQ_TSEC2_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC2_ERROR,
+				.end	= MPC85xx_IRQ_TSEC2_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_eTSEC3] = {
+		.name = "fsl-gianfar",
+		.id	= 3,
+		.dev.platform_data = &mpc85xx_etsec3_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET3_OFFSET,
+				.end	= MPC85xx_ENET3_OFFSET +
+						MPC85xx_ENET3_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC3_TX,
+				.end	= MPC85xx_IRQ_TSEC3_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC3_RX,
+				.end	= MPC85xx_IRQ_TSEC3_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC3_ERROR,
+				.end	= MPC85xx_IRQ_TSEC3_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_eTSEC4] = {
+		.name = "fsl-gianfar",
+		.id	= 4,
+		.dev.platform_data = &mpc85xx_etsec4_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x27000,
+				.end	= 0x27fff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC4_TX,
+				.end	= MPC85xx_IRQ_TSEC4_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC4_RX,
+				.end	= MPC85xx_IRQ_TSEC4_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC4_ERROR,
+				.end	= MPC85xx_IRQ_TSEC4_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_IIC2] = {
+		.name = "fsl-i2c",
+		.id	= 2,
+		.dev.platform_data = &mpc85xx_fsl_i2c2_pdata,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x03100,
+				.end	= 0x031ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_IIC1,
+				.end	= MPC85xx_IRQ_IIC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
 };
 
 static int __init mach_mpc85xx_fixup(struct platform_device *pdev)
diff --git a/arch/ppc/syslib/mpc85xx_sys.c b/arch/ppc/syslib/mpc85xx_sys.c
--- a/arch/ppc/syslib/mpc85xx_sys.c
+++ b/arch/ppc/syslib/mpc85xx_sys.c
@@ -110,6 +110,111 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 			MPC85xx_CPM_USB,
 		},
 	},
+	/* SVRs on 8548 rev1.0 matches for 8548/8547/8545 */
+	{
+		.ppc_sys_name	= "8548E",
+		.mask 		= 0xFFFF00F0,
+		.value 		= 0x80390010,
+		.num_devices	= 13,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_eTSEC1, MPC85xx_eTSEC2, MPC85xx_eTSEC3,
+			MPC85xx_eTSEC4, MPC85xx_IIC1, MPC85xx_IIC2,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "8548",
+		.mask 		= 0xFFFF00F0,
+		.value 		= 0x80310010,
+		.num_devices	= 12,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_eTSEC1, MPC85xx_eTSEC2, MPC85xx_eTSEC3,
+			MPC85xx_eTSEC4, MPC85xx_IIC1, MPC85xx_IIC2,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART,
+		},
+	},
+	{
+		.ppc_sys_name	= "8547E",
+		.mask 		= 0xFFFF00F0,
+		.value 		= 0x80390010,
+		.num_devices	= 13,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_eTSEC1, MPC85xx_eTSEC2, MPC85xx_eTSEC3,
+			MPC85xx_eTSEC4, MPC85xx_IIC1, MPC85xx_IIC2,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "8547",
+		.mask 		= 0xFFFF00F0,
+		.value 		= 0x80310010,
+		.num_devices	= 12,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_eTSEC1, MPC85xx_eTSEC2, MPC85xx_eTSEC3,
+			MPC85xx_eTSEC4, MPC85xx_IIC1, MPC85xx_IIC2,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART,
+		},
+	},
+	{
+		.ppc_sys_name	= "8545E",
+		.mask 		= 0xFFFF00F0,
+		.value 		= 0x80390010,
+		.num_devices	= 11,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_eTSEC1, MPC85xx_eTSEC2,
+			MPC85xx_IIC1, MPC85xx_IIC2,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "8545",
+		.mask 		= 0xFFFF00F0,
+		.value 		= 0x80310010,
+		.num_devices	= 10,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_eTSEC1, MPC85xx_eTSEC2,
+			MPC85xx_IIC1, MPC85xx_IIC2,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART,
+		},
+	},
+	{
+		.ppc_sys_name	= "8543E",
+		.mask 		= 0xFFFF00F0,
+		.value 		= 0x803A0010,
+		.num_devices	= 11,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_eTSEC1, MPC85xx_eTSEC2,
+			MPC85xx_IIC1, MPC85xx_IIC2,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "8543",
+		.mask 		= 0xFFFF00F0,
+		.value 		= 0x80320010,
+		.num_devices	= 10,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_eTSEC1, MPC85xx_eTSEC2,
+			MPC85xx_IIC1, MPC85xx_IIC2,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART,
+		},
+	},
 	{	/* default match */
 		.ppc_sys_name	= "",
 		.mask 		= 0x00000000,
diff --git a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h
+++ b/include/asm-ppc/irq.h
@@ -223,9 +223,15 @@ static __inline__ int irq_canonicalize(i
 #define MPC85xx_IRQ_RIO_RX	(12 + MPC85xx_OPENPIC_IRQ_OFFSET)
 #define MPC85xx_IRQ_TSEC1_TX	(13 + MPC85xx_OPENPIC_IRQ_OFFSET)
 #define MPC85xx_IRQ_TSEC1_RX	(14 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC3_TX	(15 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC3_RX	(16 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC3_ERROR	(17 + MPC85xx_OPENPIC_IRQ_OFFSET)
 #define MPC85xx_IRQ_TSEC1_ERROR	(18 + MPC85xx_OPENPIC_IRQ_OFFSET)
 #define MPC85xx_IRQ_TSEC2_TX	(19 + MPC85xx_OPENPIC_IRQ_OFFSET)
 #define MPC85xx_IRQ_TSEC2_RX	(20 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC4_TX	(21 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC4_RX	(22 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC4_ERROR	(23 + MPC85xx_OPENPIC_IRQ_OFFSET)
 #define MPC85xx_IRQ_TSEC2_ERROR	(24 + MPC85xx_OPENPIC_IRQ_OFFSET)
 #define MPC85xx_IRQ_FEC		(25 + MPC85xx_OPENPIC_IRQ_OFFSET)
 #define MPC85xx_IRQ_DUART	(26 + MPC85xx_OPENPIC_IRQ_OFFSET)
diff --git a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h
+++ b/include/asm-ppc/mpc85xx.h
@@ -74,7 +74,7 @@ extern unsigned char __res[];
 #define MPC85xx_GUTS_OFFSET	(0xe0000)
 #define MPC85xx_GUTS_SIZE	(0x01000)
 #define MPC85xx_IIC1_OFFSET	(0x03000)
-#define MPC85xx_IIC1_SIZE	(0x01000)
+#define MPC85xx_IIC1_SIZE	(0x00100)
 #define MPC85xx_OPENPIC_OFFSET	(0x40000)
 #define MPC85xx_OPENPIC_SIZE	(0x40000)
 #define MPC85xx_PCI1_OFFSET	(0x08000)
@@ -127,6 +127,11 @@ enum ppc_sys_devices {
 	MPC85xx_CPM_MCC2,
 	MPC85xx_CPM_SMC1,
 	MPC85xx_CPM_SMC2,
+	MPC85xx_eTSEC1,
+	MPC85xx_eTSEC2,
+	MPC85xx_eTSEC3,
+	MPC85xx_eTSEC4,
+	MPC85xx_IIC2,
 };
 
 #endif /* CONFIG_85xx */
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -51,6 +51,7 @@ struct gianfar_platform_data {
 
 	/* board specific information */
 	u32 board_flags;
+	u32 phy_flags;
 	u32 phyid;
 	u32 interruptPHY;
 	u8 mac_addr[6];
@@ -61,9 +62,14 @@ struct gianfar_platform_data {
 #define FSL_GIANFAR_DEV_HAS_COALESCE		0x00000002
 #define FSL_GIANFAR_DEV_HAS_RMON		0x00000004
 #define FSL_GIANFAR_DEV_HAS_MULTI_INTR		0x00000008
+#define FSL_GIANFAR_DEV_HAS_CSUM		0x00000010
+#define FSL_GIANFAR_DEV_HAS_VLAN		0x00000020
+#define FSL_GIANFAR_DEV_HAS_EXTENDED_HASH	0x00000040
+#define FSL_GIANFAR_DEV_HAS_PADDING		0x00000080
 
 /* Flags in gianfar_platform_data */
-#define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001	/* if not set use a timer */
+#define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001 /* set or use a timer */
+#define FSL_GIANFAR_BRD_IS_REDUCED	0x00000002 /* Set if RGMII, RMII */
 
 struct fsl_i2c_platform_data {
 	/* device specific information */
