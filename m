Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262683AbTCTWXF>; Thu, 20 Mar 2003 17:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbTCTWWX>; Thu, 20 Mar 2003 17:22:23 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30469 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262683AbTCTWV3>;
	Thu, 20 Mar 2003 17:21:29 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995642207@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995642679@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.4, 2003/03/18 14:37:45-08:00, greg@kroah.com

[PATCH] i2c i2c-i801.c: fix up formatting and whitespace issues.

Also made everything static, no global functions are needed here.


 drivers/i2c/busses/i2c-i801.c |  177 ++++++++++++++++++------------------------
 1 files changed, 77 insertions(+), 100 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:57:16 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:57:16 2003
@@ -49,50 +49,48 @@
 #include <linux/i2c.h>
 #include <asm/io.h>
 
-MODULE_LICENSE("GPL");
-
 #ifdef I2C_FUNC_SMBUS_BLOCK_DATA_PEC
 #define HAVE_PEC
 #endif
 
 /* I801 SMBus address offsets */
-#define SMBHSTSTS (0 + i801_smba)
-#define SMBHSTCNT (2 + i801_smba)
-#define SMBHSTCMD (3 + i801_smba)
-#define SMBHSTADD (4 + i801_smba)
-#define SMBHSTDAT0 (5 + i801_smba)
-#define SMBHSTDAT1 (6 + i801_smba)
-#define SMBBLKDAT (7 + i801_smba)
-#define SMBPEC    (8 + i801_smba)	/* ICH4 only */
-#define SMBAUXSTS (12 + i801_smba)	/* ICH4 only */
-#define SMBAUXCTL (13 + i801_smba)	/* ICH4 only */
+#define SMBHSTSTS	(0 + i801_smba)
+#define SMBHSTCNT	(2 + i801_smba)
+#define SMBHSTCMD	(3 + i801_smba)
+#define SMBHSTADD	(4 + i801_smba)
+#define SMBHSTDAT0	(5 + i801_smba)
+#define SMBHSTDAT1	(6 + i801_smba)
+#define SMBBLKDAT	(7 + i801_smba)
+#define SMBPEC		(8 + i801_smba)	/* ICH4 only */
+#define SMBAUXSTS	(12 + i801_smba)	/* ICH4 only */
+#define SMBAUXCTL	(13 + i801_smba)	/* ICH4 only */
 
 /* PCI Address Constants */
-#define SMBBA     0x020
-#define SMBHSTCFG 0x040
-#define SMBREV    0x008
+#define SMBBA		0x020
+#define SMBHSTCFG	0x040
+#define SMBREV		0x008
 
 /* Host configuration bits for SMBHSTCFG */
-#define SMBHSTCFG_HST_EN      1
-#define SMBHSTCFG_SMB_SMI_EN  2
-#define SMBHSTCFG_I2C_EN      4
+#define SMBHSTCFG_HST_EN	1
+#define SMBHSTCFG_SMB_SMI_EN	2
+#define SMBHSTCFG_I2C_EN	4
 
 /* Other settings */
-#define MAX_TIMEOUT 100
-#define ENABLE_INT9 0	/* set to 0x01 to enable - untested */
+#define MAX_TIMEOUT		100
+#define ENABLE_INT9		0	/* set to 0x01 to enable - untested */
 
 /* I801 command constants */
-#define I801_QUICK          0x00
-#define I801_BYTE           0x04
-#define I801_BYTE_DATA      0x08
-#define I801_WORD_DATA      0x0C
-#define I801_PROC_CALL      0x10	/* later chips only, unimplemented */
-#define I801_BLOCK_DATA     0x14
-#define I801_I2C_BLOCK_DATA 0x18	/* unimplemented */
-#define I801_BLOCK_LAST     0x34
-#define I801_I2C_BLOCK_LAST 0x38	/* unimplemented */
-#define I801_START          0x40
-#define I801_PEC_EN         0x80	/* ICH4 only */
+#define I801_QUICK		0x00
+#define I801_BYTE		0x04
+#define I801_BYTE_DATA		0x08
+#define I801_WORD_DATA		0x0C
+#define I801_PROC_CALL		0x10	/* later chips only, unimplemented */
+#define I801_BLOCK_DATA		0x14
+#define I801_I2C_BLOCK_DATA	0x18	/* unimplemented */
+#define I801_BLOCK_LAST		0x34
+#define I801_I2C_BLOCK_LAST	0x38	/* unimplemented */
+#define I801_START		0x40
+#define I801_PEC_EN		0x80	/* ICH4 only */
 
 /* insmod parameters */
 
