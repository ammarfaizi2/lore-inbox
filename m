Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272222AbTHIAjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272140AbTHIAh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:37:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:58815 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272162AbTHIAcX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:23 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10603869373490@kroah.com>
Subject: [PATCH] More i2c driver changes 2.6.0-test2
In-Reply-To: <20030808235501.GA2795@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 8 Aug 2003 16:55:37 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1124, 2003/08/08 16:15:11-07:00, greg@kroah.com

I2C: move the name field back into the i2c_client and i2c_adapter structures.

This is because the name field of struct device is going away, and the name
fields on these i2c structures are useful for people.


 drivers/i2c/busses/i2c-ali1535.c          |    6 ++----
 drivers/i2c/busses/i2c-ali15x3.c          |    6 ++----
 drivers/i2c/busses/i2c-amd756.c           |    6 ++----
 drivers/i2c/busses/i2c-amd8111.c          |    2 +-
 drivers/i2c/busses/i2c-i801.c             |    6 ++----
 drivers/i2c/busses/i2c-isa.c              |    4 +---
 drivers/i2c/busses/i2c-nforce2.c          |    6 ++----
 drivers/i2c/busses/i2c-piix4.c            |    8 +++-----
 drivers/i2c/busses/i2c-sis96x.c           |    6 ++----
 drivers/i2c/busses/i2c-viapro.c           |    6 ++----
 drivers/i2c/chips/adm1021.c               |    2 +-
 drivers/i2c/chips/it87.c                  |    2 +-
 drivers/i2c/chips/lm75.c                  |    2 +-
 drivers/i2c/chips/lm78.c                  |    2 +-
 drivers/i2c/chips/lm85.c                  |   12 ++++++------
 drivers/i2c/chips/via686a.c               |    2 +-
 drivers/i2c/chips/w83781d.c               |    4 ++--
 drivers/i2c/i2c-algo-bit.c                |    2 +-
 drivers/i2c/i2c-core.c                    |    4 ++--
 drivers/i2c/i2c-dev.c                     |    4 +---
 drivers/i2c/i2c-elektor.c                 |    4 +---
 drivers/i2c/i2c-elv.c                     |    4 +---
 drivers/i2c/i2c-philips-par.c             |    4 +---
 drivers/i2c/i2c-prosavage.c               |    5 -----
 drivers/i2c/i2c-velleman.c                |    4 +---
 drivers/i2c/scx200_acb.c                  |    4 ++--
 drivers/media/common/saa7146_i2c.c        |    3 +--
 drivers/media/video/adv7175.c             |   22 +++++++++-------------
 drivers/media/video/bt819.c               |   24 +++++++++++-------------
 drivers/media/video/bt856.c               |   20 +++++++++-----------
 drivers/media/video/bttv-cards.c          |    2 +-
 drivers/media/video/msp3400.c             |    2 +-
 drivers/media/video/saa5249.c             |    6 ++----
 drivers/media/video/saa7110.c             |   10 ++++------
 drivers/media/video/saa7111.c             |   15 ++++++---------
 drivers/media/video/saa7134/saa7134-i2c.c |    2 +-
 drivers/media/video/saa7185.c             |   13 +++++--------
 drivers/media/video/tda9840.c             |    6 +++---
 drivers/media/video/tda9887.c             |    4 +---
 drivers/media/video/tea6415c.c            |    6 +++---
 drivers/media/video/tea6420.c             |    6 +++---
 drivers/media/video/tuner-3036.c          |    4 +---
 drivers/media/video/tuner.c               |    8 +++-----
 include/linux/i2c.h                       |    6 ++++--
 44 files changed, 110 insertions(+), 166 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-ali1535.c	Fri Aug  8 16:47:40 2003
@@ -483,9 +483,7 @@
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI1535,
 	.algo		= &smbus_algorithm,
-	.dev		= {
-		.name	= "unset",
-	}
+	.name		= "unset",
 };
 
 static struct pci_device_id ali1535_ids[] = {
@@ -509,7 +507,7 @@
 	/* set up the driverfs linkage to our parent device */
 	ali1535_adapter.dev.parent = &dev->dev;
 
-	snprintf(ali1535_adapter.dev.name, DEVICE_NAME_SIZE, 
+	snprintf(ali1535_adapter.name, DEVICE_NAME_SIZE, 
 		"SMBus ALI1535 adapter at %04x", ali1535_smba);
 	return i2c_add_adapter(&ali1535_adapter);
 }
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Fri Aug  8 16:47:40 2003
@@ -474,9 +474,7 @@
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI15X3,
 	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
-	.dev		= {
-		.name	= "unset",
-	},
+	.name		= "unset",
 };
 
 static struct pci_device_id ali15x3_ids[] = {
@@ -500,7 +498,7 @@
 	/* set up the driverfs linkage to our parent device */
 	ali15x3_adapter.dev.parent = &dev->dev;
 
-	snprintf(ali15x3_adapter.dev.name, DEVICE_NAME_SIZE,
+	snprintf(ali15x3_adapter.name, DEVICE_NAME_SIZE,
 		"SMBus ALI15X3 adapter at %04x", ali15x3_smba);
 	return i2c_add_adapter(&ali15x3_adapter);
 }
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Fri Aug  8 16:47:40 2003
@@ -307,9 +307,7 @@
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
 	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
-	.dev		= {
-		.name	= "unset",
-	},
+	.name		= "unset",
 };
 
 enum chiptype { AMD756, AMD766, AMD768, NFORCE };
@@ -371,7 +369,7 @@
 	/* set up the driverfs linkage to our parent device */
 	amd756_adapter.dev.parent = &pdev->dev;
 
