Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTAJJCh>; Fri, 10 Jan 2003 04:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTAJJCC>; Fri, 10 Jan 2003 04:02:02 -0500
Received: from dp.samba.org ([66.70.73.150]:44446 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264705AbTAJJB3>;
	Fri, 10 Jan 2003 04:01:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: __gpl_ksymtab 
In-reply-to: Your message of "Thu, 09 Jan 2003 11:26:59 -0000."
             <20030109112659.B15310@flint.arm.linux.org.uk> 
Date: Fri, 10 Jan 2003 19:54:00 +1100
Message-Id: <20030110091014.231C82C4C2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030109112659.B15310@flint.arm.linux.org.uk> you write:
> In 2.5.55, we have a new section called "__gpl_ksymtab".
> 
> This, unfortunately, isn't mentioned in the linker script, and on ARM
> gets placed at 0x1c58, where the rest of the kernel is at 0xcXXXXXXX.
> 
> This section isn't even mentioned in the x86 linker script, so there
> isn't an example of the placement expectations of this section.

Exactly the same as __ksymtab.

> Rusty, can you provide the missing bits please?

Sure, I discarded it from the patch, when I discovered that the linker
creates the __start_ and __stop_ symbols automagically (as long as
it's not empty, which this never is).

But for clarity, and for section placement, here are all the archs,
consistent with whatever style the rest of the file is in

Linus, please apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/alpha/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/alpha/vmlinux.lds.S
--- linux-2.5.55/arch/alpha/vmlinux.lds.S	2003-01-02 12:46:56.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/alpha/vmlinux.lds.S	2003-01-10 19:47:08.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/arm/vmlinux-armo.lds.in working-2.5.55-gpl_ksymtab/arch/arm/vmlinux-armo.lds.in
--- linux-2.5.55/arch/arm/vmlinux-armo.lds.in	2003-01-02 12:32:55.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/arm/vmlinux-armo.lds.in	2003-01-10 19:45:52.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/arm/vmlinux-armv.lds.in working-2.5.55-gpl_ksymtab/arch/arm/vmlinux-armv.lds.in
--- linux-2.5.55/arch/arm/vmlinux-armv.lds.in	2003-01-10 10:55:40.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/arm/vmlinux-armv.lds.in	2003-01-10 19:46:39.000000000 +1100
@@ -81,6 +81,12 @@ SECTIONS
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/cris/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/cris/vmlinux.lds.S
--- linux-2.5.55/arch/cris/vmlinux.lds.S	2003-01-02 12:27:11.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/cris/vmlinux.lds.S	2003-01-10 19:45:16.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/i386/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/i386/vmlinux.lds.S
--- linux-2.5.55/arch/i386/vmlinux.lds.S	2003-01-02 12:46:12.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/i386/vmlinux.lds.S	2003-01-10 19:44:51.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/ia64/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/ia64/vmlinux.lds.S
--- linux-2.5.55/arch/ia64/vmlinux.lds.S	2003-01-02 12:46:59.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/ia64/vmlinux.lds.S	2003-01-10 19:44:26.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68k/vmlinux-std.lds working-2.5.55-gpl_ksymtab/arch/m68k/vmlinux-std.lds
--- linux-2.5.55/arch/m68k/vmlinux-std.lds	2003-01-02 14:47:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68k/vmlinux-std.lds	2003-01-10 19:43:03.000000000 +1100
@@ -24,6 +24,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
   _etext = .;			/* End of text section */
 
   .data : {			/* Data */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68k/vmlinux-sun3.lds working-2.5.55-gpl_ksymtab/arch/m68k/vmlinux-sun3.lds
--- linux-2.5.55/arch/m68k/vmlinux-sun3.lds	2003-01-02 14:47:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68k/vmlinux-sun3.lds	2003-01-10 19:43:53.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5206/ARNEWSH/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5206/ARNEWSH/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5206/ARNEWSH/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5206/ARNEWSH/ram.ld	2003-01-10 19:51:20.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5206e/MOTOROLA/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5206e/MOTOROLA/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5206e/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5206e/MOTOROLA/ram.ld	2003-01-10 19:51:13.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5206e/eLITE/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5206e/eLITE/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5206e/eLITE/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5206e/eLITE/ram.ld	2003-01-10 19:51:09.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5249/MOTOROLA/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5249/MOTOROLA/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5249/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5249/MOTOROLA/ram.ld	2003-01-10 19:51:04.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5272/MOTOROLA/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5272/MOTOROLA/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5272/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5272/MOTOROLA/ram.ld	2003-01-10 19:50:59.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5272/NETtel/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5272/NETtel/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5272/NETtel/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5272/NETtel/ram.ld	2003-01-10 19:50:55.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5307/ARNEWSH/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/ARNEWSH/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5307/ARNEWSH/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/ARNEWSH/ram.ld	2003-01-10 19:50:51.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5307/CLEOPATRA/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/CLEOPATRA/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5307/CLEOPATRA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/CLEOPATRA/ram.ld	2003-01-10 19:50:46.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5307/MOTOROLA/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/MOTOROLA/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5307/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/MOTOROLA/ram.ld	2003-01-10 19:50:42.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5307/MP3/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/MP3/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5307/MP3/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/MP3/ram.ld	2003-01-10 19:50:36.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5307/NETtel/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/NETtel/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5307/NETtel/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5307/NETtel/ram.ld	2003-01-10 19:50:30.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5407/CLEOPATRA/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5407/CLEOPATRA/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5407/CLEOPATRA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5407/CLEOPATRA/ram.ld	2003-01-10 19:50:23.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/5407/MOTOROLA/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5407/MOTOROLA/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/5407/MOTOROLA/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/5407/MOTOROLA/ram.ld	2003-01-10 19:50:06.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/68360/uCquicc/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68360/uCquicc/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/68360/uCquicc/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68360/uCquicc/ram.ld	2003-01-10 19:49:26.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/68360/uCquicc/rom.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68360/uCquicc/rom.ld
--- linux-2.5.55/arch/m68knommu/platform/68360/uCquicc/rom.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68360/uCquicc/rom.ld	2003-01-10 19:49:15.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/68EZ328/ucsimm/fixed.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68EZ328/ucsimm/fixed.ld
--- linux-2.5.55/arch/m68knommu/platform/68EZ328/ucsimm/fixed.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68EZ328/ucsimm/fixed.ld	2003-01-10 19:48:58.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/68EZ328/ucsimm/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68EZ328/ucsimm/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/68EZ328/ucsimm/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68EZ328/ucsimm/ram.ld	2003-01-10 19:48:52.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/68VZ328/de2/fixed.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68VZ328/de2/fixed.ld
--- linux-2.5.55/arch/m68knommu/platform/68VZ328/de2/fixed.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68VZ328/de2/fixed.ld	2003-01-10 19:48:45.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/68VZ328/de2/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68VZ328/de2/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/68VZ328/de2/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68VZ328/de2/ram.ld	2003-01-10 19:48:39.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/68VZ328/ucdimm/fixed.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68VZ328/ucdimm/fixed.ld
--- linux-2.5.55/arch/m68knommu/platform/68VZ328/ucdimm/fixed.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68VZ328/ucdimm/fixed.ld	2003-01-10 19:48:32.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68knommu/platform/68VZ328/ucdimm/ram.ld working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68VZ328/ucdimm/ram.ld
--- linux-2.5.55/arch/m68knommu/platform/68VZ328/ucdimm/ram.ld	2003-01-02 12:32:57.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/m68knommu/platform/68VZ328/ucdimm/ram.ld	2003-01-10 19:48:21.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/mips/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/mips/vmlinux.lds.S
--- linux-2.5.55/arch/mips/vmlinux.lds.S	2003-01-02 12:27:11.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/mips/vmlinux.lds.S	2003-01-10 19:42:22.000000000 +1100
@@ -29,6 +29,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
   _etext = .;
 
   . = ALIGN(8192);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/parisc/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/parisc/vmlinux.lds.S
--- linux-2.5.55/arch/parisc/vmlinux.lds.S	2003-01-02 12:34:00.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/parisc/vmlinux.lds.S	2003-01-10 19:41:28.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/ppc/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/ppc/vmlinux.lds.S
--- linux-2.5.55/arch/ppc/vmlinux.lds.S	2003-01-02 12:46:15.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/ppc/vmlinux.lds.S	2003-01-10 19:41:22.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/ppc64/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/ppc64/vmlinux.lds.S
--- linux-2.5.55/arch/ppc64/vmlinux.lds.S	2003-01-02 12:46:15.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/ppc64/vmlinux.lds.S	2003-01-10 19:41:14.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/s390/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/s390/vmlinux.lds.S
--- linux-2.5.55/arch/s390/vmlinux.lds.S	2003-01-02 12:35:59.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/s390/vmlinux.lds.S	2003-01-10 19:41:06.000000000 +1100
@@ -30,6 +30,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+
 #ifdef CONFIG_SHARED_KERNEL
   . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/s390x/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/s390x/vmlinux.lds.S
--- linux-2.5.55/arch/s390x/vmlinux.lds.S	2003-01-02 12:35:59.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/s390x/vmlinux.lds.S	2003-01-10 19:40:57.000000000 +1100
@@ -30,6 +30,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
+	
 #ifdef CONFIG_SHARED_KERNEL
   . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/sh/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/sh/vmlinux.lds.S
--- linux-2.5.55/arch/sh/vmlinux.lds.S	2003-01-02 12:03:44.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/sh/vmlinux.lds.S	2003-01-10 19:40:32.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/sparc/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/sparc/vmlinux.lds.S
--- linux-2.5.55/arch/sparc/vmlinux.lds.S	2003-01-02 14:47:58.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/sparc/vmlinux.lds.S	2003-01-10 19:40:12.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/sparc64/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/sparc64/vmlinux.lds.S
--- linux-2.5.55/arch/sparc64/vmlinux.lds.S	2003-01-02 12:46:15.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/sparc64/vmlinux.lds.S	2003-01-10 19:39:52.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/v850/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/v850/vmlinux.lds.S
--- linux-2.5.55/arch/v850/vmlinux.lds.S	2003-01-02 12:46:59.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/v850/vmlinux.lds.S	2003-01-10 19:39:33.000000000 +1100
@@ -51,6 +51,9 @@
 		___start___ksymtab = . ;/* Kernel symbol table.  */	      \
 			*(__ksymtab)					      \
 		___stop___ksymtab = . ;					      \
+		___start___gpl_ksymtab = . ;/* GPL Kernel symbol table. */    \
+			*(__gpl_ksymtab)				      \
+		___stop___gpl_ksymtab = . ;				      \
 		. = ALIGN (4) ;						      \
 		__etext = . ;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/x86_64/vmlinux.lds.S working-2.5.55-gpl_ksymtab/arch/x86_64/vmlinux.lds.S
--- linux-2.5.55/arch/x86_64/vmlinux.lds.S	2003-01-02 12:47:00.000000000 +1100
+++ working-2.5.55-gpl_ksymtab/arch/x86_64/vmlinux.lds.S	2003-01-10 19:38:12.000000000 +1100
@@ -30,6 +30,9 @@ SECTIONS
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
+  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
 
   __start___kallsyms = .;	/* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
