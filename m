Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUCPCgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbUCPBWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:22:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:48559 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262931AbUCPADG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:06 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913942653@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:34 -0800
Message-Id: <107939139468@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.12, 2004/03/15 10:28:32-08:00, greg@kroah.com

[PATCH] I2C: add CONFIG_I2C_DEBUG_ALGO to be consistant.


 drivers/i2c/Kconfig              |    9 +++++++++
 drivers/i2c/algos/Makefile       |    4 ++++
 drivers/i2c/algos/i2c-algo-bit.c |    2 --
 drivers/i2c/algos/i2c-algo-pcf.c |    2 --
 4 files changed, 13 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Mar 15 14:34:18 2004
+++ b/drivers/i2c/Kconfig	Mon Mar 15 14:34:18 2004
@@ -46,6 +46,15 @@
 	  messages to the system log.  Select this if you are having a
 	  problem with I2C support and want to see more of what is going on.
 
+config I2C_DEBUG_ALGO
+	bool "I2C Algorithm debugging messages"
+	depends on I2C
+	help
+	  Say Y here if you want the I2C algorithm drivers to produce a bunch
+	  of debug messages to the system log.  Select this if you are having
+	  a problem with I2C support and want to see more of what is going
+	  on.
+
 config I2C_DEBUG_BUS
 	bool "I2C Bus debugging messages"
 	depends on I2C
diff -Nru a/drivers/i2c/algos/Makefile b/drivers/i2c/algos/Makefile
--- a/drivers/i2c/algos/Makefile	Mon Mar 15 14:34:18 2004
+++ b/drivers/i2c/algos/Makefile	Mon Mar 15 14:34:18 2004
@@ -5,3 +5,7 @@
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ALGOITE)	+= i2c-algo-ite.o
+
+ifeq ($(CONFIG_I2C_DEBUG_ALGO),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -Nru a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- a/drivers/i2c/algos/i2c-algo-bit.c	Mon Mar 15 14:34:18 2004
+++ b/drivers/i2c/algos/i2c-algo-bit.c	Mon Mar 15 14:34:18 2004
@@ -21,8 +21,6 @@
 /* With some changes from Frodo Looijaard <frodol@dds.nl>, Kyösti Mälkki
    <kmalkki@cc.hut.fi> and Jean Delvare <khali@linux-fr.org> */
 
-/* #define DEBUG 1 */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c	Mon Mar 15 14:34:18 2004
+++ b/drivers/i2c/algos/i2c-algo-pcf.c	Mon Mar 15 14:34:18 2004
@@ -27,8 +27,6 @@
    messages, proper stop/repstart signaling during receive,
    added detect code */
 
-/* #define DEBUG 1 */		/* to pick up dev_dbg calls */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>