-	snprintf(amd756_adapter.dev.name, DEVICE_NAME_SIZE,
+	snprintf(amd756_adapter.name, DEVICE_NAME_SIZE,
 		"SMBus AMD75x adapter at %04x", amd756_ioport);
 
 	error = i2c_add_adapter(&amd756_adapter);
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Fri Aug  8 16:47:40 2003
@@ -356,7 +356,7 @@
 		goto out_kfree;
 
 	smbus->adapter.owner = THIS_MODULE;
-	snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE,
+	snprintf(smbus->adapter.name, DEVICE_NAME_SIZE,
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
 	smbus->adapter.class = I2C_ADAP_CLASS_SMBUS;
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Fri Aug  8 16:47:40 2003
@@ -543,9 +543,7 @@
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_I801,
 	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
-	.dev		= {
-		.name	= "unset",
-	},
+	.name		= "unset",
 };
 
 static struct pci_device_id i801_ids[] = {
@@ -600,7 +598,7 @@
 	/* set up the driverfs linkage to our parent device */
 	i801_adapter.dev.parent = &dev->dev;
 
-	snprintf(i801_adapter.dev.name, DEVICE_NAME_SIZE,
+	snprintf(i801_adapter.name, DEVICE_NAME_SIZE,
 		"SMBus I801 adapter at %04x", i801_smba);
 	return i2c_add_adapter(&i801_adapter);
 }
diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-isa.c	Fri Aug  8 16:47:40 2003
@@ -42,9 +42,7 @@
 	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
 	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &isa_algorithm,
-	.dev		= {
-		.name	= "ISA main adapter",
-	},
+	.name		= "ISA main adapter",
 };
 
 static int __init i2c_isa_init(void)
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-nforce2.c	Fri Aug  8 16:47:40 2003
@@ -125,9 +125,7 @@
 	.id             = I2C_ALGO_SMBUS | I2C_HW_SMBUS_NFORCE2,
 	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo           = &smbus_algorithm,
-	.dev            = {
-		.name   = "unset",
-	},
+	.name   	= "unset",
 };
 
 
@@ -342,7 +340,7 @@
 */
 	smbus->adapter = nforce2_adapter;
 	smbus->adapter.dev.parent = &dev->dev;
-	snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE,
+	snprintf(smbus->adapter.name, DEVICE_NAME_SIZE,
 		"SMBus nForce2 adapter at %04x", smbus->base);
 
 	error = i2c_add_adapter(&smbus->adapter);
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri Aug  8 16:47:40 2003
@@ -127,7 +127,7 @@
 	if (PCI_FUNC(PIIX4_dev->devfn) != id->driver_data)
 		return -ENODEV;
 
