Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267094AbUBMQQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267097AbUBMQQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:16:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:55175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267094AbUBMQOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:14:48 -0500
Date: Fri, 13 Feb 2004 08:07:53 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>
Subject: [PATCH] sys_device_[un]register() are not syscalls
Message-Id: <20040213080753.12af00bd.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



sys_xyz() names in Linux are all syscalls... except for
sys_device_register() and sys_device_unregister().

This patch renames them so that the sys_ namespace is once
again used only by syscalls.

Comments?

--
~Randy


applies_to:	linux-263-rc2
description:	renames sys_device_[un]register() to sysdev_[un]register(),
		thus cleaning up the sys_syscall namespace,
		since these are not syscalls.

diffstat:=
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


diff -Naurp ./arch/i386/kernel/time.c~sysdev ./arch/i386/kernel/time.c
--- ./arch/i386/kernel/time.c~sysdev	2004-02-03 19:43:47.000000000 -0800
+++ ./arch/i386/kernel/time.c	2004-02-12 22:08:24.000000000 -0800
@@ -346,7 +346,7 @@ static int time_init_device(void)
 {
 	int error = sysdev_class_register(&pit_sysclass);
 	if (!error)
-		error = sys_device_register(&device_i8253);
+		error = sysdev_register(&device_i8253);
 	return error;
 }
 
diff -Naurp ./arch/i386/kernel/nmi.c~sysdev ./arch/i386/kernel/nmi.c
--- ./arch/i386/kernel/nmi.c~sysdev	2004-02-03 19:43:56.000000000 -0800
+++ ./arch/i386/kernel/nmi.c	2004-02-12 22:08:43.000000000 -0800
@@ -248,7 +248,7 @@ static int __init init_lapic_nmi_sysfs(v
 
 	error = sysdev_class_register(&nmi_sysclass);
 	if (!error)
-		error = sys_device_register(&device_lapic_nmi);
+		error = sysdev_register(&device_lapic_nmi);
 	return error;
 }
 /* must come after the local APIC's device_initcall() */
diff -Naurp ./arch/i386/kernel/i8259.c~sysdev ./arch/i386/kernel/i8259.c
--- ./arch/i386/kernel/i8259.c~sysdev	2004-02-03 19:44:41.000000000 -0800
+++ ./arch/i386/kernel/i8259.c	2004-02-12 22:09:06.000000000 -0800
@@ -258,7 +258,7 @@ static int __init i8259A_init_sysfs(void
 {
 	int error = sysdev_class_register(&i8259_sysdev_class);
 	if (!error)
-		error = sys_device_register(&device_i8259A);
+		error = sysdev_register(&device_i8259A);
 	return error;
 }
 
@@ -401,7 +401,7 @@ static int __init init_timer_sysfs(void)
 {
 	int error = sysdev_class_register(&timer_sysclass);
 	if (!error)
-		error = sys_device_register(&device_timer);
+		error = sysdev_register(&device_timer);
 	return error;
 }
 
diff -Naurp ./arch/i386/kernel/apic.c~sysdev ./arch/i386/kernel/apic.c
--- ./arch/i386/kernel/apic.c~sysdev	2004-02-03 19:45:06.000000000 -0800
+++ ./arch/i386/kernel/apic.c	2004-02-12 22:09:23.000000000 -0800
@@ -595,7 +595,7 @@ static int __init init_lapic_sysfs(void)
 
 	error = sysdev_class_register(&lapic_sysclass);
 	if (!error)
-		error = sys_device_register(&device_lapic);
+		error = sysdev_register(&device_lapic);
 	return error;
 }
 device_initcall(init_lapic_sysfs);
diff -Naurp ./arch/i386/oprofile/nmi_int.c~sysdev ./arch/i386/oprofile/nmi_int.c
--- ./arch/i386/oprofile/nmi_int.c~sysdev	2004-02-03 19:44:44.000000000 -0800
+++ ./arch/i386/oprofile/nmi_int.c	2004-02-12 21:57:36.000000000 -0800
@@ -65,14 +65,14 @@ static int __init init_driverfs(void)
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
 
