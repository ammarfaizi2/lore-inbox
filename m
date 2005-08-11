Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVHKVlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVHKVlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVHKVlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:41:25 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:32013 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750842AbVHKVlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:41:24 -0400
Date: Thu, 11 Aug 2005 23:41:56 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] (5/7) I2C: Kill i2c_algorithm.id
Message-Id: <20050811234156.233a01f5.khali@linux-fr.org>
In-Reply-To: <20050811231828.3e7f5837.khali@linux-fr.org>
References: <20050811231828.3e7f5837.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the algorithm id part (16 upper bits) of the i2c adapters ids
into the definition of the adapters ids directly. After that, we don't
need to OR both ids together for each i2c_adapter structure.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/algos/i2c-algo-bit.c               |    2 
 drivers/i2c/algos/i2c-algo-ite.c               |    2 
 drivers/i2c/algos/i2c-algo-pca.c               |    2 
 drivers/i2c/algos/i2c-algo-pcf.c               |    2 
 drivers/i2c/algos/i2c-algo-sgi.c               |    1 
 drivers/i2c/algos/i2c-algo-sibyte.c            |    2 
 drivers/i2c/busses/i2c-ibm_iic.c               |    2 
 drivers/i2c/busses/i2c-isa.c                   |    2 
 drivers/i2c/busses/i2c-mpc.c                   |    2 
 drivers/i2c/busses/i2c-mv64xxx.c               |    2 
 drivers/media/video/bt832.c                    |    2 
 drivers/media/video/bttv-i2c.c                 |    2 
 drivers/media/video/ir-kbd-i2c.c               |    2 
 drivers/media/video/ovcamchip/ov6x20.c         |    6 -
 drivers/media/video/ovcamchip/ov6x30.c         |    4 
 drivers/media/video/ovcamchip/ovcamchip_core.c |    8 -
 drivers/media/video/tda7432.c                  |    2 
 drivers/media/video/tda9875.c                  |    2 
 drivers/media/video/tda9887.c                  |    4 
 drivers/media/video/tuner-3036.c               |    2 
 drivers/media/video/tvaudio.c                  |    6 -
 drivers/media/video/tveeprom.c                 |    2 
 drivers/media/video/tvmixer.c                  |    6 -
 drivers/usb/media/w9968cf.c                    |    2 
 drivers/video/matrox/matroxfb_maven.c          |    2 
 include/linux/i2c-id.h                         |  128 ++++++++++++-------------
 include/linux/i2c-isa.h                        |    2 
 27 files changed, 95 insertions(+), 106 deletions(-)

--- linux-2.6.13-rc5.orig/include/linux/i2c-id.h	2005-08-02 18:31:22.000000000 +0200
+++ linux-2.6.13-rc5/include/linux/i2c-id.h	2005-08-02 21:40:11.000000000 +0200
@@ -218,103 +218,103 @@
  */
 
 /* --- Bit algorithm adapters 						*/
