Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264589AbTDYAF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTDXXt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:49:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56720 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264552AbTDXXpI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:45:08 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512287463196@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.68
In-Reply-To: <10512287463226@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:59:06 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1179.3.4, 2003/04/23 11:33:48-07:00, hch@lst.de

[PATCH] i2c: bring i2c-viapro uptodate with the style guide


 drivers/i2c/busses/i2c-viapro.c |  321 ++++++++++++++++++----------------------
 1 files changed, 149 insertions(+), 172 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Thu Apr 24 16:47:16 2003
+++ b/drivers/i2c/busses/i2c-viapro.c	Thu Apr 24 16:47:16 2003
@@ -42,23 +42,24 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
-#define SMBBA1	    0x90
-#define SMBBA2      0x80
-#define SMBBA3      0xD0
+#define SMBBA1	   	 0x90
+#define SMBBA2     	 0x80
+#define SMBBA3     	 0xD0
 
 /* SMBus address offsets */
-#define SMBHSTSTS (0 + vt596_smba)
-#define SMBHSLVSTS (1 + vt596_smba)
-#define SMBHSTCNT (2 + vt596_smba)
-#define SMBHSTCMD (3 + vt596_smba)
-#define SMBHSTADD (4 + vt596_smba)
-#define SMBHSTDAT0 (5 + vt596_smba)
-#define SMBHSTDAT1 (6 + vt596_smba)
-#define SMBBLKDAT (7 + vt596_smba)
-#define SMBSLVCNT (8 + vt596_smba)
-#define SMBSHDWCMD (9 + vt596_smba)
-#define SMBSLVEVT (0xA + vt596_smba)
-#define SMBSLVDAT (0xC + vt596_smba)
+static unsigned short vt596_smba;
+#define SMBHSTSTS	(vt596_smba + 0)
+#define SMBHSLVSTS	(vt596_smba + 1)
+#define SMBHSTCNT	(vt596_smba + 2)
+#define SMBHSTCMD	(vt596_smba + 3)
+#define SMBHSTADD	(vt596_smba + 4)
+#define SMBHSTDAT0	(vt596_smba + 5)
+#define SMBHSTDAT1	(vt596_smba + 6)
+#define SMBBLKDAT	(vt596_smba + 7)
+#define SMBSLVCNT	(vt596_smba + 8)
+#define SMBSHDWCMD	(vt596_smba + 9)
+#define SMBSLVEVT	(vt596_smba + 0xA)
+#define SMBSLVDAT	(vt596_smba + 0xC)
 
 /* PCI Address Constants */
 
@@ -68,14 +69,14 @@
 static unsigned short smb_cf_hstcfg = 0xD2;
 
 #define SMBHSTCFG   (smb_cf_hstcfg)
-#define SMBSLVC     (SMBHSTCFG+1)
-#define SMBSHDW1    (SMBHSTCFG+2)
-#define SMBSHDW2    (SMBHSTCFG+3)
-#define SMBREV      (SMBHSTCFG+4)
+#define SMBSLVC     (smb_cf_hstcfg + 1)
+#define SMBSHDW1    (smb_cf_hstcfg + 2)
+#define SMBSHDW2    (smb_cf_hstcfg + 3)
+#define SMBREV      (smb_cf_hstcfg + 4)
 
 /* Other settings */
-#define MAX_TIMEOUT 500
-#define  ENABLE_INT9 0
+#define MAX_TIMEOUT	500
+#define ENABLE_INT9	0
 
 /* VT82C596 constants */
 #define VT596_QUICK      0x00
@@ -84,144 +85,33 @@
 #define VT596_WORD_DATA  0x0C
 #define VT596_BLOCK_DATA 0x14
 
-/* insmod parameters */
 
 /* If force is set to anything different from 0, we forcibly enable the
    VT596. DANGEROUS! */
