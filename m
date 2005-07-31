Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVGaTVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVGaTVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVGaTVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:21:13 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:47890 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261926AbVGaTUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:20:47 -0400
Date: Sun, 31 Jul 2005 21:20:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (1/11) hwmon vs i2c, second round
Message-Id: <20050731212043.27b68f44.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for kind-forced addresses to i2c_probe, like i2c_detect
has for (essentially) hardware monitoring drivers.

Note that this change will slightly increase the size of the drivers
using I2C_CLIENT_INSMOD, with no immediate benefit. This is a
requirement if we want to merge i2c_probe and i2c_detect though, and
seems a reasonable price to pay in comparison with the previous
cleanups which saved much more than that (such as the i2c-isa cleanup
or the i2c address ranges removal.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/ds1374.c       |    1 -
 drivers/i2c/chips/m41t00.c       |    1 -
 drivers/i2c/chips/rtc8564.c      |    1 -
 drivers/i2c/i2c-core.c           |   38 ++++++++++++++++++++++++++++----------
 drivers/media/video/adv7170.c    |    1 -
 drivers/media/video/adv7175.c    |    1 -
 drivers/media/video/bt819.c      |    1 -
 drivers/media/video/bt856.c      |    1 -
 drivers/media/video/saa7110.c    |    1 -
 drivers/media/video/saa7111.c    |    1 -
 drivers/media/video/saa7114.c    |    1 -
 drivers/media/video/saa7185.c    |    1 -
 drivers/media/video/tuner-3036.c |    1 -
 drivers/media/video/vpx3220.c    |    1 -
 include/linux/i2c.h              |    9 ++++++---
 15 files changed, 34 insertions(+), 26 deletions(-)

--- linux-2.6.13-rc4.orig/drivers/media/video/adv7170.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/adv7170.c	2005-07-31 20:56:05.000000000 +0200
@@ -391,7 +391,6 @@
 	.normal_i2c		= normal_i2c,
 	.probe			= &ignore,
 	.ignore			= &ignore,
-	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_adv7170;
--- linux-2.6.13-rc4.orig/drivers/media/video/adv7175.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/adv7175.c	2005-07-31 20:56:05.000000000 +0200
@@ -441,7 +441,6 @@
 	.normal_i2c		= normal_i2c,
 	.probe			= &ignore,
 	.ignore			= &ignore,
-	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_adv7175;
--- linux-2.6.13-rc4.orig/drivers/media/video/bt819.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/bt819.c	2005-07-31 20:56:05.000000000 +0200
@@ -507,7 +507,6 @@
 	.normal_i2c		= normal_i2c,
 	.probe			= &ignore,
 	.ignore			= &ignore,
-	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_bt819;
--- linux-2.6.13-rc4.orig/drivers/media/video/bt856.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/bt856.c	2005-07-31 20:56:05.000000000 +0200
@@ -295,7 +295,6 @@
 	.normal_i2c		= normal_i2c,
 	.probe			= &ignore,
 	.ignore			= &ignore,
-	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_bt856;
--- linux-2.6.13-rc4.orig/drivers/media/video/saa7110.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/saa7110.c	2005-07-31 20:56:05.000000000 +0200
@@ -470,7 +470,6 @@
 	.normal_i2c		= normal_i2c,
 	.probe			= &ignore,
 	.ignore			= &ignore,
-	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7110;
--- linux-2.6.13-rc4.orig/drivers/media/video/saa7111.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/saa7111.c	2005-07-31 20:56:05.000000000 +0200
@@ -489,7 +489,6 @@
 	.normal_i2c		= normal_i2c,
 	.probe			= &ignore,
 	.ignore			= &ignore,
-	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7111;
--- linux-2.6.13-rc4.orig/drivers/media/video/saa7114.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/saa7114.c	2005-07-31 20:56:05.000000000 +0200
@@ -827,7 +827,6 @@
 	.normal_i2c		= normal_i2c,
 	.probe			= &ignore,
 	.ignore			= &ignore,
-	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7114;
--- linux-2.6.13-rc4.orig/drivers/media/video/saa7185.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/saa7185.c	2005-07-31 20:56:05.000000000 +0200
@@ -387,7 +387,6 @@
 	.normal_i2c		= normal_i2c,
 	.probe			= &ignore,
 	.ignore			= &ignore,
-	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7185;
--- linux-2.6.13-rc4.orig/drivers/media/video/tuner-3036.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/tuner-3036.c	2005-07-31 20:56:05.000000000 +0200
@@ -41,7 +41,6 @@
 	.normal_i2c	= normal_i2c,
 	.probe		= &ignore,
 	.ignore		= &ignore,
-	.force		= &ignore,
 };
 
 /* ---------------------------------------------------------------------- */