-#define I2C_HW_B_LP	0x00	/* Parallel port Philips style adapter	*/
-#define I2C_HW_B_LPC	0x01	/* Parallel port, over control reg.	*/
-#define I2C_HW_B_SER	0x02	/* Serial line interface		*/
-#define I2C_HW_B_ELV	0x03	/* ELV Card				*/
-#define I2C_HW_B_VELLE	0x04	/* Vellemann K8000			*/
-#define I2C_HW_B_BT848	0x05	/* BT848 video boards			*/
-#define I2C_HW_B_WNV	0x06	/* Winnov Videums			*/
-#define I2C_HW_B_VIA	0x07	/* Via vt82c586b			*/
-#define I2C_HW_B_HYDRA	0x08	/* Apple Hydra Mac I/O			*/
-#define I2C_HW_B_G400	0x09	/* Matrox G400				*/
-#define I2C_HW_B_I810	0x0a	/* Intel I810 				*/
-#define I2C_HW_B_VOO	0x0b	/* 3dfx Voodoo 3 / Banshee      	*/
-#define I2C_HW_B_PPORT  0x0c	/* Primitive parallel port adapter	*/
-#define I2C_HW_B_SAVG	0x0d	/* Savage 4                     	*/
-#define I2C_HW_B_SCX200	0x0e	/* Nat'l Semi SCx200 I2C        	*/
-#define I2C_HW_B_RIVA	0x10	/* Riva based graphics cards		*/
-#define I2C_HW_B_IOC	0x11	/* IOC bit-wiggling			*/
-#define I2C_HW_B_TSUNA  0x12	/* DEC Tsunami chipset			*/
-#define I2C_HW_B_FRODO  0x13    /* 2d3D, Inc. SA-1110 Development Board */
-#define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface (ARM)		*/
-#define I2C_HW_B_GUIDE  0x15    /* Guide bit-basher			*/
-#define I2C_HW_B_IXP2000 0x16	/* GPIO on IXP2000 systems              */
-#define I2C_HW_B_IXP4XX 0x17	/* GPIO on IXP4XX systems		*/
-#define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
-#define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
-#define I2C_HW_B_PCILYNX 0x1a	/* TI PCILynx I2C adapter		*/
-#define I2C_HW_B_CX2388x 0x1b	/* connexant 2388x based tv cards	*/
+#define I2C_HW_B_LP		0x010000 /* Parallel port Philips style */
+#define I2C_HW_B_LPC		0x010001 /* Parallel port control reg. */
+#define I2C_HW_B_SER		0x010002 /* Serial line interface */
+#define I2C_HW_B_ELV		0x010003 /* ELV Card */
+#define I2C_HW_B_VELLE		0x010004 /* Vellemann K8000 */
+#define I2C_HW_B_BT848		0x010005 /* BT848 video boards */
+#define I2C_HW_B_WNV		0x010006 /* Winnov Videums */
+#define I2C_HW_B_VIA		0x010007 /* Via vt82c586b */
+#define I2C_HW_B_HYDRA		0x010008 /* Apple Hydra Mac I/O */
+#define I2C_HW_B_G400		0x010009 /* Matrox G400 */
+#define I2C_HW_B_I810		0x01000a /* Intel I810 */
+#define I2C_HW_B_VOO		0x01000b /* 3dfx Voodoo 3 / Banshee */
+#define I2C_HW_B_PPORT		0x01000c /* Primitive parallel port adapter */
+#define I2C_HW_B_SAVG		0x01000d /* Savage 4 */
+#define I2C_HW_B_SCX200		0x01000e /* Nat'l Semi SCx200 I2C */
+#define I2C_HW_B_RIVA		0x010010 /* Riva based graphics cards */
+#define I2C_HW_B_IOC		0x010011 /* IOC bit-wiggling */
+#define I2C_HW_B_TSUNA		0x010012 /* DEC Tsunami chipset */
+#define I2C_HW_B_FRODO		0x010013 /* 2d3D SA-1110 Development Board */
+#define I2C_HW_B_OMAHA		0x010014 /* Omaha I2C interface (ARM) */
+#define I2C_HW_B_GUIDE		0x010015 /* Guide bit-basher */
+#define I2C_HW_B_IXP2000	0x010016 /* GPIO on IXP2000 systems */
+#define I2C_HW_B_IXP4XX		0x010017 /* GPIO on IXP4XX systems */
+#define I2C_HW_B_S3VIA		0x010018 /* S3Via ProSavage adapter */
+#define I2C_HW_B_ZR36067	0x010019 /* Zoran-36057/36067 based boards */
+#define I2C_HW_B_PCILYNX	0x01001a /* TI PCILynx I2C adapter */
+#define I2C_HW_B_CX2388x	0x01001b /* connexant 2388x based tv cards */
 
 /* --- PCF 8584 based algorithms					*/
-#define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
-#define I2C_HW_P_ISA	0x01	/* generic ISA Bus inteface card	*/
-#define I2C_HW_P_ELEK	0x02	/* Elektor ISA Bus inteface card	*/
+#define I2C_HW_P_LP		0x020000 /* Parallel port interface */
+#define I2C_HW_P_ISA		0x020001 /* generic ISA Bus inteface card */
+#define I2C_HW_P_ELEK		0x020002 /* Elektor ISA Bus inteface card */
 
 /* --- PCA 9564 based algorithms */
