Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSHMIUx>; Tue, 13 Aug 2002 04:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHMIUx>; Tue, 13 Aug 2002 04:20:53 -0400
Received: from dp.samba.org ([66.70.73.150]:64446 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S312558AbSHMIUs>;
	Tue, 13 Aug 2002 04:20:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: trivial@rustcorp.com.au, Richard Gooch <rgooch@atnf.csiro.au>,
       sfr@canb.auug.org.au, Tigran Aivazian <tigran@veritas.com>,
       H Peter Anvin <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Designated initializers for i386
Date: Tue, 13 Aug 2002 18:18:59 +1000
Message-Id: <20020813032506.8F4DD2C142@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for batching these, but there are so damn many.

Linus, please apply.

Name: Designated initializers for i386
Author: Rusty Russell
Status: Trivial

D: The old form of designated initializers are obsolete: we need to
D: replace them with the ISO C forms before 2.6.  Gcc has always supported
D: both forms anyway.

--- working-2.5.31-designated-inits/arch/i386/kernel/mtrr.c	2002-07-27 15:24:35.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/mtrr.c.new	2002-08-13 18:10:54.000000000 +1000
@@ -1836,11 +1836,11 @@
 
 static struct file_operations mtrr_fops =
 {
-    owner:	THIS_MODULE,
-    read:	mtrr_read,
-    write:	mtrr_write,
-    ioctl:	mtrr_ioctl,
-    release:	mtrr_close,
+    .owner	= THIS_MODULE,
+    .read	= mtrr_read,
+    .write	= mtrr_write,
+    .ioctl	= mtrr_ioctl,
+    .release	= mtrr_close,
 };
 
 #  ifdef CONFIG_PROC_FS
--- working-2.5.31-designated-inits/arch/i386/kernel/time.c	2002-06-20 01:28:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/time.c.new	2002-08-13 18:10:54.000000000 +1000
@@ -639,8 +639,8 @@
 }
 
 static struct device device_i8253 = {
-	name:	       	"i8253",
-	bus_id:		"0040",
+	.name	       	= "i8253",
+	.bus_id		= "0040",
 };
 
 static int time_init_driverfs(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/i8259.c	2002-08-02 11:15:05.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/i8259.c.new	2002-08-13 18:10:54.000000000 +1000
@@ -247,13 +247,13 @@
 }
 
 static struct device_driver driver_i8259A = {
-	resume:		i8259A_resume,
+	.resume		= i8259A_resume,
 };
 
 static struct device device_i8259A = {
-	name:	       	"i8259A",
-	bus_id:		"0020",
-	driver:		&driver_i8259A,
+	.name	       	= "i8259A",
+	.bus_id		= "0020",
+	.driver		= &driver_i8259A,
 };
 
 static int __init init_8259A_devicefs(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/apm.c	2002-08-02 11:15:05.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/apm.c.new	2002-08-13 18:10:55.000000000 +1000
@@ -931,9 +931,9 @@
 }
 
 static struct sysrq_key_op	sysrq_poweroff_op = {
-	handler:        handle_poweroff,
-	help_msg:       "Off",
-	action_msg:     "Power Off\n"
+	.handler        = handle_poweroff,
+	.help_msg       = "Off",
+	.action_msg     = "Power Off\n"
 };
 
 
