Return-Path: <linux-kernel-owner+w=401wt.eu-S932745AbWLNO30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbWLNO30 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWLNO30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:29:26 -0500
Received: from gw-eur4.philips.com ([161.85.125.10]:55229 "EHLO
	gw-eur4.philips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745AbWLNO3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:29:24 -0500
To: <hpa@zytor.com>, <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] disable init/initramfs.c (updated)
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.0.3 September 26, 2003
Message-ID: <OF9C0D2745.6844BC7B-ONC1257244.003CD5C0-C1257244.004D8073@philips.com>
From: Jean-Paul Saman <jean-paul.saman@nxp.com>
Date: Thu, 14 Dec 2006 15:06:29 +0100
X-MIMETrack: Serialize by Router on ehvrmh02/H/SERVER/PHILIPS(Release 6.5.5HF805 | August
 26, 2006) at 14/12/2006 15:06:32,
	Serialize complete at 14/12/2006 15:06:32
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update all arch/*/kernel/vmlinux.lds.S to not include space for initramfs 
when CONFIG_BLK_DEV_INITRAMFS is not selected. This saves another 4 kbytes 
on most platfoms (some reserve PAGE_SIZE for initramfs).

Signed-off-by: Jean-Paul Saman <jean-paul.saman@nxp.com>
----------------------

Index: linux-2.6.git/arch/arm/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/arm/kernel/vmlinux.lds.S    2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/arm/kernel/vmlinux.lds.S 2006-12-14 
14:20:30.000000000 +0100
@@ -53,10 +53,12 @@ SECTIONS
                __security_initcall_start = .;
                        *(.security_initcall.init)
                __security_initcall_end = .;
+#ifdef CONFIG_BLK_DEV_INITRD
                . = ALIGN(32);
                __initramfs_start = .;
                        usr/built-in.o(.init.ramfs)
                __initramfs_end = .;
+#endif
                . = ALIGN(64);
                __per_cpu_start = .;
                        *(.data.percpu)
Index: linux-2.6.git/arch/alpha/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/alpha/kernel/vmlinux.lds.S  2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/alpha/kernel/vmlinux.lds.S       2006-12-14 
14:20:30.000000000 +0100
@@ -52,10 +52,12 @@ SECTIONS
   }
   __initcall_end = .;
 
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(8192);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
 
   . = ALIGN(8);
   .con_initcall.init : {
Index: linux-2.6.git/arch/arm26/kernel/vmlinux-arm26-xip.lds.in
===================================================================
--- linux-2.6.git.orig/arch/arm26/kernel/vmlinux-arm26-xip.lds.in 
2006-12-14 13:21:54.000000000 +0100
+++ linux-2.6.git/arch/arm26/kernel/vmlinux-arm26-xip.lds.in    2006-12-14 
14:20:30.000000000 +0100
@@ -46,10 +46,12 @@ SECTIONS
                __con_initcall_start = .;
                        *(.con_initcall.init)
                __con_initcall_end = .;
+#ifdef CONFIG_BLK_DEV_INITRD
                . = ALIGN(32);
                __initramfs_start = .;
                        usr/built-in.o(.init.ramfs)
                __initramfs_end = .;
+#endif
                . = ALIGN(32768);
                __init_end = .;
        }
Index: linux-2.6.git/arch/arm26/kernel/vmlinux-arm26.lds.in
===================================================================
--- linux-2.6.git.orig/arch/arm26/kernel/vmlinux-arm26.lds.in   2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/arm26/kernel/vmlinux-arm26.lds.in        2006-12-14 
14:20:30.000000000 +0100
@@ -47,10 +47,12 @@ SECTIONS
                __con_initcall_start = .;
                        *(.con_initcall.init)
                __con_initcall_end = .;
+#ifdef CONFIG_BLK_DEV_INITRD
                . = ALIGN(32);
                __initramfs_start = .;
                        usr/built-in.o(.init.ramfs)
                __initramfs_end = .;
+#endif
                . = ALIGN(32768);
                __init_end = .;
        }
Index: linux-2.6.git/arch/avr32/kernel/vmlinux.lds.c
===================================================================
--- linux-2.6.git.orig/arch/avr32/kernel/vmlinux.lds.c  2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/avr32/kernel/vmlinux.lds.c       2006-12-14 
14:20:30.000000000 +0100
@@ -46,10 +46,12 @@ SECTIONS
                __security_initcall_start = .;
                        *(.security_initcall.init)
                __security_initcall_end = .;
+#ifdef CONFIG_BLK_DEV_INITRD
                . = ALIGN(32);
                __initramfs_start = .;
                        *(.init.ramfs)
                __initramfs_end = .;
+#endif
                . = ALIGN(4096);
                __init_end = .;
        }
Index: linux-2.6.git/arch/frv/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/frv/kernel/vmlinux.lds.S    2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/frv/kernel/vmlinux.lds.S 2006-12-14 
14:20:30.000000000 +0100
@@ -61,10 +61,12 @@ SECTIONS
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
 
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
 
   . = ALIGN(THREAD_SIZE);
   __init_end = .;
Index: linux-2.6.git/arch/h8300/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/h8300/kernel/vmlinux.lds.S  2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/h8300/kernel/vmlinux.lds.S       2006-12-14 
14:20:30.000000000 +0100
@@ -126,10 +126,12 @@ SECTIONS
        ___con_initcall_end = .;
                *(.exit.text)
                *(.exit.data)
+#if defined(CONFIG_BLK_DEV_INITRD)
                . = ALIGN(4);
        ___initramfs_start = .;
                *(.init.ramfs)
        ___initramfs_end = .;
+#endif
        . = ALIGN(0x4) ;
        ___init_end = .;
        __edata = . ;
Index: linux-2.6.git/arch/ia64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/ia64/kernel/vmlinux.lds.S   2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/ia64/kernel/vmlinux.lds.S        2006-12-14 
14:20:30.000000000 +0100
@@ -111,12 +111,14 @@ SECTIONS
   .init.data : AT(ADDR(.init.data) - LOAD_OFFSET)
        { *(.init.data) }
 
+#ifdef CONFIG_BLK_DEV_INITRD
   .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET)
        {
          __initramfs_start = .;
          *(.init.ramfs)
          __initramfs_end = .;
        }
+#endif
 
    . = ALIGN(16);
   .init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET)
Index: linux-2.6.git/arch/m32r/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/m32r/kernel/vmlinux.lds.S   2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/m32r/kernel/vmlinux.lds.S        2006-12-14 
14:20:30.000000000 +0100
@@ -99,10 +99,14 @@ SECTIONS
      from .altinstructions and .eh_frame */
   .exit.text : { *(.exit.text) }
   .exit.data : { *(.exit.data) }
