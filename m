Return-Path: <linux-kernel-owner+w=401wt.eu-S1751514AbWLLQXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWLLQXX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWLLQXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:23:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3373 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751501AbWLLQWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:22:25 -0500
Date: Tue, 12 Dec 2006 17:22:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       ibm-acpi@hmh.eng.br, len.brown@intel.com, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [2.6 patch] proper prototype for drivers/base/init.c:driver_init()
Message-ID: <20061212162235.GQ28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a prototype for driver_init() in include/linux/device.h.

It also removes a static function of the same name in 
drivers/acpi/ibm_acpi.c to ibm_acpi_driver_init() to fix the namespace 
collision.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

---

 drivers/acpi/ibm_acpi.c |    4 ++--
 include/linux/device.h  |    2 ++
 init/main.c             |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.19-rc6-mm1/include/linux/device.h.old	2006-11-25 00:03:22.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/linux/device.h	2006-11-25 00:04:06.000000000 +0100
@@ -432,6 +432,8 @@
 	return dev->is_registered;
 }
 
+void driver_init(void);
+
 /*
  * High level routines for use by the bus drivers
  */
--- linux-2.6.19-rc6-mm1/init/main.c.old	2006-11-25 00:05:03.000000000 +0100
+++ linux-2.6.19-rc6-mm1/init/main.c	2006-11-25 00:05:58.000000000 +0100
@@ -52,8 +52,9 @@
 #include <linux/debug_locks.h>
 #include <linux/lockdep.h>
 #include <linux/utsrelease.h>
 #include <linux/pid_namespace.h>
 #include <linux/compile.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -90,7 +91,6 @@
 extern void radix_tree_init(void);
 extern void free_initmem(void);
 extern void populate_rootfs(void);
-extern void driver_init(void);
 extern void prepare_namespace(void);
 #ifdef	CONFIG_ACPI
 extern void acpi_early_init(void);
--- linux-2.6.19-rc6-mm1/drivers/acpi/ibm_acpi.c.old	2006-11-25 00:06:12.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/acpi/ibm_acpi.c	2006-11-25 00:06:37.000000000 +0100
@@ -355,7 +355,7 @@
 	return start;
 }
 
-static int driver_init(void)
+static int ibm_acpi_driver_init(void)
 {
 	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
 	printk(IBM_INFO "%s\n", IBM_URL);
@@ -1634,7 +1634,7 @@
 static struct ibm_struct ibms[] = {
 	{
 	 .name = "driver",
-	 .init = driver_init,
+	 .init = ibm_acpi_driver_init,
 	 .read = driver_read,
 	 },
 	{

