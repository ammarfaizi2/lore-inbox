Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTFBJxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTFBJxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:53:24 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:14585 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262098AbTFBJwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:52:49 -0400
Date: Mon, 2 Jun 2003 03:03:19 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] Early init for security modules and various cleanups
Message-ID: <20030602030319.G27233@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
References: <20030602024910.B27233@figure1.int.wirex.com> <20030602025450.C27233@figure1.int.wirex.com> <20030602025736.D27233@figure1.int.wirex.com> <20030602030009.E27233@figure1.int.wirex.com> <20030602030145.F27233@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030602030145.F27233@figure1.int.wirex.com>; from chris@wirex.com on Mon, Jun 02, 2003 at 03:01:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1263  -> 1.1264 
#	arch/m68k/vmlinux-sun3.lds	1.14    -> 1.15   
#	 security/security.c	1.7     -> 1.8    
#	include/linux/init.h	1.25    -> 1.26   
#	include/asm-generic/vmlinux.lds.h	1.7     -> 1.8    
#	arch/x86_64/vmlinux.lds.S	1.16    -> 1.17   
#	arch/sparc/vmlinux.lds.S	1.16    -> 1.17   
#	arch/h8300/platform/h8300h/generic/rom.ld	1.1     -> 1.2    
#	         init/main.c	1.99    -> 1.100  
#	arch/i386/vmlinux.lds.S	1.30    -> 1.31   
#	arch/parisc/vmlinux.lds.S	1.13    -> 1.14   
#	arch/mips/vmlinux.lds.S	1.8     -> 1.9    
#	arch/arm/vmlinux-armv.lds.in	1.24    -> 1.25   
#	security/capability.c	1.16    -> 1.17   
#	arch/s390/vmlinux.lds.S	1.13    -> 1.14   
#	arch/m68knommu/vmlinux.lds.S	1.9     -> 1.10   
#	arch/cris/vmlinux.lds.S	1.16    -> 1.17   
#	arch/mips64/vmlinux.lds.S	1.7     -> 1.8    
#	arch/alpha/vmlinux.lds.S	1.21    -> 1.22   
#	arch/sh/vmlinux.lds.S	1.10    -> 1.11   
#	arch/ppc64/vmlinux.lds.S	1.14    -> 1.15   
#	arch/ia64/vmlinux.lds.S	1.29    -> 1.30   
#	arch/sparc64/vmlinux.lds.S	1.18    -> 1.19   
#	arch/m68k/vmlinux-std.lds	1.16    -> 1.17   
#	arch/arm/vmlinux-armo.lds.in	1.15    -> 1.16   
#	security/root_plug.c	1.3     -> 1.4    
#	arch/ppc/vmlinux.lds.S	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/02	chris@wirex.com	1.1264
# [LSM] early init for security modules.  As discussed before, this allows
# for early initialization of security modules when compiled statically
# into the kernel.  The standard do_initcalls is too late for complete
# coverage of all filesystems and threads, for example.
# --------------------------------------------
#
diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/alpha/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -74,6 +74,9 @@
 	__con_initcall_end = .;
   }
 
+  . = ALIGN(8);
+  SECURITY_INIT
+
   . = ALIGN(64);
   __per_cpu_start = .;
   .data.percpu : { *(.data.percpu) }
diff -Nru a/arch/arm/vmlinux-armo.lds.in b/arch/arm/vmlinux-armo.lds.in
--- a/arch/arm/vmlinux-armo.lds.in	Mon Jun  2 01:31:49 2003
+++ b/arch/arm/vmlinux-armo.lds.in	Mon Jun  2 01:31:49 2003
@@ -43,6 +43,7 @@
 		__con_initcall_start = .;
 			*(.con_initcall.init)
 		__con_initcall_end = .;
+		SECURITY_INIT
 		. = ALIGN(32768);
 		__init_end = .;
 	}
diff -Nru a/arch/arm/vmlinux-armv.lds.in b/arch/arm/vmlinux-armv.lds.in
--- a/arch/arm/vmlinux-armv.lds.in	Mon Jun  2 01:31:49 2003
+++ b/arch/arm/vmlinux-armv.lds.in	Mon Jun  2 01:31:49 2003
@@ -53,6 +53,7 @@
 		__con_initcall_start = .;
 			*(.con_initcall.init)
 		__con_initcall_end = .;
+		SECURITY_INIT
 		. = ALIGN(32);
 		__initramfs_start = .;
 			usr/built-in.o(.init.ramfs)
