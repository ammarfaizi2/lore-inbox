Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSGSFJI>; Fri, 19 Jul 2002 01:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSGSFJH>; Fri, 19 Jul 2002 01:09:07 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:33477 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314885AbSGSFJE>;
	Fri, 19 Jul 2002 01:09:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] arch/i386/ designated initializer rework
Date: Fri, 19 Jul 2002 14:43:00 +1000
Message-Id: <20020719051249.1CA42412E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	This is the whitespace-friendly version for arch/i386/*.

Please apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Designated initializers for i386
Author: Rusty Russell
Status: Trivial

D: The old form of designated initializers are obsolete: we need to
D: replace them with the ISO C forms before 2.6.  Gcc has always supported
D: both forms anyway.

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/apm.c linux-2.5.26.28536.updated/arch/i386/kernel/apm.c
--- linux-2.5.26.28536/arch/i386/kernel/apm.c	Wed Jul 17 10:25:46 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/apm.c	Fri Jul 19 13:15:27 2002
@@ -929,9 +929,9 @@ static void handle_poweroff (int key, st
 }
 
 static struct sysrq_key_op	sysrq_poweroff_op = {
-	handler:        handle_poweroff,
-	help_msg:       "Off",
-	action_msg:     "Power Off\n"
+	.handler =      handle_poweroff,
+	.help_msg =     "Off",
+	.action_msg =   "Power Off\n"
 };
 
 
@@ -1824,12 +1824,12 @@ __setup("apm=", apm_setup);
 #endif
 
 static struct file_operations apm_bios_fops = {
-	owner:		THIS_MODULE,
-	read:		do_read,
-	poll:		do_poll,
-	ioctl:		do_ioctl,
-	open:		do_open,
-	release:	do_release,
+	.owner =	THIS_MODULE,
+	.read =		do_read,
+	.poll =		do_poll,
+	.ioctl =	do_ioctl,
+	.open =		do_open,
+	.release =	do_release,
 };
 
 static struct miscdevice apm_device = {
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/bluesmoke.c linux-2.5.26.28536.updated/arch/i386/kernel/bluesmoke.c
--- linux-2.5.26.28536/arch/i386/kernel/bluesmoke.c	Wed Jul 17 10:25:46 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/bluesmoke.c	Fri Jul 19 13:15:27 2002
@@ -302,7 +302,7 @@ static void do_mce_timer(void *data)
 } 
 
 static struct tq_struct mce_task = { 
-	routine: do_mce_timer	
+	.routine = do_mce_timer	
 };
 
 static void mce_timerfunc (unsigned long data)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/amd.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/amd.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/amd.c	Mon Jun 10 16:03:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/amd.c	Fri Jul 19 13:15:27 2002
@@ -189,9 +189,9 @@ static unsigned int amd_size_cache(struc
 }
 
 static struct cpu_dev amd_cpu_dev __initdata = {
-	c_vendor:	"AMD",
-	c_ident: 	{ "AuthenticAMD" },
-	c_models: {
+	.c_vendor =	"AMD",
+	.c_ident = 	{ "AuthenticAMD" },
+	.c_models = {
 		{ X86_VENDOR_AMD,	4,
 		  {
 			  [3] "486 DX/2",
@@ -203,9 +203,9 @@ static struct cpu_dev amd_cpu_dev __init
 		  }
 		},
 	},
-	c_init:		init_amd,
-	c_identify:	amd_identify,
-	c_size_cache:	amd_size_cache,
+	.c_init =	init_amd,
+	.c_identify =	amd_identify,
+	.c_size_cache =	amd_size_cache,
 };
 
 int __init amd_init_cpu(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/centaur.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/centaur.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/centaur.c	Mon Jun 10 16:03:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/centaur.c	Fri Jul 19 13:15:27 2002
@@ -411,10 +411,10 @@ static unsigned int centaur_size_cache(s
 }
 
 static struct cpu_dev centaur_cpu_dev __initdata = {
-	c_vendor:	"Centaur",
-	c_ident:	{ "CentaurHauls" },
-	c_init:		init_centaur,
-	c_size_cache:	centaur_size_cache,
+	.c_vendor =	"Centaur",
+	.c_ident =	{ "CentaurHauls" },
+	.c_init =	init_centaur,
+	.c_size_cache =	centaur_size_cache,
 };
 
 int __init centaur_init_cpu(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/common.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/common.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/common.c	Wed Jul 17 10:25:46 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/common.c	Fri Jul 19 13:15:27 2002
@@ -31,7 +31,7 @@ static void default_init(struct cpuinfo_
 }
 
 static struct cpu_dev default_cpu = {
-	c_init:	default_init,
+	.c_init = default_init,
 };
 static struct cpu_dev * this_cpu = &default_cpu;
 
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/cyrix.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/cyrix.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/cyrix.c	Mon Jun 10 16:03:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/cyrix.c	Fri Jul 19 13:15:27 2002
@@ -322,10 +322,10 @@ static void cyrix_identify(struct cpuinf
 }
 
 static struct cpu_dev cyrix_cpu_dev __initdata = {
-	c_vendor:	"Cyrix",
-	c_ident: 	{ "CyrixInstead" },
-	c_init:		init_cyrix,
-	c_identify:	cyrix_identify,
+	.c_vendor =	"Cyrix",
+	.c_ident = 	{ "CyrixInstead" },
+	.c_init =	init_cyrix,
+	.c_identify =	cyrix_identify,
 };
 
 int __init cyrix_init_cpu(void)
@@ -337,10 +337,10 @@ int __init cyrix_init_cpu(void)
 //early_arch_initcall(cyrix_init_cpu);
 
 static struct cpu_dev nsc_cpu_dev __initdata = {
-	c_vendor:	"NSC",
-	c_ident: 	{ "Geode by NSC" },
-	c_init:		init_cyrix,
-	c_identify:	generic_identify,
+	.c_vendor =	"NSC",
+	.c_ident = 	{ "Geode by NSC" },
+	.c_init =	init_cyrix,
+	.c_identify =	generic_identify,
 };
 
 int __init nsc_init_cpu(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/intel.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/intel.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/intel.c	Wed Jul 17 10:25:46 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/intel.c	Fri Jul 19 13:15:28 2002
@@ -323,9 +323,9 @@ static unsigned int intel_size_cache(str
 }
 
 static struct cpu_dev intel_cpu_dev __initdata = {
-	c_vendor:	"Intel",
-	c_ident: 	{ "GenuineIntel" },
-	c_models: {
+	.c_vendor =	"Intel",
+	.c_ident = 	{ "GenuineIntel" },
+	.c_models = {
 		{ X86_VENDOR_INTEL,	4,
 		  { 
 			  [0] "486 DX-25/33", 
@@ -351,9 +351,9 @@ static struct cpu_dev intel_cpu_dev __in
 		  }
 		},
 	},
-	c_init:		init_intel,
-	c_identify:	generic_identify,
-	c_size_cache:	intel_size_cache,
+	.c_init =	init_intel,
+	.c_identify =	generic_identify,
+	.c_size_cache =	intel_size_cache,
 };
 
 __init int intel_cpu_init(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/nexgen.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/nexgen.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/nexgen.c	Mon Jun 10 16:03:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/nexgen.c	Fri Jul 19 13:15:28 2002
@@ -42,13 +42,13 @@ static void nexgen_identify(struct cpuin
 }
 
 static struct cpu_dev nexgen_cpu_dev __initdata = {
-	c_vendor:	"Nexgen",
-	c_ident:	{ "NexGenDriven" },
-	c_models: {
+	.c_vendor =	"Nexgen",
+	.c_ident =	{ "NexGenDriven" },
+	.c_models = {
 		{ X86_VENDOR_NEXGEN,5, { [1] "Nx586" } },
 	},
-	c_init:		init_nexgen,
-	c_identify:	nexgen_identify,
+	.c_init =	init_nexgen,
+	.c_identify =	nexgen_identify,
 };
 
 int __init nexgen_init_cpu(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/proc.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/proc.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/proc.c	Mon Jun 10 16:03:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/proc.c	Fri Jul 19 13:15:28 2002
@@ -119,8 +119,8 @@ static void c_stop(struct seq_file *m, v
 {
 }
 struct seq_operations cpuinfo_op = {
-	start:	c_start,
-	next:	c_next,
-	stop:	c_stop,
-	show:	show_cpuinfo,
+	.start =c_start,
+	.next =	c_next,
+	.stop =	c_stop,
+	.show =	show_cpuinfo,
 };
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/rise.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/rise.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/rise.c	Mon Jun 10 16:03:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/rise.c	Fri Jul 19 13:15:28 2002
@@ -29,9 +29,9 @@ static void __init init_rise(struct cpui
 }
 
 static struct cpu_dev rise_cpu_dev __initdata = {
-	c_vendor:	"Rise",
-	c_ident:	{ "RiseRiseRise" },
-	c_models: {
+	.c_vendor =	"Rise",
+	.c_ident =	{ "RiseRiseRise" },
+	.c_models = {
 		{ X86_VENDOR_RISE,	5,
 		  { 
 			  [0] "iDragon", 
@@ -41,7 +41,7 @@ static struct cpu_dev rise_cpu_dev __ini
 		  }
 		},
 	},
-	c_init:		init_rise,
+	.c_init =	init_rise,
 };
 
 int __init rise_init_cpu(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/transmeta.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/transmeta.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/transmeta.c	Mon Jun 10 16:03:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/transmeta.c	Fri Jul 19 13:15:28 2002
@@ -80,10 +80,10 @@ static void transmeta_identify(struct cp
 }
 
 static struct cpu_dev transmeta_cpu_dev __initdata = {
-	c_vendor:	"Transmeta",
-	c_ident:	{ "GenuineTMx86", "TransmetaCPU" },
-	c_init:		init_transmeta,
-	c_identify:	transmeta_identify,
+	.c_vendor =	"Transmeta",
+	.c_ident =	{ "GenuineTMx86", "TransmetaCPU" },
+	.c_init =	init_transmeta,
+	.c_identify =	transmeta_identify,
 };
 
 int __init transmeta_init_cpu(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpu/umc.c linux-2.5.26.28536.updated/arch/i386/kernel/cpu/umc.c
--- linux-2.5.26.28536/arch/i386/kernel/cpu/umc.c	Mon Jun 10 16:03:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpu/umc.c	Fri Jul 19 13:15:28 2002
@@ -11,9 +11,9 @@ static void __init init_umc(struct cpuin
 }
 
 static struct cpu_dev umc_cpu_dev __initdata = {
-	c_vendor:	"UMC",
-	c_ident: 	{ "UMC UMC UMC" },
-	c_models: {
+	.c_vendor =	"UMC",
+	.c_ident = 	{ "UMC UMC UMC" },
+	.c_models = {
 		{ X86_VENDOR_UMC,	4,
 		  { 
 			  [1] "U5D", 
@@ -21,7 +21,7 @@ static struct cpu_dev umc_cpu_dev __init
 		  }
 		},
 	},
-	c_init:		init_umc,
+	.c_init =	init_umc,
 };
 
 int __init umc_init_cpu(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/cpuid.c linux-2.5.26.28536.updated/arch/i386/kernel/cpuid.c
--- linux-2.5.26.28536/arch/i386/kernel/cpuid.c	Sat May 25 14:34:36 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/cpuid.c	Fri Jul 19 13:16:00 2002
@@ -146,10 +146,10 @@ static int cpuid_open(struct inode *inod
  * File operations we support
  */
 static struct file_operations cpuid_fops = {
-  owner:	THIS_MODULE,
-  llseek:	cpuid_seek,
-  read:		cpuid_read,
-  open:		cpuid_open,
+  .owner =	THIS_MODULE,
+  .llseek =	cpuid_seek,
+  .read =	cpuid_read,
+  .open =	cpuid_open,
 };
 
 int __init cpuid_init(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/i8259.c linux-2.5.26.28536.updated/arch/i386/kernel/i8259.c
--- linux-2.5.26.28536/arch/i386/kernel/i8259.c	Mon Jun 17 23:19:16 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/i8259.c	Fri Jul 19 13:15:27 2002
@@ -246,13 +246,13 @@ static int i8259A_resume(struct device *
 }
 
 static struct device_driver driver_i8259A = {
-	resume:		i8259A_resume,
+	.resume =	i8259A_resume,
 };
 
 static struct device device_i8259A = {
-	name:	       	"i8259A",
-	bus_id:		"0020",
-	driver:		&driver_i8259A,
+	.name =	       	"i8259A",
+	.bus_id =	"0020",
+	.driver =	&driver_i8259A,
 };
 
 static int __init init_8259A_devicefs(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/microcode.c linux-2.5.26.28536.updated/arch/i386/kernel/microcode.c
--- linux-2.5.26.28536/arch/i386/kernel/microcode.c	Thu Jun 20 01:28:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/microcode.c	Fri Jul 19 13:15:27 2002
@@ -109,17 +109,17 @@ static unsigned int mc_fsize;       /* f
 
 /* we share file_operations between misc and devfs mechanisms */
 static struct file_operations microcode_fops = {
-	owner:		THIS_MODULE,
-	read:		microcode_read,
-	write:		microcode_write,
-	ioctl:		microcode_ioctl,
-	open:		microcode_open,
+	.owner =	THIS_MODULE,
+	.read =		microcode_read,
+	.write =	microcode_write,
+	.ioctl =	microcode_ioctl,
+	.open =		microcode_open,
 };
 
 static struct miscdevice microcode_dev = {
-	minor: MICROCODE_MINOR,
-	name:	"microcode",
-	fops:	&microcode_fops,
+	.minor = MICROCODE_MINOR,
+	.name =	"microcode",
+	.fops =	&microcode_fops,
 };
 
 static devfs_handle_t devfs_handle;
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/msr.c linux-2.5.26.28536.updated/arch/i386/kernel/msr.c
--- linux-2.5.26.28536/arch/i386/kernel/msr.c	Sat May 25 14:34:36 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/msr.c	Fri Jul 19 13:16:14 2002
@@ -246,11 +246,11 @@ static int msr_open(struct inode *inode,
  * File operations we support
  */
 static struct file_operations msr_fops = {
-  owner:	THIS_MODULE,
-  llseek:	msr_seek,
-  read:		msr_read,
-  write:	msr_write,
-  open:		msr_open,
+  .owner =	THIS_MODULE,
+  .llseek =	msr_seek,
+  .read =	msr_read,
+  .write =	msr_write,
+  .open =	msr_open,
 };
 
 int __init msr_init(void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.28536/arch/i386/kernel/time.c linux-2.5.26.28536.updated/arch/i386/kernel/time.c
--- linux-2.5.26.28536/arch/i386/kernel/time.c	Thu Jun 20 01:28:47 2002
+++ linux-2.5.26.28536.updated/arch/i386/kernel/time.c	Fri Jul 19 13:15:27 2002
@@ -639,8 +639,8 @@ bad_ctc:
 }
 
 static struct device device_i8253 = {
-	name:	       	"i8253",
-	bus_id:		"0040",
+	.name =	       	"i8253",
+	.bus_id =	"0040",
 };
 
 static int time_init_driverfs(void)
