Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbUCCEh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUCCEhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:37:16 -0500
Received: from mail.kroah.org ([65.200.24.183]:40834 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262373AbUCCEWG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:06 -0500
Subject: [PATCH] Driver Core update for 2.6.4-rc1
In-Reply-To: <20040303041438.GA16958@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:16:38 -0800
Message-Id: <10782873972560@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.72.1, 2004/02/19 13:09:14-08:00, rddunlap@osdl.org

[PATCH] sys_device_[un]register() are not syscalls

sys_xyz() names in Linux are all syscalls... except for
sys_device_register() and sys_device_unregister().

This patch renames them so that the sys_ namespace is once
again used only by syscalls.


 arch/arm/kernel/time.c                   |    2 +-
 arch/arm/mach-integrator/integrator_ap.c |    2 +-
 arch/arm/mach-sa1100/irq.c               |    2 +-
 arch/i386/kernel/apic.c                  |    2 +-
 arch/i386/kernel/i8259.c                 |    4 ++--
 arch/i386/kernel/nmi.c                   |    2 +-
 arch/i386/kernel/time.c                  |    2 +-
 arch/i386/oprofile/nmi_int.c             |    4 ++--
 arch/mips/kernel/i8259.c                 |    2 +-
 arch/ppc/platforms/pmac_pic.c            |    2 +-
 arch/ppc/syslib/open_pic.c               |    2 +-
 arch/ppc/syslib/open_pic2.c              |    2 +-
 arch/x86_64/kernel/apic.c                |    2 +-
 arch/x86_64/kernel/i8259.c               |    2 +-
 arch/x86_64/kernel/nmi.c                 |    2 +-
 drivers/base/cpu.c                       |    2 +-
 drivers/base/node.c                      |    2 +-
 drivers/base/sys.c                       |   12 ++++++------
 drivers/input/serio/i8042.c              |    4 ++--
 drivers/s390/block/xpram.c               |    6 +++---
 include/linux/sysdev.h                   |    4 ++--
 21 files changed, 32 insertions(+), 32 deletions(-)


diff -Nru a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
--- a/arch/arm/kernel/time.c	Tue Mar  2 19:52:41 2004
+++ b/arch/arm/kernel/time.c	Tue Mar  2 19:52:41 2004
@@ -178,7 +178,7 @@
 	int ret;
 	ret = sysdev_class_register(&leds_sysclass);
 	if (ret == 0)
-		ret = sys_device_register(&leds_device);
+		ret = sysdev_register(&leds_device);
 	return ret;
 }
 
diff -Nru a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
--- a/arch/arm/mach-integrator/integrator_ap.c	Tue Mar  2 19:52:41 2004
+++ b/arch/arm/mach-integrator/integrator_ap.c	Tue Mar  2 19:52:41 2004
@@ -173,7 +173,7 @@
 {
 	int ret = sysdev_class_register(&irq_class);
 	if (ret == 0)
-		ret = sys_device_register(&irq_device);
+		ret = sysdev_register(&irq_device);
 	return ret;
 }
 
diff -Nru a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
--- a/arch/arm/mach-sa1100/irq.c	Tue Mar  2 19:52:41 2004
+++ b/arch/arm/mach-sa1100/irq.c	Tue Mar  2 19:52:41 2004
@@ -278,7 +278,7 @@
 static int __init sa1100irq_init_devicefs(void)
 {
 	sysdev_class_register(&sa1100irq_sysclass);
-	return sys_device_register(&sa1100irq_device);
+	return sysdev_register(&sa1100irq_device);
 }
 
 device_initcall(sa1100irq_init_devicefs);
diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	Tue Mar  2 19:52:41 2004
+++ b/arch/i386/kernel/apic.c	Tue Mar  2 19:52:41 2004
@@ -595,7 +595,7 @@
 
 	error = sysdev_class_register(&lapic_sysclass);
 	if (!error)