+
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
+
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
Index: linux-2.6.git/arch/m68k/kernel/vmlinux-std.lds
===================================================================
--- linux-2.6.git.orig/arch/m68k/kernel/vmlinux-std.lds 2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/m68k/kernel/vmlinux-std.lds      2006-12-14 
14:20:30.000000000 +0100
@@ -61,10 +61,12 @@ SECTIONS
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
   SECURITY_INIT
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(8192);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
   . = ALIGN(8192);
   __init_end = .;
 
Index: linux-2.6.git/arch/m68k/kernel/vmlinux-sun3.lds
===================================================================
--- linux-2.6.git.orig/arch/m68k/kernel/vmlinux-sun3.lds        2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/m68k/kernel/vmlinux-sun3.lds     2006-12-14 
14:20:30.000000000 +0100
@@ -55,10 +55,12 @@ __init_begin = .;
        .con_initcall.init : { *(.con_initcall.init) }
        __con_initcall_end = .;
        SECURITY_INIT
+#ifdef CONFIG_BLK_DEV_INITRD
        . = ALIGN(8192);
        __initramfs_start = .;
        .init.ramfs : { *(.init.ramfs) }
        __initramfs_end = .;
+#endif
        . = ALIGN(8192);
        __init_end = .;
        .data.init.task : { *(.data.init_task) }
Index: linux-2.6.git/arch/m68knommu/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/m68knommu/kernel/vmlinux.lds.S      2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/m68knommu/kernel/vmlinux.lds.S   2006-12-14 
14:20:30.000000000 +0100
@@ -149,10 +149,12 @@ SECTIONS {
                __security_initcall_start = .;
                *(.security_initcall.init)
                __security_initcall_end = .;
+#ifdef CONFIG_BLK_DEV_INITRD
                . = ALIGN(4);
                __initramfs_start = .;
                *(.init.ramfs)
                __initramfs_end = .;
+#endif
                . = ALIGN(4096);
                __init_end = .;
        } > INIT
