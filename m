Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTIVXrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTIVXrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:47:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:9121 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262465AbTIVXas convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:48 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064273423404@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734231255@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:23 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.14, 2003/09/22 12:46:46-07:00, greg@kroah.com

[PATCH] I2C: move i2c-prosavage.c driver to drivers/i2c/busses where it belongs.


 drivers/i2c/i2c-prosavage.c        |  356 -------------------------------------
 drivers/i2c/Kconfig                |   14 -
 drivers/i2c/Makefile               |    1 
 drivers/i2c/busses/Kconfig         |   14 +
 drivers/i2c/busses/Makefile        |    1 
 drivers/i2c/busses/i2c-prosavage.c |  356 +++++++++++++++++++++++++++++++++++++
 6 files changed, 371 insertions(+), 371 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Sep 22 16:13:48 2003
+++ b/drivers/i2c/Kconfig	Mon Sep 22 16:13:48 2003
@@ -48,20 +48,6 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-bit.
 
-config I2C_PROSAVAGE
-	tristate "S3/VIA (Pro)Savage"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
-	help
-	  If you say yes to this option, support will be included for the
-	  I2C bus and DDC bus of the S3VIA embedded Savage4 and ProSavage8
-	  graphics processors.
-	  chipsets supported:
-	    S3/VIA KM266/VT8375 aka ProSavage8
-	    S3/VIA KM133/VT8365 aka Savage4
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-prosavage.
-
 config I2C_PHILIPSPAR
 	tristate "Philips style parallel port adapter"
 	depends on I2C_ALGOBIT && PARPORT
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Mon Sep 22 16:13:48 2003
+++ b/drivers/i2c/Makefile	Mon Sep 22 16:13:48 2003
@@ -5,7 +5,6 @@
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
-obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
 obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
 obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
 obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:13:48 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:13:48 2003
@@ -113,6 +113,20 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-piix4.
 
+config I2C_PROSAVAGE
+	tristate "S3/VIA (Pro)Savage"
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for the
+	  I2C bus and DDC bus of the S3VIA embedded Savage4 and ProSavage8
+	  graphics processors.
+	  chipsets supported:
+	    S3/VIA KM266/VT8375 aka ProSavage8
+	    S3/VIA KM133/VT8365 aka Savage4
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-prosavage.
+
 config I2C_SAVAGE4
 	tristate "S3 Savage 4"
 	depends on I2C && PCI && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:13:48 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:13:48 2003
@@ -11,6 +11,7 @@
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
+obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
 obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-prosavage.c	Mon Sep 22 16:13:48 2003
