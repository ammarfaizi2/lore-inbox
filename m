Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262740AbTCTWgn>; Thu, 20 Mar 2003 17:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262723AbTCTWZH>; Thu, 20 Mar 2003 17:25:07 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:38917 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262695AbTCTWVj>;
	Thu, 20 Mar 2003 17:21:39 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995724104@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995733467@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.11, 2003/03/20 11:15:37-08:00, greg@kroah.com

[PATCH] i2c i2c-ali15x3.c: fix up formatting and whitespace issues.


 drivers/i2c/busses/i2c-ali15x3.c |  184 ++++++++++++++++++---------------------
 1 files changed, 88 insertions(+), 96 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 20 12:54:35 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 20 12:54:35 2003
@@ -73,46 +73,46 @@
 #include <asm/io.h>
 
 /* ALI15X3 SMBus address offsets */
-#define SMBHSTSTS (0 + ali15x3_smba)
-#define SMBHSTCNT (1 + ali15x3_smba)
-#define SMBHSTSTART (2 + ali15x3_smba)
-#define SMBHSTCMD (7 + ali15x3_smba)
-#define SMBHSTADD (3 + ali15x3_smba)
-#define SMBHSTDAT0 (4 + ali15x3_smba)
-#define SMBHSTDAT1 (5 + ali15x3_smba)
-#define SMBBLKDAT (6 + ali15x3_smba)
+#define SMBHSTSTS	(0 + ali15x3_smba)
+#define SMBHSTCNT	(1 + ali15x3_smba)
+#define SMBHSTSTART	(2 + ali15x3_smba)
+#define SMBHSTCMD	(7 + ali15x3_smba)
+#define SMBHSTADD	(3 + ali15x3_smba)
+#define SMBHSTDAT0	(4 + ali15x3_smba)
+#define SMBHSTDAT1	(5 + ali15x3_smba)
+#define SMBBLKDAT	(6 + ali15x3_smba)
 
 /* PCI Address Constants */
-#define SMBCOM    0x004
-#define SMBBA     0x014
-#define SMBATPC   0x05B		/* used to unlock xxxBA registers */
-#define SMBHSTCFG 0x0E0
-#define SMBSLVC   0x0E1
-#define SMBCLK    0x0E2
-#define SMBREV    0x008
+#define SMBCOM		0x004
+#define SMBBA		0x014
+#define SMBATPC		0x05B	/* used to unlock xxxBA registers */
+#define SMBHSTCFG	0x0E0
+#define SMBSLVC		0x0E1
+#define SMBCLK		0x0E2
+#define SMBREV		0x008
 
 /* Other settings */
-#define MAX_TIMEOUT 200		/* times 1/100 sec */
-#define ALI15X3_SMB_IOSIZE 32
+#define MAX_TIMEOUT		200	/* times 1/100 sec */
+#define ALI15X3_SMB_IOSIZE	32
 
 /* this is what the Award 1004 BIOS sets them to on a ASUS P5A MB.
    We don't use these here. If the bases aren't set to some value we
    tell user to upgrade BIOS and we fail.
 */
-#define ALI15X3_SMB_DEFAULTBASE 0xE800
+#define ALI15X3_SMB_DEFAULTBASE	0xE800
 
 /* ALI15X3 address lock bits */
-#define ALI15X3_LOCK	0x06
+#define ALI15X3_LOCK		0x06
 
 /* ALI15X3 command constants */
-#define ALI15X3_ABORT      0x02
-#define ALI15X3_T_OUT      0x04
-#define ALI15X3_QUICK      0x00
-#define ALI15X3_BYTE       0x10
-#define ALI15X3_BYTE_DATA  0x20
-#define ALI15X3_WORD_DATA  0x30
-#define ALI15X3_BLOCK_DATA 0x40
-#define ALI15X3_BLOCK_CLR  0x80
+#define ALI15X3_ABORT		0x02
+#define ALI15X3_T_OUT		0x04
+#define ALI15X3_QUICK		0x00
+#define ALI15X3_BYTE		0x10
+#define ALI15X3_BYTE_DATA	0x20
+#define ALI15X3_WORD_DATA	0x30
+#define ALI15X3_BLOCK_DATA	0x40
+#define ALI15X3_BLOCK_CLR	0x80
 
 /* ALI15X3 status register bits */
 #define ALI15X3_STS_IDLE	0x04
@@ -131,34 +131,31 @@
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the i2c controller");
 
-
-static void ali15x3_do_pause(unsigned int amount);
-
 static unsigned short ali15x3_smba = 0;
 