--- linux-2.6.13-rc4.orig/drivers/media/video/vpx3220.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/media/video/vpx3220.c	2005-07-31 20:56:05.000000000 +0200
@@ -576,7 +576,6 @@
 	.normal_i2c		= normal_i2c,
 	.probe			= &ignore,
 	.ignore			= &ignore,
-	.force			= &ignore,
 };
 
 static struct i2c_driver vpx3220_i2c_driver;
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/ds1374.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/ds1374.c	2005-07-31 20:56:05.000000000 +0200
@@ -53,7 +53,6 @@
 	.normal_i2c = normal_addr,
 	.probe = ignore,
 	.ignore = ignore,
-	.force = ignore,
 };
 
 static ulong ds1374_read_rtc(void)
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/m41t00.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/m41t00.c	2005-07-31 20:56:05.000000000 +0200
@@ -42,7 +42,6 @@
 	.normal_i2c		= normal_addr,
 	.probe			= ignore,
 	.ignore			= ignore,
-	.force			= ignore,
 };
 
 ulong
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/rtc8564.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/rtc8564.c	2005-07-31 20:56:05.000000000 +0200
@@ -67,7 +67,6 @@
 	.normal_i2c		= normal_addr,
 	.probe			= ignore,
 	.ignore			= ignore,
-	.force			= ignore,
 };
 
 static int rtc8564_read_mem(struct i2c_client *client, struct mem *mem);
--- linux-2.6.13-rc4.orig/drivers/i2c/i2c-core.c	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/i2c-core.c	2005-07-31 20:56:05.000000000 +0200
@@ -662,6 +662,28 @@
  * Will not work for 10-bit addresses!
  * ----------------------------------------------------
  */
+/* Return: kind (>= 0) if force found, -1 if not found */
+static inline int i2c_probe_forces(struct i2c_adapter *adapter, int addr,
+				   unsigned short **forces)
+{
+	unsigned short kind;
+	int j, adap_id = i2c_adapter_id(adapter);
+
+	for (kind = 0; forces[kind]; kind++) {
+		for (j = 0; forces[kind][j] != I2C_CLIENT_END; j += 2) {
+			if ((forces[kind][j] == adap_id ||
+			     forces[kind][j] == ANY_I2C_BUS)
+			 && forces[kind][j + 1] == addr) {
+				dev_dbg(&adapter->dev, "found force parameter, "
+					"addr 0x%02x, kind %u\n", addr, kind);
+				return kind;
+			}
+		}
+	}
+
+	return -1;
+}
+
 int i2c_probe(struct i2c_adapter *adapter,
 	      struct i2c_client_address_data *address_data,
 	      int (*found_proc) (struct i2c_adapter *, int, int))
@@ -683,19 +705,15 @@
 		   at all */
 		found = 0;
 
-		for (i = 0; !found && (address_data->force[i] != I2C_CLIENT_END); i += 2) {
-			if (((adap_id == address_data->force[i]) || 
-			     (address_data->force[i] == ANY_I2C_BUS)) &&
-			     (addr == address_data->force[i+1])) {
-				dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n",
-					adap_id, addr);
-				if ((err = found_proc(adapter,addr,0)))
+		if (address_data->forces) {
+			int kind = i2c_probe_forces(adapter, addr,
+						    address_data->forces);
+			if (kind >= 0) { /* force found */
+				if ((err = found_proc(adapter, addr, kind)))
 					return err;
-				found = 1;
+				continue;
 			}
 		}
-		if (found) 
-			continue;
 
 		/* If this address is in one of the ignores, we can forget about
 		   it right now */
--- linux-2.6.13-rc4.orig/include/linux/i2c.h	2005-07-31 16:03:01.000000000 +0200
+++ linux-2.6.13-rc4/include/linux/i2c.h	2005-07-31 20:56:05.000000000 +0200
@@ -48,7 +48,6 @@
 struct i2c_adapter;
 struct i2c_client;
 struct i2c_driver;
-struct i2c_client_address_data;
 union i2c_smbus_data;
 
 /*
@@ -301,7 +300,7 @@
 	unsigned short *normal_i2c;
 	unsigned short *probe;
 	unsigned short *ignore;
-	unsigned short *force;
+	unsigned short **forces;
 };
 
 /* Internal numbers to terminate lists */
@@ -575,11 +574,15 @@
   I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
+	static unsigned short *addr_forces[] = {			\
+			force,						\
+			NULL						\
+		};							\
 	static struct i2c_client_address_data addr_data = {		\
 			.normal_i2c = 		normal_i2c,		\
 			.probe =		probe,			\
 			.ignore =		ignore,			\
-			.force =		force,			\
+			.forces =		addr_forces,		\
 		}
 
 #endif /* _LINUX_I2C_H */


-- 
Jean Delvare