-		error = sys_device_register(&device_lapic);
+		error = sysdev_register(&device_lapic);
 	return error;
 }
 device_initcall(init_lapic_sysfs);
diff -Nru a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c	Tue Mar  2 19:52:41 2004
+++ b/arch/i386/kernel/i8259.c	Tue Mar  2 19:52:41 2004
@@ -258,7 +258,7 @@
 {
 	int error = sysdev_class_register(&i8259_sysdev_class);
 	if (!error)
-		error = sys_device_register(&device_i8259A);
+		error = sysdev_register(&device_i8259A);
 	return error;
 }
 
@@ -401,7 +401,7 @@
 {
 	int error = sysdev_class_register(&timer_sysclass);
 	if (!error)
-		error = sys_device_register(&device_timer);
+		error = sysdev_register(&device_timer);
 	return error;
 }
 
diff -Nru a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
--- a/arch/i386/kernel/nmi.c	Tue Mar  2 19:52:41 2004
+++ b/arch/i386/kernel/nmi.c	Tue Mar  2 19:52:41 2004
@@ -248,7 +248,7 @@
 
 	error = sysdev_class_register(&nmi_sysclass);
 	if (!error)
-		error = sys_device_register(&device_lapic_nmi);
+		error = sysdev_register(&device_lapic_nmi);
 	return error;
 }
 /* must come after the local APIC's device_initcall() */
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Mar  2 19:52:41 2004
+++ b/arch/i386/kernel/time.c	Tue Mar  2 19:52:41 2004
@@ -346,7 +346,7 @@
 {
 	int error = sysdev_class_register(&pit_sysclass);
 	if (!error)
-		error = sys_device_register(&device_i8253);
+		error = sysdev_register(&device_i8253);
 	return error;
 }
 
diff -Nru a/arch/i386/oprofile/nmi_int.c b/arch/i386/oprofile/nmi_int.c
--- a/arch/i386/oprofile/nmi_int.c	Tue Mar  2 19:52:41 2004
+++ b/arch/i386/oprofile/nmi_int.c	Tue Mar  2 19:52:41 2004
@@ -65,14 +65,14 @@
 {
 	int error;
 	if (!(error = sysdev_class_register(&oprofile_sysclass)))
-		error = sys_device_register(&device_oprofile);
+		error = sysdev_register(&device_oprofile);
 	return error;
 }
 
 
 static void __exit exit_driverfs(void)
 {
-	sys_device_unregister(&device_oprofile);
+	sysdev_unregister(&device_oprofile);
 	sysdev_class_unregister(&oprofile_sysclass);
 }
 
diff -Nru a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
--- a/arch/mips/kernel/i8259.c	Tue Mar  2 19:52:41 2004
+++ b/arch/mips/kernel/i8259.c	Tue Mar  2 19:52:41 2004
@@ -242,7 +242,7 @@
 {
 	int error = sysdev_class_register(&i8259_sysdev_class);
 	if (!error)
-		error = sys_device_register(&device_i8259A);
+		error = sysdev_register(&device_i8259A);
 	return error;
 }
 
diff -Nru a/arch/ppc/platforms/pmac_pic.c b/arch/ppc/platforms/pmac_pic.c
--- a/arch/ppc/platforms/pmac_pic.c	Tue Mar  2 19:52:41 2004
+++ b/arch/ppc/platforms/pmac_pic.c	Tue Mar  2 19:52:41 2004
@@ -646,7 +646,7 @@
 
 	printk(KERN_DEBUG "Registering pmac pic with sysfs...\n");
 	sysdev_class_register(&pmacpic_sysclass);
-	sys_device_register(&device_pmacpic);
+	sysdev_register(&device_pmacpic);
 	sysdev_driver_register(&pmacpic_sysclass, &driver_pmacpic);
 	return 0;
 }
