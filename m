Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUKIFuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUKIFuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbUKIFtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:49:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:63134 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261384AbUKIFY7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:59 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778564013@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:16 -0800
Message-Id: <10999778562059@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.14, 2004/11/08 16:33:52-08:00, greg@kroah.com

I2C: remove probe_range from I2C sensor drivers, as it's not used.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/pc87360.c     |    2 --
 drivers/i2c/chips/smsc47m1.c    |    2 --
 drivers/i2c/i2c-sensor-detect.c |    9 ---------
 include/linux/i2c-sensor.h      |   11 -----------
 4 files changed, 24 deletions(-)


diff -Nru a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c	2004-11-08 18:55:16 -08:00
+++ b/drivers/i2c/chips/pc87360.c	2004-11-08 18:55:16 -08:00
@@ -57,8 +57,6 @@
 	.normal_i2c_range	= normal_i2c_range,
 	.normal_isa		= normal_isa,
 	.normal_isa_range	= normal_isa_range,
-	.probe			= normal_i2c,		/* cheat */
-	.probe_range		= normal_i2c_range,	/* cheat */
 	.ignore			= normal_i2c,		/* cheat */
 	.ignore_range		= normal_i2c_range,	/* cheat */
 	.forces			= forces,
diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2004-11-08 18:55:16 -08:00
+++ b/drivers/i2c/chips/smsc47m1.c	2004-11-08 18:55:16 -08:00
@@ -46,8 +46,6 @@
 	.normal_i2c_range	= normal_i2c_range,
 	.normal_isa		= normal_isa,
 	.normal_isa_range	= normal_isa_range,
-	.probe			= normal_i2c,		/* cheat */
-	.probe_range		= normal_i2c_range,	/* cheat */
 	.ignore			= normal_i2c,		/* cheat */
 	.ignore_range		= normal_i2c_range,	/* cheat */
 	.forces			= forces,
diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:55:16 -08:00
+++ b/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:55:16 -08:00
@@ -138,15 +138,6 @@
 				found = 1;
 			}
 		}
-		for (i = 0; !found && (address_data->probe_range[i] != I2C_CLIENT_END); i += 3) {
-			if ( ((adapter_id == address_data->probe_range[i]) ||
-			      ((address_data->probe_range[i] == ANY_I2C_BUS) && !is_isa)) &&
-			     (addr >= address_data->probe_range[i + 1]) &&
-			     (addr <= address_data->probe_range[i + 2])) {
-				found = 1;
-				dev_dbg(&adapter->dev, "found probe_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
-			}
-		}
 		if (!found)
 			continue;
 
diff -Nru a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h	2004-11-08 18:55:16 -08:00
+++ b/include/linux/i2c-sensor.h	2004-11-08 18:55:16 -08:00
@@ -58,12 +58,6 @@
      A list of pairs. The first value is a bus number (ANY_I2C_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second is the address. These
      addresses are also probed, as if they were in the 'normal' list.
-   probe_range: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END 
-     values.
-     A list of triples. The first value is a bus number (ANY_I2C_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
-     These form an inclusive range of addresses that are also probed, as
-     if they were in the 'normal' list.
    ignore: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END values.
      A list of pairs. The first value is a bus number (ANY_I2C_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second is the I2C address. These
@@ -84,7 +78,6 @@
 	unsigned int *normal_isa;
 	unsigned int *normal_isa_range;
 	unsigned short *probe;
-	unsigned short *probe_range;
 	unsigned short *ignore;
 	unsigned short *ignore_range;
 	struct i2c_force_data *forces;
@@ -100,9 +93,6 @@
 #define SENSORS_INSMOD \
   I2C_CLIENT_MODULE_PARM(probe, \
                       "List of adapter,address pairs to scan additionally"); \
-  I2C_CLIENT_MODULE_PARM(probe_range, \
-                      "List of adapter,start-addr,end-addr triples to scan " \
-                      "additionally"); \
   I2C_CLIENT_MODULE_PARM(ignore, \
                       "List of adapter,address pairs not to scan"); \
   I2C_CLIENT_MODULE_PARM(ignore_range, \
@@ -114,7 +104,6 @@
 			.normal_isa =		normal_isa,		\
 			.normal_isa_range =	normal_isa_range,	\
 			.probe =		probe,			\
-			.probe_range =		probe_range,		\
 			.ignore =		ignore,			\
 			.ignore_range =		ignore_range,		\
 			.forces =		forces,			\