diff -Naurp ./arch/ppc/syslib/open_pic.c~sysdev ./arch/ppc/syslib/open_pic.c
--- ./arch/ppc/syslib/open_pic.c~sysdev	2004-02-12 21:08:54.000000000 -0800
+++ ./arch/ppc/syslib/open_pic.c	2004-02-12 22:10:12.000000000 -0800
@@ -1032,7 +1032,7 @@ static int __init init_openpic_sysfs(voi
 		printk(KERN_ERR "Failed registering openpic sys class\n");
 		return -ENODEV;
 	}
-	rc = sys_device_register(&device_openpic);
+	rc = sysdev_register(&device_openpic);
 	if (rc) {
 		printk(KERN_ERR "Failed registering openpic sys device\n");
 		return -ENODEV;
diff -Naurp ./arch/ppc/syslib/open_pic2.c~sysdev ./arch/ppc/syslib/open_pic2.c
--- ./arch/ppc/syslib/open_pic2.c~sysdev	2004-02-12 21:08:54.000000000 -0800
+++ ./arch/ppc/syslib/open_pic2.c	2004-02-12 22:10:06.000000000 -0800
@@ -699,7 +699,7 @@ static int __init init_openpic2_sysfs(vo
 		printk(KERN_ERR "Failed registering openpic sys class\n");
 		return -ENODEV;
 	}
-	rc = sys_device_register(&device_openpic2);
+	rc = sysdev_register(&device_openpic2);
 	if (rc) {
 		printk(KERN_ERR "Failed registering openpic sys device\n");
 		return -ENODEV;
diff -Naurp ./arch/ppc/platforms/pmac_pic.c~sysdev ./arch/ppc/platforms/pmac_pic.c
--- ./arch/ppc/platforms/pmac_pic.c~sysdev	2004-02-12 21:08:54.000000000 -0800
+++ ./arch/ppc/platforms/pmac_pic.c	2004-02-12 22:10:36.000000000 -0800
@@ -646,7 +646,7 @@ static int __init init_pmacpic_sysfs(voi
 
 	printk(KERN_DEBUG "Registering pmac pic with sysfs...\n");
 	sysdev_class_register(&pmacpic_sysclass);
-	sys_device_register(&device_pmacpic);
+	sysdev_register(&device_pmacpic);
 	sysdev_driver_register(&pmacpic_sysclass, &driver_pmacpic);
 	return 0;
 }
diff -Naurp ./arch/mips/kernel/i8259.c~sysdev ./arch/mips/kernel/i8259.c
--- ./arch/mips/kernel/i8259.c~sysdev	2004-02-03 19:43:15.000000000 -0800
+++ ./arch/mips/kernel/i8259.c	2004-02-12 22:11:06.000000000 -0800
@@ -242,7 +242,7 @@ static int __init i8259A_init_sysfs(void
 {
 	int error = sysdev_class_register(&i8259_sysdev_class);
 	if (!error)
-		error = sys_device_register(&device_i8259A);
+		error = sysdev_register(&device_i8259A);
 	return error;
 }
 
diff -Naurp ./arch/arm/kernel/time.c~sysdev ./arch/arm/kernel/time.c
--- ./arch/arm/kernel/time.c~sysdev	2004-02-03 19:44:05.000000000 -0800
+++ ./arch/arm/kernel/time.c	2004-02-12 22:11:27.000000000 -0800
@@ -173,7 +173,7 @@ static int __init leds_init(void)
 	int ret;
 	ret = sysdev_class_register(&leds_sysclass);
 	if (ret == 0)
-		ret = sys_device_register(&leds_device);
+		ret = sysdev_register(&leds_device);
 	return ret;
 }
 
diff -Naurp ./arch/arm/mach-sa1100/irq.c~sysdev ./arch/arm/mach-sa1100/irq.c
--- ./arch/arm/mach-sa1100/irq.c~sysdev	2004-02-03 19:44:54.000000000 -0800
+++ ./arch/arm/mach-sa1100/irq.c	2004-02-12 22:11:49.000000000 -0800
@@ -278,7 +278,7 @@ static struct sys_device sa1100irq_devic
 static int __init sa1100irq_init_devicefs(void)
 {
 	sysdev_class_register(&sa1100irq_sysclass);
-	return sys_device_register(&sa1100irq_device);
+	return sysdev_register(&sa1100irq_device);
 }
 
 device_initcall(sa1100irq_init_devicefs);
diff -Naurp ./arch/arm/mach-integrator/integrator_ap.c~sysdev ./arch/arm/mach-integrator/integrator_ap.c
--- ./arch/arm/mach-integrator/integrator_ap.c~sysdev	2004-02-12 21:08:54.000000000 -0800
+++ ./arch/arm/mach-integrator/integrator_ap.c	2004-02-12 22:12:19.000000000 -0800
@@ -173,7 +173,7 @@ static int __init irq_init_sysfs(void)
 {
 	int ret = sysdev_class_register(&irq_class);
 	if (ret == 0)
-		ret = sys_device_register(&irq_device);
+		ret = sysdev_register(&irq_device);
 	return ret;
 }
 
diff -Naurp ./arch/x86_64/kernel/apic.c~sysdev ./arch/x86_64/kernel/apic.c
--- ./arch/x86_64/kernel/apic.c~sysdev	2004-02-03 19:43:13.000000000 -0800
+++ ./arch/x86_64/kernel/apic.c	2004-02-12 22:13:07.000000000 -0800
@@ -552,7 +552,7 @@ static int __init init_lapic_sysfs(void)
 	/* XXX: remove suspend/resume procs if !apic_pm_state.active? */
 	error = sysdev_class_register(&lapic_sysclass);
 	if (!error)
-		error = sys_device_register(&device_lapic);
+		error = sysdev_register(&device_lapic);
 	return error;
 }
 device_initcall(init_lapic_sysfs);
diff -Naurp ./arch/x86_64/kernel/i8259.c~sysdev ./arch/x86_64/kernel/i8259.c
--- ./arch/x86_64/kernel/i8259.c~sysdev	2004-02-03 19:43:15.000000000 -0800
+++ ./arch/x86_64/kernel/i8259.c	2004-02-12 22:13:12.000000000 -0800
@@ -430,7 +430,7 @@ static int __init init_timer_sysfs(void)
 {
 	int error = sysdev_class_register(&timer_sysclass);
 	if (!error)
-		error = sys_device_register(&device_timer);
+		error = sysdev_register(&device_timer);
 	return error;
 }
 
diff -Naurp ./arch/x86_64/kernel/nmi.c~sysdev ./arch/x86_64/kernel/nmi.c
--- ./arch/x86_64/kernel/nmi.c~sysdev	2004-02-12 21:08:54.000000000 -0800
+++ ./arch/x86_64/kernel/nmi.c	2004-02-12 22:13:16.000000000 -0800
@@ -218,7 +218,7 @@ static int __init init_lapic_nmi_sysfs(v
 
 	error = sysdev_class_register(&nmi_sysclass);
 	if (!error)
-		error = sys_device_register(&device_lapic_nmi);
+		error = sysdev_register(&device_lapic_nmi);
 	return error;
 }
 /* must come after the local APIC's device_initcall() */
diff -Naurp ./drivers/s390/block/xpram.c~sysdev ./drivers/s390/block/xpram.c
--- ./drivers/s390/block/xpram.c~sysdev	2004-02-03 19:44:14.000000000 -0800
+++ ./drivers/s390/block/xpram.c	2004-02-12 22:07:27.000000000 -0800
@@ -492,7 +492,7 @@ static void __exit xpram_exit(void)
 	}
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 	devfs_remove("slram");
-	sys_device_unregister(&xpram_sys_device);
+	sysdev_unregister(&xpram_sys_device);
 	sysdev_class_unregister(&xpram_sysclass);
 }
 
