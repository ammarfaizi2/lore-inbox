Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267316AbUHPBh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267316AbUHPBh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 21:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUHPBh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 21:37:27 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:38050 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S267316AbUHPBhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 21:37:20 -0400
Subject: [PATCH] Fix Permissions on module_param Usage
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1092620209.29604.52.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 11:36:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a patch which checks for sane perms at compile time, but it
bloats modules, so I haven't included it.

Name: Fix Permissions on module_param Usage
Status: Tested on 2.6.8-rc4-bk1
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (authored)

module_param() and family take a "perms" argument; several people has
incorrectly "644" instead of "0644".

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/acpiphp_core.c .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/acpiphp_core.c
--- .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/acpiphp_core.c	2004-06-17 08:48:22.000000000 +1000
+++ .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/acpiphp_core.c	2004-08-12 13:25:46.000000000 +1000
@@ -60,7 +60,7 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
-module_param(debug, bool, 644);
+module_param(debug, bool, 0644);
 
 static int enable_slot		(struct hotplug_slot *slot);
 static int disable_slot		(struct hotplug_slot *slot);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/cpcihp_zt5550.c .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/cpcihp_zt5550.c
--- .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/cpcihp_zt5550.c	2004-06-17 08:48:22.000000000 +1000
+++ .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/cpcihp_zt5550.c	2004-08-12 13:25:50.000000000 +1000
@@ -298,7 +298,7 @@ module_exit(zt5550_exit);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-module_param(debug, bool, 644);
+module_param(debug, bool, 0644);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
-module_param(poll, bool, 644);
+module_param(poll, bool, 0644);
 MODULE_PARM_DESC(poll, "#ENUM polling mode enabled or not");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/cpqphp_core.c .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/cpqphp_core.c
--- .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/cpqphp_core.c	2004-06-17 08:48:23.000000000 +1000
+++ .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/cpqphp_core.c	2004-08-12 13:25:54.000000000 +1000
@@ -69,10 +69,10 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(power_mode, bool, 644);
+module_param(power_mode, bool, 0644);
 MODULE_PARM_DESC(power_mode, "Power mode enabled or not");
 
-module_param(debug, bool, 644);
+module_param(debug, bool, 0644);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 
 #define CPQHPC_MODULE_MINOR 208
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/pci_hotplug_core.c .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/pci_hotplug_core.c
--- .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/pci_hotplug_core.c	2004-06-17 08:48:23.000000000 +1000
+++ .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/pci_hotplug_core.c	2004-08-12 13:25:56.000000000 +1000
@@ -701,7 +701,7 @@ module_exit(pci_hotplug_exit);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-module_param(debug, bool, 644);
+module_param(debug, bool, 0644);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 
 EXPORT_SYMBOL_GPL(pci_hotplug_slots_subsys);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/pciehp_core.c .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/pciehp_core.c
--- .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/pciehp_core.c	2004-06-17 08:48:23.000000000 +1000
+++ .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/pciehp_core.c	2004-08-12 13:26:02.000000000 +1000
@@ -57,9 +57,9 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(pciehp_debug, bool, 644);
-module_param(pciehp_poll_mode, bool, 644);
-module_param(pciehp_poll_time, int, 644);
+module_param(pciehp_debug, bool, 0644);
+module_param(pciehp_poll_mode, bool, 0644);
+module_param(pciehp_poll_time, int, 0644);
 MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/pcihp_skeleton.c .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/pcihp_skeleton.c
--- .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/pcihp_skeleton.c	2004-06-17 08:48:23.000000000 +1000
+++ .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/pcihp_skeleton.c	2004-08-12 13:25:58.000000000 +1000
@@ -70,7 +70,7 @@ static int num_slots;
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-module_param(debug, bool, 644);
+module_param(debug, bool, 0644);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 
 static int enable_slot		(struct hotplug_slot *slot);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/shpchp_core.c .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/shpchp_core.c
