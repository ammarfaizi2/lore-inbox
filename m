Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbTBFEEY>; Wed, 5 Feb 2003 23:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbTBFEEC>; Wed, 5 Feb 2003 23:04:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:46352 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265368AbTBFECx>;
	Wed, 5 Feb 2003 23:02:53 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044851666@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044851308@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.4, 2003/02/05 17:17:06+11:00, stanley.wang@linux.co.intel.com

[PATCH] PCI Hotplug: Remove procfs stuff from pci_hotplug_core

Here is a little patch that remove procfs stuff in pci_hotplug_core.c
Remove /proc entry for pci_hotplug_core.


diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Feb  6 14:52:13 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Feb  6 14:52:13 2003
@@ -40,7 +40,6 @@
 #include <linux/namei.h>
 #include <linux/pci.h>
 #include <linux/dnotify.h>
-#include <linux/proc_fs.h>
 #include <asm/uaccess.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
@@ -131,12 +130,6 @@
 	"133 MHz PCIX 533",	/* 0x13 */
 };
 
-#ifdef CONFIG_PROC_FS		
-extern struct proc_dir_entry *proc_bus_pci_dir;
-static struct proc_dir_entry *slotdir = NULL;
-static const char *slotdir_name = "slots";
-#endif
-
 #ifdef CONFIG_HOTPLUG_PCI_CPCI
 extern int cpci_hotplug_init(int debug);
 extern void cpci_hotplug_exit(void);
@@ -568,11 +561,6 @@
 		goto err_subsys;
 	}
 
-#ifdef CONFIG_PROC_FS
-	/* create mount point for pcihpfs */
-	slotdir = proc_mkdir(slotdir_name, proc_bus_pci_dir);
-#endif
-
 	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	goto exit;
 	
@@ -584,11 +572,6 @@
 
 static void __exit pci_hotplug_exit (void)
 {
-#ifdef CONFIG_PROC_FS
-	if (slotdir)
-		remove_proc_entry(slotdir_name, proc_bus_pci_dir);
-#endif
-
 	cpci_hotplug_exit();
 	subsystem_unregister(&hotplug_slots_subsys);
 }