-#define I2C_HW_A_ISA	0x00	/* generic ISA Bus interface card	*/
+#define I2C_HW_A_ISA		0x1a0000 /* generic ISA Bus interface card */
 
 /* --- ACPI Embedded controller algorithms                              */
-#define I2C_HW_ACPI_EC          0x00
+#define I2C_HW_ACPI_EC          0x1f0000
 
 /* --- MPC824x PowerPC adapters						*/
-#define I2C_HW_MPC824X 0x00	/* Motorola 8240 / 8245                 */
+#define I2C_HW_MPC824X		0x100001 /* Motorola 8240 / 8245 */
 
 /* --- MPC8xx PowerPC adapters						*/
-#define I2C_HW_MPC8XX_EPON 0x00	/* Eponymous MPC8xx I2C adapter 	*/
+#define I2C_HW_MPC8XX_EPON	0x110000 /* Eponymous MPC8xx I2C adapter */
 
 /* --- ITE based algorithms						*/
-#define I2C_HW_I_IIC	0x00	/* controller on the ITE */
+#define I2C_HW_I_IIC		0x080000 /* controller on the ITE */
 
 /* --- PowerPC on-chip adapters						*/
-#define I2C_HW_OCP 0x00	/* IBM on-chip I2C adapter 	*/
+#define I2C_HW_OCP		0x120000 /* IBM on-chip I2C adapter */
 
 /* --- Broadcom SiByte adapters						*/
-#define I2C_HW_SIBYTE	0x00
+#define I2C_HW_SIBYTE		0x150000
 
 /* --- SGI adapters							*/
-#define I2C_HW_SGI_VINO	0x00
-#define I2C_HW_SGI_MACE	0x01
+#define I2C_HW_SGI_VINO		0x160000
+#define I2C_HW_SGI_MACE		0x160001
 
 /* --- XSCALE on-chip adapters                          */
-#define I2C_HW_IOP3XX 0x00
+#define I2C_HW_IOP3XX		0x140000
 
 /* --- Au1550 PSC adapters adapters					*/
-#define I2C_HW_AU1550_PSC	0x00
+#define I2C_HW_AU1550_PSC	0x1b0000
 
 /* --- SMBus only adapters						*/
-#define I2C_HW_SMBUS_PIIX4	0x00
-#define I2C_HW_SMBUS_ALI15X3	0x01
-#define I2C_HW_SMBUS_VIA2	0x02
-#define I2C_HW_SMBUS_VOODOO3	0x03
-#define I2C_HW_SMBUS_I801	0x04
-#define I2C_HW_SMBUS_AMD756	0x05
-#define I2C_HW_SMBUS_SIS5595	0x06
-#define I2C_HW_SMBUS_ALI1535	0x07
-#define I2C_HW_SMBUS_SIS630	0x08
-#define I2C_HW_SMBUS_SIS96X	0x09
-#define I2C_HW_SMBUS_AMD8111	0x0a
-#define I2C_HW_SMBUS_SCX200	0x0b
-#define I2C_HW_SMBUS_NFORCE2	0x0c
-#define I2C_HW_SMBUS_W9968CF	0x0d
-#define I2C_HW_SMBUS_OV511	0x0e	/* OV511(+) USB 1.1 webcam ICs	*/
-#define I2C_HW_SMBUS_OV518	0x0f	/* OV518(+) USB 1.1 webcam ICs	*/
-#define I2C_HW_SMBUS_OV519	0x10	/* OV519 USB 1.1 webcam IC	*/
-#define I2C_HW_SMBUS_OVFX2	0x11	/* Cypress/OmniVision FX2 webcam */
+#define I2C_HW_SMBUS_PIIX4	0x040000
+#define I2C_HW_SMBUS_ALI15X3	0x040001
+#define I2C_HW_SMBUS_VIA2	0x040002
+#define I2C_HW_SMBUS_VOODOO3	0x040003
+#define I2C_HW_SMBUS_I801	0x040004
+#define I2C_HW_SMBUS_AMD756	0x040005
+#define I2C_HW_SMBUS_SIS5595	0x040006
+#define I2C_HW_SMBUS_ALI1535	0x040007
+#define I2C_HW_SMBUS_SIS630	0x040008
+#define I2C_HW_SMBUS_SIS96X	0x040009
+#define I2C_HW_SMBUS_AMD8111	0x04000a
+#define I2C_HW_SMBUS_SCX200	0x04000b
+#define I2C_HW_SMBUS_NFORCE2	0x04000c
+#define I2C_HW_SMBUS_W9968CF	0x04000d
+#define I2C_HW_SMBUS_OV511	0x04000e /* OV511(+) USB 1.1 webcam ICs */
+#define I2C_HW_SMBUS_OV518	0x04000f /* OV518(+) USB 1.1 webcam ICs */
+#define I2C_HW_SMBUS_OV519	0x040010 /* OV519 USB 1.1 webcam IC */
+#define I2C_HW_SMBUS_OVFX2	0x040011 /* Cypress/OmniVision FX2 webcam */
 
 /* --- ISA pseudo-adapter						*/