@@ -515,14 +515,14 @@ static int __init xpram_init(void)
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
 
diff -Naurp ./drivers/base/sys.c~sysdev ./drivers/base/sys.c
--- ./drivers/base/sys.c~sysdev	2004-02-03 19:43:02.000000000 -0800
+++ ./drivers/base/sys.c	2004-02-12 21:30:23.000000000 -0800
@@ -8,7 +8,7 @@
  * 
  * This exports a 'system' bus type. 
  * By default, a 'sys' bus gets added to the root of the system. There will
- * always be core system devices. Devices can use sys_device_register() to
+ * always be core system devices. Devices can use sysdev_register() to
  * add themselves as children of the system bus.
  */
 
@@ -164,11 +164,11 @@ EXPORT_SYMBOL(sysdev_driver_unregister);
 
 
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
@@ -212,7 +212,7 @@ int sys_device_register(struct sys_devic
 	return error;
 }
 
-void sys_device_unregister(struct sys_device * sysdev)
+void sysdev_unregister(struct sys_device * sysdev)
 {
 	struct sysdev_driver * drv;
 
@@ -390,5 +390,5 @@ int __init sys_bus_init(void)
 	return subsystem_register(&system_subsys);
 }
 
-EXPORT_SYMBOL(sys_device_register);
-EXPORT_SYMBOL(sys_device_unregister);
+EXPORT_SYMBOL(sysdev_register);
+EXPORT_SYMBOL(sysdev_unregister);
diff -Naurp ./drivers/base/node.c~sysdev ./drivers/base/node.c
--- ./drivers/base/node.c~sysdev	2004-02-03 19:43:15.000000000 -0800
+++ ./drivers/base/node.c	2004-02-12 22:35:40.000000000 -0800
@@ -69,7 +69,7 @@ int __init register_node(struct node *no
 	node->cpumap = node_to_cpumask(num);
 	node->sysdev.id = num;
 	node->sysdev.cls = &node_class;
-	error = sys_device_register(&node->sysdev);
+	error = sysdev_register(&node->sysdev);
 
 	if (!error){
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
diff -Naurp ./drivers/base/cpu.c~sysdev ./drivers/base/cpu.c
--- ./drivers/base/cpu.c~sysdev	2004-02-03 19:43:39.000000000 -0800
+++ ./drivers/base/cpu.c	2004-02-12 22:35:35.000000000 -0800
@@ -29,7 +29,7 @@ int __init register_cpu(struct cpu *cpu,
 	cpu->sysdev.id = num;
 	cpu->sysdev.cls = &cpu_sysdev_class;
 
-	error = sys_device_register(&cpu->sysdev);
+	error = sysdev_register(&cpu->sysdev);
 	if (!error && root)
 		error = sysfs_create_link(&root->sysdev.kobj,
 					  &cpu->sysdev.kobj,
diff -Naurp ./drivers/input/serio/i8042.c~sysdev ./drivers/input/serio/i8042.c
--- ./drivers/input/serio/i8042.c~sysdev	2004-02-12 21:08:54.000000000 -0800
+++ ./drivers/input/serio/i8042.c	2004-02-12 22:06:24.000000000 -0800
@@ -957,7 +957,7 @@ int __init i8042_init(void)
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
         if (sysdev_class_register(&kbc_sysclass) == 0) {
-                if (sys_device_register(&device_i8042) == 0)
+                if (sysdev_register(&device_i8042) == 0)
 			i8042_sysdev_initialized = 1;
 		else
 			sysdev_class_unregister(&kbc_sysclass);
@@ -980,7 +980,7 @@ void __exit i8042_exit(void)
 		pm_unregister(i8042_pm_dev);
 
 	if (i8042_sysdev_initialized) {
-		sys_device_unregister(&device_i8042);
+		sysdev_unregister(&device_i8042);
 		sysdev_class_unregister(&kbc_sysclass);
 	}
 
diff -Naurp ./include/linux/sysdev.h~sysdev ./include/linux/sysdev.h
--- ./include/linux/sysdev.h~sysdev	2004-02-03 19:43:56.000000000 -0800
+++ ./include/linux/sysdev.h	2004-02-12 22:18:02.000000000 -0800
@@ -70,8 +70,8 @@ struct sys_device {
 	struct kobject		kobj;
 };
 
-extern int sys_device_register(struct sys_device *);
-extern void sys_device_unregister(struct sys_device *);
+extern int sysdev_register(struct sys_device *);
+extern void sysdev_unregister(struct sys_device *);
 
 
 struct sysdev_attribute { 


--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
