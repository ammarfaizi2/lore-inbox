Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265358AbUEOAob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265358AbUEOAob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUENXqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:46:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:20197 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264595AbUENX3x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:53 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773583580@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:18 -0700
Message-Id: <10845773582039@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.15, 2004/05/11 13:46:12-07:00, khali@linux-fr.org

[PATCH] I2C: Rename hardware monitoring I2C class

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


 Documentation/i2c/porting-clients      |    4 ++--
 drivers/i2c/busses/i2c-ali1535.c       |    2 +-
 drivers/i2c/busses/i2c-ali1563.c       |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c       |    2 +-
 drivers/i2c/busses/i2c-amd756.c        |    2 +-
 drivers/i2c/busses/i2c-amd8111.c       |    2 +-
 drivers/i2c/busses/i2c-i801.c          |    2 +-
 drivers/i2c/busses/i2c-isa.c           |    2 +-
 drivers/i2c/busses/i2c-nforce2.c       |    2 +-
 drivers/i2c/busses/i2c-parport-light.c |    2 +-
 drivers/i2c/busses/i2c-parport.c       |    2 +-
 drivers/i2c/busses/i2c-piix4.c         |    2 +-
 drivers/i2c/busses/i2c-sis5595.c       |    2 +-
 drivers/i2c/busses/i2c-sis630.c        |    2 +-
 drivers/i2c/busses/i2c-sis96x.c        |    2 +-
 drivers/i2c/busses/i2c-via.c           |    2 +-
 drivers/i2c/busses/i2c-viapro.c        |    2 +-
 drivers/i2c/chips/adm1021.c            |    2 +-
 drivers/i2c/chips/asb100.c             |    2 +-
 drivers/i2c/chips/fscher.c             |    2 +-
 drivers/i2c/chips/gl518sm.c            |    2 +-
 drivers/i2c/chips/it87.c               |    2 +-
 drivers/i2c/chips/lm75.c               |    2 +-
 drivers/i2c/chips/lm78.c               |    2 +-
 drivers/i2c/chips/lm80.c               |    2 +-
 drivers/i2c/chips/lm83.c               |    2 +-
 drivers/i2c/chips/lm90.c               |    2 +-
 drivers/i2c/chips/via686a.c            |    2 +-
 drivers/i2c/chips/w83781d.c            |    2 +-
 drivers/i2c/chips/w83l785ts.c          |    2 +-
 include/linux/i2c.h                    |    2 +-
 31 files changed, 32 insertions(+), 32 deletions(-)


diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients	Fri May 14 16:19:05 2004
+++ b/Documentation/i2c/porting-clients	Fri May 14 16:19:05 2004
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
 
diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-ali1535.c	Fri May 14 16:19:05 2004
@@ -480,7 +480,7 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-ali1563.c	Fri May 14 16:19:05 2004
@@ -357,7 +357,7 @@
 
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
-	.class	= I2C_CLASS_SMBUS,
+	.class	= I2C_CLASS_HWMON,
 	.algo	= &ali1563_algorithm,
 };
 
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Fri May 14 16:19:05 2004
@@ -470,7 +470,7 @@
 
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-amd756.c	Fri May 14 16:19:05 2004
@@ -303,7 +303,7 @@
 
 static struct i2c_adapter amd756_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-amd8111.c	Fri May 14 16:19:05 2004
@@ -359,7 +359,7 @@
 	smbus->adapter.owner = THIS_MODULE;
 	snprintf(smbus->adapter.name, I2C_NAME_SIZE,
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
-	smbus->adapter.class = I2C_CLASS_SMBUS;
+	smbus->adapter.class = I2C_CLASS_HWMON;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-i801.c	Fri May 14 16:19:05 2004
@@ -539,7 +539,7 @@
 
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-isa.c	Fri May 14 16:19:05 2004
@@ -43,7 +43,7 @@
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
 };
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-nforce2.c	Fri May 14 16:19:05 2004
@@ -119,7 +119,7 @@
 
 static struct i2c_adapter nforce2_adapter = {
 	.owner          = THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.algo           = &smbus_algorithm,
 	.name   	= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
--- a/drivers/i2c/busses/i2c-parport-light.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-parport-light.c	Fri May 14 16:19:05 2004
@@ -112,7 +112,7 @@
 
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.id		= I2C_HW_B_LP,
 	.algo_data	= &parport_algo_data,
 	.name		= "Parallel port adapter (light)",
diff -Nru a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
--- a/drivers/i2c/busses/i2c-parport.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-parport.c	Fri May 14 16:19:05 2004
@@ -147,7 +147,7 @@
 
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.id		= I2C_HW_B_LP,
 	.name		= "Parallel port adapter",
 };
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri May 14 16:19:05 2004
@@ -409,7 +409,7 @@
 
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-sis5595.c	Fri May 14 16:19:05 2004
@@ -360,7 +360,7 @@
 
 static struct i2c_adapter sis5595_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-sis630.c	Fri May 14 16:19:05 2004
@@ -456,7 +456,7 @@
 
 static struct i2c_adapter sis630_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-sis96x.c	Fri May 14 16:19:05 2004
@@ -260,7 +260,7 @@
 
 static struct i2c_adapter sis96x_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-via.c	Fri May 14 16:19:05 2004
@@ -88,7 +88,7 @@
 
 static struct i2c_adapter vt586b_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_CLASS_SMBUS,
+	.class          = I2C_CLASS_HWMON,
 	.name		= "VIA i2c",
 	.algo_data	= &bit_data,
 };
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/busses/i2c-viapro.c	Fri May 14 16:19:05 2004
@@ -289,7 +289,7 @@
 
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_SMBUS,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/adm1021.c	Fri May 14 16:19:05 2004
@@ -200,7 +200,7 @@
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, adm1021_detect);
 }
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/asb100.c	Fri May 14 16:19:05 2004
@@ -609,7 +609,7 @@
  */
 static int asb100_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, asb100_detect);
 }
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/fscher.c	Fri May 14 16:19:05 2004
@@ -293,7 +293,7 @@
 
 static int fscher_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, fscher_detect);
 }
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/gl518sm.c	Fri May 14 16:19:05 2004
@@ -335,7 +335,7 @@
 
 static int gl518_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, gl518_detect);
 }
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/it87.c	Fri May 14 16:19:05 2004
@@ -500,7 +500,7 @@
      * when a new adapter is inserted (and it87_driver is still present) */
 static int it87_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, it87_detect);
 }
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/lm75.c	Fri May 14 16:19:05 2004
@@ -105,7 +105,7 @@
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/lm78.c	Fri May 14 16:19:05 2004
@@ -488,7 +488,7 @@
      * when a new adapter is inserted (and lm78_driver is still present) */
 static int lm78_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm78_detect);
 }
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/lm80.c	Fri May 14 16:19:05 2004
@@ -376,7 +376,7 @@
 
 static int lm80_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm80_detect);
 }
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/lm83.c	Fri May 14 16:19:05 2004
@@ -216,7 +216,7 @@
 
 static int lm83_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm83_detect);
 }
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/lm90.c	Fri May 14 16:19:05 2004
@@ -274,7 +274,7 @@
 
 static int lm90_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm90_detect);
 }
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/via686a.c	Fri May 14 16:19:05 2004
@@ -573,7 +573,7 @@
 /* This is called when the module is loaded */
 static int via686a_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/w83781d.c	Fri May 14 16:19:05 2004
@@ -911,7 +911,7 @@
 static int
 w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Fri May 14 16:19:05 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Fri May 14 16:19:05 2004
@@ -145,7 +145,7 @@
 
 static int w83l785ts_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_detect(adapter, &addr_data, w83l785ts_detect);
 }
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri May 14 16:19:05 2004
+++ b/include/linux/i2c.h	Fri May 14 16:19:05 2004
@@ -286,7 +286,7 @@
 						/* Must equal I2C_M_TEN below */
 
 /* i2c adapter classes (bitmask) */
-#define I2C_CLASS_SMBUS		(1<<0)	/* lm_sensors, ... */
+#define I2C_CLASS_HWMON		(1<<0)	/* lm_sensors, ... */
 #define I2C_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
 #define I2C_CLASS_TV_DIGITAL	(1<<2)	/* dvb cards */
 #define I2C_CLASS_DDC		(1<<3)	/* i2c-matroxfb ? */

