Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbTCTWY0>; Thu, 20 Mar 2003 17:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbTCTWXw>; Thu, 20 Mar 2003 17:23:52 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:37893 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262693AbTCTWVi>;
	Thu, 20 Mar 2003 17:21:38 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995723512@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995724104@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.10, 2003/03/20 11:15:18-08:00, greg@kroah.com

[PATCH] i2c i2c-ali15x3.c: remove check_region() call.


 drivers/i2c/busses/i2c-ali15x3.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 20 12:54:58 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 20 12:54:58 2003
@@ -170,7 +170,7 @@
 	if(force_addr)
 		ali15x3_smba = force_addr & ~(ALI15X3_SMB_IOSIZE - 1);
 
-	if (check_region(ali15x3_smba, ALI15X3_SMB_IOSIZE)) {
+	if (!request_region(ali15x3_smba, ALI15X3_SMB_IOSIZE, "ali15x3-smb")) {
 		dev_err(&ALI15X3_dev->dev,
 			"ALI15X3_smb region 0x%x already in use!\n",
 			ali15x3_smba);
@@ -209,9 +209,6 @@
 
 /* set SMB clock to 74KHz as recommended in data sheet */
 	pci_write_config_byte(ALI15X3_dev, SMBCLK, 0x20);
-
-	/* Everything is happy, let's grab the memory and set things up. */
-	request_region(ali15x3_smba, ALI15X3_SMB_IOSIZE, "ali15x3-smb");
 
 /*
   The interrupt routing for SMB is set up in register 0x77 in the

