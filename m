Return-Path: <linux-kernel-owner+w=401wt.eu-S1030344AbWLTUEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWLTUEm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWLTUEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:04:42 -0500
Received: from ns2.suse.de ([195.135.220.15]:52876 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030344AbWLTUEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:04:41 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/3] Driver core: proper prototype for drivers/base/init.c:driver_init()
Date: Wed, 20 Dec 2006 12:03:57 -0800
Message-Id: <11666450471497-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11666450412291-git-send-email-greg@kroah.com>
References: <20061220200151.GC1698@kroah.com> <11666450372548-git-send-email-greg@kroah.com> <11666450412291-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

Add a prototype for driver_init() in include/linux/device.h.

Also remove a static function of the same name in drivers/acpi/ibm_acpi.c to
ibm_acpi_driver_init() to fix the namespace collision.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/acpi/ibm_acpi.c |    4 ++--
 include/linux/device.h  |    2 ++
 init/main.c             |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 003a987..5a84459 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -352,7 +352,7 @@ static char *next_cmd(char **cmds)
 	return start;
 }
 
-static int driver_init(void)
+static int ibm_acpi_driver_init(void)
 {
 	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
 	printk(IBM_INFO "%s\n", IBM_URL);
@@ -1605,7 +1605,7 @@ static int fan_write(char *buf)
 static struct ibm_struct ibms[] = {
 	{
 	 .name = "driver",
-	 .init = driver_init,
+	 .init = ibm_acpi_driver_init,
 	 .read = driver_read,
 	 },
 	{
diff --git a/include/linux/device.h b/include/linux/device.h
index 49ab53c..f44247f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -433,6 +433,8 @@ static inline int device_is_registered(struct device *dev)
 	return dev->is_registered;
 }
 
+void driver_init(void);
+
 /*
  * High level routines for use by the bus drivers
  */
diff --git a/init/main.c b/init/main.c
index e3f0bb2..2b1cdaa 100644
--- a/init/main.c
+++ b/init/main.c
@@ -53,6 +53,7 @@
 #include <linux/utsrelease.h>
 #include <linux/pid_namespace.h>
 #include <linux/compile.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -94,7 +95,6 @@ extern void pidmap_init(void);
 extern void prio_tree_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
-extern void driver_init(void);
 extern void prepare_namespace(void);
 #ifdef	CONFIG_ACPI
 extern void acpi_early_init(void);
-- 
1.4.4.2

