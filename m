Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262688AbTCTWXD>; Thu, 20 Mar 2003 17:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbTCTWW7>; Thu, 20 Mar 2003 17:22:59 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:33797 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262688AbTCTWVg>;
	Thu, 20 Mar 2003 17:21:36 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995653857@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <1048199566294@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.7, 2003/03/18 17:13:06-08:00, greg@kroah.com

[PATCH] i2c i2c-piix4.c: fix up formatting and whitespace issues.


 drivers/i2c/busses/i2c-piix4.c |   80 +++++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 42 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Thu Mar 20 12:56:08 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Thu Mar 20 12:56:08 2003
@@ -51,37 +51,37 @@
 };
 
 /* PIIX4 SMBus address offsets */
-#define SMBHSTSTS (0 + piix4_smba)
-#define SMBHSLVSTS (1 + piix4_smba)
-#define SMBHSTCNT (2 + piix4_smba)
-#define SMBHSTCMD (3 + piix4_smba)
-#define SMBHSTADD (4 + piix4_smba)
-#define SMBHSTDAT0 (5 + piix4_smba)
-#define SMBHSTDAT1 (6 + piix4_smba)
-#define SMBBLKDAT (7 + piix4_smba)
-#define SMBSLVCNT (8 + piix4_smba)
-#define SMBSHDWCMD (9 + piix4_smba)
-#define SMBSLVEVT (0xA + piix4_smba)
-#define SMBSLVDAT (0xC + piix4_smba)
+#define SMBHSTSTS	(0 + piix4_smba)
+#define SMBHSLVSTS	(1 + piix4_smba)
+#define SMBHSTCNT	(2 + piix4_smba)
+#define SMBHSTCMD	(3 + piix4_smba)
+#define SMBHSTADD	(4 + piix4_smba)
+#define SMBHSTDAT0	(5 + piix4_smba)
+#define SMBHSTDAT1	(6 + piix4_smba)
+#define SMBBLKDAT	(7 + piix4_smba)
+#define SMBSLVCNT	(8 + piix4_smba)
+#define SMBSHDWCMD	(9 + piix4_smba)
+#define SMBSLVEVT	(0xA + piix4_smba)
+#define SMBSLVDAT	(0xC + piix4_smba)
 
 /* PCI Address Constants */
-#define SMBBA     0x090
-#define SMBHSTCFG 0x0D2
-#define SMBSLVC   0x0D3
-#define SMBSHDW1  0x0D4
-#define SMBSHDW2  0x0D5
-#define SMBREV    0x0D6
+#define SMBBA		0x090
+#define SMBHSTCFG	0x0D2
+#define SMBSLVC		0x0D3
+#define SMBSHDW1	0x0D4
+#define SMBSHDW2	0x0D5
+#define SMBREV		0x0D6
 
 /* Other settings */
-#define MAX_TIMEOUT 500
-#define  ENABLE_INT9 0
+#define MAX_TIMEOUT	500
+#define  ENABLE_INT9	0
 
 /* PIIX4 constants */
-#define PIIX4_QUICK      0x00
-#define PIIX4_BYTE       0x04
-#define PIIX4_BYTE_DATA  0x08
-#define PIIX4_WORD_DATA  0x0C
-#define PIIX4_BLOCK_DATA 0x14
+#define PIIX4_QUICK		0x00
+#define PIIX4_BYTE		0x04
+#define PIIX4_BYTE_DATA		0x08
+#define PIIX4_WORD_DATA		0x0C
+#define PIIX4_BLOCK_DATA	0x14
 
 /* insmod parameters */
 
@@ -138,7 +138,7 @@
 		goto END;
 	}
 
-/* Determine the address of the SMBus areas */
+	/* Determine the address of the SMBus areas */
 	if (force_addr) {
 		piix4_smba = force_addr & 0xfff0;
 		force = 0;
@@ -161,8 +161,8 @@
 	}
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
-/* If force_addr is set, we program the new address here. Just to make
-   sure, we disable the PIIX4 first. */
+	/* If force_addr is set, we program the new address here. Just to make
+	   sure, we disable the PIIX4 first. */
 	if (force_addr) {
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp & 0xfe);
 		pci_write_config_word(PIIX4_dev, SMBBA, piix4_smba);
@@ -171,12 +171,14 @@
 			"new address %04x!\n", piix4_smba);
 	} else if ((temp & 1) == 0) {
 		if (force) {
-/* This should never need to be done, but has been noted that
-   many Dell machines have the SMBus interface on the PIIX4
-   disabled!? NOTE: This assumes I/O space and other allocations WERE
-   done by the Bios!  Don't complain if your hardware does weird 
-   things after enabling this. :') Check for Bios updates before
-   resorting to this.  */
+			/* This should never need to be done, but has been
+			 * noted that many Dell machines have the SMBus
+			 * interface on the PIIX4 disabled!? NOTE: This assumes
+			 * I/O space and other allocations WERE done by the
+			 * Bios!  Don't complain if your hardware does weird
+			 * things after enabling this. :') Check for Bios
+			 * updates before resorting to this.
+			 */
 			pci_write_config_byte(PIIX4_dev, SMBHSTCFG,
 					      temp | 1);
 			dev_printk(KERN_NOTICE, &PIIX4_dev->dev,
@@ -202,11 +204,10 @@
 	dev_dbg(&PIIX4_dev->dev, "SMBREV = 0x%X\n", temp);
 	dev_dbg(&PIIX4_dev->dev, "SMBA = 0x%X\n", piix4_smba);
 
-      END:
+END:
 	return error_return;
 }
 
-
 /* Internally used pause function */
 static void piix4_do_pause(unsigned int amount)
 {
@@ -377,7 +378,6 @@
 	return 0;
 }
 
-
 static u32 piix4_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
@@ -399,8 +399,6 @@
 	.algo		= &smbus_algorithm,
 };
 
-
-
 static struct pci_device_id piix4_ids[] __devinitdata = {
 	{
 		.vendor =	PCI_VENDOR_ID_INTEL,
@@ -443,7 +441,7 @@
 static int __devinit piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;
-	
+
 	retval = piix4_setup(dev, id);
 	if (retval)
 		return retval;
@@ -484,8 +482,6 @@
 	pci_unregister_driver(&piix4_driver);
 	release_region(piix4_smba, 8);
 }
-
-
 
 MODULE_AUTHOR
     ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");