-static int force = 0;
+static int force;
 MODULE_PARM(force, "i");
 MODULE_PARM_DESC(force, "Forcibly enable the SMBus. DANGEROUS!");
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the VT596 at the given address. VERY DANGEROUS! */
-static int force_addr = 0;
+static int force_addr;
 MODULE_PARM(force_addr, "i");
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the SMBus at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
-static void vt596_do_pause(unsigned int amount);
-static int vt596_transaction(void);
-s32 vt596_access(struct i2c_adapter * adap, u16 addr, unsigned short flags, 
-	char read_write, u8 command, int size, union i2c_smbus_data * data);
-u32 vt596_func(struct i2c_adapter *adapter);
-
-static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
-	.id		= I2C_ALGO_SMBUS,
-	.smbus_xfer	= vt596_access,
-	.functionality	= vt596_func,
-};
-
-static struct i2c_adapter vt596_adapter = {
-	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_VIA2,
-	.algo		= &smbus_algorithm,
-	.dev		= {
-		.name	= "unset",
-	},
-};
-
-
-
-
-static unsigned short vt596_smba = 0;
-
-
-/* Detect whether a compatible device can be found, and initialize it. */
-int vt596_setup(struct pci_dev *VT596_dev, struct pci_device_id const *id)
-{
-	unsigned char temp;
-	
-	dev_info(&VT596_dev->dev, "Found Via %s device\n", VT596_dev->dev.name);
-
-	/* Determine the address of the SMBus areas */
-	if (force_addr) {
-		vt596_smba = force_addr & 0xfff0;
-		force = 0;
-	} else {
-		if ((pci_read_config_word(VT596_dev, id->driver_data, &vt596_smba))
-		    || !(vt596_smba & 0x1)) {
-			/* try 2nd address and config reg. for 596 */
-			if((id->device == PCI_DEVICE_ID_VIA_82C596_3) &&
-			   (!pci_read_config_word(VT596_dev, SMBBA2, &vt596_smba)) &&
-			   (vt596_smba & 0x1)) {
-				smb_cf_hstcfg = 0x84;
-			} else {
-			        /* no matches at all */
-			        dev_err(&VT596_dev->dev, "Cannot configure "
-					"SMBus I/O Base address\n");
-			        return(-ENODEV);
-			}
-		}
-		vt596_smba &= 0xfff0;
-		if(vt596_smba == 0) {
-			dev_err(&VT596_dev->dev, "SMBus base address "
-				"uninitialized - upgrade BIOS or use "
-				"force_addr=0xaddr\n");
-			return -ENODEV;
-		}
-	}
-
-	if (!request_region(vt596_smba, 8, "viapro-smbus")) {
-		dev_err(&VT596_dev->dev, "SMBus region 0x%x already in use!\n",
-		        vt596_smba);
-		return(-ENODEV);
-	}
-
-	pci_read_config_byte(VT596_dev, SMBHSTCFG, &temp);
-	/* If force_addr is set, we program the new address here. Just to make
-	   sure, we disable the VT596 first. */
-	if (force_addr) {
-		pci_write_config_byte(VT596_dev, SMBHSTCFG, temp & 0xfe);
-		pci_write_config_word(VT596_dev, id->driver_data, vt596_smba);
-		pci_write_config_byte(VT596_dev, SMBHSTCFG, temp | 0x01);
-		dev_warn(&VT596_dev->dev, "WARNING: SMBus interface set to new "
-		     "address 0x%04x!\n", vt596_smba);
-	} else if ((temp & 1) == 0) {
-		if (force) {
-			/* NOTE: This assumes I/O space and other allocations 
-			 * WERE done by the Bios!  Don't complain if your 
-			 * hardware does weird things after enabling this. 
-			 * :') Check for Bios updates before resorting to 
-			 * this.
-			 */
-			pci_write_config_byte(VT596_dev, SMBHSTCFG,
-					      temp | 1);
-			dev_info(&VT596_dev->dev, "Enabling SMBus device\n");
-		} else {
-			dev_err(&VT596_dev->dev, "SMBUS: Error: Host SMBus "
-				"controller not enabled! - upgrade BIOS or "
-				"use force=1\n");
-			return(-ENODEV);
-		}
-	}
-
-	if ((temp & 0x0E) == 8)
-		dev_dbg(&VT596_dev->dev, "using Interrupt 9 for SMBus.\n");
-	else if ((temp & 0x0E) == 0)
-		dev_dbg(&VT596_dev->dev, "using Interrupt SMI# for SMBus.\n");
-	else
-		dev_dbg(&VT596_dev->dev, "Illegal Interrupt configuration "
-			"(or code out of date)!\n");
-
-	pci_read_config_byte(VT596_dev, SMBREV, &temp);
-	dev_dbg(&VT596_dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&VT596_dev->dev, "VT596_smba = 0x%X\n", vt596_smba);
-
-	return(0);
-}
 