-#define I2C_HW_ISA 0x00
+#define I2C_HW_ISA		0x050000
 
 /* --- IPMI pseudo-adapter						*/
-#define I2C_HW_IPMI 0x00
+#define I2C_HW_IPMI		0x0b0000
 
 /* --- IPMB adapter						*/
-#define I2C_HW_IPMB 0x00
+#define I2C_HW_IPMB		0x0c0000
 
 /* --- MCP107 adapter */
-#define I2C_HW_MPC107 0x00
+#define I2C_HW_MPC107		0x0d0000
 
 /* --- Marvell mv64xxx i2c adapter */
-#define I2C_HW_MV64XXX 0x00
+#define I2C_HW_MV64XXX		0x190000
 
 #endif /* LINUX_I2C_ID_H */
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-bit.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-bit.c	2005-08-02 22:14:32.000000000 +0200
@@ -539,8 +539,6 @@
 	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
 
 	/* register new adapter to i2c module... */
-
-	adap->id |= I2C_ALGO_BIT;
 	adap->algo = &i2c_bit_algo;
 
 	adap->timeout = 100;	/* default values, should	*/
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-ite.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-ite.c	2005-08-02 22:14:27.000000000 +0200
@@ -736,8 +736,6 @@
 	            adap->name));
 
 	/* register new adapter to i2c module... */
-
-	adap->id |= I2C_ALGO_IIC;
 	adap->algo = &iic_algo;
 
 	adap->timeout = 100;	/* default values, should	*/
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-pca.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-pca.c	2005-08-02 22:14:23.000000000 +0200
@@ -369,8 +369,6 @@
 	int rval;
 
 	/* register new adapter to i2c module... */
-
-	adap->id |= I2C_ALGO_PCA;
 	adap->algo = &pca_algo;
 
 	adap->timeout = 100;		/* default values, should	*/
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-pcf.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-pcf.c	2005-08-02 22:14:19.000000000 +0200
@@ -474,8 +474,6 @@
 	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
 
 	/* register new adapter to i2c module... */
