Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbUKIFcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbUKIFcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUKIF30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:29:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:52126 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261374AbUKIFYx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:53 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778563792@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:17 -0800
Message-Id: <10999778573332@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.18, 2004/11/08 16:37:43-08:00, greg@kroah.com

I2C: moved from all sensor drivers from normal_i2c_range to normal_i2c

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1021.c   |    8 ++++----
 drivers/i2c/chips/adm1025.c   |    3 +--
 drivers/i2c/chips/adm1031.c   |    3 +--
 drivers/i2c/chips/asb100.c    |    4 ++--
 drivers/i2c/chips/ds1621.c    |    4 ++--
 drivers/i2c/chips/eeprom.c    |    4 ++--
 drivers/i2c/chips/fscher.c    |    1 -
 drivers/i2c/chips/gl518sm.c   |    1 -
 drivers/i2c/chips/it87.c      |    6 ++++--
 drivers/i2c/chips/lm63.c      |    1 -
 drivers/i2c/chips/lm75.c      |    4 ++--
 drivers/i2c/chips/lm77.c      |    3 +--
 drivers/i2c/chips/lm78.c      |    6 ++++--
 drivers/i2c/chips/lm80.c      |    4 ++--
 drivers/i2c/chips/lm83.c      |    7 ++++---
 drivers/i2c/chips/lm85.c      |    1 -
 drivers/i2c/chips/lm87.c      |    3 +--
 drivers/i2c/chips/lm90.c      |    1 -
 drivers/i2c/chips/max1619.c   |    7 ++++---
 drivers/i2c/chips/pc87360.c   |    2 --
 drivers/i2c/chips/pcf8574.c   |    5 +++--
 drivers/i2c/chips/pcf8591.c   |    4 ++--
 drivers/i2c/chips/rtc8564.c   |    3 ---
 drivers/i2c/chips/smsc47m1.c  |    2 --
 drivers/i2c/chips/via686a.c   |    1 -
 drivers/i2c/chips/w83627hf.c  |    1 -
 drivers/i2c/chips/w83781d.c   |    5 +++--
 drivers/i2c/chips/w83l785ts.c |    1 -
 28 files changed, 42 insertions(+), 53 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/adm1021.c	2004-11-08 18:54:55 -08:00
@@ -40,10 +40,10 @@
 #define ADM1021_ALARM_RTEMP_NA		0x04
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
-	0x4c, 0x4e, I2C_CLIENT_END
-};
+static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
+					0x29, 0x2a, 0x2b,
+					0x4c, 0x4d, 0x4e, 
+					I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/adm1025.c b/drivers/i2c/chips/adm1025.c
--- a/drivers/i2c/chips/adm1025.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/adm1025.c	2004-11-08 18:54:55 -08:00
@@ -59,8 +59,7 @@
  * NE1619 has two possible addresses: 0x2c and 0x2d.
  */
 
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/adm1031.c	2004-11-08 18:54:55 -08:00
@@ -57,8 +57,7 @@
 #define ADM1031_CONF2_TEMP_ENABLE(chan)	(0x10 << (chan))
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/asb100.c	2004-11-08 18:54:55 -08:00
@@ -56,8 +56,8 @@
 #define ASB100_VERSION "1.0.0"
 
 /* I2C addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x28, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+					0x2e, 0x2f, I2C_CLIENT_END };
 
 /* ISA addresses to scan (none) */
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
diff -Nru a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/ds1621.c	2004-11-08 18:54:55 -08:00
@@ -29,8 +29,8 @@
 #include "lm75.h"
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
+					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/eeprom.c	2004-11-08 18:54:55 -08:00
@@ -36,8 +36,8 @@
 #include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x50, 0x57, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
+					0x55, 0x56, 0x57, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/fscher.c	2004-11-08 18:54:55 -08:00
@@ -38,7 +38,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/gl518sm.c	2004-11-08 18:54:55 -08:00
@@ -45,7 +45,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/it87.c	2004-11-08 18:54:55 -08:00
@@ -42,8 +42,10 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24,
+					0x25, 0x26, 0x27, 0x28, 0x29,
+					0x2a, 0x2b, 0x2c, 0x2d, 0x2e,
+					0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/lm63.c	2004-11-08 18:54:55 -08:00
@@ -50,7 +50,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/lm75.c	2004-11-08 18:54:55 -08:00
@@ -28,8 +28,8 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
+					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/lm77.c b/drivers/i2c/chips/lm77.c
--- a/drivers/i2c/chips/lm77.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/lm77.c	2004-11-08 18:54:55 -08:00
@@ -34,8 +34,7 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4b, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/lm78.c	2004-11-08 18:54:55 -08:00
@@ -27,8 +27,10 @@
 #include <asm/io.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24,
+					0x25, 0x26, 0x27, 0x28, 0x29,
+					0x2a, 0x2b, 0x2c, 0x2d, 0x2e,
+					0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/lm80.c	2004-11-08 18:54:55 -08:00
@@ -29,8 +29,8 @@
 #include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x28, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c,
+					0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/lm83.c	2004-11-08 18:54:55 -08:00
@@ -40,9 +40,10 @@
  * addresses.
  */
 
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
-	0x4c, 0x4e, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
+					0x29, 0x2a, 0x2b,
+					0x4c, 0x4d, 0x4e,
+					I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/lm85.c	2004-11-08 18:54:55 -08:00
@@ -33,7 +33,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/lm87.c b/drivers/i2c/chips/lm87.c
--- a/drivers/i2c/chips/lm87.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/lm87.c	2004-11-08 18:54:55 -08:00
@@ -65,8 +65,7 @@
  * LM87 has three possible addresses: 0x2c, 0x2d and 0x2e.
  */
 
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/lm90.c	2004-11-08 18:54:55 -08:00
@@ -76,7 +76,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x4c, 0x4d, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
diff -Nru a/drivers/i2c/chips/max1619.c b/drivers/i2c/chips/max1619.c
--- a/drivers/i2c/chips/max1619.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/max1619.c	2004-11-08 18:54:55 -08:00
@@ -34,9 +34,10 @@
 #include <linux/i2c-sensor.h>
 
 
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
-						0x4c, 0x4e, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
+					0x29, 0x2a, 0x2b,
+					0x4c, 0x4d, 0x4e,
+					I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
diff -Nru a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/pc87360.c	2004-11-08 18:54:55 -08:00
@@ -43,7 +43,6 @@
 #include <asm/io.h>
 
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
 static struct i2c_force_data forces[] = {{ NULL }};
 static u8 devid;
@@ -53,7 +52,6 @@
 enum chips { any_chip, pc87360, pc87363, pc87364, pc87365, pc87366 };
 static struct i2c_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.normal_isa		= normal_isa,
 	.forces			= forces,
 };
diff -Nru a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/pcf8574.c	2004-11-08 18:54:55 -08:00
@@ -42,8 +42,9 @@
 #include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x20, 0x27, 0x38, 0x3f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+					0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+					I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/pcf8591.c	2004-11-08 18:54:55 -08:00
@@ -27,8 +27,8 @@
 #include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
+					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
--- a/drivers/i2c/chips/rtc8564.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/rtc8564.c	2004-11-08 18:54:55 -08:00
@@ -66,11 +66,8 @@
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_addr,
-	.normal_i2c_range	= ignore,
 	.probe			= ignore,
-	.probe_range		= ignore,
 	.ignore			= ignore,
-	.ignore_range		= ignore,
 	.force			= ignore,
 };
 
diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/smsc47m1.c	2004-11-08 18:54:55 -08:00
@@ -34,7 +34,6 @@
 #include <asm/io.h>
 
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 /* Address is autodetected, there is no default value */
 static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
 static struct i2c_force_data forces[] = {{NULL}};
@@ -42,7 +41,6 @@
 enum chips { any_chip, smsc47m1 };
 static struct i2c_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.normal_isa		= normal_isa,
 	.forces			= forces,
 };
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/via686a.c	2004-11-08 18:54:55 -08:00
@@ -52,7 +52,6 @@
    Note that we can't determine the ISA address until we have initialized
    our module */
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/w83627hf.c	2004-11-08 18:54:55 -08:00
@@ -57,7 +57,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/w83781d.c	2004-11-08 18:54:55 -08:00
@@ -49,8 +49,9 @@
 #define W83781D_RT			1
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
+					0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
+					0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	2004-11-08 18:54:55 -08:00
+++ b/drivers/i2c/chips/w83l785ts.c	2004-11-08 18:54:55 -08:00
@@ -47,7 +47,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*