diff -Nru a/arch/cris/vmlinux.lds.S b/arch/cris/vmlinux.lds.S
--- a/arch/cris/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/cris/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -74,7 +74,9 @@
 		__con_initcall_start = .;
 		*(.con_initcall.init)
 		__con_initcall_end = .;
-	
+	}
+	SECURITY_INIT
+
 		/* We fill to the next page, so we can discard all init
 		   pages without needing to consider what payload might be
 		   appended to the kernel image.  */
diff -Nru a/arch/h8300/platform/h8300h/generic/rom.ld b/arch/h8300/platform/h8300h/generic/rom.ld
--- a/arch/h8300/platform/h8300h/generic/rom.ld	Mon Jun  2 01:31:49 2003
+++ b/arch/h8300/platform/h8300h/generic/rom.ld	Mon Jun  2 01:31:49 2003
@@ -83,6 +83,7 @@
 	___con_initcall_start = .;
 		*(.con_initcall.init)
 	___con_initcall_end = .;
+	SECURITY_INIT
 		. = ALIGN(4);
 	___initramfs_start = .;
   		*(.init.ramfs)
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/i386/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -81,6 +81,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4);
   __alt_instructions = .;
   .altinstructions : { *(.altinstructions) } 
diff -Nru a/arch/ia64/vmlinux.lds.S b/arch/ia64/vmlinux.lds.S
--- a/arch/ia64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/ia64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -141,6 +141,10 @@
   .con_initcall.init : AT(ADDR(.con_initcall.init) - PAGE_OFFSET)
 	{ *(.con_initcall.init) }
   __con_initcall_end = .;
+  __security_initcall_start = .;
+  .security_initcall.init : AT(ADDR(.security_initcall.init) - PAGE_OFFSET)
+	{ *(.security_initcall.init) }
+  __security_initcall_end = .;
   . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
diff -Nru a/arch/m68k/vmlinux-std.lds b/arch/m68k/vmlinux-std.lds
--- a/arch/m68k/vmlinux-std.lds	Mon Jun  2 01:31:49 2003
+++ b/arch/m68k/vmlinux-std.lds	Mon Jun  2 01:31:49 2003
@@ -67,6 +67,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(8192);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/m68k/vmlinux-sun3.lds b/arch/m68k/vmlinux-sun3.lds
--- a/arch/m68k/vmlinux-sun3.lds	Mon Jun  2 01:31:49 2003
+++ b/arch/m68k/vmlinux-sun3.lds	Mon Jun  2 01:31:49 2003
@@ -61,6 +61,7 @@
 	__con_initcall_start = .;
 	.con_initcall.init : { *(.con_initcall.init) }
 	__con_initcall_end = .;
+	SECURITY_INIT
 	. = ALIGN(8192);
 	__initramfs_start = .;
 	.init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/m68knommu/vmlinux.lds.S b/arch/m68knommu/vmlinux.lds.S
--- a/arch/m68knommu/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/m68knommu/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -277,9 +277,7 @@
 		__con_initcall_start = .;
 		*(.con_initcall.init)
 		__con_initcall_end = .;
-		__security_initcall_start = .;
-		*(.security_initcall.init)
-		__security_initcall_end = .;
+		SECURITY_INIT
 		. = ALIGN(4);
 		__initramfs_start = .;
 		*(.init.ramfs)
diff -Nru a/arch/mips/vmlinux.lds.S b/arch/mips/vmlinux.lds.S
--- a/arch/mips/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/mips/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -54,6 +54,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);	/* Align double page for init_task_union */
   __init_end = .;
 
diff -Nru a/arch/mips64/vmlinux.lds.S b/arch/mips64/vmlinux.lds.S
--- a/arch/mips64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/mips64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -53,6 +53,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);	/* Align double page for init_task_union */
   __init_end = .;
 
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/parisc/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -80,6 +80,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/ppc/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -115,6 +115,8 @@
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
 
+  SECURITY_INIT
+
   __start___ftr_fixup = .;
   __ftr_fixup : { *(__ftr_fixup) }
   __stop___ftr_fixup = .;
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/ppc64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -104,6 +104,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/s390/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -94,6 +94,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(256);
   __initramfs_start = .;
   .init.ramfs : { *(.init.initramfs) }
