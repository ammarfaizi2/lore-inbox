Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTAMDCG>; Sun, 12 Jan 2003 22:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTAMDCG>; Sun, 12 Jan 2003 22:02:06 -0500
Received: from dp.samba.org ([66.70.73.150]:56243 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261398AbTAMDBd>;
	Sun, 12 Jan 2003 22:01:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Place __gpl_ksymtab section in all linker scripts
Date: Mon, 13 Jan 2003 12:13:51 +1100
Message-Id: <20030113031023.0F6BF2C052@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see v850 already did it, so this is the rest.

Linus, please apply.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: __gpl_ksymtab section placement patch
Author: Rusty Russell
Status: Trivial

D: Explicitly place the __gpl_ksymtab section for every arch.  RMK
D: pointed out that some archs will place it really badly otherwise.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/alpha/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/alpha/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/alpha/vmlinux.lds.S	2003-01-02 12:46:56.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/alpha/vmlinux.lds.S	2003-01-13 12:12:21.000000000 +1100
@@ -32,6 +32,13 @@ SECTIONS
 	__stop___ksymtab = .;
   }
 
+  /* Kernel symbol table: GPL only */
+  __gpl_ksymtab ALIGN(8) : {
+	__start___gpl_ksymtab = .;
+	*(__gpl_ksymtab)
+	__stop___gpl_ksymtab = .;
+  }
+
   /* All kernel symbols */
   __kallsyms ALIGN(8) : {
 	__start___kallsyms = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/arm/vmlinux-armo.lds.in .18366-linux-2.5-bk.updated/arch/arm/vmlinux-armo.lds.in
--- .18366-linux-2.5-bk/arch/arm/vmlinux-armo.lds.in	2003-01-02 12:32:55.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/arm/vmlinux-armo.lds.in	2003-01-13 12:12:21.000000000 +1100
@@ -78,6 +78,12 @@ SECTIONS
 		__stop___ksymtab = .;
 	}
 
