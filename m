Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbUKSWVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbUKSWVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbUKSWVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:21:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:52889 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261628AbUKSWAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:00:48 -0500
Date: Fri, 19 Nov 2004 14:00:15 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
Message-ID: <20041119220015.GC15956@kroah.com>
References: <20041119215935.GA15956@kroah.com> <20041119220001.GB15956@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119220001.GB15956@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2165, 2004/11/19 09:13:08-08:00, khali@linux-fr.org

[PATCH] I2C: Fixes to the i2c-amd756-s4882 driver

While working on the 2.4 version of the i2c-amd756-s4882 driver, I
noticed a few quirks on the 2.6 version I sent to you. The following
patch attempts to fix them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-amd756-s4882.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd756-s4882.c b/drivers/i2c/busses/i2c-amd756-s4882.c
--- a/drivers/i2c/busses/i2c-amd756-s4882.c	2004-11-19 11:40:48 -08:00
+++ b/drivers/i2c/busses/i2c-amd756-s4882.c	2004-11-19 11:40:48 -08:00
@@ -35,6 +35,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 
@@ -156,7 +157,9 @@
 	/* Unregister physical bus */
 	error = i2c_del_adapter(&amd756_smbus);
 	if (error) {
-		if (error != -EINVAL)
+		if (error == -EINVAL)
+			error = -ENODEV;
+		else
 			dev_err(&amd756_smbus.dev, "Physical bus removal "
 				"failed\n");
 		goto ERROR0;
@@ -200,7 +203,7 @@
 					      I2C_SMBUS_WRITE, 0x03,
 					      I2C_SMBUS_BYTE_DATA, &ioconfig);
 	if (error) {
-		dev_dbg(&amd756_smbus.dev, "PCA9556 configuration failed\n");
+		dev_err(&amd756_smbus.dev, "PCA9556 configuration failed\n");
 		error = -EIO;
 		goto ERROR3;
 	}