-	dev_info(&PIIX4_dev->dev, "Found %s device\n", PIIX4_dev->dev.name);
+	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
 
 	if(ibm_dmi_probe()) {
 		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
@@ -389,9 +389,7 @@
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_PIIX4,
 	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
-	.dev		= {
-		.name	= "unset",
-	},
+	.name		= "unset",
 };
 
 static struct pci_device_id piix4_ids[] = {
@@ -444,7 +442,7 @@
 	/* set up the driverfs linkage to our parent device */
 	piix4_adapter.dev.parent = &dev->dev;
 
-	snprintf(piix4_adapter.dev.name, DEVICE_NAME_SIZE,
+	snprintf(piix4_adapter.name, DEVICE_NAME_SIZE,
 		"SMBus PIIX4 adapter at %04x", piix4_smba);
 
 	retval = i2c_add_adapter(&piix4_adapter);
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-sis96x.c	Fri Aug  8 16:47:40 2003
@@ -264,9 +264,7 @@
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_SIS96X,
 	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
-	.dev		= {
-		.name	="unset",
-	},
+	.name		= "unset",
 };
 
 static struct pci_device_id sis96x_ids[] = {
@@ -320,7 +318,7 @@
 	/* set up the driverfs linkage to our parent device */
 	sis96x_adapter.dev.parent = &dev->dev;
 
-	snprintf(sis96x_adapter.dev.name, DEVICE_NAME_SIZE,
+	snprintf(sis96x_adapter.name, DEVICE_NAME_SIZE,
 		"SiS96x SMBus adapter at 0x%04x", sis96x_smbus_base);
 
 	if ((retval = i2c_add_adapter(&sis96x_adapter))) {
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/busses/i2c-viapro.c	Fri Aug  8 16:47:40 2003
@@ -290,9 +290,7 @@
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_VIA2,
 	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
-	.dev		= {
-		.name	= "unset",
-	},
+	.name		= "unset",
 };
 
 static int __devinit vt596_probe(struct pci_dev *pdev,
@@ -378,7 +376,7 @@
 	dev_dbg(&pdev->dev, "VT596_smba = 0x%X\n", vt596_smba);
 
 	vt596_adapter.dev.parent = &pdev->dev;
-	snprintf(vt596_adapter.dev.name, DEVICE_NAME_SIZE,
+	snprintf(vt596_adapter.name, DEVICE_NAME_SIZE,
 			"SMBus Via Pro adapter at %04x", vt596_smba);
 	
 	return i2c_add_adapter(&vt596_adapter);
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Fri Aug  8 16:47:39 2003
+++ b/drivers/i2c/chips/adm1021.c	Fri Aug  8 16:47:39 2003
@@ -320,7 +320,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	new_client->id = adm1021_id++;
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/chips/it87.c	Fri Aug  8 16:47:40 2003
@@ -692,7 +692,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, name, DEVICE_NAME_SIZE);
 
 	data->type = kind;
 
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Fri Aug  8 16:47:39 2003
+++ b/drivers/i2c/chips/lm75.c	Fri Aug  8 16:47:39 2003
@@ -194,7 +194,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, name, DEVICE_NAME_SIZE);
 
 	new_client->id = lm75_id++;
 	data->valid = 0;
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/chips/lm78.c	Fri Aug  8 16:47:40 2003
@@ -638,7 +638,7 @@
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	data->valid = 0;
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/chips/lm85.c	Fri Aug  8 16:47:40 2003
@@ -853,19 +853,19 @@
 	/* Fill in the chip specific driver values */
 	if ( kind == any_chip ) {
 		type_name = "lm85";
-		strlcpy(new_client->dev.name, "Generic LM85", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "Generic LM85", DEVICE_NAME_SIZE);
 	} else if ( kind == lm85b ) {
 		type_name = "lm85b";
-		strlcpy(new_client->dev.name, "National LM85-B", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "National LM85-B", DEVICE_NAME_SIZE);
 	} else if ( kind == lm85c ) {
 		type_name = "lm85c";
-		strlcpy(new_client->dev.name, "National LM85-C", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "National LM85-C", DEVICE_NAME_SIZE);
 	} else if ( kind == adm1027 ) {
 		type_name = "adm1027";
-		strlcpy(new_client->dev.name, "Analog Devices ADM1027", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "Analog Devices ADM1027", DEVICE_NAME_SIZE);
 	} else if ( kind == adt7463 ) {
 		type_name = "adt7463";
-		strlcpy(new_client->dev.name, "Analog Devices ADT7463", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "Analog Devices ADT7463", DEVICE_NAME_SIZE);
 	} else {
 		dev_dbg(&adapter->dev, "Internal error, invalid kind (%d)!", kind);
 		err = -EFAULT ;
@@ -880,7 +880,7 @@
 
 	if (lm85debug) {
 		printk("lm85: Assigning ID %d to %s at %d,0x%02x\n",
-		new_client->id, new_client->dev.name,
+		new_client->id, new_client->name,
 		i2c_adapter_id(new_client->adapter),
 		new_client->addr);
 	}
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Fri Aug  8 16:47:39 2003
+++ b/drivers/i2c/chips/via686a.c	Fri Aug  8 16:47:39 2003
@@ -727,7 +727,7 @@
 	new_client->dev.parent = &adapter->dev;
 
 	/* Fill in the remaining client fields and put into the global list */
-	snprintf(new_client->dev.name, DEVICE_NAME_SIZE, client_name);
+	snprintf(new_client->name, DEVICE_NAME_SIZE, client_name);
 
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Fri Aug  8 16:47:39 2003
+++ b/drivers/i2c/chips/w83781d.c	Fri Aug  8 16:47:39 2003
@@ -1116,7 +1116,7 @@
 		data->lm75[i]->adapter = adapter;
 		data->lm75[i]->driver = &w83781d_driver;
 		data->lm75[i]->flags = 0;
-		strlcpy(data->lm75[i]->dev.name, client_name,
+		strlcpy(data->lm75[i]->name, client_name,
 			DEVICE_NAME_SIZE);
 		if ((err = i2c_attach_client(data->lm75[i]))) {
 			dev_err(&new_client->dev, "Subclient %d "
@@ -1326,7 +1326,7 @@
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	data->valid = 0;
diff -Nru a/drivers/i2c/i2c-algo-bit.c b/drivers/i2c/i2c-algo-bit.c
--- a/drivers/i2c/i2c-algo-bit.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/i2c-algo-bit.c	Fri Aug  8 16:47:40 2003
@@ -527,7 +527,7 @@
 	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
 
 	if (bit_test) {
-		int ret = test_bus(bit_adap, adap->dev.name);
+		int ret = test_bus(bit_adap, adap->name);
 		if (ret<0)
 			return -ENODEV;
 	}
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/i2c-core.c	Fri Aug  8 16:47:40 2003
@@ -250,7 +250,7 @@
 					continue;
 				DEB2(printk(KERN_DEBUG "i2c-core.o: "
 					    "detaching client %s:\n",
-					    client->dev.name));
+					    client->name));
 				if ((res = driver->detach_client(client))) {
 					dev_err(&adap->dev, "while "
 						"unregistering driver "
@@ -352,7 +352,7 @@
 		if (res) {
 			printk(KERN_ERR
 			       "i2c-core.o: client_unregister [%s] failed, "
-			       "client not detached", client->dev.name);
+			       "client not detached", client->name);
 			goto out;
 		}
 	}
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/i2c-dev.c	Fri Aug  8 16:47:40 2003
@@ -484,9 +484,7 @@
 };
 
 static struct i2c_client i2cdev_client_template = {
-	.dev		= {
-		.name	= "I2C /dev entry",
-	},
+	.name		= "I2C /dev entry",
 	.id		= 1,
 	.addr		= -1,
 	.driver		= &i2cdev_driver,
diff -Nru a/drivers/i2c/i2c-elektor.c b/drivers/i2c/i2c-elektor.c
--- a/drivers/i2c/i2c-elektor.c	Fri Aug  8 16:47:39 2003
+++ b/drivers/i2c/i2c-elektor.c	Fri Aug  8 16:47:39 2003
@@ -178,9 +178,7 @@
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_P_ELEK,
 	.algo_data	= &pcf_isa_data,
-	.dev		= {
-		.name	= "PCF8584 ISA adapter",
-	},
+	.name		= "PCF8584 ISA adapter",
 };
 
 static int __init i2c_pcfisa_init(void) 
diff -Nru a/drivers/i2c/i2c-elv.c b/drivers/i2c/i2c-elv.c
--- a/drivers/i2c/i2c-elv.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/i2c-elv.c	Fri Aug  8 16:47:40 2003
@@ -131,9 +131,7 @@
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_B_ELV,
 	.algo_data	= &bit_elv_data,
-	.dev		= {
-		.name	= "ELV Parallel port adaptor",
-	},
+	.name		= "ELV Parallel port adaptor",
 };
 
 static int __init i2c_bitelv_init(void)
diff -Nru a/drivers/i2c/i2c-philips-par.c b/drivers/i2c/i2c-philips-par.c
--- a/drivers/i2c/i2c-philips-par.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/i2c-philips-par.c	Fri Aug  8 16:47:40 2003
@@ -152,9 +152,7 @@
 static struct i2c_adapter bit_lp_ops = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_B_LP,
-	.dev		= {
-		.name	= "Philips Parallel port adapter",
-	},
+	.name		= "Philips Parallel port adapter",
 };
 
 static void i2c_parport_attach (struct parport *port)
diff -Nru a/drivers/i2c/i2c-prosavage.c b/drivers/i2c/i2c-prosavage.c
--- a/drivers/i2c/i2c-prosavage.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/i2c-prosavage.c	Fri Aug  8 16:47:40 2003
@@ -70,12 +70,7 @@
 #define	DRIVER_ID	"i2c-prosavage"
 #define	DRIVER_VERSION	"20030621"
 
-/* lm_sensors2 / kernel 2.5.xx compatibility */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 #define ADAPTER_NAME(x) (x).name
-#else
-#define ADAPTER_NAME(x) (x).dev.name
-#endif /* LINUX_VERSION_CODE */
 
 #define MAX_BUSSES	2
 
diff -Nru a/drivers/i2c/i2c-velleman.c b/drivers/i2c/i2c-velleman.c
--- a/drivers/i2c/i2c-velleman.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/i2c-velleman.c	Fri Aug  8 16:47:40 2003
@@ -116,9 +116,7 @@
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_B_VELLE,
 	.algo_data	= &bit_velle_data,
-	.dev		= {
-		.name	= "Velleman K8000",
-	},
+	.name		= "Velleman K8000",
 };
 
 static int __init i2c_bitvelle_init(void)
diff -Nru a/drivers/i2c/scx200_acb.c b/drivers/i2c/scx200_acb.c
--- a/drivers/i2c/scx200_acb.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/i2c/scx200_acb.c	Fri Aug  8 16:47:40 2003
@@ -456,14 +456,14 @@
 	memset(iface, 0, sizeof(*iface));
 	adapter = &iface->adapter;
 	i2c_set_adapdata(adapter, iface);
-	snprintf(adapter->dev.name, DEVICE_NAME_SIZE, "SCx200 ACB%d", index);
+	snprintf(adapter->name, DEVICE_NAME_SIZE, "SCx200 ACB%d", index);
 	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_ALGO_SMBUS;
 	adapter->algo = &scx200_acb_algorithm;
 
 	init_MUTEX(&iface->sem);
 
-	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->dev.name);
+	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
 	if (request_region(base, 8, description) == 0) {
 		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
diff -Nru a/drivers/media/common/saa7146_i2c.c b/drivers/media/common/saa7146_i2c.c
--- a/drivers/media/common/saa7146_i2c.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/common/saa7146_i2c.c	Fri Aug  8 16:47:40 2003
@@ -407,11 +407,10 @@
 
 	if( NULL != i2c_adapter ) {
 		memset(i2c_adapter,0,sizeof(struct i2c_adapter));
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
 		strcpy(i2c_adapter->name, dev->name);	
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
 		i2c_adapter->data = dev;
 #else
-		strcpy(i2c_adapter->dev.name, dev->name);	
 		i2c_set_adapdata(i2c_adapter,dev);
 #endif
 		i2c_adapter->algo	   = &saa7146_algo;
diff -Nru a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
--- a/drivers/media/video/adv7175.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/adv7175.c	Fri Aug  8 16:47:40 2003
@@ -159,7 +159,7 @@
 	0x06, 0x1a,		/* subc. phase */
 };
 
-static int adv717x_attach(struct i2c_adapter *adap, int addr, unsigned short flags, int kind)
+static int adv717x_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct adv7175 *encoder;
 	struct	i2c_client	*client;
@@ -191,7 +191,7 @@
 		// We should never get here!!!
 		dname = unknown_name;
 	}