-
-	adap->id |= I2C_ALGO_PCF;
 	adap->algo = &pcf_algo;
 
 	adap->timeout = 100;		/* default values, should	*/
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-sgi.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-sgi.c	2005-08-02 22:14:14.000000000 +0200
@@ -167,7 +167,6 @@
  */
 int i2c_sgi_add_bus(struct i2c_adapter *adap)
 {
-	adap->id |= I2C_ALGO_SGI;
 	adap->algo = &sgi_algo;
 
 	return i2c_add_adapter(adap);
--- linux-2.6.13-rc5.orig/drivers/i2c/algos/i2c-algo-sibyte.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/algos/i2c-algo-sibyte.c	2005-08-02 22:14:03.000000000 +0200
@@ -149,8 +149,6 @@
 	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
 
 	/* register new adapter to i2c module... */
-
-	i2c_adap->id |= I2C_ALGO_SIBYTE;
 	i2c_adap->algo = &i2c_sibyte_algo;
         
         /* Set the frequency to 100 kHz */
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-ibm_iic.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-ibm_iic.c	2005-08-02 22:13:57.000000000 +0200
@@ -725,7 +725,7 @@
 	adap = &dev->adap;
 	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
-	adap->id = I2C_ALGO_OCP | I2C_HW_OCP;
+	adap->id = I2C_HW_OCP;
 	adap->algo = &iic_algo;
 	adap->client_register = NULL;
 	adap->client_unregister = NULL;
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-isa.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-isa.c	2005-08-02 22:13:51.000000000 +0200
@@ -49,7 +49,7 @@
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
+	.id		= I2C_HW_ISA,
 	.class          = I2C_CLASS_HWMON,
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-mpc.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-mpc.c	2005-08-02 22:13:45.000000000 +0200
@@ -279,7 +279,7 @@
 static struct i2c_adapter mpc_ops = {
 	.owner = THIS_MODULE,
 	.name = "MPC adapter",
-	.id = I2C_ALGO_MPC107 | I2C_HW_MPC107,
+	.id = I2C_HW_MPC107,
 	.algo = &mpc_algo,
 	.class = I2C_CLASS_HWMON,
 	.timeout = 1,
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-mv64xxx.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-mv64xxx.c	2005-08-02 22:13:39.000000000 +0200
@@ -521,7 +521,7 @@
 	drv_data->freq_m = pdata->freq_m;
 	drv_data->freq_n = pdata->freq_n;
 	drv_data->irq = platform_get_irq(pd, 0);
-	drv_data->adapter.id = I2C_ALGO_MV64XXX | I2C_HW_MV64XXX;
+	drv_data->adapter.id = I2C_HW_MV64XXX;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
 	drv_data->adapter.owner = THIS_MODULE;
 	drv_data->adapter.class = I2C_CLASS_HWMON;
--- linux-2.6.13-rc5.orig/drivers/media/video/bt832.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/bt832.c	2005-08-02 22:13:31.000000000 +0200
@@ -188,7 +188,7 @@
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, bt832_attach);
 #else
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->id == I2C_HW_B_BT848)
 		return i2c_probe(adap, &addr_data, bt832_attach);
 #endif
 	return 0;
--- linux-2.6.13-rc5.orig/drivers/media/video/bttv-i2c.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/bttv-i2c.c	2005-08-02 22:13:21.000000000 +0200
@@ -281,7 +281,7 @@
 	.class         = I2C_CLASS_TV_ANALOG,
 #endif
 	I2C_DEVNAME("bt878"),
-	.id            = I2C_ALGO_BIT | I2C_HW_B_BT848 /* FIXME */,
+	.id            = I2C_HW_B_BT848 /* FIXME */,
 	.algo          = &bttv_algo,
 	.client_register = attach_inform,
 };
--- linux-2.6.13-rc5.orig/drivers/media/video/ir-kbd-i2c.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/ir-kbd-i2c.c	2005-08-02 22:13:11.000000000 +0200
@@ -429,7 +429,7 @@
 	struct i2c_client c; char buf; int i,rc;
 
 	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	case I2C_HW_B_BT848:
 		probe = probe_bttv;
 		break;
 	case I2C_ALGO_SAA7134:
--- linux-2.6.13-rc5.orig/drivers/media/video/ovcamchip/ov6x20.c	2004-12-24 22:34:44.000000000 +0100
+++ linux-2.6.13-rc5/drivers/media/video/ovcamchip/ov6x20.c	2005-08-02 22:13:03.000000000 +0200
@@ -164,10 +164,10 @@
 	DDEBUG(4, &c->dev, "entered");
 
 	switch (c->adapter->id) {
-	case I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV511:
+	case I2C_HW_SMBUS_OV511:
 		rc = ov_write_regvals(c, regvals_init_6x20_511);
 		break;
-	case I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518:
+	case I2C_HW_SMBUS_OV518:
 		rc = ov_write_regvals(c, regvals_init_6x20_518);
 		break;
 	default:
@@ -338,7 +338,7 @@
 	/******** Palette-specific regs ********/
 
 	/* OV518 needs 8 bit multiplexed in color mode, and 16 bit in B&W */
-	if (c->adapter->id == (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518)) {
+	if (c->adapter->id == I2C_HW_SMBUS_OV518) {
 		if (win->format == VIDEO_PALETTE_GREY)
 			ov_write_mask(c, 0x13, 0x00, 0x20);
 		else
--- linux-2.6.13-rc5.orig/drivers/media/video/ovcamchip/ov6x30.c	2004-12-24 22:35:21.000000000 +0100
+++ linux-2.6.13-rc5/drivers/media/video/ovcamchip/ov6x30.c	2005-08-02 22:12:47.000000000 +0200
@@ -301,7 +301,7 @@
 	/******** Palette-specific regs ********/
 
 	if (win->format == VIDEO_PALETTE_GREY) {
-		if (c->adapter->id == (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518)) {
+		if (c->adapter->id == I2C_HW_SMBUS_OV518) {
 			/* Do nothing - we're already in 8-bit mode */
 		} else {
 			ov_write_mask(c, 0x13, 0x20, 0x20);
@@ -313,7 +313,7 @@
 		 * Therefore, the OV6630 needs to be in 8-bit multiplexed
 		 * output mode */
 
-		if (c->adapter->id == (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518)) {
+		if (c->adapter->id == I2C_HW_SMBUS_OV518) {
 			/* Do nothing - we want to stay in 8-bit mode */
 			/* Warning: Messing with reg 0x13 breaks OV518 color */
 		} else {
--- linux-2.6.13-rc5.orig/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-06-18 09:32:24.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-08-02 22:12:25.000000000 +0200
@@ -296,10 +296,10 @@
 	 * attach to adapters that are known to contain OV camera chips. */
 
 	switch (adap->id) {
-	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV511):
-	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518):
-	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OVFX2):
-	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_W9968CF):
+	case I2C_HW_SMBUS_OV511:
+	case I2C_HW_SMBUS_OV518:
+	case I2C_HW_SMBUS_OVFX2:
+	case I2C_HW_SMBUS_W9968CF:
 		PDEBUG(1, "Adapter ID 0x%06x accepted", adap->id);
 		break;
 	default:
--- linux-2.6.13-rc5.orig/drivers/media/video/tda7432.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tda7432.c	2005-08-02 22:12:06.000000000 +0200
@@ -328,7 +328,7 @@
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda7432_attach);
 #else
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->id == I2C_HW_B_BT848)
 		return i2c_probe(adap, &addr_data, tda7432_attach);
 #endif
 	return 0;
--- linux-2.6.13-rc5.orig/drivers/media/video/tda9875.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tda9875.c	2005-08-02 22:11:59.000000000 +0200
@@ -262,7 +262,7 @@
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda9875_attach);
 #else
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->id == I2C_HW_B_BT848)
 		return i2c_probe(adap, &addr_data, tda9875_attach);
 #endif
 	return 0;
--- linux-2.6.13-rc5.orig/drivers/media/video/tda9887.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tda9887.c	2005-08-02 22:11:48.000000000 +0200
@@ -618,8 +618,8 @@
 		return i2c_probe(adap, &addr_data, tda9887_attach);
 #else
 	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_HW_B_BT848:
+	case I2C_HW_B_RIVA:
 	case I2C_ALGO_SAA7134:
 		return i2c_probe(adap, &addr_data, tda9887_attach);
 		break;
--- linux-2.6.13-rc5.orig/drivers/media/video/tuner-3036.c	2005-08-02 18:49:18.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tuner-3036.c	2005-08-02 22:11:29.000000000 +0200
@@ -165,7 +165,7 @@
 tuner_probe(struct i2c_adapter *adap)
 {
 	this_adap = 0;
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_LP))
+	if (adap->id == I2C_HW_B_LP)
 		return i2c_probe(adap, &addr_data, tuner_attach);
 	return 0;
 }