Index: linux-2.6.git/arch/parisc/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/parisc/kernel/vmlinux.lds.S 2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/parisc/kernel/vmlinux.lds.S      2006-12-14 
14:20:30.000000000 +0100
@@ -173,10 +173,12 @@ SECTIONS
      from .altinstructions and .eh_frame */
   .exit.text : { *(.exit.text) }
   .exit.data : { *(.exit.data) }
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(ASM_PAGE_SIZE);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
Index: linux-2.6.git/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/vmlinux.lds.S        2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/powerpc/kernel/vmlinux.lds.S     2006-12-14 
14:20:30.000000000 +0100
@@ -131,14 +131,14 @@ SECTIONS
                __stop___fw_ftr_fixup = .;
        }
 #endif
-
+#ifdef CONFIG_BLK_DEV_INITRD
        . = ALIGN(PAGE_SIZE);
        .init.ramfs : {
                __initramfs_start = .;
                *(.init.ramfs)
                __initramfs_end = .;
        }
-
+#endif
 #ifdef CONFIG_PPC32
        . = ALIGN(32);
 #else
Index: linux-2.6.git/arch/ppc/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/ppc/kernel/vmlinux.lds.S    2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/ppc/kernel/vmlinux.lds.S 2006-12-14 
14:20:30.000000000 +0100
@@ -135,10 +135,12 @@ SECTIONS
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
 
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
 
   . = ALIGN(4096);
   __init_end = .;
Index: linux-2.6.git/arch/s390/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/s390/kernel/vmlinux.lds.S   2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/s390/kernel/vmlinux.lds.S        2006-12-14 
14:56:33.000000000 +0100
@@ -90,11 +90,14 @@ SECTIONS
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
   SECURITY_INIT
+
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(256);
   __initramfs_start = .;
   .init.ramfs : { *(.init.initramfs) }
   . = ALIGN(2);
   __initramfs_end = .;
+#endif
   . = ALIGN(256);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
Index: linux-2.6.git/arch/sh/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/sh/kernel/vmlinux.lds.S     2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/sh/kernel/vmlinux.lds.S  2006-12-14 
14:20:30.000000000 +0100
@@ -83,9 +83,13 @@ SECTIONS
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
   SECURITY_INIT
+
+#ifdef CONFIG_BLK_DEV_INITRD
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
+
   __machvec_start = .;
   .init.machvec : { *(.init.machvec) }
   __machvec_end = .;
Index: linux-2.6.git/arch/sh64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/sh64/kernel/vmlinux.lds.S   2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/sh64/kernel/vmlinux.lds.S        2006-12-14 
14:57:16.000000000 +0100
@@ -115,9 +115,13 @@ SECTIONS
   .con_initcall.init : C_PHYS(.con_initcall.init) { *(.con_initcall.init) 
}
   __con_initcall_end = .;
   SECURITY_INIT
+
+#ifdef CONFIG_BLK_DEV_INITRD
   __initramfs_start = .;
   .init.ramfs : C_PHYS(.init.ramfs) { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
+
   . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
Index: linux-2.6.git/arch/sparc/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/sparc/kernel/vmlinux.lds.S  2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/sparc/kernel/vmlinux.lds.S       2006-12-14 
14:20:30.000000000 +0100
@@ -57,10 +57,14 @@ SECTIONS
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
   SECURITY_INIT
+
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
+
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
Index: linux-2.6.git/arch/sparc64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/sparc64/kernel/vmlinux.lds.S        2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/sparc64/kernel/vmlinux.lds.S     2006-12-14 
14:20:30.000000000 +0100
@@ -81,10 +81,14 @@ SECTIONS
   __sun4v_2insn_patch = .;
   .sun4v_2insn_patch : { *(.sun4v_2insn_patch) }
   __sun4v_2insn_patch_end = .;
+
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(8192); 
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
+
   . = ALIGN(8192);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
Index: linux-2.6.git/arch/v850/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/v850/kernel/vmlinux.lds.S   2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/v850/kernel/vmlinux.lds.S        2006-12-14 
14:20:30.000000000 +0100
@@ -190,12 +190,16 @@
                __root_fs_image_start = . ;    \
                *(.root)    \
                __root_fs_image_end = . ;
+
+#ifdef CONFIG_BLK_DEV_INITRD
 /* The initramfs archive.  */
 #define INITRAMFS_CONTENTS    \
                . = ALIGN (4) ;    \
                ___initramfs_start = . ;    \
                        *(.init.ramfs)    \
                ___initramfs_end = . ;
+#endif
+
 /* Where the initial bootmap (bitmap for the boot-time memory allocator) 
    should be place.  */
 #define BOOTMAP_CONTENTS    \
Index: linux-2.6.git/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/x86_64/kernel/vmlinux.lds.S 2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/x86_64/kernel/vmlinux.lds.S      2006-12-14 
14:20:30.000000000 +0100
@@ -192,10 +192,14 @@ SECTIONS
      from .altinstructions and .eh_frame */
   .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
   .exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) { *(.exit.data) }