-	strlcpy(client->dev.name, dname, DEVICE_NAME_SIZE);
+	strlcpy(client->name, dname, DEVICE_NAME_SIZE);
 	init_MUTEX(&encoder->lock);
 	encoder->client = client;
 	i2c_set_clientdata(client, encoder);
@@ -203,7 +203,7 @@
 	for (i=1; i<x_common; i++) {
 		rv = i2c_smbus_write_byte(client,init_common[i]);
 		if (rv < 0) {
-			printk(KERN_ERR "%s_attach: init error %d\n", client->dev.name, rv);
+			printk(KERN_ERR "%s_attach: init error %d\n", client->name, rv);
 			break;
 		}
 	}
@@ -213,7 +213,7 @@
 		i2c_smbus_write_byte_data(client,0x07, TR0MODE);
 		i2c_smbus_read_byte_data(client,0x12);
 		printk(KERN_INFO "%s_attach: %s rev. %d at 0x%02x\n",
-		       client->dev.name, dname, rv & 1, client->addr);
+		       client->name, dname, rv & 1, client->addr);
 	}
 
 	i2c_attach_client(client);
@@ -297,9 +297,8 @@
 					i2c_smbus_write_byte_data(client,0x07, TR0MODE);
 					break;
 				default:
-					printk(KERN_ERR
-					       "%s: illegal norm: %d\n",
-					       client->dev.name, iarg);
+					printk(KERN_ERR "%s: illegal norm: %d\n",
+					       client->name, iarg);
 					return -EINVAL;
 
 				}