@@ -104,10 +102,6 @@
 		 "Forcibly enable the I801 at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
-
-
-
-
 static void i801_do_pause(unsigned int amount);
 static int i801_transaction(void);
 static int i801_block_transaction(union i2c_smbus_data *data,
@@ -132,7 +126,7 @@
 	else
 		isich4 = 0;
 
-/* Determine the address of the SMBus areas */
+	/* Determine the address of the SMBus areas */
 	if (force_addr) {
 		i801_smba = force_addr & 0xfff0;
 	} else {
@@ -155,8 +149,9 @@
 	pci_read_config_byte(I801_dev, SMBHSTCFG, &temp);
 	temp &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
 	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
-/* If force_addr is set, we program the new address here. Just to make
-   sure, we disable the device first. */
+
+	/* If force_addr is set, we program the new address here. Just to make
+	   sure, we disable the device first. */
 	if (force_addr) {
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp & 0xfe);
 		pci_write_config_word(I801_dev, SMBBA, i801_smba);
@@ -177,18 +172,18 @@
 	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
 	dev_dbg(&dev->dev, "I801_smba = 0x%X\n", i801_smba);
 
-      END:
+END:
 	return error_return;
 }
 
 
-void i801_do_pause(unsigned int amount)
+static void i801_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
 }
 
-int i801_transaction(void)
+static int i801_transaction(void)
 {
 	int temp;
 	int result = 0;
@@ -259,28 +254,28 @@
 }
 
 /* All-inclusive block transaction function */
-int i801_block_transaction(union i2c_smbus_data *data, char read_write, 
-                           int command)
+static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
+				  int command)
 {
 	int i, len;
 	int smbcmd;
 	int temp;
 	int result = 0;
 	int timeout;
-        unsigned char hostc, errmask;
+	unsigned char hostc, errmask;
 
-        if (command == I2C_SMBUS_I2C_BLOCK_DATA) {
-                if (read_write == I2C_SMBUS_WRITE) {
-                        /* set I2C_EN bit in configuration register */
-                        pci_read_config_byte(I801_dev, SMBHSTCFG, &hostc);
-                        pci_write_config_byte(I801_dev, SMBHSTCFG, 
-                                              hostc | SMBHSTCFG_I2C_EN);
-                } else {
-                        dev_err(&I801_dev->dev,
+	if (command == I2C_SMBUS_I2C_BLOCK_DATA) {
+		if (read_write == I2C_SMBUS_WRITE) {
+			/* set I2C_EN bit in configuration register */
+			pci_read_config_byte(I801_dev, SMBHSTCFG, &hostc);
+			pci_write_config_byte(I801_dev, SMBHSTCFG,
+					      hostc | SMBHSTCFG_I2C_EN);
+		} else {
+			dev_err(&I801_dev->dev,
 				"I2C_SMBUS_I2C_BLOCK_READ not DB!\n");
-                        return -1;
-                }
-        }
+			return -1;
+		}
+	}
 
 	if (read_write == I2C_SMBUS_WRITE) {
 		len = data->block[0];
@@ -303,10 +298,6 @@
 			smbcmd = I801_BLOCK_LAST;
 		else
 			smbcmd = I801_BLOCK_DATA;
-#if 0 /* now using HW PEC */
-		if(isich4 && command == I2C_SMBUS_BLOCK_DATA_PEC)
-			smbcmd |= I801_PEC_EN;
-#endif
 		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT);
 
 		dev_dbg(&I801_dev->dev, "Block (pre %d): CNT=%02x, CMD=%02x, "
@@ -316,15 +307,15 @@
 
 		/* Make sure the SMBus host is ready to start transmitting */
 		temp = inb_p(SMBHSTSTS);
-                if (i == 1) {
-                    /* Erronenous conditions before transaction: 
-                     * Byte_Done, Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
-                    errmask=0x9f; 
-                } else {
-                    /* Erronenous conditions during transaction: 
-                     * Failed, Bus_Err, Dev_Err, Intr */
-                    errmask=0x1e; 
-                }
+		if (i == 1) {
+			/* Erronenous conditions before transaction: 
+			 * Byte_Done, Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
+			errmask=0x9f; 
+		} else {
+			/* Erronenous conditions during transaction: 
+			 * Failed, Bus_Err, Dev_Err, Intr */
+			errmask=0x1e; 
+		}
 		if (temp & errmask) {
 			dev_dbg(&I801_dev->dev, "SMBus busy (%02x). "
 				"Resetting... \n", temp);
@@ -336,20 +327,14 @@
                                 goto END;
 			}
 			if (i != 1) {
-                                result = -1;  /* if die in middle of block transaction, fail */
-                                goto END;
-                        }
+				/* if die in middle of block transaction, fail */
+				result = -1;
+				goto END;
+			}
 		}
 
-		if (i == 1) {
-#if 0 /* #ifdef HAVE_PEC (now using HW PEC) */
-			if(isich4 && command == I2C_SMBUS_BLOCK_DATA_PEC) {
-				if(read_write == I2C_SMBUS_WRITE)
-					outb_p(data->block[len + 1], SMBPEC);
-			}
-#endif
+		if (i == 1)
 			outb_p(inb(SMBHSTCNT) | I801_START, SMBHSTCNT);
-		}
 
 		/* We will always wait for a fraction of a second! */
 		timeout = 0;
@@ -387,7 +372,7 @@
 			data->block[0] = len;
 		}
 
