Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTLXXLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 18:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTLXXLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 18:11:09 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:6922 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264104AbTLXXLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 18:11:01 -0500
Date: Thu, 25 Dec 2003 00:11:57 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, second wave (5/5)
Message-Id: <20031225001157.6354b903.khali@linux-fr.org>
In-Reply-To: <20031224225707.749707e5.khali@linux-fr.org>
References: <20031224225707.749707e5.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And finally, this patch adds documentation for the i2c-velleman driver,
and also fixes a typo (the device is refered to as K9000 in many places
while its real name is actually K8000).

I'll send a similar patch to Greg KH for Linux 2.6 in a few days.

Thanks!

diff -ruN linux-2.4.24-pre2/Documentation/Configure.help linux-2.4.24-pre2-k5/Documentation/Configure.help
--- linux-2.4.24-pre2/Documentation/Configure.help	Tue Dec 23 22:19:41 2003
+++ linux-2.4.24-pre2-k5/Documentation/Configure.help	Wed Dec 24 22:25:24 2003
@@ -19052,9 +19052,9 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-elv.o.
 
-Velleman K9000 adapter
+Velleman K8000 adapter
 CONFIG_I2C_VELLEMAN
-  This supports the Velleman K9000 parallel-port I2C adapter.  Say Y
+  This supports the Velleman K8000 parallel-port I2C adapter.  Say Y
   if you own such an adapter.
 
   This driver is also available as a module.  If you want to compile
diff -ruN linux-2.4.24-pre2/Documentation/i2c/i2c-velleman linux-2.4.24-pre2-k5/Documentation/i2c/i2c-velleman
--- linux-2.4.24-pre2/Documentation/i2c/i2c-velleman	Thu Jan  1 01:00:00 1970
+++ linux-2.4.24-pre2-k5/Documentation/i2c/i2c-velleman	Wed Dec 24 22:25:24 2003
@@ -0,0 +1,23 @@
+i2c-velleman driver
+-------------------
+This is a driver for i2c-hw access for Velleman K8000 and other adapters.
+
+Useful links
+------------
+Velleman:
+	http://www.velleman.be/
+
+Velleman K8000 Howto:
+	http://howto.htlw16.ac.at/k8000-howto.html
+
+K8000 and K8005 libraries
+-------------------------
+The project has lead to new libs for the Velleman K8000 and K8005:
+LIBK8000 v1.99.1 and LIBK8005 v0.21
+
+With these libs, you can control the K8000 interface card and the K8005
+stepper motor card with the simple commands which are in the original
+Velleman software, like SetIOchannel, ReadADchannel, SendStepCCWFull and
+many more, using /dev/velleman.
+
+The libs can be found on http://groups.yahoo.com/group/k8000/files/linux/
diff -ruN linux-2.4.24-pre2/Documentation/i2c/summary linux-2.4.24-pre2-k5/Documentation/i2c/summary
--- linux-2.4.24-pre2/Documentation/i2c/summary	Mon Dec 22 21:50:09 2003
+++ linux-2.4.24-pre2-k5/Documentation/i2c/summary	Wed Dec 24 22:25:24 2003
@@ -71,5 +71,5 @@
 i2c-ppc405:      IBM 405xx processor I2C device (uses i2c-algo-ppc405) (NOT BUILT BY DEFAULT)
 i2c-pport:       Primitive parallel port adapter (uses i2c-algo-bit)
 i2c-rpx:         RPX board Motorola 8xx I2C device (uses i2c-algo-8xx) (NOT BUILT BY DEFAULT)
-i2c-velleman:    Velleman K9000 parallel port adapter (uses i2c-algo-bit)
+i2c-velleman:    Velleman K8000 parallel port adapter (uses i2c-algo-bit)
 
diff -ruN linux-2.4.24-pre2/drivers/i2c/Config.in linux-2.4.24-pre2-k5/drivers/i2c/Config.in
--- linux-2.4.24-pre2/drivers/i2c/Config.in	Tue Dec 23 22:19:41 2003
+++ linux-2.4.24-pre2-k5/drivers/i2c/Config.in	Wed Dec 24 22:25:47 2003
@@ -12,7 +12,7 @@
    if [ "$CONFIG_I2C_ALGOBIT" != "n" ]; then
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
-      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Velleman K8000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
       dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_SCx200 $CONFIG_I2C_ALGOBIT
       if [ "$CONFIG_SCx200_I2C" != "n" ]; then
          int  '    GPIO pin used for SCL' CONFIG_SCx200_I2C_SCL 12
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-velleman.c linux-2.4.24-pre2-k5/drivers/i2c/i2c-velleman.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-velleman.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k5/drivers/i2c/i2c-velleman.c	Wed Dec 24 22:25:24 2003
@@ -1,5 +1,5 @@
 /* ------------------------------------------------------------------------- */
-/* i2c-velleman.c i2c-hw access for Velleman K9000 adapters		     */
+/* i2c-velleman.c i2c-hw access for Velleman K8000 adapters		     */
 /* ------------------------------------------------------------------------- */
 /*   Copyright (C) 1995-96, 2000 Simon G. Vogl
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
