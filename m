Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbUATARF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUATAPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:15:36 -0500
Received: from mail.kroah.org ([65.200.24.183]:27308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265151AbUATAAK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:10 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567584080@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:18 -0800
Message-Id: <10745567584195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.4, 2004/01/14 11:11:06-08:00, mhoffman@lightlink.com

[PATCH] I2C: link asb100 in the proper order

* Jean Delvare <khali@linux-fr.org> [2004-01-09 22:58:58 +0100]:

> Shouldn't the asb100 be listed first, the same way the w83781d is, since
> it has subclients? I would even put asb100 before w83781d, since for now
> the w83781d driver will try to handle ASB100 chips too, thus preventing
> the asb100 driver from being used if both drivers are built-in.

You're right, thanks

* * * * *

This patch fixes the link order for asb100 sensors chip driver.


 drivers/i2c/chips/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Mon Jan 19 15:32:50 2004
+++ b/drivers/i2c/chips/Makefile	Mon Jan 19 15:32:50 2004
@@ -2,11 +2,11 @@
 # Makefile for the kernel hardware sensors chip drivers.
 #
 
-# w83781d goes first, as it can override other driver's addresses.
+# asb100, then w83781d go first, as they can override other drivers' addresses.
+obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
 obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
 
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
-obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o