-                /* Retrieve/store value in SMBBLKDAT */
+		/* Retrieve/store value in SMBBLKDAT */
 		if (read_write == I2C_SMBUS_READ)
 			data->block[i] = inb_p(SMBBLKDAT);
 		if (read_write == I2C_SMBUS_WRITE && i+1 <= len)
@@ -422,27 +407,22 @@
 		if (timeout >= MAX_TIMEOUT) {
 			dev_dbg(&I801_dev->dev, "PEC Timeout!\n");
 		}
-#if 0 /* now using HW PEC */
-		if(read_write == I2C_SMBUS_READ) {
-			data->block[len + 1] = inb_p(SMBPEC);
-		}
-#endif
 		outb_p(temp, SMBHSTSTS); 
 	}
 #endif
-        result = 0;
+	result = 0;
 END:
-        if (command == I2C_SMBUS_I2C_BLOCK_DATA) {
-                /* restore saved configuration register value */
+	if (command == I2C_SMBUS_I2C_BLOCK_DATA) {
+		/* restore saved configuration register value */
 		pci_write_config_byte(I801_dev, SMBHSTCFG, hostc);
-        }
+	}
 	return result;
 }
 
 /* Return -1 on error. */
-s32 i801_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
-		char read_write, u8 command, int size,
-		union i2c_smbus_data * data)
+static s32 i801_access(struct i2c_adapter * adap, u16 addr,
+		       unsigned short flags, char read_write, u8 command,
+		       int size, union i2c_smbus_data * data)
 {
 	int hwpec = 0;
 	int block = 0;
@@ -544,7 +524,7 @@
 }
 
 
-u32 i801_func(struct i2c_adapter *adapter)
+static u32 i801_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
@@ -571,8 +551,6 @@
 	.algo		= &smbus_algorithm,
 };
 
-
-
 static struct pci_device_id i801_ids[] __devinitdata = {
 	{
 		.vendor =	PCI_VENDOR_ID_INTEL,
@@ -642,18 +620,17 @@
 	return pci_module_init(&i801_driver);
 }
 
-
 static void __exit i2c_i801_exit(void)
 {
 	pci_unregister_driver(&i801_driver);
 	release_region(i801_smba, (isich4 ? 16 : 8));
 }
 
-
-
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl>, "
+		"Philip Edelbrock <phil@netroedge.com>, "
+		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
 MODULE_DESCRIPTION("I801 SMBus driver");
+MODULE_LICENSE("GPL");
 
 module_init(i2c_i801_init);
 module_exit(i2c_i801_exit);

