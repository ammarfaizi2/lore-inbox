Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265083AbUFVSBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUFVSBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUFVSAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:00:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:49077 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265083AbUFVRng convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:36 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261111349@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:51 -0700
Message-Id: <10879261111963@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.102.1, 2004/06/04 14:45:53-07:00, vojtech@suse.cz

[PATCH] I2C i2c-piix: Don't treat ServerWorks servers as Laptops

I'm sending you this little obvious patch which should enable i2c-piix
to work on IBM servers with ServerWorks chipsets. It still will treat
any IBM/Intel machine as a laptop and refuse to work, but it's better
than before.


  i2c: Treat only IBM machines with Intel chipsets as IBM laptops.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-piix4.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Tue Jun 22 09:48:20 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Tue Jun 22 09:48:20 2004
@@ -138,7 +138,7 @@
 
 	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
 
-	if(ibm_dmi_probe()) {
+	if(ibm_dmi_probe() && PIIX4_dev->vendor == PCI_VENDOR_ID_INTEL) {
 		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "
 			"module!\n");

