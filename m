Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317728AbSGKFYH>; Thu, 11 Jul 2002 01:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317758AbSGKFYG>; Thu, 11 Jul 2002 01:24:06 -0400
Received: from mail110.mail.bellsouth.net ([205.152.58.50]:8247 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S317728AbSGKFYE>; Thu, 11 Jul 2002 01:24:04 -0400
Message-ID: <3D2D1712.DA5D89E8@bellsouth.net>
Date: Thu, 11 Jul 2002 01:26:42 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] 2.5.25 I2C driver id and Config updates
Content-Type: multipart/mixed;
 boundary="------------0A18773703F98A03B15C7B96"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0A18773703F98A03B15C7B96
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
Could you please apply these 3 patches toward 2.5.26.
They include Config.in updates, additions in i2c-id.h
for "Video for Linux" and a compatibility fix for
i2c-algo-bit.c


Thanks,
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------0A18773703F98A03B15C7B96
Content-Type: text/plain; charset=us-ascii;
 name="47-i2c-5-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="47-i2c-5-patch"

# i2c-algo-bit.c: Added KERNEL_VERSION check around if (current->need_resched) schedule(); and cond_sched();
--- linux/drivers/i2c/i2c-algo-bit.c.orig	2002-07-05 13:08:27.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-bit.c	2002-07-05 13:09:58.000000000 -0400
@@ -119,7 +119,12 @@
 		if (time_after_eq(jiffies, start+adap->timeout)) {
 			return -ETIMEDOUT;
 		}
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+ 		if (current->need_resched)
+ 			schedule();
+#else
 		cond_resched();
+#endif
 	}
 	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
 #ifdef SLO_IO

--------------0A18773703F98A03B15C7B96
Content-Type: text/plain; charset=us-ascii;
 name="47-i2c-6-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="47-i2c-6-patch"

--- linux/drivers/i2c/Config.help.orig	2002-07-07 16:41:47.000000000 -0400
+++ linux/drivers/i2c/Config.help	2002-07-07 16:45:21.000000000 -0400
@@ -1,3 +1,4 @@
+I2C support
 CONFIG_I2C
   I2C (pronounce: I-square-C) is a slow serial bus protocol used in
   many micro controller applications and developed by Philips.  SMBus,
@@ -21,6 +22,7 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-core.o.
 
+I2C bit-banging interfaces
 CONFIG_I2C_ALGOBIT
   This allows you to use a range of I2C adapters called bit-banging
   adapters.  Say Y if you own an I2C adapter belonging to this class
@@ -31,6 +33,7 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-algo-bit.o.
 
+Philips style parallel port adapter
 CONFIG_I2C_PHILIPSPAR
   This supports parallel-port I2C adapters made by Philips.  Say Y if
   you own such an adapter.
@@ -43,6 +46,7 @@
   Note that if you want support for different parallel port devices,
   life will be much easier if you compile them all as modules.
 
+ELV adapter
 CONFIG_I2C_ELV
   This supports parallel-port I2C adapters called ELV.  Say Y if you
   own such an adapter.
@@ -52,6 +56,7 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-elv.o.
 
+Velleman K9000 adapter
 CONFIG_I2C_VELLEMAN
   This supports the Velleman K9000 parallel-port I2C adapter.  Say Y
   if you own such an adapter.
@@ -61,6 +66,7 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-velleman.o.
 
+I2C PCF 8584 interfaces
 CONFIG_I2C_ALGOPCF
   This allows you to use a range of I2C adapters called PCF adapters.
   Say Y if you own an I2C adapter belonging to this class and then say
@@ -71,6 +77,7 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-algo-pcf.o.
 
+Elektor ISA card
 CONFIG_I2C_ELEKTOR
   This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
   such an adapter.
@@ -80,6 +87,7 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-elektor.o.
 
+I2C device interface
 CONFIG_I2C_CHARDEV
   Say Y here to use i2c-* device files, usually found in the /dev
   directory on your system.  They make it possible to have user-space
@@ -91,6 +99,7 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-dev.o.
 
+I2C /proc interface (required for hardware sensors)
 CONFIG_I2C_PROC
   This provides support for i2c device entries in the /proc filesystem.
   The entries will be found in /proc/sys/dev/sensors.

--------------0A18773703F98A03B15C7B96
Content-Type: text/plain; charset=us-ascii;
 name="47-i2c-7-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="47-i2c-7-patch"

--- linux/include/linux/i2c-id.h.orig	2002-07-10 19:12:15.000000000 -0400
+++ linux/include/linux/i2c-id.h	2002-07-10 19:13:42.000000000 -0400
@@ -90,7 +90,11 @@
 #define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
 #define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
 #define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/
-#define I2C_DRIVERID_SAA7108    46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_SAA7108	46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_DS1307	47     /* DS1307 real time clock	*/
+#define I2C_DRIVERID_ADV717x	48     /* ADV 7175/7176 video encoder	*/
+#define I2C_DRIVERID_ZR36067	49     /* Zoran 36067 video encoder	*/
+#define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
 
 
 

--------------0A18773703F98A03B15C7B96--