@@ -353,9 +352,8 @@
 					break;
 
 				default:
-					printk(KERN_ERR
-					       "%s: illegal input: %d\n",
-					       client->dev.name, iarg);
+					printk(KERN_ERR "%s: illegal input: %d\n",
+					       client->name, iarg);
 					return -EINVAL;
 
 				}
@@ -422,9 +420,7 @@
 
 static struct i2c_client client_template = {
 	.driver		= &i2c_driver_adv7175,
-	.dev		= {
-		.name	= "adv7175_client",
-	},
+	.name		= "adv7175_client",
 };
 
 static int adv717x_init(void)
diff -Nru a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
--- a/drivers/media/video/bt819.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/bt819.c	Fri Aug  8 16:47:40 2003
@@ -150,7 +150,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-static int bt819_attach(struct i2c_adapter *adap, int addr , unsigned long flags, int kind)
+static int bt819_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	int i;
 	struct bt819 *decoder;
@@ -172,7 +172,7 @@
 	}
 
 	memset(decoder, 0, sizeof(struct bt819));
-	strlcpy(client->dev.name, "bt819", DEVICE_NAME_SIZE);
+	strlcpy(client->name, "bt819", DEVICE_NAME_SIZE);
 	i2c_set_clientdata(client, decoder);
 	decoder->client = client;
 	decoder->addr = addr;
@@ -188,10 +188,10 @@
 	i = bt819_init(client);
 	if (i < 0) {
 		printk(KERN_ERR "%s: bt819_attach: init status %d\n",
-		       decoder->client->dev.name, i);
+		       decoder->client->name, i);
 	} else {
 		printk(KERN_INFO "%s: bt819_attach: chip version %x\n",
-		       decoder->client->dev.name, i2c_smbus_read_byte_data(client,
+		       decoder->client->name, i2c_smbus_read_byte_data(client,
 						      0x17) & 0x0f);
 	}
 	init_MUTEX(&decoder->lock);
@@ -270,7 +270,7 @@
 			*iarg = res;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: get status %x\n",
-				     decoder->client->dev.name, *iarg));
+				     decoder->client->name, *iarg));
 		}
 		break;
 
@@ -280,7 +280,7 @@
 			struct timing *timing;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: set norm %x\n",
-				     decoder->client->dev.name, *iarg));
+				     decoder->client->name, *iarg));
 
 			if (*iarg == VIDEO_MODE_NTSC) {
 				bt819_setbit(decoder, 0x01, 0, 1);
@@ -321,7 +321,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: set input %x\n",
-				     decoder->client->dev.name, *iarg));
+				     decoder->client->name, *iarg));
 
 			if (*iarg < 0 || *iarg > 7) {
 				return -EINVAL;
@@ -346,7 +346,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: set output %x\n",
-				     decoder->client->dev.name, *iarg));
+				     decoder->client->name, *iarg));
 
 			/* not much choice of outputs */
 			if (*iarg != 0) {
@@ -362,7 +362,7 @@
 
 			DEBUG(printk
 			      (KERN_INFO "%s-bt819: enable output %x\n",
-			       decoder->client->dev.name, *iarg));
+			       decoder->client->name, *iarg));
 
 			if (decoder->enable != enable) {
 				decoder->enable = enable;
@@ -383,7 +383,7 @@
 			DEBUG(printk
 			      (KERN_INFO
 			       "%s-bt819: set picture brightness %d contrast %d colour %d\n",
-			       decoder->client->dev.name, pic->brightness,
+			       decoder->client->name, pic->brightness,
 			       pic->contrast, pic->colour));
 
 
@@ -452,9 +452,7 @@
 static struct i2c_client client_template = {
 	.id = -1,
 	.driver = &i2c_driver_bt819,
-	.dev = {
-		.name = "bt819_client",
-	},
+	.name = "bt819_client",
 };
 
 static int bt819_setup(void)
diff -Nru a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
--- a/drivers/media/video/bt856.c	Fri Aug  8 16:47:39 2003
+++ b/drivers/media/video/bt856.c	Fri Aug  8 16:47:39 2003
@@ -97,7 +97,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-static int bt856_attach(struct i2c_adapter *adap, int addr , unsigned long flags, int kind)
+static int bt856_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct bt856 *encoder;
 	struct i2c_client *client;
@@ -123,14 +123,14 @@
 
 
 	memset(encoder, 0, sizeof(struct bt856));
-	strlcpy(client->dev.name, "bt856", DEVICE_NAME_SIZE);
+	strlcpy(client->name, "bt856", DEVICE_NAME_SIZE);
 	encoder->client = client;
 	i2c_set_clientdata(client, encoder);
 	encoder->addr = client->addr;
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->enable = 1;
 
-	DEBUG(printk(KERN_INFO "%s-bt856: attach\n", encoder->client->dev.name));
+	DEBUG(printk(KERN_INFO "%s-bt856: attach\n", encoder->client->name));
 
 	i2c_smbus_write_byte_data(client, 0xdc, 0x18);
 	encoder->reg[0xdc] = 0x18;
@@ -190,7 +190,7 @@
 
 			DEBUG(printk
 			      (KERN_INFO "%s-bt856: get capabilities\n",
-			       encoder->client->dev.name));
+			       encoder->client->name));
 
 			cap->flags
 			    = VIDEO_ENCODER_PAL