+
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
+
     . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) 
}
Index: linux-2.6.git/arch/xtensa/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/xtensa/kernel/vmlinux.lds.S 2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/xtensa/kernel/vmlinux.lds.S      2006-12-14 
14:20:30.000000000 +0100
@@ -203,10 +203,12 @@ SECTIONS
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
 
+#ifdef CONFIG_BLK_DEV_INITRD
   . = ALIGN(4096);
   __initramfs_start =.;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
 
   /* We need this dummy segment here */
 
Index: linux-2.6.git/arch/cris/arch-v10/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v10/vmlinux.lds.S 2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/cris/arch-v10/vmlinux.lds.S      2006-12-14 
14:20:30.000000000 +0100
@@ -82,7 +82,8 @@ SECTIONS
                __con_initcall_end = .;
        } 
        SECURITY_INIT
- 
+
+#ifdef CONFIG_BLK_DEV_INITRD
        .init.ramfs : {
                __initramfs_start = .;
                *(.init.ramfs)
@@ -93,6 +94,7 @@ SECTIONS
                FILL (0); 
                . = ALIGN (8192);
        }
+#endif
 
        __vmlinux_end = .;            /* last address of the physical file 
*/
        __init_end = .;
Index: linux-2.6.git/arch/cris/arch-v32/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/cris/arch-v32/vmlinux.lds.S 2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/cris/arch-v32/vmlinux.lds.S      2006-12-14 
14:20:30.000000000 +0100
@@ -95,6 +95,7 @@ SECTIONS
        .data.percpu  : { *(.data.percpu) }
        __per_cpu_end = .;
 
+#ifdef CONFIG_BLK_DEV_INITRD
        .init.ramfs : {
                __initramfs_start = .;
                *(.init.ramfs)
@@ -107,6 +108,7 @@ SECTIONS
                FILL (0);
                . = ALIGN (8192);
        }
+#endif
 
        __vmlinux_end = .;      /* Last address of the physical file. */
        __init_end = .;
Index: linux-2.6.git/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/i386/kernel/vmlinux.lds.S   2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/i386/kernel/vmlinux.lds.S        2006-12-14 
14:20:30.000000000 +0100
@@ -181,12 +181,14 @@ SECTIONS
      from .altinstructions and .eh_frame */
   .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
   .exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) { *(.exit.data) }
+#if defined(CONFIG_BLK_DEV_INITRD)
   . = ALIGN(4096);
   .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
        __initramfs_start = .;
        *(.init.ramfs)
        __initramfs_end = .;
   }
+#endif
   . = ALIGN(L1_CACHE_BYTES);
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) {
        __per_cpu_start = .;
Index: linux-2.6.git/arch/mips/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/mips/kernel/vmlinux.lds.S   2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/arch/mips/kernel/vmlinux.lds.S        2006-12-14 
14:20:30.000000000 +0100
@@ -113,10 +113,12 @@ SECTIONS
      references from .rodata */
   .exit.text : { *(.exit.text) }
   .exit.data : { *(.exit.data) }
+#if defined(CONFIG_BLK_DEV_INITRD)
   . = ALIGN(_PAGE_SIZE);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
+#endif
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }

-----
Kind greetings,

Jean-Paul Saman

NXP Semiconductors CTO/RTG DesignIP