+static struct i2c_adapter vt596_adapter;
 
 /* Internally used pause function */
-void vt596_do_pause(unsigned int amount)
+static void vt596_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
 }
 
 /* Another internally used function */
-int vt596_transaction(void)
+static int vt596_transaction(void)
 {
 	int temp;
 	int result = 0;
@@ -296,15 +186,16 @@
 }
 
 /* Return -1 on error. */
-s32 vt596_access(struct i2c_adapter *adap, u16 addr, unsigned short flags, 
-		char read_write, u8 command, int size, 
-		union i2c_smbus_data * data)
+static s32 vt596_access(struct i2c_adapter *adap, u16 addr,
+		unsigned short flags,  char read_write, u8 command,
+		int size,  union i2c_smbus_data *data)
 {
 	int i, len;
 
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		dev_info(&vt596_adapter.dev, "I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_info(&vt596_adapter.dev,
+			 "I2C_SMBUS_PROC_CALL not supported!\n");
 		return -1;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
@@ -363,7 +254,6 @@
 	if ((read_write == I2C_SMBUS_WRITE) || (size == VT596_QUICK))
 		return 0;
 
-
 	switch (size) {
 	case VT596_BYTE:
 		/* Where is the result put? I assume here it is in
@@ -388,15 +278,127 @@
 	return 0;
 }
 
-
-u32 vt596_func(struct i2c_adapter *adapter)
+static u32 vt596_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	    I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
+static struct i2c_algorithm smbus_algorithm = {
+	.name		= "Non-I2C SMBus adapter",
+	.id		= I2C_ALGO_SMBUS,
+	.smbus_xfer	= vt596_access,
+	.functionality	= vt596_func,
+};
+
+static struct i2c_adapter vt596_adapter = {
+	.owner		= THIS_MODULE,
+	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_VIA2,
+	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
+};
+
+static int __devinit vt596_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *id)
+{
+	unsigned char temp;
+	int error = -ENODEV;
+	
+	/* Determine the address of the SMBus areas */
+	if (force_addr) {
+		vt596_smba = force_addr & 0xfff0;
+		force = 0;
+		goto found;
+	}
+
+	if ((pci_read_config_word(pdev, id->driver_data, &vt596_smba)) ||
+	    !(vt596_smba & 0x1)) {
+		/* try 2nd address and config reg. for 596 */
+		if (id->device == PCI_DEVICE_ID_VIA_82C596_3 &&
+		    !pci_read_config_word(pdev, SMBBA2, &vt596_smba) &&
+		    (vt596_smba & 0x1)) {
+			smb_cf_hstcfg = 0x84;
+		} else {
+			/* no matches at all */
+			dev_err(&pdev->dev, "Cannot configure "
+				"SMBus I/O Base address\n");
+			return -ENODEV;
+		}
+	}
 
+	vt596_smba &= 0xfff0;
+	if (vt596_smba == 0) {
+		dev_err(&pdev->dev, "SMBus base address "
+			"uninitialized - upgrade BIOS or use "
+			"force_addr=0xaddr\n");
+		return -ENODEV;
+	}
+
+ found:
+	if (!request_region(vt596_smba, 8, "viapro-smbus")) {
+		dev_err(&pdev->dev, "SMBus region 0x%x already in use!\n",
+		        vt596_smba);
+		return -ENODEV;
+	}
+
+	pci_read_config_byte(pdev, SMBHSTCFG, &temp);
+	/* If force_addr is set, we program the new address here. Just to make
+	   sure, we disable the VT596 first. */
+	if (force_addr) {
+		pci_write_config_byte(pdev, SMBHSTCFG, temp & 0xfe);
+		pci_write_config_word(pdev, id->driver_data, vt596_smba);
+		pci_write_config_byte(pdev, SMBHSTCFG, temp | 0x01);
+		dev_warn(&pdev->dev, "WARNING: SMBus interface set to new "
+		     "address 0x%04x!\n", vt596_smba);
+	} else if ((temp & 1) == 0) {
+		if (force) {
+			/* NOTE: This assumes I/O space and other allocations 
+			 * WERE done by the Bios!  Don't complain if your 
+			 * hardware does weird things after enabling this. 
+			 * :') Check for Bios updates before resorting to 
+			 * this.
+			 */
+			pci_write_config_byte(pdev, SMBHSTCFG, temp | 1);
+			dev_info(&pdev->dev, "Enabling SMBus device\n");
+		} else {
+			dev_err(&pdev->dev, "SMBUS: Error: Host SMBus "
+				"controller not enabled! - upgrade BIOS or "
+				"use force=1\n");
+			goto release_region;
+		}
+	}
+
+	if ((temp & 0x0E) == 8)
+		dev_dbg(&pdev->dev, "using Interrupt 9 for SMBus.\n");
+	else if ((temp & 0x0E) == 0)
+		dev_dbg(&pdev->dev, "using Interrupt SMI# for SMBus.\n");
+	else
+		dev_dbg(&pdev->dev, "Illegal Interrupt configuration "
+			"(or code out of date)!\n");
+
+	pci_read_config_byte(pdev, SMBREV, &temp);
+	dev_dbg(&pdev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&pdev->dev, "VT596_smba = 0x%X\n", vt596_smba);
+
+	vt596_adapter.dev.parent = &pdev->dev;
+	snprintf(vt596_adapter.dev.name, DEVICE_NAME_SIZE,
+			"SMBus Via Pro adapter at %04x", vt596_smba);
+	
+	return i2c_add_adapter(&vt596_adapter);
+
+ release_region:
+	release_region(vt596_smba, 8);
+	return error;
+}
+
+static void __devexit vt596_remove(struct pci_dev *pdev)
+{
+	i2c_del_adapter(&vt596_adapter);
+	release_region(vt596_smba, 8);
+}
 
 static struct pci_device_id vt596_ids[] __devinitdata = {
 	{
@@ -451,29 +453,6 @@
 	{ 0, }
 };
 
-static int __devinit vt596_probe(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	int retval;
-
-	retval = vt596_setup(dev, id);
-	if (retval)
-		return retval;
-
-	vt596_adapter.dev.parent = &dev->dev;
-
-	snprintf(vt596_adapter.dev.name, DEVICE_NAME_SIZE,
-			"SMBus Via Pro adapter at %04x", vt596_smba);
-	
-	retval = i2c_add_adapter(&vt596_adapter);
-
-	return retval;
-}
-
-static void __devexit vt596_remove(struct pci_dev *dev)
-{
-	i2c_del_adapter(&vt596_adapter);
-}
-
 static struct pci_driver vt596_driver = {
 	.name		= "vt596 smbus",
 	.id_table	= vt596_ids,
@@ -490,14 +469,12 @@
 static void __exit i2c_vt596_exit(void)
 {
 	pci_unregister_driver(&vt596_driver);
-	release_region(vt596_smba, 8);
 }
 
-
-
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR(
+    "Frodo Looijaard <frodol@dds.nl> and "
+    "Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("vt82c596 SMBus driver");
-
 MODULE_LICENSE("GPL");
 
 module_init(i2c_vt596_init);

