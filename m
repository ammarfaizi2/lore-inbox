Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVGSV5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVGSV5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVGSVyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:54:40 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:30737 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261721AbVGSVw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:52:56 -0400
Date: Tue, 19 Jul 2005 23:53:07 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (4/9)
Message-Id: <20050719235307.61e2f6cf.khali@linux-fr.org>
In-Reply-To: <20050719233902.40282559.khali@linux-fr.org>
References: <20050719233902.40282559.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All ISA hardware monitoring drivers (including hybrid drivers) now have
a hard dependency on i2c-isa, so they must select I2C_ISA. As a result,
CONFIG_I2C_ISA doesn't need to be left visible to the user. The good
thing here is that users will stop complaining that some driver doesn't
work just because they forgot to compile or load i2c-isa.

At this point, all drivers are working again and the cleanup phase can
begin.

 drivers/hwmon/Kconfig      |    3 +++
 drivers/i2c/busses/Kconfig |    8 +-------
 2 files changed, 4 insertions(+), 7 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/Kconfig	2005-07-16 09:53:08.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/Kconfig	2005-07-16 20:33:50.000000000 +0200
@@ -160,6 +160,7 @@
 	tristate "ITE IT87xx and compatibles"
 	depends on HWMON && I2C
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for ITE IT87xx sensor chips
 	  and clones: SiS960.
@@ -211,6 +212,7 @@
 	tristate "National Semiconductor LM78 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
 	  LM78-J and LM79.
@@ -366,6 +368,7 @@
 	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
 	depends on HWMON && I2C
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for the Winbond W8378x series
 	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
--- linux-2.6.13-rc3.orig/drivers/i2c/busses/Kconfig	2005-07-13 23:34:12.000000000 +0200
+++ linux-2.6.13-rc3/drivers/i2c/busses/Kconfig	2005-07-16 20:34:31.000000000 +0200
@@ -182,14 +182,8 @@
 	  will be called i2c-iop3xx.
 
 config I2C_ISA
-	tristate "ISA Bus support"
+	tristate
 	depends on I2C
-	help
-	  If you say yes to this option, support will be included for i2c
-	  interfaces that are on the ISA bus.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-isa.
 
 config I2C_ITE
 	tristate "ITE I2C Adapter"


-- 
Jean Delvare
