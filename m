Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbUCPBmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUCPB1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:27:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:31919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262906AbUCPACj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:39 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913932514@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:33 -0800
Message-Id: <10793913933600@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.5, 2004/03/09 14:59:37-08:00, rddunlap@osdl.org

[PATCH] I2C: fix i2c-prosavage.c section usage

prosavage_remove() is called during init, so it shouldn't be
marked as exit code.  (It matters when CONFIG_HOTPLUG=n.)


 drivers/i2c/busses/i2c-prosavage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	Mon Mar 15 14:34:55 2004
+++ b/drivers/i2c/busses/i2c-prosavage.c	Mon Mar 15 14:34:55 2004
@@ -216,7 +216,7 @@
 /*
  * Cleanup stuff
  */
-static void __devexit prosavage_remove(struct pci_dev *dev)
+static void prosavage_remove(struct pci_dev *dev)
 {
 	struct s_i2c_chip *chip;
 	int i, ret;
@@ -321,7 +321,7 @@
 	.name		=	"prosavage-smbus",
 	.id_table	=	prosavage_pci_tbl,
 	.probe		=	prosavage_probe,
-	.remove		=	__devexit_p(prosavage_remove),
+	.remove		=	prosavage_remove,
 };
 
 static int __init i2c_prosavage_init(void)

