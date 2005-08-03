Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVHCXLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVHCXLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVHCXI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:08:58 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:59525 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261628AbVHCXHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:07:35 -0400
Message-ID: <42F14E33.2020606@acm.org>
Date: Wed, 03 Aug 2005 18:07:31 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IPMI driver update part 6, clean up versioning of the IPMI
 driver
Content-Type: multipart/mixed;
 boundary="------------080802080608070605080701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080802080608070605080701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080802080608070605080701
Content-Type: unknown/unknown;
 name="ipmi-add-module-info-tags.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-add-module-info-tags.patch"


This adds MODULE_VERSION, MODULE_DESCRIPTION, and MODULE_AUTHOR tags
to the IPMI driver modules.  Also changes the MODULE_VERSION to remove
the prepended 'v' on each value, consistent with the module versioning
policy.

This patch also removes all the version information from everything
except the ipmi_msghandler module.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_bt_sm.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_bt_sm.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_bt_sm.c
@@ -31,8 +31,6 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-#define IPMI_BT_VERSION "v33"
-
 static int bt_debug = 0x00;	/* Production value 0, see following flags */
 
 #define	BT_DEBUG_ENABLE	1
@@ -501,7 +499,6 @@
 
 struct si_sm_handlers bt_smi_handlers =
 {
-	.version           = IPMI_BT_VERSION,
 	.init_data         = bt_init_data,
 	.start_transaction = bt_start_transaction,
 	.get_result        = bt_get_result,
Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_devintf.c
@@ -47,8 +47,6 @@
 #include <linux/device.h>
 #include <linux/compat.h>
 
-#define IPMI_DEVINTF_VERSION "v33"
-
 struct ipmi_file_private
 {
 	ipmi_user_t          user;
@@ -822,8 +820,7 @@
 	if (ipmi_major < 0)
 		return -EINVAL;
 
-	printk(KERN_INFO "ipmi device interface version "
-	       IPMI_DEVINTF_VERSION "\n");
+	printk(KERN_INFO "ipmi device interface\n");
 
 	ipmi_class = class_create(THIS_MODULE, "ipmi");
 	if (IS_ERR(ipmi_class)) {
@@ -866,3 +863,5 @@
 module_exit(cleanup_ipmi);
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Corey Minyard <minyard@mvista.com>");
+MODULE_DESCRIPTION("Linux device interface for the IPMI message handler.");
Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_kcs_sm.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_kcs_sm.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -42,8 +42,6 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-#define IPMI_KCS_VERSION "v33"
-
 /* Set this if you want a printout of why the state machine was hosed
    when it gets hosed. */
 #define DEBUG_HOSED_REASON
@@ -489,7 +487,6 @@
 
 struct si_sm_handlers kcs_smi_handlers =
 {
-	.version           = IPMI_KCS_VERSION,
 	.init_data         = init_kcs_data,
 	.start_transaction = start_kcs_transaction,
 	.get_result        = get_kcs_result,
Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_msghandler.c
@@ -47,7 +47,8 @@
 #include <linux/proc_fs.h>
 
 #define PFX "IPMI message handler: "
-#define IPMI_MSGHANDLER_VERSION "v33"
+
+#define IPMI_DRIVER_VERSION "36.0"
 
 static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
@@ -3150,7 +3151,7 @@
 		return 0;
 
 	printk(KERN_INFO "ipmi message handler version "
-	       IPMI_MSGHANDLER_VERSION "\n");
+	       IPMI_DRIVER_VERSION "\n");
 
 	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
 		ipmi_interfaces[i] = NULL;
@@ -3222,6 +3223,9 @@
 
 module_init(ipmi_init_msghandler_mod);
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Corey Minyard <minyard@mvista.com>");
+MODULE_DESCRIPTION("Incoming and outgoing message routing for an IPMI interface.");
+MODULE_VERSION(IPMI_DRIVER_VERSION);
 
 EXPORT_SYMBOL(ipmi_create_user);
 EXPORT_SYMBOL(ipmi_destroy_user);
Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_poweroff.c
@@ -42,7 +42,6 @@
 #include <linux/ipmi_smi.h>
 
 #define PFX "IPMI poweroff: "
-#define IPMI_POWEROFF_VERSION	"v33"
 
 /* Where to we insert our poweroff function? */
 extern void (*pm_power_off)(void);
@@ -582,8 +581,7 @@
 	struct proc_dir_entry *file;
 
 	printk ("Copyright (C) 2004 MontaVista Software -"
-		" IPMI Powerdown via sys_reboot version "
-		IPMI_POWEROFF_VERSION ".\n");
+		" IPMI Powerdown via sys_reboot.\n");
 
 	switch (poweroff_control) {
 		case IPMI_CHASSIS_POWER_CYCLE:
@@ -642,3 +640,5 @@
 
 module_init(ipmi_poweroff_init);
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Corey Minyard <minyard@mvista.com>");
+MODULE_DESCRIPTION("IPMI Poweroff extension to sys_reboot");
Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_si_intf.c
@@ -76,8 +76,6 @@
 #include "ipmi_si_sm.h"
 #include <linux/init.h>
 
-#define IPMI_SI_VERSION "v33"
-
 /* Measure times between events in the driver. */
 #undef DEBUG_TIMING
 
@@ -2381,15 +2379,7 @@
 		}
 	}
 
-	printk(KERN_INFO "IPMI System Interface driver version "
-	       IPMI_SI_VERSION);
-	if (kcs_smi_handlers.version)
-		printk(", KCS version %s", kcs_smi_handlers.version);
-	if (smic_smi_handlers.version)
-		printk(", SMIC version %s", smic_smi_handlers.version);
-	if (bt_smi_handlers.version)
-   	        printk(", BT version %s", bt_smi_handlers.version);
-	printk("\n");
+	printk(KERN_INFO "IPMI System Interface driver.\n");
 
 #ifdef CONFIG_X86
 	dmi_decode();
@@ -2501,3 +2491,5 @@
 module_exit(cleanup_ipmi_si);
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Corey Minyard <minyard@mvista.com>");
+MODULE_DESCRIPTION("Interface to the IPMI driver for the KCS, SMIC, and BT system interfaces.");
Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_smic_sm.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_smic_sm.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_smic_sm.c
@@ -46,8 +46,6 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-#define IPMI_SMIC_VERSION "v33"
-
 /* smic_debug is a bit-field
  *	SMIC_DEBUG_ENABLE -	turned on for now
  *	SMIC_DEBUG_MSG -	commands and their responses
@@ -588,7 +586,6 @@
 
 struct si_sm_handlers smic_smi_handlers =
 {
-	.version           = IPMI_SMIC_VERSION,
 	.init_data         = init_smic_data,
 	.start_transaction = start_smic_transaction,
 	.get_result        = smic_get_result,
Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_watchdog.c
@@ -53,8 +53,6 @@
 
 #define	PFX "IPMI Watchdog: "
 
-#define IPMI_WATCHDOG_VERSION "v33"
-
 /*
  * The IPMI command/response information for the watchdog timer.
  */
@@ -928,9 +926,6 @@
 {
 	int rv;
 
-	printk(KERN_INFO PFX "driver version "
-	       IPMI_WATCHDOG_VERSION "\n");
-
 	if (strcmp(action, "reset") == 0) {
 		action_val = WDOG_TIMEOUT_RESET;
 	} else if (strcmp(action, "none") == 0) {
@@ -1015,6 +1010,8 @@
 	register_reboot_notifier(&wdog_reboot_notifier);
 	notifier_chain_register(&panic_notifier_list, &wdog_panic_notifier);
 
+	printk(KERN_INFO PFX "driver initialized\n");
+
 	return 0;
 }
 
@@ -1066,3 +1063,5 @@
 module_exit(ipmi_wdog_exit);
 module_init(ipmi_wdog_init);
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Corey Minyard <minyard@mvista.com>");
+MODULE_DESCRIPTION("watchdog timer based upon the IPMI interface.");

--------------080802080608070605080701--