@@ -1826,12 +1826,12 @@
 #endif
 
 static struct file_operations apm_bios_fops = {
-	owner:		THIS_MODULE,
-	read:		do_read,
-	poll:		do_poll,
-	ioctl:		do_ioctl,
-	open:		do_open,
-	release:	do_release,
+	.owner		= THIS_MODULE,
+	.read		= do_read,
+	.poll		= do_poll,
+	.ioctl		= do_ioctl,
+	.open		= do_open,
+	.release	= do_release,
 };
 
 static struct miscdevice apm_device = {
--- working-2.5.31-designated-inits/arch/i386/kernel/microcode.c	2002-06-20 01:28:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/microcode.c.new	2002-08-13 18:10:55.000000000 +1000
@@ -109,17 +109,17 @@
 
 /* we share file_operations between misc and devfs mechanisms */
 static struct file_operations microcode_fops = {
-	owner:		THIS_MODULE,
-	read:		microcode_read,
-	write:		microcode_write,
-	ioctl:		microcode_ioctl,
-	open:		microcode_open,
+	.owner		= THIS_MODULE,
+	.read		= microcode_read,
+	.write		= microcode_write,
+	.ioctl		= microcode_ioctl,
+	.open		= microcode_open,
 };
 
 static struct miscdevice microcode_dev = {
-	minor: MICROCODE_MINOR,
-	name:	"microcode",
-	fops:	&microcode_fops,
+	.minor = MICROCODE_MINOR,
+	.name	= "microcode",
+	.fops	= &microcode_fops,
 };
 
 static devfs_handle_t devfs_handle;
--- working-2.5.31-designated-inits/arch/i386/kernel/cpuid.c	2002-05-25 14:34:36.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpuid.c.new	2002-08-13 18:10:55.000000000 +1000
@@ -146,10 +146,10 @@
  * File operations we support
  */
 static struct file_operations cpuid_fops = {
-  owner:	THIS_MODULE,
-  llseek:	cpuid_seek,
-  read:		cpuid_read,
-  open:		cpuid_open,
+  .owner	= THIS_MODULE,
+  .llseek	= cpuid_seek,
+  .read		= cpuid_read,
+  .open		= cpuid_open,
 };
 
 int __init cpuid_init(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/msr.c	2002-05-25 14:34:36.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/msr.c.new	2002-08-13 18:10:55.000000000 +1000
@@ -246,11 +246,11 @@
  * File operations we support
  */
 static struct file_operations msr_fops = {
-  owner:	THIS_MODULE,
-  llseek:	msr_seek,
-  read:		msr_read,
-  write:	msr_write,
-  open:		msr_open,
+  .owner	= THIS_MODULE,
+  .llseek	= msr_seek,
+  .read		= msr_read,
+  .write	= msr_write,
+  .open		= msr_open,
 };
 
 int __init msr_init(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/bluesmoke.c	2002-07-25 10:13:01.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/bluesmoke.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -307,7 +307,7 @@
 } 
 
 static struct tq_struct mce_task = { 
-	routine: do_mce_timer	
+	.routine = do_mce_timer	
 };
 
 static void mce_timerfunc (unsigned long data)
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/amd.c	2002-06-10 16:03:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/amd.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -189,8 +189,8 @@
 }
 
 static struct cpu_dev amd_cpu_dev __initdata = {
-	c_vendor:	"AMD",
-	c_ident: 	{ "AuthenticAMD" },
+	.c_vendor	= "AMD",
+	.c_ident 	= { "AuthenticAMD" },
 	c_models: {
 		{ X86_VENDOR_AMD,	4,
 		  {
@@ -203,9 +203,9 @@
 		  }
 		},
 	},
-	c_init:		init_amd,
-	c_identify:	amd_identify,
-	c_size_cache:	amd_size_cache,
+	.c_init		= init_amd,
+	.c_identify	= amd_identify,
+	.c_size_cache	= amd_size_cache,
 };
 
 int __init amd_init_cpu(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/centaur.c	2002-06-10 16:03:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/centaur.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -411,10 +411,10 @@
 }
 
 static struct cpu_dev centaur_cpu_dev __initdata = {
-	c_vendor:	"Centaur",
-	c_ident:	{ "CentaurHauls" },
-	c_init:		init_centaur,
-	c_size_cache:	centaur_size_cache,
+	.c_vendor	= "Centaur",
+	.c_ident	= { "CentaurHauls" },
+	.c_init		= init_centaur,
+	.c_size_cache	= centaur_size_cache,
 };
 
 int __init centaur_init_cpu(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/common.c	2002-07-27 15:24:35.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/common.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -31,7 +31,7 @@
 }
 
 static struct cpu_dev default_cpu = {
-	c_init:	default_init,
+	.c_init	= default_init,
 };
 static struct cpu_dev * this_cpu = &default_cpu;
 
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/cyrix.c	2002-06-10 16:03:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/cyrix.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -322,10 +322,10 @@
 }
 
 static struct cpu_dev cyrix_cpu_dev __initdata = {
-	c_vendor:	"Cyrix",
-	c_ident: 	{ "CyrixInstead" },
-	c_init:		init_cyrix,
-	c_identify:	cyrix_identify,
+	.c_vendor	= "Cyrix",
+	.c_ident 	= { "CyrixInstead" },
+	.c_init		= init_cyrix,
+	.c_identify	= cyrix_identify,
 };
 
 int __init cyrix_init_cpu(void)