+	__gpl_ksymtab : {		/* Kernel symbol table: GPL-only */
+		__start___gpl_ksymtab = .;
+			*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+	}
+
 	.data : {
 		/*
 		 * The cacheline aligned data
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/arm/vmlinux-armv.lds.in .18366-linux-2.5-bk.updated/arch/arm/vmlinux-armv.lds.in
--- .18366-linux-2.5-bk/arch/arm/vmlinux-armv.lds.in	2003-01-13 11:17:24.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/arm/vmlinux-armv.lds.in	2003-01-13 12:12:21.000000000 +1100
@@ -87,6 +87,12 @@ SECTIONS
 		__stop___ksymtab = .;
 	}
 
+	__gpl_ksymtab : {		/* Kernel symbol table: GPL-only*/
+		__start___gpl_ksymtab = .;
+			*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+	}
+
 	__kallsyms : {			/* All kernel symbols		*/
 		__start___kallsyms = .;
 			*(__kallsyms)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/cris/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/cris/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/cris/vmlinux.lds.S	2003-01-02 12:27:11.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/cris/vmlinux.lds.S	2003-01-13 12:12:21.000000000 +1100
@@ -43,6 +43,10 @@ SECTIONS
   	__ksymtab : { *(__ksymtab) }
   	__stop___ksymtab = .;
 
+	__start___gpl_ksymtab = .;    /* Kernel symbol table: GPL-only */
+	__gpl_ksymtab : { *(__gpl_ksymtab) }
+	__stop___gpl_ksymtab = .;
+
 	. = ALIGN (4);
 	___data_start = . ;
 	__Sdata = . ;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/i386/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/i386/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/i386/vmlinux.lds.S	2003-01-02 12:46:12.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/i386/vmlinux.lds.S	2003-01-13 12:12:21.000000000 +1100
@@ -31,6 +31,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   __start___kallsyms = .;       /* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
   __stop___kallsyms = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/ia64/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/ia64/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/ia64/vmlinux.lds.S	2003-01-02 12:46:59.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/ia64/vmlinux.lds.S	2003-01-13 12:12:21.000000000 +1100
@@ -65,6 +65,11 @@ SECTIONS
 	{ *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL only */
+  __gpl_ksymtab : AT(ADDR(__gpl_ksymtab) - PAGE_OFFSET)
+	{ *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   __kallsyms : AT(ADDR(__kallsyms) - PAGE_OFFSET)
 	{
 	  __start___kallsyms = .;	/* All kernel symbols */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68k/vmlinux-std.lds .18366-linux-2.5-bk.updated/arch/m68k/vmlinux-std.lds
--- .18366-linux-2.5-bk/arch/m68k/vmlinux-std.lds	2003-01-02 14:47:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68k/vmlinux-std.lds	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table: GPL only */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   _etext = .;			/* End of text section */
 
   .data : {			/* Data */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68k/vmlinux-sun3.lds .18366-linux-2.5-bk.updated/arch/m68k/vmlinux-sun3.lds
--- .18366-linux-2.5-bk/arch/m68k/vmlinux-sun3.lds	2003-01-02 14:47:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68k/vmlinux-sun3.lds	2003-01-13 12:12:21.000000000 +1100
@@ -30,6 +30,9 @@ SECTIONS
   	__start___ksymtab = .;	/* Kernel symbol table */
   	*(__ksymtab) 
   	__stop___ksymtab = .;
+	__start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+	__gpl_ksymtab : { *(__gpl_ksymtab) }
+	__stop___gpl_ksymtab = .;
 	}
   /* End of data goes *here* so that freeing init code works properly. */
   _edata = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5206/ARNEWSH/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5206/ARNEWSH/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5206/ARNEWSH/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5206/ARNEWSH/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5206e/MOTOROLA/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5206e/MOTOROLA/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5206e/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5206e/MOTOROLA/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5206e/eLITE/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5206e/eLITE/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5206e/eLITE/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5206e/eLITE/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5249/MOTOROLA/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5249/MOTOROLA/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5249/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5249/MOTOROLA/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -25,6 +25,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5272/MOTOROLA/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5272/MOTOROLA/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5272/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5272/MOTOROLA/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -25,6 +25,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5272/NETtel/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5272/NETtel/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5272/NETtel/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5272/NETtel/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -25,6 +25,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5307/ARNEWSH/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/ARNEWSH/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5307/ARNEWSH/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/ARNEWSH/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5307/CLEOPATRA/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/CLEOPATRA/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5307/CLEOPATRA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/CLEOPATRA/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5307/MOTOROLA/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/MOTOROLA/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5307/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/MOTOROLA/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5307/MP3/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/MP3/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5307/MP3/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/MP3/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5307/NETtel/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/NETtel/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5307/NETtel/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5307/NETtel/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5407/CLEOPATRA/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5407/CLEOPATRA/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5407/CLEOPATRA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5407/CLEOPATRA/ram.ld	2003-01-13 12:12:21.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/5407/MOTOROLA/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5407/MOTOROLA/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/5407/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/5407/MOTOROLA/ram.ld	2003-01-13 12:12:22.000000000 +1100
@@ -24,6 +24,11 @@ SECTIONS {
 		__start___ksymtab = .;  /* Kernel symbol table          */
 		*(__ksymtab)
 		__stop___ksymtab = .;
+
+	        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only */
+		*(__gpl_ksymtab)
+		__stop___gpl_ksymtab = .;
+
 		. = ALIGN(4) ;
 		_etext = . ;
 	} > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/68360/uCquicc/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68360/uCquicc/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/68360/uCquicc/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68360/uCquicc/ram.ld	2003-01-13 12:12:22.000000000 +1100
@@ -38,6 +38,9 @@ SECTIONS
 	__start___ksymtab = . ;
 	*(__ksymtab)
         __stop___ksymtab = . ;
+	__start___gpl_ksymtab = . ;
+	*(__gpl_ksymtab)
+        __stop___gpl_ksymtab = . ;
 	__start___ex_table = . ;
 	*(___ex_table)
 	__stop___ex_table = . ;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/68360/uCquicc/rom.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68360/uCquicc/rom.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/68360/uCquicc/rom.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68360/uCquicc/rom.ld	2003-01-13 12:12:22.000000000 +1100
@@ -38,6 +38,9 @@ SECTIONS
         __start___ksymtab = . ;
         *(__ksymtab)
         __stop___ksymtab = . ;
+        __start___gpl_ksymtab = . ;
+        *(__gpl_ksymtab)
+        __stop___gpl_ksymtab = . ;
         __start___ex_table = . ;
         *(___ex_table)
         __stop___ex_table = . ;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/68EZ328/ucsimm/fixed.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68EZ328/ucsimm/fixed.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/68EZ328/ucsimm/fixed.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68EZ328/ucsimm/fixed.ld	2003-01-13 12:12:22.000000000 +1100
@@ -30,6 +30,10 @@ SECTIONS
 		 *(__ksymtab)
 	__stop___ksymtab = .;
 
+        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only  */
+		 *(__gpl_ksymtab)
+	__stop___gpl_ksymtab = .;
+
 	. = ALIGN(0x4) ;
 	_etext = . ;
 	__data_rom_start = . ;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/68EZ328/ucsimm/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68EZ328/ucsimm/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/68EZ328/ucsimm/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68EZ328/ucsimm/ram.ld	2003-01-13 12:12:22.000000000 +1100
@@ -51,6 +51,10 @@ SECTIONS
 		 *(__ksymtab)
 	__stop___ksymtab = .;
 
+        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only  */
+		 *(__gpl_ksymtab)
+	__stop___gpl_ksymtab = .;
+
 	_etext = . ;
 	__data_rom_start = ALIGN ( 4 ) ;
         } > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/68VZ328/de2/fixed.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68VZ328/de2/fixed.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/68VZ328/de2/fixed.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68VZ328/de2/fixed.ld	2003-01-13 12:12:22.000000000 +1100
@@ -29,6 +29,10 @@ SECTIONS
 		 *(__ksymtab)
 	__stop___ksymtab = .;
 
+        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only  */
+		 *(__gpl_ksymtab)
+	__stop___gpl_ksymtab = .;
+
 	. = ALIGN(0x4) ;
 	_etext = . ;
 	__data_rom_start = . ;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/68VZ328/de2/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68VZ328/de2/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/68VZ328/de2/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68VZ328/de2/ram.ld	2003-01-13 12:12:22.000000000 +1100
@@ -50,6 +50,10 @@ SECTIONS
 		 *(__ksymtab)
 	__stop___ksymtab = .;
 
+        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only  */
+		 *(__gpl_ksymtab)
+	__stop___gpl_ksymtab = .;
+
 	_etext = . ;
 	__data_rom_start = ALIGN ( 4 ) ;
         } > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/68VZ328/ucdimm/fixed.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68VZ328/ucdimm/fixed.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/68VZ328/ucdimm/fixed.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68VZ328/ucdimm/fixed.ld	2003-01-13 12:12:22.000000000 +1100
@@ -29,6 +29,10 @@ SECTIONS
 		 *(__ksymtab)
 	__stop___ksymtab = .;
 
+        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only  */
+		 *(__gpl_ksymtab)
+	__stop___gpl_ksymtab = .;
+
 	. = ALIGN(0x4) ;
 	_etext = . ;
 	__data_rom_start = . ;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/m68knommu/platform/68VZ328/ucdimm/ram.ld .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68VZ328/ucdimm/ram.ld
--- .18366-linux-2.5-bk/arch/m68knommu/platform/68VZ328/ucdimm/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/m68knommu/platform/68VZ328/ucdimm/ram.ld	2003-01-13 12:12:22.000000000 +1100
@@ -50,6 +50,10 @@ SECTIONS
 		 *(__ksymtab)
 	__stop___ksymtab = .;
 
+        __start___gpl_ksymtab = .;  /* Kernel symbol table: GPL-only  */
+		 *(__gpl_ksymtab)
+	__stop___gpl_ksymtab = .;
+
 	_etext = . ;
 	__data_rom_start = ALIGN ( 4 ) ;
         } > ram
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/mips/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/mips/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/mips/vmlinux.lds.S	2003-01-02 12:27:11.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/mips/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -29,6 +29,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   _etext = .;
 
   . = ALIGN(8192);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/parisc/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/parisc/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/parisc/vmlinux.lds.S	2003-01-02 12:34:00.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/parisc/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -49,6 +49,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   __start___kallsyms = .;       /* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
   __stop___kallsyms = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/ppc/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/ppc/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/ppc/vmlinux.lds.S	2003-01-02 12:46:15.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/ppc/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -61,6 +61,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   __start___kallsyms = .;     /* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
   __stop___kallsyms = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/ppc64/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/ppc64/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/ppc64/vmlinux.lds.S	2003-01-02 12:46:15.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/ppc64/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -69,6 +69,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   __start___kallsyms = .;	/* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
   __stop___kallsyms = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/s390/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/s390/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/s390/vmlinux.lds.S	2003-01-02 12:35:59.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/s390/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -30,6 +30,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
 #ifdef CONFIG_SHARED_KERNEL
   . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/s390x/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/s390x/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/s390x/vmlinux.lds.S	2003-01-02 12:35:59.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/s390x/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -30,6 +30,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+	
 #ifdef CONFIG_SHARED_KERNEL
   . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/sh/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/sh/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/sh/vmlinux.lds.S	2003-01-02 12:03:44.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/sh/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -37,6 +37,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   __start___kallsyms = .;	/* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
   __stop___kallsyms = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/sparc/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/sparc/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/sparc/vmlinux.lds.S	2003-01-02 14:47:58.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/sparc/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -35,6 +35,10 @@ SECTIONS
   __ksymtab  : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   __start___kallsyms = .;	/* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
   __stop___kallsyms = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/sparc64/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/sparc64/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/sparc64/vmlinux.lds.S	2003-01-02 12:46:15.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/sparc64/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -39,6 +39,9 @@ SECTIONS
   __start___ksymtab = .;
   __ksymtab  : { *(__ksymtab) }
   __stop___ksymtab = .;
+  __start___gpl_ksymtab = .;
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
   __kstrtab  : { *(.kstrtab) }
   __start___kallsyms = .;	/* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18366-linux-2.5-bk/arch/x86_64/vmlinux.lds.S .18366-linux-2.5-bk.updated/arch/x86_64/vmlinux.lds.S
--- .18366-linux-2.5-bk/arch/x86_64/vmlinux.lds.S	2003-01-02 12:47:00.000000000 +1100
+++ .18366-linux-2.5-bk.updated/arch/x86_64/vmlinux.lds.S	2003-01-13 12:12:22.000000000 +1100
@@ -30,6 +30,9 @@ SECTIONS
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
 
   __start___kallsyms = .;	/* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
