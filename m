Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbUCPBS1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbUCPBSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:18:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:56495 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262945AbUCPADV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:21 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <1079391393684@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:34 -0800
Message-Id: <10793913943831@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.7, 2004/03/09 15:29:46-08:00, khali@linux-fr.org

[PATCH] I2c: Kconfig for non-sensors i2c chip drivers

Quoting myself:

> I think that it would make sense to have a specific menu entry for
> these, separate from the sensors stuff. Looks like an easy thing to
> do.

Here is a proposed patch that does this. Comments welcome.


 drivers/i2c/chips/Kconfig |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Mon Mar 15 14:34:43 2004
+++ b/drivers/i2c/chips/Kconfig	Mon Mar 15 14:34:43 2004
@@ -2,7 +2,7 @@
 # I2C Sensor device configuration
 #
 
-menu "I2C Hardware Sensors Chip support"
+menu "Hardware Sensors Chip support"
 	depends on I2C
 
 config I2C_SENSOR
@@ -33,18 +33,6 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
-config SENSORS_EEPROM
-	tristate "EEPROM (DIMM) reader"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get read-only access to the EEPROM data
-	  available on modern memory DIMMs, and which could theoretically
-	  also be available on other devices.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called eeprom.
-
 config SENSORS_FSCHER
 	tristate "FSC Hermes"
 	depends on I2C && EXPERIMENTAL
@@ -192,5 +180,22 @@
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627hf.
+
+endmenu
+
+menu "Other I2C Chip support"
+	depends on I2C
+
+config SENSORS_EEPROM
+	tristate "EEPROM reader"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get read-only access to the EEPROM data
+	  available on modern memory DIMMs and Sony Vaio laptops.  Such
+	  EEPROMs could theoretically be available on other devices as well.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called eeprom.
 
 endmenu

