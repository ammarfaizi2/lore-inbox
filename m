Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbUCPC0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUCPBXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:23:48 -0500
Received: from mail.kroah.org ([65.200.24.183]:47791 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262930AbUCPADF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:05 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <107939139468@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:34 -0800
Message-Id: <1079391394165@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.13, 2004/03/15 10:45:02-08:00, greg@kroah.com

[PATCH] I2C: fix up CONFIG_I2C_DEBUG_CHIP logic to be simpler on the .c files.


 drivers/i2c/chips/Makefile    |    4 ++++
 drivers/i2c/chips/adm1021.c   |    4 ----
 drivers/i2c/chips/asb100.c    |    4 ----
 drivers/i2c/chips/eeprom.c    |    4 ----
 drivers/i2c/chips/fscher.c    |    4 ----
 drivers/i2c/chips/gl518sm.c   |    4 ----
 drivers/i2c/chips/it87.c      |    4 ----
 drivers/i2c/chips/lm75.c      |    4 ----
 drivers/i2c/chips/lm78.c      |    4 ----
 drivers/i2c/chips/lm80.c      |    4 ----
 drivers/i2c/chips/lm83.c      |    4 ----
 drivers/i2c/chips/lm85.c      |    4 ----
 drivers/i2c/chips/lm90.c      |    4 ----
 drivers/i2c/chips/via686a.c   |    4 ----
 drivers/i2c/chips/w83781d.c   |    4 ----
 drivers/i2c/chips/w83l785ts.c |    4 ----
 16 files changed, 4 insertions(+), 60 deletions(-)


diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/Makefile	Mon Mar 15 14:34:13 2004
@@ -20,3 +20,7 @@
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
+
+ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:34:13 2004
@@ -20,10 +20,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/asb100.c	Mon Mar 15 14:34:13 2004
@@ -37,10 +37,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/eeprom.c	Mon Mar 15 14:34:13 2004
@@ -27,10 +27,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/fscher.c	Mon Mar 15 14:34:13 2004
@@ -27,10 +27,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:34:13 2004
@@ -37,10 +37,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/it87.c	Mon Mar 15 14:34:13 2004
@@ -32,10 +32,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/lm75.c	Mon Mar 15 14:34:13 2004
@@ -19,10 +19,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/lm78.c	Mon Mar 15 14:34:13 2004
@@ -19,10 +19,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/lm80.c	Mon Mar 15 14:34:13 2004
@@ -22,10 +22,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/lm83.c	Mon Mar 15 14:34:13 2004
@@ -28,10 +28,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/lm85.c	Mon Mar 15 14:34:13 2004
@@ -23,10 +23,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/lm90.c	Mon Mar 15 14:34:13 2004
@@ -36,10 +36,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/via686a.c	Mon Mar 15 14:34:13 2004
@@ -32,10 +32,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:34:13 2004
@@ -36,10 +36,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:34:13 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:34:13 2004
@@ -31,10 +31,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CHIP
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>

