Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbUCPBmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUCPB0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:26:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:41647 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262854AbUCPACw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:52 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913902844@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:31 -0800
Message-Id: <10793913911774@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.7, 2004/02/18 09:39:10-08:00, greg@kroah.com

I2C: fix oops in i2c-ali1535 driver if no hardware is present.

Thanks to Dave Jones for pointing this out.


 drivers/i2c/busses/i2c-ali1535.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:37:27 2004
+++ b/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:37:27 2004
@@ -517,6 +517,7 @@
 static void __devexit ali1535_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&ali1535_adapter);
+	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
 }
 
 static struct pci_driver ali1535_driver = {
@@ -534,7 +535,6 @@
 static void __exit i2c_ali1535_exit(void)
 {
 	pci_unregister_driver(&ali1535_driver);
-	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "

