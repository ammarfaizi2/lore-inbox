Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264349AbUEIPsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264349AbUEIPsI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 11:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUEIPsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 11:48:08 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:15621 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264349AbUEIPrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 11:47:48 -0400
Date: Sun, 9 May 2004 17:48:20 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: Michael Hunold <hunold@convergence.de>, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: [PATCH 2.6] Rename hardware monitoring I2C class
Message-Id: <20040509174820.5bc47686.khali@linux-fr.org>
In-Reply-To: <20040506213455.29154c51.khali@linux-fr.org>
References: <409923F7.7050101@convergence.de>
	<20040506213455.29154c51.khali@linux-fr.org>
Reply-To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

Quoting myself:

> Mmm, I once proposed that I2C_ADAP_CLASS_SMBUS would be better renamed
> I2C_ADAP_CLASS_SENSORS (so I2C_CLASS_SENSORS now). What about that? I
> think it would be great to embed that change into your patch, so that
> the name changes only once.
> 
> BTW, if HWMON is prefered to SENSORS, this is fine with me too, I
> have no strong preference.

Below is a patch that does that. I finally went for HWMON. Yes, it's
big, but it's actually nothing more than
s/I2C_CLASS_SMBUS/I2C_CLASS_HWMON/ (thanks perl -wip :)).

Greg, can you please apply it on top of Michael's patch?

Thanks.

diff -ruN linux-2.6.6-rc3/Documentation/i2c/porting-clients linux-2.6.6-rc3.class/Documentation/i2c/porting-clients
--- linux-2.6.6-rc3/Documentation/i2c/porting-clients	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/Documentation/i2c/porting-clients	Sun May  9 17:05:17 2004
@@ -62,9 +62,9 @@
   patch to the Documentation/i2c/sysfs-interface file.
 
 * [Attach] For I2C drivers, the attach function should make sure
-  that the adapter's class has I2C_CLASS_SMBUS, using the
+  that the adapter's class has I2C_CLASS_HWMON, using the
   following construct:
-  if (!(adapter->class & I2C_CLASS_SMBUS))
+  if (!(adapter->class & I2C_CLASS_HWMON))
           return 0;
   ISA-only drivers of course don't need this.
 
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1535.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-ali1535.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1535.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-ali1535.c	Sun May  9 17:05:17 2004
@@ -480,7 +480,7 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1563.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-ali1563.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1563.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-ali1563.c	Sun May  9 17:05:17 2004
@@ -357,7 +357,7 @@
 
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
-	.class	= I2C_CLASS_SMBUS,
+	.class	= I2C_CLASS_HWMON,
 	.algo	= &ali1563_algorithm,
 };
 
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali15x3.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-ali15x3.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali15x3.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-ali15x3.c	Sun May  9 17:05:17 2004
@@ -470,7 +470,7 @@
 
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd756.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-amd756.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd756.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-amd756.c	Sun May  9 17:05:17 2004
@@ -303,7 +303,7 @@
 
 static struct i2c_adapter amd756_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd8111.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-amd8111.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd8111.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-amd8111.c	Sun May  9 17:05:17 2004