@@ -337,10 +337,10 @@
 //early_arch_initcall(cyrix_init_cpu);
 
 static struct cpu_dev nsc_cpu_dev __initdata = {
-	c_vendor:	"NSC",
-	c_ident: 	{ "Geode by NSC" },
-	c_init:		init_cyrix,
-	c_identify:	generic_identify,
+	.c_vendor	= "NSC",
+	.c_ident 	= { "Geode by NSC" },
+	.c_init		= init_cyrix,
+	.c_identify	= generic_identify,
 };
 
 int __init nsc_init_cpu(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/intel.c	2002-08-11 15:31:31.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/intel.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -327,8 +327,8 @@
 }
 
 static struct cpu_dev intel_cpu_dev __initdata = {
-	c_vendor:	"Intel",
-	c_ident: 	{ "GenuineIntel" },
+	.c_vendor	= "Intel",
+	.c_ident 	= { "GenuineIntel" },
 	c_models: {
 		{ X86_VENDOR_INTEL,	4,
 		  { 
@@ -375,9 +375,9 @@
 		  }
 		},
 	},
-	c_init:		init_intel,
-	c_identify:	generic_identify,
-	c_size_cache:	intel_size_cache,
+	.c_init		= init_intel,
+	.c_identify	= generic_identify,
+	.c_size_cache	= intel_size_cache,
 };
 
 __init int intel_cpu_init(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/nexgen.c	2002-06-10 16:03:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/nexgen.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -42,13 +42,13 @@
 }
 
 static struct cpu_dev nexgen_cpu_dev __initdata = {
-	c_vendor:	"Nexgen",
-	c_ident:	{ "NexGenDriven" },
+	.c_vendor	= "Nexgen",
+	.c_ident	= { "NexGenDriven" },
 	c_models: {
 		{ X86_VENDOR_NEXGEN,5, { [1] "Nx586" } },
 	},
-	c_init:		init_nexgen,
-	c_identify:	nexgen_identify,
+	.c_init		= init_nexgen,
+	.c_identify	= nexgen_identify,
 };
 
 int __init nexgen_init_cpu(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/proc.c	2002-06-10 16:03:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/proc.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -119,8 +119,8 @@
 {
 }
 struct seq_operations cpuinfo_op = {
-	start:	c_start,
-	next:	c_next,
-	stop:	c_stop,
-	show:	show_cpuinfo,
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= show_cpuinfo,
 };
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/rise.c	2002-06-10 16:03:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/rise.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -29,8 +29,8 @@
 }
 
 static struct cpu_dev rise_cpu_dev __initdata = {
-	c_vendor:	"Rise",
-	c_ident:	{ "RiseRiseRise" },
+	.c_vendor	= "Rise",
+	.c_ident	= { "RiseRiseRise" },
 	c_models: {
 		{ X86_VENDOR_RISE,	5,
 		  { 
@@ -41,7 +41,7 @@
 		  }
 		},
 	},
-	c_init:		init_rise,
+	.c_init		= init_rise,
 };
 
 int __init rise_init_cpu(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/transmeta.c	2002-06-10 16:03:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/transmeta.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -80,10 +80,10 @@
 }
 
 static struct cpu_dev transmeta_cpu_dev __initdata = {
-	c_vendor:	"Transmeta",
-	c_ident:	{ "GenuineTMx86", "TransmetaCPU" },
-	c_init:		init_transmeta,
-	c_identify:	transmeta_identify,
+	.c_vendor	= "Transmeta",
+	.c_ident	= { "GenuineTMx86", "TransmetaCPU" },
+	.c_init		= init_transmeta,
+	.c_identify	= transmeta_identify,
 };
 
 int __init transmeta_init_cpu(void)
--- working-2.5.31-designated-inits/arch/i386/kernel/cpu/umc.c	2002-06-10 16:03:47.000000000 +1000
+++ working-2.5.31-designated-inits/arch/i386/kernel/cpu/umc.c.new	2002-08-13 18:10:56.000000000 +1000
@@ -11,8 +11,8 @@
 }
 
 static struct cpu_dev umc_cpu_dev __initdata = {
-	c_vendor:	"UMC",
-	c_ident: 	{ "UMC UMC UMC" },
+	.c_vendor	= "UMC",
+	.c_ident 	= { "UMC UMC UMC" },
 	c_models: {
 		{ X86_VENDOR_UMC,	4,
 		  { 
@@ -21,7 +21,7 @@
 		  }
 		},
 	},
-	c_init:		init_umc,
+	.c_init		= init_umc,
 };
 
 int __init umc_init_cpu(void)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