diff -Nru a/arch/ppc/syslib/open_pic.c b/arch/ppc/syslib/open_pic.c
--- a/arch/ppc/syslib/open_pic.c	Tue Mar  2 19:52:41 2004
+++ b/arch/ppc/syslib/open_pic.c	Tue Mar  2 19:52:41 2004
@@ -1032,7 +1032,7 @@
 		printk(KERN_ERR "Failed registering openpic sys class\n");
 		return -ENODEV;
 	}
-	rc = sys_device_register(&device_openpic);
+	rc = sysdev_register(&device_openpic);
 	if (rc) {
 		printk(KERN_ERR "Failed registering openpic sys device\n");
 		return -ENODEV;
diff -Nru a/arch/ppc/syslib/open_pic2.c b/arch/ppc/syslib/open_pic2.c
--- a/arch/ppc/syslib/open_pic2.c	Tue Mar  2 19:52:41 2004
+++ b/arch/ppc/syslib/open_pic2.c	Tue Mar  2 19:52:41 2004
@@ -699,7 +699,7 @@
 		printk(KERN_ERR "Failed registering openpic sys class\n");
 		return -ENODEV;
 	}
-	rc = sys_device_register(&device_openpic2);
+	rc = sysdev_register(&device_openpic2);
 	if (rc) {
 		printk(KERN_ERR "Failed registering openpic sys device\n");
 		return -ENODEV;
diff -Nru a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c	Tue Mar  2 19:52:41 2004
+++ b/arch/x86_64/kernel/apic.c	Tue Mar  2 19:52:41 2004
@@ -552,7 +552,7 @@
 	/* XXX: remove suspend/resume procs if !apic_pm_state.active? */
 	error = sysdev_class_register(&lapic_sysclass);
 	if (!error)
-		error = sys_device_register(&device_lapic);
+		error = sysdev_register(&device_lapic);
 	return error;
 }
 device_initcall(init_lapic_sysfs);
diff -Nru a/arch/x86_64/kernel/i8259.c b/arch/x86_64/kernel/i8259.c
--- a/arch/x86_64/kernel/i8259.c	Tue Mar  2 19:52:41 2004
+++ b/arch/x86_64/kernel/i8259.c	Tue Mar  2 19:52:41 2004
@@ -430,7 +430,7 @@
 {
 	int error = sysdev_class_register(&timer_sysclass);
 	if (!error)
-		error = sys_device_register(&device_timer);
+		error = sysdev_register(&device_timer);
 	return error;
 }
 
diff -Nru a/arch/x86_64/kernel/nmi.c b/arch/x86_64/kernel/nmi.c
--- a/arch/x86_64/kernel/nmi.c	Tue Mar  2 19:52:41 2004
+++ b/arch/x86_64/kernel/nmi.c	Tue Mar  2 19:52:41 2004
@@ -218,7 +218,7 @@
 
 	error = sysdev_class_register(&nmi_sysclass);
 	if (!error)
-		error = sys_device_register(&device_lapic_nmi);
+		error = sysdev_register(&device_lapic_nmi);
 	return error;
 }
 /* must come after the local APIC's device_initcall() */
diff -Nru a/drivers/base/cpu.c b/drivers/base/cpu.c
--- a/drivers/base/cpu.c	Tue Mar  2 19:52:41 2004
+++ b/drivers/base/cpu.c	Tue Mar  2 19:52:41 2004
@@ -29,7 +29,7 @@
 	cpu->sysdev.id = num;
 	cpu->sysdev.cls = &cpu_sysdev_class;
 
