Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263011AbTCTWxN>; Thu, 20 Mar 2003 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262703AbTCTWVx>; Thu, 20 Mar 2003 17:21:53 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:27397 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262680AbTCTWV2>;
	Thu, 20 Mar 2003 17:21:28 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995574110@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995631475@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.2, 2003/03/18 14:36:49-08:00, greg@kroah.com

[PATCH] i2c i2c-i801.c: remove check_region() usage.


 drivers/i2c/busses/i2c-i801.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:58:00 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:58:00 2003
@@ -158,10 +158,10 @@
 		}
 	}
 
-	if (check_region(i801_smba, (isich4 ? 16 : 8))) {
+	if (!request_region(i801_smba, (isich4 ? 16 : 8), "i801-smbus")) {
 		dev_err(&dev->dev, "I801_smb region 0x%x already in use!\n",
 			i801_smba);
-		error_return = -ENODEV;
+		error_return = -EBUSY;
 		goto END;
 	}
 
@@ -180,8 +180,6 @@
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 1);
 		dev_warn(&dev->dev, "enabling SMBus device\n");
 	}
-
-	request_region(i801_smba, (isich4 ? 16 : 8), "i801-smbus");
 
 	if (temp & 0x02)
 		dev_dbg(&dev->dev, "I801 using Interrupt SMI# for SMBus.\n");

