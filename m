Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbUCPASq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUCPAGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:06:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:9135 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262885AbUCPACG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:06 -0500
Subject: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <20040315235558.GA23280@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:05 -0800
Message-Id: <10793951453984@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.1, 2004/03/09 14:25:46-08:00, greg@kroah.com

Driver core: make CONFIG_DEBUG_DRIVER implementation a whole lot cleaner


 drivers/base/Makefile         |    5 +++++
 drivers/base/bus.c            |    4 ----
 drivers/base/class.c          |    4 ----
 drivers/base/class_simple.c   |    4 ----
 drivers/base/core.c           |    4 ----
 drivers/base/driver.c         |    4 ----
 drivers/base/power/Makefile   |    4 ++++
 drivers/base/power/main.c     |    4 ----
 drivers/base/power/shutdown.c |    4 ----
 drivers/base/sys.c            |    4 ----
 10 files changed, 9 insertions(+), 32 deletions(-)


diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/Makefile	Mon Mar 15 15:30:28 2004
@@ -6,3 +6,8 @@
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
+
+ifeq ($(CONFIG_DEBUG_DRIVER),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/bus.c	Mon Mar 15 15:30:28 2004
@@ -9,10 +9,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_DEBUG_DRIVER
-#define DEBUG	1
-#endif
-
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/errno.h>
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/class.c	Mon Mar 15 15:30:28 2004
@@ -11,10 +11,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_DEBUG_DRIVER
-#define DEBUG	1
-#endif
-
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/base/class_simple.c b/drivers/base/class_simple.c
--- a/drivers/base/class_simple.c	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/class_simple.c	Mon Mar 15 15:30:28 2004
@@ -9,10 +9,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_DEBUG_DRIVER
-#define DEBUG	1
-#endif
-
 #include <linux/device.h>
 #include <linux/kdev_t.h>
 #include <linux/err.h>
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/core.c	Mon Mar 15 15:30:28 2004
@@ -9,10 +9,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_DEBUG_DRIVER
-#define DEBUG	1
-#endif
-
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/driver.c	Mon Mar 15 15:30:28 2004
@@ -9,10 +9,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_DEBUG_DRIVER
-#define DEBUG	1
-#endif
-
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/errno.h>
diff -Nru a/drivers/base/power/Makefile b/drivers/base/power/Makefile
--- a/drivers/base/power/Makefile	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/power/Makefile	Mon Mar 15 15:30:28 2004
@@ -1,2 +1,6 @@
 obj-y			:= shutdown.o
 obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o
+
+ifeq ($(CONFIG_DEBUG_DRIVER),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -Nru a/drivers/base/power/main.c b/drivers/base/power/main.c
--- a/drivers/base/power/main.c	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/power/main.c	Mon Mar 15 15:30:28 2004
@@ -20,10 +20,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_DEBUG_DRIVER
-#define DEBUG	1
-#endif
-
 #include <linux/device.h>
 #include "power.h"
 
diff -Nru a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
--- a/drivers/base/power/shutdown.c	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/power/shutdown.c	Mon Mar 15 15:30:28 2004
@@ -9,10 +9,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_DEBUG_DRIVER
-#define DEBUG	1
-#endif
-
 #include <linux/device.h>
 #include <asm/semaphore.h>
 
diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	Mon Mar 15 15:30:28 2004
+++ b/drivers/base/sys.c	Mon Mar 15 15:30:28 2004
@@ -13,10 +13,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_DEBUG_DRIVER
-#define DEBUG	1
-#endif
-
 #include <linux/sysdev.h>
 #include <linux/err.h>
 #include <linux/module.h>