@@ -205,7 +205,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt856: set norm %d\n",
-				     encoder->client->dev.name, *iarg));
+				     encoder->client->name, *iarg));
 
 			switch (*iarg) {
 
@@ -232,7 +232,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt856: set input %d\n",
-				     encoder->client->dev.name, *iarg));
+				     encoder->client->name, *iarg));
 
 			/*     We only have video bus.
 			   *iarg = 0: input is from bt819
@@ -268,7 +268,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt856: set output %d\n",
-				     encoder->client->dev.name, *iarg));
+				     encoder->client->name, *iarg));
 
 			/* not much choice of outputs */
 			if (*iarg != 0) {
@@ -285,7 +285,7 @@
 
 			DEBUG(printk
 			      (KERN_INFO "%s-bt856: enable output %d\n",
-			       encoder->client->dev.name, encoder->enable));
+			       encoder->client->name, encoder->enable));
 		}
 		break;
 
@@ -311,9 +311,7 @@
 static struct i2c_client client_template = {
 	.id = -1,
 	.driver = &i2c_driver_bt856,
-	.dev = {
-		.name = "bt856_client",
-	},
+	.name = "bt856_client",
 };
 
 static int bt856_init(void)
diff -Nru a/drivers/media/video/bttv-cards.c b/drivers/media/video/bttv-cards.c
--- a/drivers/media/video/bttv-cards.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/bttv-cards.c	Fri Aug  8 16:47:40 2003
@@ -3469,7 +3469,7 @@
 
 	/* print which chipset we have */
 	while ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
-		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->dev.name);
+		printk(KERN_INFO "bttv: Host bridge is %s\n",pci_name(dev));
 
 	/* print warnings about any quirks found */
 	if (triton1)
diff -Nru a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/msp3400.c	Fri Aug  8 16:47:40 2003
@@ -1316,7 +1316,7 @@
 #endif
 	msp3400c_setvolume(c,msp->muted,msp->left,msp->right);
 
-	snprintf(c->dev.name, DEVICE_NAME_SIZE, "MSP34%02d%c-%c%d",
+	snprintf(c->name, DEVICE_NAME_SIZE, "MSP34%02d%c-%c%d",
 		 (msp->rev2>>8)&0xff, (msp->rev1&0xff)+'@',
 		 ((msp->rev1>>8)&0xff)+'@', msp->rev2&0x1f);
 
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/saa5249.c	Fri Aug  8 16:47:40 2003
@@ -171,7 +171,7 @@
 		return -ENOMEM;
 	}
 	memset(t, 0, sizeof(*t));
-	strlcpy(client->dev.name, IF_NAME, DEVICE_NAME_SIZE);
+	strlcpy(client->name, IF_NAME, DEVICE_NAME_SIZE);
 	init_MUTEX(&t->lock);
 	
 	/*
@@ -263,9 +263,7 @@
 static struct i2c_client client_template = {
 	.id 		= -1,
 	.driver		= &i2c_driver_videotext,
-	.dev		= {
-		.name	= "(unset)",
-	},
+	.name		= "(unset)",
 };
 
 /*
diff -Nru a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
--- a/drivers/media/video/saa7110.c	Fri Aug  8 16:47:39 2003
+++ b/drivers/media/video/saa7110.c	Fri Aug  8 16:47:39 2003
@@ -147,7 +147,7 @@
 }
 
 static
-int saa7110_attach(struct i2c_adapter *adap, int  addr, unsigned short flags, int kind)
+int saa7110_attach(struct i2c_adapter *adap, int  addr, int kind)
 {
 static	const unsigned char initseq[] = {
 	     0, 0x4C, 0x3C, 0x0D, 0xEF, 0xBD, 0xF0, 0x00, 0x00,
@@ -176,7 +176,7 @@
 
 	/* clear our private data */
 	memset(decoder, 0, sizeof(*decoder));
-	strlcpy(client->dev.name, IF_NAME, DEVICE_NAME_SIZE);
+	strlcpy(client->name, IF_NAME, DEVICE_NAME_SIZE);
 	decoder->client = client;
 	i2c_set_clientdata(client, decoder);
 	decoder->addr = addr;
@@ -190,7 +190,7 @@
 
 	rv = i2c_master_send(client, initseq, sizeof(initseq));
 	if (rv < 0)
-		printk(KERN_ERR "%s_attach: init status %d\n", client->dev.name, rv);
+		printk(KERN_ERR "%s_attach: init status %d\n", client->name, rv);
 	else {
 		i2c_smbus_write_byte_data(client,0x21,0x16);
 		i2c_smbus_write_byte_data(client,0x0D,0x04);
@@ -393,9 +393,7 @@
 static struct i2c_client client_template = {
 	.id 		= -1,
 	.driver 	= &i2c_driver_saa7110,
-	.dev		= {
-		.name	= "saa7110_client",
-	},
+	.name		= "saa7110_client",
 };
 
 static int saa7110_init(void)
diff -Nru a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
--- a/drivers/media/video/saa7111.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/saa7111.c	Fri Aug  8 16:47:40 2003
@@ -122,7 +122,7 @@
 	}
 
 	memset(decoder, 0, sizeof(*decoder));
-	strlcpy(client->dev.name, "saa7111", DEVICE_NAME_SIZE);
+	strlcpy(client->name, "saa7111", DEVICE_NAME_SIZE);
 	decoder->client = client;
 	i2c_set_clientdata(client, decoder);
 	decoder->addr = addr;
@@ -137,10 +137,10 @@
 	i = i2c_master_send(client, init, sizeof(init));
 	if (i < 0) {
 		printk(KERN_ERR "%s_attach: init status %d\n",
-		       client->dev.name, i);
+		       client->name, i);
 	} else {
 		printk(KERN_INFO "%s_attach: chip version %x @ 0x%08x\n",
-		       client->dev.name, i2c_smbus_read_byte_data(client, 0x00) >> 4,addr);
+		       client->name, i2c_smbus_read_byte_data(client, 0x00) >> 4,addr);
 	}
 
 	init_MUTEX(&decoder->lock);