@@ -0,0 +1,356 @@
+/*
+ *    kernel/busses/i2c-prosavage.c
+ *
+ *    i2c bus driver for S3/VIA 8365/8375 graphics processor.
+ *    Copyright (c) 2003 Henk Vergonet <henk@god.dyndns.org>
+ *    Based on code written by:
+ *	Frodo Looijaard <frodol@dds.nl>,
+ *	Philip Edelbrock <phil@netroedge.com>,
+ *	Ralph Metzler <rjkm@thp.uni-koeln.de>, and
+ *	Mark D. Studebaker <mdsxyz123@yahoo.com>
+ *	Simon Vogl
+ *	and others
+ *
+ *    Please read the lm_sensors documentation for details on use.
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+/*  18-05-2003 HVE - created
+ *  14-06-2003 HVE - adapted for lm_sensors2
+ *  17-06-2003 HVE - linux 2.5.xx compatible
+ *  18-06-2003 HVE - codingstyle
+ *  21-06-2003 HVE - compatibility lm_sensors2 and linux 2.5.xx
+ *		     codingstyle, mmio enabled
+ *
+ *  This driver interfaces to the I2C bus of the VIA north bridge embedded
+ *  ProSavage4/8 devices. Usefull for gaining access to the TV Encoder chips.
+ *
+ *  Graphics cores:
+ *   S3/VIA KM266/VT8375 aka ProSavage8
+ *   S3/VIA KM133/VT8365 aka Savage4
+ *
+ *  Two serial busses are implemented:
+ *   SERIAL1 - I2C serial communications interface
+ *   SERIAL2 - DDC2 monitor communications interface
+ *
+ *  Tested on a FX41 mainboard, see http://www.shuttle.com
+ * 
+ *
+ *  TODO:
+ *  - integration with prosavage framebuffer device
+ *    (Additional documentation needed :(
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/io.h>
+
+
+/*
+ * driver configuration
+ */
+#define	DRIVER_ID	"i2c-prosavage"
+#define	DRIVER_VERSION	"20030621"
+
+#define ADAPTER_NAME(x) (x).name
+
+#define MAX_BUSSES	2
+
+struct s_i2c_bus {
+	u8	*mmvga;
+	int	i2c_reg;
+	int	adap_ok;
+	struct i2c_adapter		adap;
+	struct i2c_algo_bit_data	algo;
+};
+
+struct s_i2c_chip {
+	u8	*mmio;
+	struct s_i2c_bus	i2c_bus[MAX_BUSSES];
+};
+
+
+/*
+ * i2c configuration
+ */
+#ifndef I2C_HW_B_S3VIA
+#define I2C_HW_B_S3VIA	0x18	/* S3VIA ProSavage adapter		*/
+#endif
+
+/* delays */
+#define CYCLE_DELAY	10
+#define TIMEOUT		(HZ / 2)
+
+
+/* 
+ * S3/VIA 8365/8375 registers
+ */
+#ifndef PCI_VENDOR_ID_S3
+#define PCI_VENDOR_ID_S3		0x5333
+#endif
+#ifndef PCI_DEVICE_ID_S3_SAVAGE4
+#define PCI_DEVICE_ID_S3_SAVAGE4	0x8a25
+#endif
+#ifndef PCI_DEVICE_ID_S3_PROSAVAGE8
+#define PCI_DEVICE_ID_S3_PROSAVAGE8	0x8d04
+#endif
+
+#define VGA_CR_IX	0x3d4
+#define VGA_CR_DATA	0x3d5
+
+#define CR_SERIAL1	0xa0	/* I2C serial communications interface */
+#define MM_SERIAL1	0xff20
+#define CR_SERIAL2	0xb1	/* DDC2 monitor communications interface */
+
+/* based on vt8365 documentation */
+#define I2C_ENAB	0x10
+#define I2C_SCL_OUT	0x01
+#define I2C_SDA_OUT	0x02
+#define I2C_SCL_IN	0x04
+#define I2C_SDA_IN	0x08
+
+#define SET_CR_IX(p, val)	*((p)->mmvga + VGA_CR_IX) = (u8)(val)
+#define SET_CR_DATA(p, val)	*((p)->mmvga + VGA_CR_DATA) = (u8)(val)
+#define GET_CR_DATA(p)		*((p)->mmvga + VGA_CR_DATA)
+
+
+/*
+ * Serial bus line handling
+ *
+ * serial communications register as parameter in private data
+ *
+ * TODO: locks with other code sections accessing video registers?
+ */
+static void bit_s3via_setscl(void *bus, int val)
+{
+	struct s_i2c_bus *p = (struct s_i2c_bus *)bus;
+	unsigned int r;
+
+	SET_CR_IX(p, p->i2c_reg);
+	r = GET_CR_DATA(p);
+	r |= I2C_ENAB;
+	if (val) {
+		r |= I2C_SCL_OUT;
+	} else {
+		r &= ~I2C_SCL_OUT;
+	}
+	SET_CR_DATA(p, r);
+}
+
+static void bit_s3via_setsda(void *bus, int val)
+{
+	struct s_i2c_bus *p = (struct s_i2c_bus *)bus;
+	unsigned int r;
+	
+	SET_CR_IX(p, p->i2c_reg);
+	r = GET_CR_DATA(p);
+	r |= I2C_ENAB;
+	if (val) {
+		r |= I2C_SDA_OUT;
+	} else {
+		r &= ~I2C_SDA_OUT;
+	}
+	SET_CR_DATA(p, r);
+}
+
+static int bit_s3via_getscl(void *bus)
+{
+	struct s_i2c_bus *p = (struct s_i2c_bus *)bus;
+
+	SET_CR_IX(p, p->i2c_reg);
+	return (0 != (GET_CR_DATA(p) & I2C_SCL_IN));
+}
+
+static int bit_s3via_getsda(void *bus)
+{
+	struct s_i2c_bus *p = (struct s_i2c_bus *)bus;
+
+	SET_CR_IX(p, p->i2c_reg);
+	return (0 != (GET_CR_DATA(p) & I2C_SDA_IN));
+}
+
+
+/*
+ * adapter initialisation
+ */
+static int i2c_register_bus(struct s_i2c_bus *p, u8 *mmvga, u32 i2c_reg)
+{
+	int ret;
+	p->adap.owner	  = THIS_MODULE;
+	p->adap.id	  = I2C_HW_B_S3VIA;
+	p->adap.algo_data = &p->algo;
+	p->algo.setsda	  = bit_s3via_setsda;
+	p->algo.setscl	  = bit_s3via_setscl;
+	p->algo.getsda	  = bit_s3via_getsda;
+	p->algo.getscl	  = bit_s3via_getscl;
+	p->algo.udelay	  = CYCLE_DELAY;
+	p->algo.mdelay	  = CYCLE_DELAY;
+	p->algo.timeout	  = TIMEOUT;
+	p->algo.data	  = p;
+	p->mmvga	  = mmvga;
+	p->i2c_reg	  = i2c_reg;
+    
+	ret = i2c_bit_add_bus(&p->adap);
+	if (ret) {
+		return ret;
+	}
+
+	p->adap_ok = 1;
+	return 0;
+}
+
+
+/*
+ * Cleanup stuff
+ */
+static void __devexit prosavage_remove(struct pci_dev *dev)
+{
+	struct s_i2c_chip *chip;
+	int i, ret;
+
+	chip = (struct s_i2c_chip *)pci_get_drvdata(dev);
+
+	if (!chip) {
+		return;
+	}
+	for (i = MAX_BUSSES - 1; i >= 0; i--) {
+		if (chip->i2c_bus[i].adap_ok == 0)
+			continue;
+
+		ret = i2c_bit_del_bus(&chip->i2c_bus[i].adap);
+	        if (ret) {
+			printk(DRIVER_ID ": %s not removed\n",
+				ADAPTER_NAME(chip->i2c_bus[i].adap));
+		}
+	}
+	if (chip->mmio) {
+		iounmap(chip->mmio);
+	}
+	kfree(chip);
+}
+
+
+/*
+ * Detect chip and initialize it
+ */
+static int __devinit prosavage_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	int ret;
+	unsigned long base, len;
+	struct s_i2c_chip *chip;
+	struct s_i2c_bus  *bus;
+
+        pci_set_drvdata(dev, kmalloc(sizeof(struct s_i2c_chip), GFP_KERNEL)); 
+	chip = (struct s_i2c_chip *)pci_get_drvdata(dev);
+	if (chip == NULL) {
+		return -ENOMEM;
+	}
+
+	memset(chip, 0, sizeof(struct s_i2c_chip));
+
+	base = dev->resource[0].start & PCI_BASE_ADDRESS_MEM_MASK;
+	len  = dev->resource[0].end - base + 1;
+	chip->mmio = ioremap_nocache(base, len);
+
+	if (chip->mmio == NULL) {
+		printk (DRIVER_ID ": ioremap failed\n");
+		prosavage_remove(dev);
+		return -ENODEV;
+	}
+
+
+	/*
+	 * Chip initialisation
+	 */
+	/* Unlock Extended IO Space ??? */
+
+
+	/*
+	 * i2c bus registration
+	 */
+	bus = &chip->i2c_bus[0];
+	snprintf(ADAPTER_NAME(bus->adap), sizeof(ADAPTER_NAME(bus->adap)),
+		"ProSavage I2C bus at %02x:%02x.%x",
+		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	ret = i2c_register_bus(bus, chip->mmio + 0x8000, CR_SERIAL1);
+	if (ret) {
+		goto err_adap;
+	}
+	/*
+	 * ddc bus registration
+	 */
+	bus = &chip->i2c_bus[1];
+	snprintf(ADAPTER_NAME(bus->adap), sizeof(ADAPTER_NAME(bus->adap)),
+		"ProSavage DDC bus at %02x:%02x.%x",
+		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	ret = i2c_register_bus(bus, chip->mmio + 0x8000, CR_SERIAL2);
+	if (ret) {
+		goto err_adap;
+	}
+	return 0;
+err_adap:
+	printk (DRIVER_ID ": %s failed\n", ADAPTER_NAME(bus->adap));
+	prosavage_remove(dev);
+	return ret;
+}
+
+
+/*
+ * Data for PCI driver interface
+ */
+static struct pci_device_id prosavage_pci_tbl[] = {
+   {
+	.vendor		=	PCI_VENDOR_ID_S3,
+	.device		=	PCI_DEVICE_ID_S3_SAVAGE4,
+	.subvendor	=	PCI_ANY_ID,
+	.subdevice	=	PCI_ANY_ID,
+   },{
+	.vendor		=	PCI_VENDOR_ID_S3,
+	.device		=	PCI_DEVICE_ID_S3_PROSAVAGE8,
+	.subvendor	=	PCI_ANY_ID,
+	.subdevice	=	PCI_ANY_ID,
+   },{ 0, }
+};
+
+static struct pci_driver prosavage_driver = {
+	.name		=	"prosavage-smbus",
+	.id_table	=	prosavage_pci_tbl,
+	.probe		=	prosavage_probe,
+	.remove		=	__devexit_p(prosavage_remove),
+};
+
+static int __init i2c_prosavage_init(void)
+{
+	printk(DRIVER_ID " version %s (%s)\n", I2C_VERSION, DRIVER_VERSION);
+	return pci_module_init(&prosavage_driver);
+}
+
+static void __exit i2c_prosavage_exit(void)
+{
+	pci_unregister_driver(&prosavage_driver);
+}
+
+MODULE_DEVICE_TABLE(pci, prosavage_pci_tbl);
+MODULE_AUTHOR("Henk Vergonet");
+MODULE_DESCRIPTION("ProSavage VIA 8365/8375 smbus driver");
+MODULE_LICENSE("GPL");
+
+module_init (i2c_prosavage_init);
+module_exit (i2c_prosavage_exit);
diff -Nru a/drivers/i2c/i2c-prosavage.c b/drivers/i2c/i2c-prosavage.c
--- a/drivers/i2c/i2c-prosavage.c	Mon Sep 22 16:13:48 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,356 +0,0 @@
-/*
- *    kernel/busses/i2c-prosavage.c
- *
- *    i2c bus driver for S3/VIA 8365/8375 graphics processor.
- *    Copyright (c) 2003 Henk Vergonet <henk@god.dyndns.org>
- *    Based on code written by:
- *	Frodo Looijaard <frodol@dds.nl>,
- *	Philip Edelbrock <phil@netroedge.com>,
- *	Ralph Metzler <rjkm@thp.uni-koeln.de>, and
- *	Mark D. Studebaker <mdsxyz123@yahoo.com>
- *	Simon Vogl
- *	and others
- *
- *    Please read the lm_sensors documentation for details on use.
- *
- *    This program is free software; you can redistribute it and/or modify
- *    it under the terms of the GNU General Public License as published by
- *    the Free Software Foundation; either version 2 of the License, or
- *    (at your option) any later version.
- *
- *    This program is distributed in the hope that it will be useful,
- *    but WITHOUT ANY WARRANTY; without even the implied warranty of
- *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *    GNU General Public License for more details.
- *
- *    You should have received a copy of the GNU General Public License
- *    along with this program; if not, write to the Free Software
- *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-/*  18-05-2003 HVE - created
- *  14-06-2003 HVE - adapted for lm_sensors2
- *  17-06-2003 HVE - linux 2.5.xx compatible
- *  18-06-2003 HVE - codingstyle
- *  21-06-2003 HVE - compatibility lm_sensors2 and linux 2.5.xx
- *		     codingstyle, mmio enabled
- *
- *  This driver interfaces to the I2C bus of the VIA north bridge embedded
- *  ProSavage4/8 devices. Usefull for gaining access to the TV Encoder chips.
- *
- *  Graphics cores:
- *   S3/VIA KM266/VT8375 aka ProSavage8
- *   S3/VIA KM133/VT8365 aka Savage4
- *
- *  Two serial busses are implemented:
- *   SERIAL1 - I2C serial communications interface
- *   SERIAL2 - DDC2 monitor communications interface
- *
- *  Tested on a FX41 mainboard, see http://www.shuttle.com
- * 
- *
- *  TODO:
- *  - integration with prosavage framebuffer device
- *    (Additional documentation needed :(
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-
-#include <asm/io.h>
-
-
-/*
- * driver configuration
- */
-#define	DRIVER_ID	"i2c-prosavage"
-#define	DRIVER_VERSION	"20030621"
-
-#define ADAPTER_NAME(x) (x).name
-
-#define MAX_BUSSES	2
-
-struct s_i2c_bus {
-	u8	*mmvga;
-	int	i2c_reg;
-	int	adap_ok;
-	struct i2c_adapter		adap;
-	struct i2c_algo_bit_data	algo;
-};
-
-struct s_i2c_chip {
-	u8	*mmio;
-	struct s_i2c_bus	i2c_bus[MAX_BUSSES];
-};
-
-
-/*
- * i2c configuration
- */
-#ifndef I2C_HW_B_S3VIA
-#define I2C_HW_B_S3VIA	0x18	/* S3VIA ProSavage adapter		*/
-#endif
-
-/* delays */
-#define CYCLE_DELAY	10
-#define TIMEOUT		(HZ / 2)
-
-
-/* 
- * S3/VIA 8365/8375 registers
- */
-#ifndef PCI_VENDOR_ID_S3
-#define PCI_VENDOR_ID_S3		0x5333
-#endif
-#ifndef PCI_DEVICE_ID_S3_SAVAGE4
-#define PCI_DEVICE_ID_S3_SAVAGE4	0x8a25
-#endif
-#ifndef PCI_DEVICE_ID_S3_PROSAVAGE8
-#define PCI_DEVICE_ID_S3_PROSAVAGE8	0x8d04
-#endif
-
-#define VGA_CR_IX	0x3d4
-#define VGA_CR_DATA	0x3d5
-
-#define CR_SERIAL1	0xa0	/* I2C serial communications interface */
-#define MM_SERIAL1	0xff20
-#define CR_SERIAL2	0xb1	/* DDC2 monitor communications interface */
-
-/* based on vt8365 documentation */
-#define I2C_ENAB	0x10
-#define I2C_SCL_OUT	0x01
-#define I2C_SDA_OUT	0x02
-#define I2C_SCL_IN	0x04
-#define I2C_SDA_IN	0x08
-
-#define SET_CR_IX(p, val)	*((p)->mmvga + VGA_CR_IX) = (u8)(val)
-#define SET_CR_DATA(p, val)	*((p)->mmvga + VGA_CR_DATA) = (u8)(val)
-#define GET_CR_DATA(p)		*((p)->mmvga + VGA_CR_DATA)
-
-
-/*
- * Serial bus line handling
- *
- * serial communications register as parameter in private data
- *
- * TODO: locks with other code sections accessing video registers?
- */
-static void bit_s3via_setscl(void *bus, int val)
-{
-	struct s_i2c_bus *p = (struct s_i2c_bus *)bus;
-	unsigned int r;
-
-	SET_CR_IX(p, p->i2c_reg);
-	r = GET_CR_DATA(p);
-	r |= I2C_ENAB;
-	if (val) {
-		r |= I2C_SCL_OUT;
-	} else {
-		r &= ~I2C_SCL_OUT;
-	}
-	SET_CR_DATA(p, r);
-}
-
-static void bit_s3via_setsda(void *bus, int val)
-{
-	struct s_i2c_bus *p = (struct s_i2c_bus *)bus;
-	unsigned int r;
-	
-	SET_CR_IX(p, p->i2c_reg);
-	r = GET_CR_DATA(p);
-	r |= I2C_ENAB;
-	if (val) {
-		r |= I2C_SDA_OUT;
-	} else {
-		r &= ~I2C_SDA_OUT;
-	}
-	SET_CR_DATA(p, r);
-}
-
-static int bit_s3via_getscl(void *bus)
-{
-	struct s_i2c_bus *p = (struct s_i2c_bus *)bus;
-
-	SET_CR_IX(p, p->i2c_reg);
-	return (0 != (GET_CR_DATA(p) & I2C_SCL_IN));
-}
-
-static int bit_s3via_getsda(void *bus)
-{
-	struct s_i2c_bus *p = (struct s_i2c_bus *)bus;
-
-	SET_CR_IX(p, p->i2c_reg);
-	return (0 != (GET_CR_DATA(p) & I2C_SDA_IN));
-}
-
-
-/*
- * adapter initialisation
- */
-static int i2c_register_bus(struct s_i2c_bus *p, u8 *mmvga, u32 i2c_reg)
-{
-	int ret;
-	p->adap.owner	  = THIS_MODULE;
-	p->adap.id	  = I2C_HW_B_S3VIA;
-	p->adap.algo_data = &p->algo;
-	p->algo.setsda	  = bit_s3via_setsda;
-	p->algo.setscl	  = bit_s3via_setscl;
-	p->algo.getsda	  = bit_s3via_getsda;
-	p->algo.getscl	  = bit_s3via_getscl;
-	p->algo.udelay	  = CYCLE_DELAY;
-	p->algo.mdelay	  = CYCLE_DELAY;
-	p->algo.timeout	  = TIMEOUT;
-	p->algo.data	  = p;
-	p->mmvga	  = mmvga;
-	p->i2c_reg	  = i2c_reg;
-    
-	ret = i2c_bit_add_bus(&p->adap);
-	if (ret) {
-		return ret;
-	}
-
-	p->adap_ok = 1;
-	return 0;
-}
-
-
-/*
- * Cleanup stuff
- */
-static void __devexit prosavage_remove(struct pci_dev *dev)
-{
-	struct s_i2c_chip *chip;
-	int i, ret;
-
-	chip = (struct s_i2c_chip *)pci_get_drvdata(dev);
-
-	if (!chip) {
-		return;
-	}
-	for (i = MAX_BUSSES - 1; i >= 0; i--) {
-		if (chip->i2c_bus[i].adap_ok == 0)
-			continue;
-
-		ret = i2c_bit_del_bus(&chip->i2c_bus[i].adap);
-	        if (ret) {
-			printk(DRIVER_ID ": %s not removed\n",
-				ADAPTER_NAME(chip->i2c_bus[i].adap));
-		}
-	}
-	if (chip->mmio) {
-		iounmap(chip->mmio);
-	}
-	kfree(chip);
-}
-
-
-/*
- * Detect chip and initialize it
- */
-static int __devinit prosavage_probe(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	int ret;
-	unsigned long base, len;
-	struct s_i2c_chip *chip;
-	struct s_i2c_bus  *bus;
-
-        pci_set_drvdata(dev, kmalloc(sizeof(struct s_i2c_chip), GFP_KERNEL)); 
-	chip = (struct s_i2c_chip *)pci_get_drvdata(dev);
-	if (chip == NULL) {
-		return -ENOMEM;
-	}
-
-	memset(chip, 0, sizeof(struct s_i2c_chip));
-
-	base = dev->resource[0].start & PCI_BASE_ADDRESS_MEM_MASK;
-	len  = dev->resource[0].end - base + 1;
-	chip->mmio = ioremap_nocache(base, len);
-
-	if (chip->mmio == NULL) {
-		printk (DRIVER_ID ": ioremap failed\n");
-		prosavage_remove(dev);
-		return -ENODEV;
-	}
-
-
-	/*
-	 * Chip initialisation
-	 */
-	/* Unlock Extended IO Space ??? */
-
-
-	/*
-	 * i2c bus registration
-	 */
-	bus = &chip->i2c_bus[0];
-	snprintf(ADAPTER_NAME(bus->adap), sizeof(ADAPTER_NAME(bus->adap)),
-		"ProSavage I2C bus at %02x:%02x.%x",
-		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	ret = i2c_register_bus(bus, chip->mmio + 0x8000, CR_SERIAL1);
-	if (ret) {
-		goto err_adap;
-	}
-	/*
-	 * ddc bus registration
-	 */
-	bus = &chip->i2c_bus[1];
-	snprintf(ADAPTER_NAME(bus->adap), sizeof(ADAPTER_NAME(bus->adap)),
-		"ProSavage DDC bus at %02x:%02x.%x",
-		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	ret = i2c_register_bus(bus, chip->mmio + 0x8000, CR_SERIAL2);
-	if (ret) {
-		goto err_adap;
-	}
-	return 0;
-err_adap:
-	printk (DRIVER_ID ": %s failed\n", ADAPTER_NAME(bus->adap));
-	prosavage_remove(dev);
-	return ret;
-}
-
-
-/*
- * Data for PCI driver interface
- */
-static struct pci_device_id prosavage_pci_tbl[] = {
-   {
-	.vendor		=	PCI_VENDOR_ID_S3,
-	.device		=	PCI_DEVICE_ID_S3_SAVAGE4,
-	.subvendor	=	PCI_ANY_ID,
-	.subdevice	=	PCI_ANY_ID,
-   },{
-	.vendor		=	PCI_VENDOR_ID_S3,
-	.device		=	PCI_DEVICE_ID_S3_PROSAVAGE8,
-	.subvendor	=	PCI_ANY_ID,
-	.subdevice	=	PCI_ANY_ID,
-   },{ 0, }
-};
-
-static struct pci_driver prosavage_driver = {
-	.name		=	"prosavage-smbus",
-	.id_table	=	prosavage_pci_tbl,
-	.probe		=	prosavage_probe,
-	.remove		=	__devexit_p(prosavage_remove),
-};
-
-static int __init i2c_prosavage_init(void)
-{
-	printk(DRIVER_ID " version %s (%s)\n", I2C_VERSION, DRIVER_VERSION);
-	return pci_module_init(&prosavage_driver);
-}
-
-static void __exit i2c_prosavage_exit(void)
-{
-	pci_unregister_driver(&prosavage_driver);
-}
-
-MODULE_DEVICE_TABLE(pci, prosavage_pci_tbl);
-MODULE_AUTHOR("Henk Vergonet");
-MODULE_DESCRIPTION("ProSavage VIA 8365/8375 smbus driver");
-MODULE_LICENSE("GPL");
-
-module_init (i2c_prosavage_init);
-module_exit (i2c_prosavage_exit);