--- linux-2.6.13-rc5.orig/drivers/media/video/tvaudio.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tvaudio.c	2005-08-02 22:11:14.000000000 +0200
@@ -1098,7 +1098,7 @@
 			    /* extern	*/ TDA8425_S1_CH1, /* intern */ TDA8425_S1_OFF,
 			    /* off	*/ TDA8425_S1_OFF, /* on     */ TDA8425_S1_CH2};
 
-	if (chip->c.adapter->id == (I2C_ALGO_BIT | I2C_HW_B_RIVA)) {
+	if (chip->c.adapter->id == I2C_HW_B_RIVA) {
 		memcpy (desc->inputmap, inputmap, sizeof (inputmap));
 	}
 	return 0;
@@ -1555,8 +1555,8 @@
 		return i2c_probe(adap, &addr_data, chip_attach);
 #else
 	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_HW_B_BT848:
+	case I2C_HW_B_RIVA:
 	case I2C_ALGO_SAA7134:
 		return i2c_probe(adap, &addr_data, chip_attach);
 	}
--- linux-2.6.13-rc5.orig/drivers/media/video/tveeprom.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tveeprom.c	2005-08-02 22:08:35.000000000 +0200
@@ -534,7 +534,7 @@
 tveeprom_attach_adapter (struct i2c_adapter *adapter)
 {
 	dprintk(1,"%s: id 0x%x\n",__FUNCTION__,adapter->id);
-	if (adapter->id != (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adapter->id != I2C_HW_B_BT848)
 		return 0;
 	return i2c_probe(adapter, &addr_data, tveeprom_detect_client);
 }
--- linux-2.6.13-rc5.orig/drivers/media/video/tvmixer.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tvmixer.c	2005-08-02 22:08:24.000000000 +0200
@@ -276,9 +276,9 @@
 #else
 	/* TV card ??? */
 	switch (client->adapter->id) {
-	case I2C_ALGO_BIT | I2C_HW_SMBUS_VOODOO3:
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_HW_SMBUS_VOODOO3:
+	case I2C_HW_B_BT848:
+	case I2C_HW_B_RIVA:
 		/* ok, have a look ... */
 		break;
 	default:
--- linux-2.6.13-rc5.orig/drivers/usb/media/w9968cf.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/usb/media/w9968cf.c	2005-08-02 22:08:06.000000000 +0200
@@ -1579,7 +1579,7 @@
 	};
 
 	static struct i2c_adapter adap = {
-		.id =                I2C_ALGO_SMBUS | I2C_HW_SMBUS_W9968CF,
+		.id =                I2C_HW_SMBUS_W9968CF,
 		.class =             I2C_CLASS_CAM_DIGITAL,
 		.owner =             THIS_MODULE,
 		.client_register =   w9968cf_i2c_attach_inform,
--- linux-2.6.13-rc5.orig/drivers/video/matrox/matroxfb_maven.c	2005-08-02 18:31:14.000000000 +0200
+++ linux-2.6.13-rc5/drivers/video/matrox/matroxfb_maven.c	2005-08-02 22:08:00.000000000 +0200
@@ -1271,7 +1271,7 @@
 }
 
 static int maven_attach_adapter(struct i2c_adapter* adapter) {
-	if (adapter->id == (I2C_ALGO_BIT | I2C_HW_B_G400))
+	if (adapter->id == I2C_HW_B_G400)
 		return i2c_probe(adapter, &addr_data, &maven_detect_client);
 	return 0;
 }
--- linux-2.6.13-rc5.orig/include/linux/i2c-isa.h	2005-08-02 20:30:24.000000000 +0200
+++ linux-2.6.13-rc5/include/linux/i2c-isa.h	2005-08-02 21:49:43.000000000 +0200
@@ -29,7 +29,7 @@
 /* Detect whether we are on the isa bus. This is only useful to hybrid
    (i2c+isa) drivers. */
 #define i2c_is_isa_adapter(adapptr) \
-        ((adapptr)->id == (I2C_ALGO_ISA | I2C_HW_ISA))
+        ((adapptr)->id == I2C_HW_ISA)
 #define i2c_is_isa_client(clientptr) \
         i2c_is_isa_adapter((clientptr)->adapter)
 


-- 
Jean Delvare