@@ -159,7 +159,7 @@
 	}
 	
 	printk("saa7111: probing %s i2c adapter [id=0x%x]\n",
-                       adap->dev.name,adap->id);
+                       adap->name,adap->id);
 	return i2c_probe(adap, &addr_data, saa7111_attach);
 }
 
@@ -188,8 +188,7 @@
 			for (i = 0; i < 32; i += 16) {
 				int j;
 
-				printk("KERN_DEBUG %s: %03x", client->dev.name,
-				       i);
+				printk("KERN_DEBUG %s: %03x", client->name, i);
 				for (j = 0; j < 16; ++j) {
 					printk(" %02x",
 					       i2c_smbus_read_byte_data(client,
@@ -413,9 +412,7 @@
 static struct i2c_client client_template = {
 	.id 	= -1,
 	.driver	= &i2c_driver_saa7111,
-	.dev	= {
-		.name	= "saa7111_client",
-	},
+	.name	= "saa7111_client",
 };
 
 static int saa7111_init(void)
diff -Nru a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/saa7134/saa7134-i2c.c	Fri Aug  8 16:47:40 2003
@@ -399,7 +399,7 @@
 int saa7134_i2c_register(struct saa7134_dev *dev)
 {
 	dev->i2c_adap = saa7134_adap_template;
-	strcpy(dev->i2c_adap.dev.name,dev->name);
+	strcpy(dev->i2c_adap.name,dev->name);
 	dev->i2c_adap.algo_data = dev;
 	i2c_add_adapter(&dev->i2c_adap);
 	
diff -Nru a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
--- a/drivers/media/video/saa7185.c	Fri Aug  8 16:47:39 2003
+++ b/drivers/media/video/saa7185.c	Fri Aug  8 16:47:39 2003
@@ -181,7 +181,7 @@
 	0x66, 0x21,		/* FSC3 */
 };
 
-static int saa7185_attach(struct i2c_adapter *adap, int addr, unsigned short flags, int kind)
+static int saa7185_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	int i;
 	struct saa7185 *encoder;
@@ -202,7 +202,7 @@
 
 
 	memset(encoder, 0, sizeof(*encoder));
-	strlcpy(client->dev.name, "saa7185", DEVICE_NAME_SIZE);
+	strlcpy(client->name, "saa7185", DEVICE_NAME_SIZE);
 	encoder->client = client;
 	i2c_set_clientdata(client, encoder);
 	encoder->addr = addr;
@@ -215,11 +215,10 @@
 					sizeof(init_ntsc));
 	}
 	if (i < 0) {
-		printk(KERN_ERR "%s_attach: init error %d\n", client->dev.name,
-		       i);
+		printk(KERN_ERR "%s_attach: init error %d\n", client->name, i);
 	} else {
 		printk(KERN_INFO "%s_attach: chip version %d\n",
-		       client->dev.name, i2c_smbus_read_byte(client) >> 5);
+		       client->name, i2c_smbus_read_byte(client) >> 5);
 	}
 	init_MUTEX(&encoder->lock);
 	i2c_attach_client(client);
@@ -367,9 +366,7 @@
 static struct i2c_client client_template = {
 	.id 	= -1,
 	.driver = &i2c_driver_saa7185,
-	.dev	= {
-		.name	= "saa7185_client",
-	},
+	.name	= "saa7185_client",
 };
 
 static int saa7185_init(void)
diff -Nru a/drivers/media/video/tda9840.c b/drivers/media/video/tda9840.c
--- a/drivers/media/video/tda9840.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/tda9840.c	Fri Aug  8 16:47:40 2003
@@ -198,7 +198,7 @@
 	}
 	
 	/* fill client structure */
-	sprintf(client->dev.name,"tda9840 (0x%02x)", address);
+	sprintf(client->name,"tda9840 (0x%02x)", address);
 	client->id = tda9840_id++;
 	client->flags = 0;
 	client->addr = address;
@@ -227,7 +227,7 @@
  		printk("tda9840.o: could not initialize ic #3. continuing anyway. (result:%d)\n",result);
 	} 
 	
-	printk("tda9840.o: detected @ 0x%02x on adapter %s\n",2*address,&client->adapter->dev.name[0]);
+	printk("tda9840.o: detected @ 0x%02x on adapter %s\n",2*address,&client->adapter->name[0]);
 
 	return 0;
 }
@@ -236,7 +236,7 @@
 {
 	/* let's see whether this is a know adapter we can attach to */
 	if( adapter->id != I2C_ALGO_SAA7146 ) {
-		dprintk("tda9840.o: refusing to probe on unknown adapter [name='%s',id=0x%x]\n",adapter->dev.name,adapter->id);
+		dprintk("tda9840.o: refusing to probe on unknown adapter [name='%s',id=0x%x]\n",adapter->name,adapter->id);
 		return -ENODEV;
 	}
 
diff -Nru a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
--- a/drivers/media/video/tda9887.c	Fri Aug  8 16:47:39 2003
+++ b/drivers/media/video/tda9887.c	Fri Aug  8 16:47:39 2003
@@ -441,9 +441,7 @@
 {
 	.flags  = I2C_CLIENT_ALLOW_USE,
         .driver = &driver,
-        .dev	= {
-		.name	= "tda9887",
-	},
+	.name	= "tda9887",
 };
 
 static int tda9887_init_module(void)
diff -Nru a/drivers/media/video/tea6415c.c b/drivers/media/video/tea6415c.c
--- a/drivers/media/video/tea6415c.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/tea6415c.c	Fri Aug  8 16:47:40 2003
@@ -72,7 +72,7 @@
 	}
 
 	/* fill client structure */
