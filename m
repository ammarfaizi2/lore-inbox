Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbUCRBIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 20:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUCRBIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 20:08:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:34435 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262258AbUCRBH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 20:07:59 -0500
Date: Wed, 17 Mar 2004 17:08:21 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: davem@redhat.com, hennus@cybercomm.nl, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6 RFT] QIC-02 tape drive hookup to classes in sysfs
Message-ID: <16020000.1079572101@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a patch to hook up the qic02 tape device to have class
support in sysfs. I have verified it compiles. I do not have access to
the hardware to test. Could someone who does please verify?

>From the file:
* This is a driver for the Wangtek 5150 tape drive with
 * a QIC-02 controller for ISA-PC type computers.
 * Hopefully it will work with other QIC-02 tape drives as well.

Please consider for Testing or Inclusion

Hanna

----

diff -Nrup -Xdontdiff linux-2.6.4/drivers/char/tpqic02.c linux-2.6.4p/drivers/char/tpqic02.c
--- linux-2.6.4/drivers/char/tpqic02.c	2004-03-10 18:55:27.000000000 -0800
+++ linux-2.6.4p/drivers/char/tpqic02.c	2004-03-17 16:19:44.000000000 -0800
@@ -94,6 +94,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #include <asm/dma.h>
 #include <asm/system.h>
@@ -229,6 +230,8 @@ static const char *format_names[] = {
 	"600"			/* untested. */
 };
 
+static struct class_simple *tpqic02_class;
+
 
 /* `exception_list' is needed for exception status reporting.
  * Exceptions 1..14 are defined by QIC-02 rev F.
@@ -2696,23 +2699,32 @@ int __init qic02_tape_init(void)
 		return -ENODEV;
 	}
 
+	tpqic02_class = class_simple_create(THIS_MODULE, TPQIC02_NAME);
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 2), NULL, "ntpqic11");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 2),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "ntpqic11");
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 3), NULL, "tpqic11");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 3),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "tpqic11");
 
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 4), NULL, "ntpqic24");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 4),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "ntpqic24");
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 5), NULL, "tpqic24");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 5),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "tpqic24");
 
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 6), NULL, "ntpqic20");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 6),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "ntpqic120");
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 7), NULL, "tpqic20");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 7),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "tpqic120");
 
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 8), NULL, "ntpqic50");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 8),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "ntpqic150");
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 9), NULL, "tpqic50");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 9),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "tpqic150");
 
@@ -2757,13 +2769,23 @@ static void qic02_module_exit(void)
 		qic02_release_resources();
 		
 	devfs_remove("ntpqic11");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 2));
 	devfs_remove("tpqic11");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 3));
 	devfs_remove("ntpqic24");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 4));
 	devfs_remove("tpqic24");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 5));
 	devfs_remove("ntpqic120");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 6));
 	devfs_remove("tpqic120");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 7));
 	devfs_remove("ntpqic150");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 8));
 	devfs_remove("tpqic150");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 9));
+
+	class_simple_destroy(tpqic02_class);
 }
 
 static int qic02_module_init(void)