-int ali15x3_setup(struct pci_dev *ALI15X3_dev)
+static int ali15x3_setup(struct pci_dev *ALI15X3_dev)
 {
 	u16 a;
 	unsigned char temp;
 
-/* Check the following things:
-	- SMB I/O address is initialized
-	- Device is enabled
-	- We can use the addresses
-*/
-
-/* Unlock the register.
-   The data sheet says that the address registers are read-only
-   if the lock bits are 1, but in fact the address registers
-   are zero unless you clear the lock bits.
-*/
+	/* Check the following things:
+		- SMB I/O address is initialized
+		- Device is enabled
+		- We can use the addresses
+	*/
+
+	/* Unlock the register.
+	   The data sheet says that the address registers are read-only
+	   if the lock bits are 1, but in fact the address registers
+	   are zero unless you clear the lock bits.
+	*/
 	pci_read_config_byte(ALI15X3_dev, SMBATPC, &temp);
 	if (temp & ALI15X3_LOCK) {
 		temp &= ~ALI15X3_LOCK;
 		pci_write_config_byte(ALI15X3_dev, SMBATPC, temp);
 	}
 
-/* Determine the address of the SMBus area */
+	/* Determine the address of the SMBus area */
 	pci_read_config_word(ALI15X3_dev, SMBBA, &ali15x3_smba);
 	ali15x3_smba &= (0xffff & ~(ALI15X3_SMB_IOSIZE - 1));
 	if (ali15x3_smba == 0 && force_addr == 0) {
@@ -193,30 +190,30 @@
 			return -ENODEV;
 		}
 	}
-/* check if whole device is enabled */
+	/* check if whole device is enabled */
 	pci_read_config_byte(ALI15X3_dev, SMBCOM, &temp);
 	if ((temp & 1) == 0) {
 		dev_info(&ALI15X3_dev->dev, "enabling SMBus device\n");
 		pci_write_config_byte(ALI15X3_dev, SMBCOM, temp | 0x01);
 	}
 
-/* Is SMB Host controller enabled? */
+	/* Is SMB Host controller enabled? */
 	pci_read_config_byte(ALI15X3_dev, SMBHSTCFG, &temp);
 	if ((temp & 1) == 0) {
 		dev_info(&ALI15X3_dev->dev, "enabling SMBus controller\n");
 		pci_write_config_byte(ALI15X3_dev, SMBHSTCFG, temp | 0x01);
 	}
 
-/* set SMB clock to 74KHz as recommended in data sheet */
+	/* set SMB clock to 74KHz as recommended in data sheet */
 	pci_write_config_byte(ALI15X3_dev, SMBCLK, 0x20);
 
-/*
-  The interrupt routing for SMB is set up in register 0x77 in the
-  1533 ISA Bridge device, NOT in the 7101 device.
-  Don't bother with finding the 1533 device and reading the register.
+	/*
+	  The interrupt routing for SMB is set up in register 0x77 in the
+	  1533 ISA Bridge device, NOT in the 7101 device.
+	  Don't bother with finding the 1533 device and reading the register.
 	if ((....... & 0x0F) == 1)
 		dev_dbg(&ALI15X3_dev->dev, "ALI15X3 using Interrupt 9 for SMBus.\n");
-*/
+	*/
 	pci_read_config_byte(ALI15X3_dev, SMBREV, &temp);
 	dev_dbg(&ALI15X3_dev->dev, "SMBREV = 0x%X\n", temp);
 	dev_dbg(&ALI15X3_dev->dev, "iALI15X3_smba = 0x%X\n", ali15x3_smba);
@@ -224,9 +221,8 @@
 	return 0;
 }
 
-
 /* Internally used pause function */
-void ali15x3_do_pause(unsigned int amount)
+static void ali15x3_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
@@ -250,33 +246,32 @@
 	/* Make sure the SMBus host is ready to start transmitting */
 	/* Check the busy bit first */
 	if (temp & ALI15X3_STS_BUSY) {
-/*
-   If the host controller is still busy, it may have timed out in the previous transaction,
-   resulting in a "SMBus Timeout" Dev.
-   I've tried the following to reset a stuck busy bit.
-	1. Reset the controller with an ABORT command.
-	   (this doesn't seem to clear the controller if an external device is hung)
-	2. Reset the controller and the other SMBus devices with a T_OUT command.
-	   (this clears the host busy bit if an external device is hung,
-	   but it comes back upon a new access to a device)
-	3. Disable and reenable the controller in SMBHSTCFG
-   Worst case, nothing seems to work except power reset.
-*/
-/* Abort - reset the host controller */
-/*
-   Try resetting entire SMB bus, including other devices -
-   This may not work either - it clears the BUSY bit but
-   then the BUSY bit may come back on when you try and use the chip again.
-   If that's the case you are stuck.
-*/
+	/*
+	   If the host controller is still busy, it may have timed out in the
+	   previous transaction, resulting in a "SMBus Timeout" Dev.
+	   I've tried the following to reset a stuck busy bit.
+		1. Reset the controller with an ABORT command.
+		   (this doesn't seem to clear the controller if an external
+		   device is hung)
+		2. Reset the controller and the other SMBus devices with a
+		   T_OUT command.  (this clears the host busy bit if an
+		   external device is hung, but it comes back upon a new access
+		   to a device)
+		3. Disable and reenable the controller in SMBHSTCFG
+	   Worst case, nothing seems to work except power reset.
+	*/
+	/* Abort - reset the host controller */
+	/*
+	   Try resetting entire SMB bus, including other devices -
+	   This may not work either - it clears the BUSY bit but
+	   then the BUSY bit may come back on when you try and use the chip again.
+	   If that's the case you are stuck.
+	*/
 		dev_info(&adap->dev, "Resetting entire SMB Bus to "
 			"clear busy condition (%02x)\n", temp);
 		outb_p(ALI15X3_T_OUT, SMBHSTCNT);
 		temp = inb_p(SMBHSTSTS);
 	}