-	error = sys_device_register(&cpu->sysdev);
+	error = sysdev_register(&cpu->sysdev);
 	if (!error && root)
 		error = sysfs_create_link(&root->sysdev.kobj,
 					  &cpu->sysdev.kobj,
diff -Nru a/drivers/base/node.c b/drivers/base/node.c
--- a/drivers/base/node.c	Tue Mar  2 19:52:41 2004
+++ b/drivers/base/node.c	Tue Mar  2 19:52:41 2004
@@ -69,7 +69,7 @@
 	node->cpumap = node_to_cpumask(num);
 	node->sysdev.id = num;
 	node->sysdev.cls = &node_class;
-	error = sys_device_register(&node->sysdev);
+	error = sysdev_register(&node->sysdev);
 
 	if (!error){
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	Tue Mar  2 19:52:41 2004
+++ b/drivers/base/sys.c	Tue Mar  2 19:52:41 2004
@@ -8,7 +8,7 @@
  * 
  * This exports a 'system' bus type. 
  * By default, a 'sys' bus gets added to the root of the system. There will
- * always be core system devices. Devices can use sys_device_register() to
+ * always be core system devices. Devices can use sysdev_register() to
  * add themselves as children of the system bus.
  */
 
@@ -164,11 +164,11 @@
 
 
 /**
- *	sys_device_register - add a system device to the tree
+ *	sysdev_register - add a system device to the tree
  *	@sysdev:	device in question
  *
  */
-int sys_device_register(struct sys_device * sysdev)
+int sysdev_register(struct sys_device * sysdev)
 {
 	int error;
 	struct sysdev_class * cls = sysdev->cls;
@@ -212,7 +212,7 @@
 	return error;
 }
 
-void sys_device_unregister(struct sys_device * sysdev)
+void sysdev_unregister(struct sys_device * sysdev)
 {
 	struct sysdev_driver * drv;
 
@@ -390,5 +390,5 @@
 	return subsystem_register(&system_subsys);
 }
 
-EXPORT_SYMBOL(sys_device_register);
-EXPORT_SYMBOL(sys_device_unregister);
+EXPORT_SYMBOL(sysdev_register);
+EXPORT_SYMBOL(sysdev_unregister);
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Mar  2 19:52:41 2004
+++ b/drivers/input/serio/i8042.c	Tue Mar  2 19:52:41 2004
@@ -957,7 +957,7 @@
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
         if (sysdev_class_register(&kbc_sysclass) == 0) {
-                if (sys_device_register(&device_i8042) == 0)
+                if (sysdev_register(&device_i8042) == 0)
 			i8042_sysdev_initialized = 1;
 		else
 			sysdev_class_unregister(&kbc_sysclass);
@@ -980,7 +980,7 @@
 		pm_unregister(i8042_pm_dev);
 
 	if (i8042_sysdev_initialized) {
-		sys_device_unregister(&device_i8042);
+		sysdev_unregister(&device_i8042);
 		sysdev_class_unregister(&kbc_sysclass);
 	}
 
diff -Nru a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c	Tue Mar  2 19:52:41 2004
+++ b/drivers/s390/block/xpram.c	Tue Mar  2 19:52:41 2004
@@ -492,7 +492,7 @@
 	}
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 	devfs_remove("slram");
-	sys_device_unregister(&xpram_sys_device);
+	sysdev_unregister(&xpram_sys_device);
 	sysdev_class_unregister(&xpram_sysclass);
 }
 
@@ -515,14 +515,14 @@
 	if (rc)
 		return rc;
 
-	rc = sys_device_register(&xpram_sys_device);
+	rc = sysdev_register(&xpram_sys_device);
 	if (rc) {
 		sysdev_class_unregister(&xpram_sysclass);
 		return rc;
 	}
 	rc = xpram_setup_blkdev();
 	if (rc)
-		sys_device_unregister(&xpram_sys_device);
+		sysdev_unregister(&xpram_sys_device);
 	return rc;
 }
 
diff -Nru a/include/linux/sysdev.h b/include/linux/sysdev.h
--- a/include/linux/sysdev.h	Tue Mar  2 19:52:41 2004
+++ b/include/linux/sysdev.h	Tue Mar  2 19:52:41 2004
@@ -70,8 +70,8 @@
 	struct kobject		kobj;
 };
 
-extern int sys_device_register(struct sys_device *);
-extern void sys_device_unregister(struct sys_device *);
+extern int sysdev_register(struct sys_device *);
+extern void sysdev_unregister(struct sys_device *);
 
 
 struct sysdev_attribute { 

