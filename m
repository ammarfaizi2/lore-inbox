Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbUCCEap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbUCCEap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:30:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:37762 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262362AbUCCEWA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:00 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
In-Reply-To: <10782873992219@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:16:39 -0800
Message-Id: <10782873993395@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1612.24.4, 2004/03/02 16:39:36-08:00, greg@kroah.com

Driver core: add CONFIG_DEBUG_DRIVER to help track down driver core bugs easier.


 drivers/base/Kconfig          |   11 +++++++++++
 drivers/base/bus.c            |    5 ++++-
 drivers/base/class.c          |    5 ++++-
 drivers/base/class_simple.c   |    5 ++++-
 drivers/base/core.c           |    5 ++++-
 drivers/base/driver.c         |    5 ++++-
 drivers/base/power/main.c     |    5 ++++-
 drivers/base/power/shutdown.c |    7 +++++--
 drivers/base/sys.c            |    5 ++++-
 9 files changed, 44 insertions(+), 9 deletions(-)


diff -Nru a/drivers/base/Kconfig b/drivers/base/Kconfig
--- a/drivers/base/Kconfig	Tue Mar  2 19:48:11 2004
+++ b/drivers/base/Kconfig	Tue Mar  2 19:48:11 2004
@@ -8,4 +8,15 @@
 	  require hotplug firmware loading support, but a module built outside
 	  the kernel tree does.
 
+config DEBUG_DRIVER
+        bool "Driver Core verbose debug messages"
+        depends on DEBUG_KERNEL
+        help
+          Say Y here if you want the Driver core to produce a bunch of
+          debug messages to the system log. Select this if you are having a
+          problem with the driver core and want to see more of what is
+          going on.
+
+          If you are unsure about this, say N here.
+
 endmenu
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Tue Mar  2 19:48:11 2004
+++ b/drivers/base/bus.c	Tue Mar  2 19:48:11 2004
@@ -8,7 +8,10 @@
  *
  */
 
-#undef DEBUG
+#include <linux/config.h>
+#ifdef CONFIG_DEBUG_DRIVER
+#define DEBUG	1
+#endif
 
 #include <linux/device.h>
 #include <linux/module.h>
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Tue Mar  2 19:48:11 2004
+++ b/drivers/base/class.c	Tue Mar  2 19:48:11 2004
@@ -10,7 +10,10 @@
  *
  */
 
-#undef DEBUG
+#include <linux/config.h>
+#ifdef CONFIG_DEBUG_DRIVER
+#define DEBUG	1
+#endif
 
 #include <linux/device.h>
 #include <linux/module.h>
diff -Nru a/drivers/base/class_simple.c b/drivers/base/class_simple.c
--- a/drivers/base/class_simple.c	Tue Mar  2 19:48:11 2004
+++ b/drivers/base/class_simple.c	Tue Mar  2 19:48:11 2004
@@ -8,7 +8,10 @@
  *
  */
 
-#define DEBUG 1
+#include <linux/config.h>
+#ifdef CONFIG_DEBUG_DRIVER
+#define DEBUG	1
+#endif
 
 #include <linux/device.h>
 #include <linux/kdev_t.h>
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Tue Mar  2 19:48:11 2004
+++ b/drivers/base/core.c	Tue Mar  2 19:48:11 2004
@@ -8,7 +8,10 @@
  *
  */
 
-#undef DEBUG
+#include <linux/config.h>
+#ifdef CONFIG_DEBUG_DRIVER
+#define DEBUG	1
+#endif
 
 #include <linux/device.h>
 #include <linux/err.h>
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Tue Mar  2 19:48:11 2004
+++ b/drivers/base/driver.c	Tue Mar  2 19:48:11 2004
@@ -8,7 +8,10 @@
  *
  */
 
-#undef DEBUG
+#include <linux/config.h>
+#ifdef CONFIG_DEBUG_DRIVER
+#define DEBUG	1
+#endif
 
 #include <linux/device.h>
 #include <linux/module.h>
diff -Nru a/drivers/base/power/main.c b/drivers/base/power/main.c
--- a/drivers/base/power/main.c	Tue Mar  2 19:48:11 2004
+++ b/drivers/base/power/main.c	Tue Mar  2 19:48:11 2004
@@ -19,7 +19,10 @@
  * ancestral dependencies that the subsystem list maintains.
  */
 
-#undef DEBUG
+#include <linux/config.h>
+#ifdef CONFIG_DEBUG_DRIVER
+#define DEBUG	1
+#endif
 
 #include <linux/device.h>
 #include "power.h"
diff -Nru a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
--- a/drivers/base/power/shutdown.c	Tue Mar  2 19:48:11 2004
+++ b/drivers/base/power/shutdown.c	Tue Mar  2 19:48:11 2004
@@ -8,7 +8,10 @@
  *
  */
 
-#undef DEBUG
+#include <linux/config.h>
+#ifdef CONFIG_DEBUG_DRIVER
+#define DEBUG	1
+#endif
 
 #include <linux/device.h>
 #include <asm/semaphore.h>
@@ -54,7 +57,7 @@
 	
 	down_write(&devices_subsys.rwsem);
 	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
-		pr_debug("shutting down %s: ",dev->name);
+		pr_debug("shutting down %s: ",dev->bus_id);
 		if (dev->driver && dev->driver->shutdown) {
 			pr_debug("Ok\n");
 			dev->driver->shutdown(dev);
diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	Tue Mar  2 19:48:11 2004
+++ b/drivers/base/sys.c	Tue Mar  2 19:48:11 2004
@@ -12,7 +12,10 @@
  * add themselves as children of the system bus.
  */
 
-#undef DEBUG
+#include <linux/config.h>
+#ifdef CONFIG_DEBUG_DRIVER
+#define DEBUG	1
+#endif
 
 #include <linux/sysdev.h>
 #include <linux/err.h>