-/*
-  }
-*/
 
 	/* now check the error bits and the busy bit */
 	if (temp & (ALI15X3_STS_ERR | ALI15X3_STS_BUSY)) {
@@ -321,12 +316,12 @@
 		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
 	}
 
-/*
-  Unfortunately the ALI SMB controller maps "no response" and "bus collision"
-  into a single bit. No reponse is the usual case so don't
-  do a printk.
-  This means that bus collisions go unreported.
-*/
+	/*
+	  Unfortunately the ALI SMB controller maps "no response" and "bus
+	  collision" into a single bit. No reponse is the usual case so don't
+	  do a printk.
+	  This means that bus collisions go unreported.
+	*/
 	if (temp & ALI15X3_STS_COLL) {
 		result = -1;
 		dev_dbg(&adap->dev,
@@ -334,7 +329,7 @@
 			inb_p(SMBHSTADD));
 	}
 
-/* haven't ever seen this */
+	/* haven't ever seen this */
 	if (temp & ALI15X3_STS_DEV) {
 		result = -1;
 		dev_err(&adap->dev, "Error: device error\n");
@@ -347,7 +342,7 @@
 }
 
 /* Return -1 on error. */
-s32 ali15x3_access(struct i2c_adapter * adap, u16 addr,
+static s32 ali15x3_access(struct i2c_adapter * adap, u16 addr,
 		   unsigned short flags, char read_write, u8 command,
 		   int size, union i2c_smbus_data * data)
 {
@@ -355,9 +350,9 @@
 	int temp;
 	int timeout;
 
-/* clear all the bits (clear-on-write) */
+	/* clear all the bits (clear-on-write) */
 	outb_p(0xFF, SMBHSTSTS);
-/* make sure SMBus is idle */
+	/* make sure SMBus is idle */
 	temp = inb_p(SMBHSTSTS);
 	for (timeout = 0;
 	     (timeout < MAX_TIMEOUT) && !(temp & ALI15X3_STS_IDLE);
@@ -418,7 +413,8 @@
 				data->block[0] = len;
 			}
 			outb_p(len, SMBHSTDAT0);
-			outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);	/* Reset SMBBLKDAT */
+			/* Reset SMBBLKDAT */
+			outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);
 			for (i = 1; i <= len; i++)
 				outb_p(data->block[i], SMBBLKDAT);
 		}
@@ -450,7 +446,8 @@
 		if (len > 32)
 			len = 32;
 		data->block[0] = len;
-		outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);	/* Reset SMBBLKDAT */
+		/* Reset SMBBLKDAT */
+		outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);
 		for (i = 1; i <= data->block[0]; i++) {
 			data->block[i] = inb_p(SMBBLKDAT);
 			dev_dbg(&adap->dev, "Blk: len=%d, i=%d, data=%02x\n",
@@ -461,8 +458,7 @@
 	return 0;
 }
 
-
-u32 ali15x3_func(struct i2c_adapter *adapter)
+static u32 ali15x3_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
@@ -483,8 +479,6 @@
 	.algo		= &smbus_algorithm,
 };
 
-
-
 static struct pci_device_id ali15x3_ids[] __devinitdata = {
 	{
 	.vendor =	PCI_VENDOR_ID_AL,
@@ -529,17 +523,15 @@
 	return pci_module_init(&ali15x3_driver);
 }
 
-
 static void __exit i2c_ali15x3_exit(void)
 {
 	pci_unregister_driver(&ali15x3_driver);
 	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
 }
 
-
-
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl>, "
+		"Philip Edelbrock <phil@netroedge.com>, "
+		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
 MODULE_DESCRIPTION("ALI15X3 SMBus driver");
 MODULE_LICENSE("GPL");
 