@@ -359,7 +359,7 @@
 	smbus->adapter.owner = THIS_MODULE;
 	snprintf(smbus->adapter.name, I2C_NAME_SIZE,
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
-	smbus->adapter.class = I2C_CLASS_SMBUS;
+	smbus->adapter.class = I2C_CLASS_HWMON;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-i801.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-i801.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-i801.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-i801.c	Sun May  9 17:05:17 2004
@@ -539,7 +539,7 @@
 
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-isa.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-isa.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-isa.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-isa.c	Sun May  9 17:05:17 2004
@@ -43,7 +43,7 @@
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-nforce2.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-nforce2.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-nforce2.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-nforce2.c	Sun May  9 17:05:17 2004
@@ -119,7 +119,7 @@
 
 static struct i2c_adapter nforce2_adapter = {
 	.owner          = THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo           = &smbus_algorithm,
 	.name   	= "unset",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport-light.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-parport-light.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport-light.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-parport-light.c	Sun May  9 17:05:17 2004
@@ -112,7 +112,7 @@
 
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.id		= I2C_HW_B_LP,
 	.algo_data	= &parport_algo_data,
 	.name		= "Parallel port adapter (light)",
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-parport.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-parport.c	Sun May  9 17:05:17 2004
@@ -147,7 +147,7 @@
 
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.id		= I2C_HW_B_LP,
 	.name		= "Parallel port adapter",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-piix4.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-piix4.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-piix4.c	Sun May  9 17:05:17 2004
@@ -410,7 +410,7 @@
 
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis5595.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-sis5595.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis5595.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-sis5595.c	Sun May  9 17:05:17 2004
@@ -360,7 +360,7 @@
 
 static struct i2c_adapter sis5595_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis630.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-sis630.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis630.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-sis630.c	Sun May  9 17:05:17 2004
@@ -456,7 +456,7 @@
 
 static struct i2c_adapter sis630_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis96x.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-sis96x.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis96x.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-sis96x.c	Sun May  9 17:05:17 2004
@@ -260,7 +260,7 @@
 
 static struct i2c_adapter sis96x_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-via.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-via.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-via.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-via.c	Sun May  9 17:05:17 2004
@@ -88,7 +88,7 @@
 
 static struct i2c_adapter vt586b_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.name		= "VIA i2c",
 	.algo_data	= &bit_data,
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/busses/i2c-viapro.c linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-viapro.c
--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-viapro.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/busses/i2c-viapro.c	Sun May  9 17:05:17 2004
@@ -289,7 +289,7 @@
 
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/adm1021.c linux-2.6.6-rc3.class/drivers/i2c/chips/adm1021.c
--- linux-2.6.6-rc3/drivers/i2c/chips/adm1021.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/adm1021.c	Sun May  9 17:05:17 2004
@@ -200,7 +200,7 @@
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, adm1021_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/asb100.c linux-2.6.6-rc3.class/drivers/i2c/chips/asb100.c
--- linux-2.6.6-rc3/drivers/i2c/chips/asb100.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/asb100.c	Sun May  9 17:05:17 2004
@@ -609,7 +609,7 @@
  */
 static int asb100_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, asb100_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/fscher.c linux-2.6.6-rc3.class/drivers/i2c/chips/fscher.c
--- linux-2.6.6-rc3/drivers/i2c/chips/fscher.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/fscher.c	Sun May  9 17:05:17 2004
@@ -293,7 +293,7 @@
 
 static int fscher_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, fscher_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/gl518sm.c linux-2.6.6-rc3.class/drivers/i2c/chips/gl518sm.c
--- linux-2.6.6-rc3/drivers/i2c/chips/gl518sm.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/gl518sm.c	Sun May  9 17:05:17 2004
@@ -335,7 +335,7 @@
 
 static int gl518_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, gl518_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/it87.c linux-2.6.6-rc3.class/drivers/i2c/chips/it87.c
--- linux-2.6.6-rc3/drivers/i2c/chips/it87.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/it87.c	Sun May  9 17:05:17 2004
@@ -500,7 +500,7 @@
      * when a new adapter is inserted (and it87_driver is still present) */
 static int it87_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, it87_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/lm75.c linux-2.6.6-rc3.class/drivers/i2c/chips/lm75.c
--- linux-2.6.6-rc3/drivers/i2c/chips/lm75.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/lm75.c	Sun May  9 17:05:17 2004
@@ -105,7 +105,7 @@
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/lm78.c linux-2.6.6-rc3.class/drivers/i2c/chips/lm78.c
--- linux-2.6.6-rc3/drivers/i2c/chips/lm78.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/lm78.c	Sun May  9 17:05:17 2004
@@ -488,7 +488,7 @@
      * when a new adapter is inserted (and lm78_driver is still present) */
 static int lm78_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm78_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/lm80.c linux-2.6.6-rc3.class/drivers/i2c/chips/lm80.c
--- linux-2.6.6-rc3/drivers/i2c/chips/lm80.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/lm80.c	Sun May  9 17:05:17 2004
@@ -376,7 +376,7 @@
 
 static int lm80_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm80_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/lm83.c linux-2.6.6-rc3.class/drivers/i2c/chips/lm83.c
--- linux-2.6.6-rc3/drivers/i2c/chips/lm83.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/lm83.c	Sun May  9 17:05:17 2004
@@ -216,7 +216,7 @@
 
 static int lm83_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm83_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/lm90.c linux-2.6.6-rc3.class/drivers/i2c/chips/lm90.c
--- linux-2.6.6-rc3/drivers/i2c/chips/lm90.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/lm90.c	Sun May  9 17:05:17 2004
@@ -274,7 +274,7 @@
 
 static int lm90_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm90_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/via686a.c linux-2.6.6-rc3.class/drivers/i2c/chips/via686a.c
--- linux-2.6.6-rc3/drivers/i2c/chips/via686a.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/via686a.c	Sun May  9 17:05:17 2004
@@ -573,7 +573,7 @@
 /* This is called when the module is loaded */
 static int via686a_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c linux-2.6.6-rc3.class/drivers/i2c/chips/w83781d.c
--- linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/w83781d.c	Sun May  9 17:05:17 2004
@@ -911,7 +911,7 @@
 static int
 w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
diff -ruN linux-2.6.6-rc3/drivers/i2c/chips/w83l785ts.c linux-2.6.6-rc3.class/drivers/i2c/chips/w83l785ts.c
--- linux-2.6.6-rc3/drivers/i2c/chips/w83l785ts.c	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/drivers/i2c/chips/w83l785ts.c	Sun May  9 17:05:17 2004
@@ -145,7 +145,7 @@
 
 static int w83l785ts_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, w83l785ts_detect);
 }
diff -ruN linux-2.6.6-rc3/include/linux/i2c.h linux-2.6.6-rc3.class/include/linux/i2c.h
--- linux-2.6.6-rc3/include/linux/i2c.h	Sun May  9 13:44:30 2004
+++ linux-2.6.6-rc3.class/include/linux/i2c.h	Sun May  9 17:05:17 2004
@@ -286,7 +286,7 @@
 						/* Must equal I2C_M_TEN below */
 
 /* i2c adapter classes (bitmask) */
-#define I2C_CLASS_SMBUS		(1<<0)	/* lm_sensors, ... */
+#define I2C_CLASS_HWMON		(1<<0)	/* lm_sensors, ... */
 #define I2C_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
 #define I2C_CLASS_TV_DIGITAL	(1<<2)	/* dvb cards */
 #define I2C_CLASS_DDC		(1<<3)	/* i2c-matroxfb ? */


-- 
Jean Delvare
http://khali.linux-fr.org/