--- .6168-linux-2.6.8-rc4-bk1/drivers/pci/hotplug/shpchp_core.c	2004-06-17 08:48:23.000000000 +1000
+++ .6168-linux-2.6.8-rc4-bk1.updated/drivers/pci/hotplug/shpchp_core.c	2004-08-12 13:26:10.000000000 +1000
@@ -57,9 +57,9 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(shpchp_debug, bool, 644);
-module_param(shpchp_poll_mode, bool, 644);
-module_param(shpchp_poll_time, int, 644);
+module_param(shpchp_debug, bool, 0644);
+module_param(shpchp_poll_mode, bool, 0644);
+module_param(shpchp_poll_time, int, 0644);
 MODULE_PARM_DESC(shpchp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(shpchp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(shpchp_poll_time, "Polling mechanism frequency, in seconds");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/drivers/usb/input/ati_remote.c .6168-linux-2.6.8-rc4-bk1.updated/drivers/usb/input/ati_remote.c
--- .6168-linux-2.6.8-rc4-bk1/drivers/usb/input/ati_remote.c	2004-08-11 09:41:59.000000000 +1000
+++ .6168-linux-2.6.8-rc4-bk1.updated/drivers/usb/input/ati_remote.c	2004-08-12 13:26:27.000000000 +1000
@@ -112,11 +112,11 @@
 #define ATI_INPUTNUM      1     /* Which input device to register as */
 
 static unsigned long channel_mask = 0;
-module_param(channel_mask, ulong, 444);
+module_param(channel_mask, ulong, 0444);
 MODULE_PARM_DESC(channel_mask, "Bitmask of remote control channels to ignore");
 
 static int debug = 0;
-module_param(debug, int, 444);
+module_param(debug, int, 0444);
 MODULE_PARM_DESC(debug, "Enable extra debug messages and information");
 
 #define dbginfo(dev, format, arg...) do { if (debug) dev_info(dev , format , ## arg); } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/fs/jfs/super.c .6168-linux-2.6.8-rc4-bk1.updated/fs/jfs/super.c
--- .6168-linux-2.6.8-rc4-bk1/fs/jfs/super.c	2004-08-11 09:42:05.000000000 +1000
+++ .6168-linux-2.6.8-rc4-bk1.updated/fs/jfs/super.c	2004-08-12 13:21:41.000000000 +1000
@@ -58,7 +58,7 @@ DECLARE_COMPLETION(jfsIOwait);
 
 #ifdef CONFIG_JFS_DEBUG
 int jfsloglevel = JFS_LOGLEVEL_WARN;
-module_param(jfsloglevel, int, 644);
+module_param(jfsloglevel, int, 0644);
 MODULE_PARM_DESC(jfsloglevel, "Specify JFS loglevel (0, 1 or 2)");
 #endif
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6168-linux-2.6.8-rc4-bk1/fs/lockd/svc.c .6168-linux-2.6.8-rc4-bk1.updated/fs/lockd/svc.c
--- .6168-linux-2.6.8-rc4-bk1/fs/lockd/svc.c	2004-03-12 07:57:15.000000000 +1100
+++ .6168-linux-2.6.8-rc4-bk1.updated/fs/lockd/svc.c	2004-08-12 13:21:35.000000000 +1000
@@ -409,13 +409,13 @@ MODULE_DESCRIPTION("NFS file locking ser
 MODULE_LICENSE("GPL");
 
 module_param_call(nlm_grace_period, param_set_grace_period, param_get_ulong,
-		  &nlm_grace_period, 644);
+		  &nlm_grace_period, 0644);
 module_param_call(nlm_timeout, param_set_timeout, param_get_ulong,
-		  &nlm_timeout, 644);
+		  &nlm_timeout, 0644);
 module_param_call(nlm_udpport, param_set_port, param_get_int,
-		  &nlm_udpport, 644);
+		  &nlm_udpport, 0644);
 module_param_call(nlm_tcpport, param_set_port, param_get_int,
-		  &nlm_tcpport, 644);
+		  &nlm_tcpport, 0644);
 
 /*
  * Initialising and terminating the module.

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

