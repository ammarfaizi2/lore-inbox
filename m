Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270248AbUJTBqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270248AbUJTBqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUJTA4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:56:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:64691 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266465AbUJTAT1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:27 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <1098231506201@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:27 -0700
Message-Id: <10982315062141@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2075, 2004/10/19 15:22:05-07:00, khali@linux-fr.org

[PATCH] I2C: Clean up i2c-amd756 and i2c-prosavage messages

A number of messages in the i2c-amd756 and i2c-prosavage drivers have a
leading ": " (especially the former). This is a legacy from lm_sensors'
printks of the 2.4 times. This patch cleans them up. While I was there,
I dropped a couple useless white spaces and dots as well.


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-amd756.c    |   38 ++++++++++++++++++-------------------
 drivers/i2c/busses/i2c-prosavage.c |    4 +--
 2 files changed, 21 insertions(+), 21 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	2004-10-19 16:53:43 -07:00
+++ b/drivers/i2c/busses/i2c-amd756.c	2004-10-19 16:53:43 -07:00
@@ -116,14 +116,14 @@
 	int result = 0;
 	int timeout = 0;
 
-	dev_dbg(&adap->dev, ": Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, "
+	dev_dbg(&adap->dev, "Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, "
 		"DAT=%04x\n", inw_p(SMB_GLOBAL_STATUS),
 		inw_p(SMB_GLOBAL_ENABLE), inw_p(SMB_HOST_ADDRESS),
 		inb_p(SMB_HOST_DATA));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
-		dev_dbg(&adap->dev, ": SMBus busy (%04x). Waiting... \n", temp);
+		dev_dbg(&adap->dev, "SMBus busy (%04x). Waiting...\n", temp);
 		do {
 			msleep(1);
 			temp = inw_p(SMB_GLOBAL_STATUS);
@@ -131,7 +131,7 @@
 		         (timeout++ < MAX_TIMEOUT));
 		/* If the SMBus is still busy, we give up */
 		if (timeout >= MAX_TIMEOUT) {
-			dev_dbg(&adap->dev, ": Busy wait timeout (%04x)\n", temp);
+			dev_dbg(&adap->dev, "Busy wait timeout (%04x)\n", temp);
 			goto abort;
 		}
 		timeout = 0;
@@ -148,46 +148,46 @@
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		dev_dbg(&adap->dev, ": Completion timeout!\n");
+		dev_dbg(&adap->dev, "Completion timeout!\n");
 		goto abort;
 	}
 
 	if (temp & GS_PRERR_STS) {
 		result = -1;
-		dev_dbg(&adap->dev, ": SMBus Protocol error (no response)!\n");
+		dev_dbg(&adap->dev, "SMBus Protocol error (no response)!\n");
 	}
 
 	if (temp & GS_COL_STS) {
 		result = -1;
-		dev_warn(&adap->dev, " SMBus collision!\n");
+		dev_warn(&adap->dev, "SMBus collision!\n");
 	}
 
 	if (temp & GS_TO_STS) {
 		result = -1;
-		dev_dbg(&adap->dev, ": SMBus protocol timeout!\n");
+		dev_dbg(&adap->dev, "SMBus protocol timeout!\n");
 	}
 
 	if (temp & GS_HCYC_STS)
-		dev_dbg(&adap->dev, " SMBus protocol success!\n");
+		dev_dbg(&adap->dev, "SMBus protocol success!\n");
 
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
 
 #ifdef DEBUG
 	if (((temp = inw_p(SMB_GLOBAL_STATUS)) & GS_CLEAR_STS) != 0x00) {
 		dev_dbg(&adap->dev,
-			": Failed reset at end of transaction (%04x)\n", temp);
+			"Failed reset at end of transaction (%04x)\n", temp);
 	}
 #endif
 
 	dev_dbg(&adap->dev,
-		": Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
+		"Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
 		inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
 		inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
 
 	return result;
 
  abort:
-	dev_warn(&adap->dev, ": Sending abort.\n");
+	dev_warn(&adap->dev, "Sending abort\n");
 	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
 	msleep(100);
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
@@ -204,7 +204,7 @@
 	/** TODO: Should I supporte the 10-bit transfers? */
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		dev_dbg(&adap->dev, ": I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_dbg(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
 		/* TODO: Well... It is supported, I'm just not sure what to do here... */
 		return -1;
 	case I2C_SMBUS_QUICK:
@@ -334,8 +334,8 @@
 	u8 temp;
 	
 	if (amd756_ioport) {
-		dev_err(&pdev->dev, ": Only one device supported. "
-		       "(you have a strange motherboard, btw..)\n");
+		dev_err(&pdev->dev, "Only one device supported "
+		       "(you have a strange motherboard, btw)\n");
 		return -ENODEV;
 	}
 
@@ -352,7 +352,7 @@
 		pci_read_config_byte(pdev, SMBGCFG, &temp);
 		if ((temp & 128) == 0) {
 			dev_err(&pdev->dev,
-				": Error: SMBus controller I/O not enabled!\n");
+				"Error: SMBus controller I/O not enabled!\n");
 			return -ENODEV;
 		}
 
@@ -364,14 +364,14 @@
 	}
 
 	if (!request_region(amd756_ioport, SMB_IOSIZE, "amd756-smbus")) {
-		dev_err(&pdev->dev, ": SMB region 0x%x already in use!\n",
+		dev_err(&pdev->dev, "SMB region 0x%x already in use!\n",
 			amd756_ioport);
 		return -ENODEV;
 	}
 
 	pci_read_config_byte(pdev, SMBREV, &temp);
-	dev_dbg(&pdev->dev, ": SMBREV = 0x%X\n", temp);
-	dev_dbg(&pdev->dev, ": AMD756_smba = 0x%X\n", amd756_ioport);
+	dev_dbg(&pdev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&pdev->dev, "AMD756_smba = 0x%X\n", amd756_ioport);
 
 	/* set up the driverfs linkage to our parent device */
 	amd756_adapter.dev.parent = &pdev->dev;
@@ -382,7 +382,7 @@
 	error = i2c_add_adapter(&amd756_adapter);
 	if (error) {
 		dev_err(&pdev->dev,
-			": Adapter registration failed, module not inserted.\n");
+			"Adapter registration failed, module not inserted\n");
 		goto out_err;
 	}
 
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:53:43 -07:00
+++ b/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:53:43 -07:00
@@ -228,7 +228,7 @@
 
 		ret = i2c_bit_del_bus(&chip->i2c_bus[i].adap);
 	        if (ret) {
-			dev_err(&dev->dev, ": %s not removed\n",
+			dev_err(&dev->dev, "%s not removed\n",
 				chip->i2c_bus[i].adap.name);
 		}
 	}
@@ -298,7 +298,7 @@
 	}
 	return 0;
 err_adap:
-	dev_err(&dev->dev, ": %s failed\n", bus->adap.name);
+	dev_err(&dev->dev, "%s failed\n", bus->adap.name);
 	prosavage_remove(dev);
 	return ret;
 }