-	sprintf(client->dev.name,"tea6415c (0x%02x)", address);
+	sprintf(client->name,"tea6415c (0x%02x)", address);
 	client->id = tea6415c_id++;
 	client->flags = 0;
 	client->addr = address;
@@ -85,7 +85,7 @@
 		return err;
 	}
 
-	printk("tea6415c.o: detected @ 0x%02x on adapter %s\n",2*address,&client->adapter->dev.name[0]);
+	printk("tea6415c.o: detected @ 0x%02x on adapter %s\n",2*address,&client->adapter->name[0]);
 
 	return 0;
 }
@@ -94,7 +94,7 @@
 {
 	/* let's see whether this is a know adapter we can attach to */
 	if( adapter->id != I2C_ALGO_SAA7146 ) {
-		dprintk("tea6415c.o: refusing to probe on unknown adapter [name='%s',id=0x%x]\n",adapter->dev.name,adapter->id);
+		dprintk("tea6415c.o: refusing to probe on unknown adapter [name='%s',id=0x%x]\n",adapter->name,adapter->id);
 		return -ENODEV;
 	}
 
diff -Nru a/drivers/media/video/tea6420.c b/drivers/media/video/tea6420.c
--- a/drivers/media/video/tea6420.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/tea6420.c	Fri Aug  8 16:47:40 2003
@@ -112,7 +112,7 @@
 	}
 	
 	/* fill client structure */
-	sprintf(client->dev.name,"tea6420 (0x%02x)", address);
+	sprintf(client->name,"tea6420 (0x%02x)", address);
 	client->id = tea6420_id++;
 	client->flags = 0;
 	client->addr = address;
@@ -135,7 +135,7 @@
 		printk("tea6420.o: could not initialize chipset. continuing anyway.\n");
 	}
 	
-	printk("tea6420.o: detected @ 0x%02x on adapter %s\n",2*address,&client->adapter->dev.name[0]);
+	printk("tea6420.o: detected @ 0x%02x on adapter %s\n",2*address,&client->adapter->name[0]);
 
 	return 0;
 }
@@ -144,7 +144,7 @@
 {
 	/* let's see whether this is a know adapter we can attach to */
 	if( adapter->id != I2C_ALGO_SAA7146 ) {
-		dprintk("tea6420.o: refusing to probe on unknown adapter [name='%s',id=0x%x]\n",adapter->dev.name,adapter->id);
+		dprintk("tea6420.o: refusing to probe on unknown adapter [name='%s',id=0x%x]\n",adapter->name,adapter->id);
 		return -ENODEV;
 	}
 
diff -Nru a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
--- a/drivers/media/video/tuner-3036.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/tuner-3036.c	Fri Aug  8 16:47:40 2003
@@ -197,9 +197,7 @@
 {
         .id 		= -1,
         .driver		= &i2c_driver_tuner,
-        .dev		= {
-		.name	= "SAB3036",
-	},
+	.name		= "SAB3036",
 };
 
 int __init
diff -Nru a/drivers/media/video/tuner.c b/drivers/media/video/tuner.c
--- a/drivers/media/video/tuner.c	Fri Aug  8 16:47:40 2003
+++ b/drivers/media/video/tuner.c	Fri Aug  8 16:47:40 2003
@@ -824,7 +824,7 @@
 	if (type < TUNERS) {
 		t->type = type;
 		printk("tuner(bttv): type forced to %d (%s) [insmod]\n",t->type,tuners[t->type].name);
-		strlcpy(client->dev.name, tuners[t->type].name, DEVICE_NAME_SIZE);
+		strlcpy(client->name, tuners[t->type].name, DEVICE_NAME_SIZE);
 	}
         i2c_attach_client(client);
         if (t->type == TUNER_MT2032)
@@ -875,7 +875,7 @@
 		t->type = *iarg;
 		printk("tuner: type set to %d (%s)\n",
                         t->type,tuners[t->type].name);
-		strlcpy(client->dev.name, tuners[t->type].name, DEVICE_NAME_SIZE);
+		strlcpy(client->name, tuners[t->type].name, DEVICE_NAME_SIZE);
 		if (t->type == TUNER_MT2032)
                         mt2032_init(client);
 		break;
@@ -962,9 +962,7 @@
 {
 	.flags  = I2C_CLIENT_ALLOW_USE,
 	.driver = &driver,
-	.dev  = {
-		.name   = "(tuner unset)",
-	},
+	.name   = "(tuner unset)",
 };
 
 static int tuner_init_module(void)
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri Aug  8 16:47:40 2003
+++ b/include/linux/i2c.h	Fri Aug  8 16:47:40 2003
@@ -166,6 +166,7 @@
 					/* to the client		*/
 	struct device dev;		/* the device structure		*/
 	struct list_head list;
+	char name[DEVICE_NAME_SIZE];
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
@@ -179,11 +180,11 @@
 	dev_set_drvdata (&dev->dev, data);
 }
 
-#define I2C_DEVNAME(str)   .dev = { .name = str }
+#define I2C_DEVNAME(str)	.name = str
 
 static inline char *i2c_clientname(struct i2c_client *c)
 {
-	return c->dev.name;
+	return &c->name[0];
 }
 
 /*
@@ -251,6 +252,7 @@
 	int nr;
 	struct list_head clients;
 	struct list_head list;
+	char name[DEVICE_NAME_SIZE];
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 

