Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVAHLH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVAHLH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 06:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVAHHeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:34:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:2182 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261904AbVAHFsg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:36 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627741477@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:35 -0800
Message-Id: <11051627753704@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.55, 2005/01/07 11:16:13-08:00, rddunlap@osdl.org

[PATCH] i2c-ali1563: fix init & exit section usage

Fix init & exit section usages, beginning with this diagnostic
from reference_discarded.pl (make buildcheck):
Error: ./drivers/i2c/busses/i2c-ali1563.o .data refers to 00000278 R_386_32          .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ali1563.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	2005-01-07 14:53:24 -08:00
+++ b/drivers/i2c/busses/i2c-ali1563.c	2005-01-07 14:53:24 -08:00
@@ -306,7 +306,7 @@
 	pci_write_config_word(dev,ALI1563_SMBBA,ctrl);
 }
 
-static int __init ali1563_setup(struct pci_dev * dev)
+static int __devinit ali1563_setup(struct pci_dev * dev)
 {
 	u16 ctrl;
 
@@ -362,7 +362,7 @@
 	.algo	= &ali1563_algorithm,
 };
 
-static int __init ali1563_probe(struct pci_dev * dev,
+static int __devinit ali1563_probe(struct pci_dev * dev,
 				const struct pci_device_id * id_table)
 {
 	int error;
@@ -378,7 +378,7 @@
 	return error;
 }
 
-static void __exit ali1563_remove(struct pci_dev * dev)
+static void __devexit ali1563_remove(struct pci_dev * dev)
 {
 	i2c_del_adapter(&ali1563_adapter);
 	ali1563_shutdown(dev);
@@ -395,7 +395,7 @@
  	.name		= "ali1563_i2c",
 	.id_table	= ali1563_id_table,
  	.probe		= ali1563_probe,
-	.remove		= ali1563_remove,
+	.remove		= __devexit_p(ali1563_remove),
 };
 
 static int __init ali1563_init(void)