diff -Nru a/arch/sh/vmlinux.lds.S b/arch/sh/vmlinux.lds.S
--- a/arch/sh/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/sh/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -71,6 +71,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   __machvec_start = .;
   .machvec.init : { *(.machvec.init) }
   __machvec_end = .;
diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/sparc/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -62,6 +62,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/sparc64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -68,6 +68,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(8192); 
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
+++ b/arch/x86_64/vmlinux.lds.S	Mon Jun  2 01:31:49 2003
@@ -105,6 +105,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Mon Jun  2 01:31:49 2003
+++ b/include/asm-generic/vmlinux.lds.h	Mon Jun  2 01:31:49 2003
@@ -45,3 +45,9 @@
 		*(__ksymtab_strings)					\
 	}
 
+#define SECURITY_INIT							\
+	.security_initcall.init : {					\
+		__security_initcall_start = .;				\
+		*(.security_initcall.init) 				\
+		__security_initcall_end = .;				\
+	}
diff -Nru a/include/linux/init.h b/include/linux/init.h
--- a/include/linux/init.h	Mon Jun  2 01:31:49 2003
+++ b/include/linux/init.h	Mon Jun  2 01:31:49 2003
@@ -64,6 +64,7 @@
 typedef void (*exitcall_t)(void);
 
 extern initcall_t __con_initcall_start, __con_initcall_end;
+extern initcall_t __security_initcall_start, __security_initcall_end;
 #endif
   
 #ifndef MODULE
@@ -96,6 +97,9 @@
 #define console_initcall(fn) \
 	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".con_initcall.init")))=fn
 
+#define security_initcall(fn) \
+	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".security_initcall.init"))) = fn
+
 struct obs_kernel_param {
 	const char *str;
 	int (*setup_func)(char *);
@@ -142,6 +146,8 @@
 #define fs_initcall(fn)			module_init(fn)
 #define device_initcall(fn)		module_init(fn)
 #define late_initcall(fn)		module_init(fn)
+
+#define security_initcall(fn)		module_init(fn)
 
 /* These macros create a dummy inline: gcc 2.9x does not count alias
  as usage, hence the `unused function' warning when __init functions
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Mon Jun  2 01:31:49 2003
+++ b/init/main.c	Mon Jun  2 01:31:49 2003
@@ -435,8 +435,8 @@
 	pte_chain_init();
 	fork_init(num_physpages);
 	proc_caches_init();
-	security_scaffolding_startup();
 	buffer_init();
+	security_scaffolding_startup();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
diff -Nru a/security/capability.c b/security/capability.c
--- a/security/capability.c	Mon Jun  2 01:31:49 2003
+++ b/security/capability.c	Mon Jun  2 01:31:49 2003
@@ -340,7 +340,7 @@
 	}
 }
 
-module_init (capability_init);
+security_initcall (capability_init);
 module_exit (capability_exit);
 
 MODULE_DESCRIPTION("Standard Linux Capabilities Security Module");
diff -Nru a/security/root_plug.c b/security/root_plug.c
--- a/security/root_plug.c	Mon Jun  2 01:31:49 2003
+++ b/security/root_plug.c	Mon Jun  2 01:31:49 2003
@@ -183,7 +183,7 @@
 	printk (KERN_INFO "Root Plug module removed\n");
 }
 
-module_init (rootplug_init);
+security_initcall (rootplug_init);
 module_exit (rootplug_exit);
 
 MODULE_DESCRIPTION("Root Plug sample LSM module, written for Linux Journal article");
diff -Nru a/security/security.c b/security/security.c
--- a/security/security.c	Mon Jun  2 01:31:49 2003
+++ b/security/security.c	Mon Jun  2 01:31:49 2003
@@ -38,12 +38,22 @@
 	return 0;
 }
 
+static void __init do_security_initcalls(void)
+{
+	initcall_t *call;
+	call = &__security_initcall_start;
+	while (call < &__security_initcall_end) {
+		(*call)();
+		call++;
+	}
+}
+
 /**
  * security_scaffolding_startup - initialzes the security scaffolding framework
  *
  * This should be called early in the kernel initialization sequence.
  */
-int security_scaffolding_startup (void)
+int __init security_scaffolding_startup (void)
 {
 	printk (KERN_INFO "Security Scaffold v" SECURITY_SCAFFOLD_VERSION
 		" initialized\n");
@@ -55,6 +65,7 @@
 	}
 
 	security_ops = &dummy_security_ops;
+	do_security_initcalls();
 
 	return 0;
 }
