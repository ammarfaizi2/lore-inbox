Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVGKCRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVGKCRT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 22:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVGKCRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 22:17:19 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:5760 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S262185AbVGKCRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 22:17:16 -0400
Date: Sun, 10 Jul 2005 22:11:44 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc2] all archs: add "__slow" tag for slow code
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Chris Zankel <zankel@tensilica.com>,
       David Mosberger <davidm@hpl.hp.com>, Denis Vlasenko <vda@ilport.com.ua>,
       Geert Uytterhoeven <geert@linux-m68k.org>, Ian Molton <spyro@f2s.com>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Matthew Wilcox <willy@debian.org>, Paul Mackerras <paulus@samba.org>,
       Paul Mundt <lethal@linux-sh.org>, Ralf Baechle <ralf@linux-mips.org>,
       Richard Henderson <rth@twiddle.net>,
       Russell King <rmk@arm.linux.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jeff Dike <jdike@karaya.com>
Message-ID: <200507102213_MC3-1-A41D-E92A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch adds a tag, "__slow" for marking non-performance-critical
functions in all architectures.

===================================================================
--- 2.6.13-rc2a.orig/include/linux/compiler.h	2005-06-24 00:50:34.000000000 -0400
+++ 2.6.13-rc2a/include/linux/compiler.h	2005-07-10 12:33:00.000000000 -0400
@@ -36,6 +36,10 @@
 
 #ifdef __KERNEL__
 
+/* Text section for code that is not speed-critical.
+ */
+#define __slow		noinline __attribute__((__section__(".slow.text")))
+
 #if __GNUC__ > 4
 #error no compiler-gcc.h file for this gcc version
 #elif __GNUC__ == 4
===================================================================
--- 2.6.13-rc2a.orig/arch/alpha/kernel/vmlinux.lds.S	2004-09-03 19:55:27.000000000 -0400
+++ 2.6.13-rc2a/arch/alpha/kernel/vmlinux.lds.S	2005-07-10 12:46:56.000000000 -0400
@@ -20,6 +20,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
   } :kernel
   _etext = .;					/* End of text section */
===================================================================
--- 2.6.13-rc2a.orig/arch/arm/kernel/vmlinux.lds.S	2005-06-24 00:50:17.000000000 -0400
+++ 2.6.13-rc2a/arch/arm/kernel/vmlinux.lds.S	2005-07-10 12:38:39.000000000 -0400
@@ -81,6 +81,7 @@
 			SCHED_TEXT
 			LOCK_TEXT
 			*(.fixup)
+			*(.slow.text)
 			*(.gnu.warning)
 			*(.rodata)
 			*(.rodata.*)
===================================================================
--- 2.6.13-rc2a.orig/arch/arm26/kernel/vmlinux-arm26-xip.lds.in	2005-01-03 18:49:27.000000000 -0500
+++ 2.6.13-rc2a/arch/arm26/kernel/vmlinux-arm26-xip.lds.in	2005-07-10 12:43:46.000000000 -0400
@@ -66,6 +66,7 @@
 			SCHED_TEXT
 			LOCK_TEXT       /* FIXME - borrowed from arm32 - check*/
 			*(.fixup)
+			*(.slow.text)
 			*(.gnu.warning)
 			*(.rodata)
 			*(.rodata.*)
===================================================================
--- 2.6.13-rc2a.orig/arch/arm26/kernel/vmlinux-arm26.lds.in	2005-01-03 18:49:27.000000000 -0500
+++ 2.6.13-rc2a/arch/arm26/kernel/vmlinux-arm26.lds.in	2005-07-10 12:44:02.000000000 -0400
@@ -67,6 +67,7 @@
 			SCHED_TEXT
 			LOCK_TEXT
 			*(.fixup)
+			*(.slow.text)
 			*(.gnu.warning)
 			*(.rodata)
 			*(.rodata.*)
===================================================================
--- 2.6.13-rc2a.orig/arch/cris/arch-v10/vmlinux.lds.S	2004-11-11 03:33:13.000000000 -0500
+++ 2.6.13-rc2a/arch/cris/arch-v10/vmlinux.lds.S	2005-07-10 12:42:05.000000000 -0400
@@ -28,6 +28,7 @@
 		SCHED_TEXT
 		LOCK_TEXT
 		*(.fixup)
+		*(.slow.text)
 		*(.text.__*)
 	}
 
===================================================================
--- 2.6.13-rc2a.orig/arch/frv/kernel/vmlinux.lds.S	2005-02-04 07:35:19.000000000 -0500
+++ 2.6.13-rc2a/arch/frv/kernel/vmlinux.lds.S	2005-07-10 12:51:29.000000000 -0400
@@ -113,6 +113,7 @@
 	)
 	SCHED_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	*(.exitcall.exit)
 	} = 0x9090
===================================================================
--- 2.6.13-rc2a.orig/arch/h8300/kernel/vmlinux.lds.S	2004-11-15 22:29:13.000000000 -0500
+++ 2.6.13-rc2a/arch/h8300/kernel/vmlinux.lds.S	2005-07-10 12:49:14.000000000 -0400
@@ -78,6 +78,7 @@
         	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
+		*(.slow.text)
 	__etext = . ;
 	. = ALIGN(16);          /* Exception table              */
 	___start___ex_table = .;
===================================================================
--- 2.6.13-rc2a.orig/arch/i386/kernel/vmlinux.lds.S	2005-07-07 18:19:01.000000000 -0400
+++ 2.6.13-rc2a/arch/i386/kernel/vmlinux.lds.S	2005-07-09 22:20:29.000000000 -0400
@@ -23,6 +23,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	} = 0x9090
 
===================================================================
--- 2.6.13-rc2a.orig/arch/ia64/kernel/vmlinux.lds.S	2005-07-07 18:19:01.000000000 -0400
+++ 2.6.13-rc2a/arch/ia64/kernel/vmlinux.lds.S	2005-07-10 12:45:56.000000000 -0400
@@ -48,6 +48,7 @@
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
+	*(.slow.text)
 	*(.gnu.linkonce.t*)
     }
   .text2 : AT(ADDR(.text2) - LOAD_OFFSET)
===================================================================
--- 2.6.13-rc2a.orig/arch/m32r/kernel/vmlinux.lds.S	2004-09-24 04:27:50.000000000 -0400
+++ 2.6.13-rc2a/arch/m32r/kernel/vmlinux.lds.S	2005-07-10 12:49:47.000000000 -0400
@@ -29,6 +29,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	} = 0x9090
 #ifdef CONFIG_SMP
===================================================================
--- 2.6.13-rc2a.orig/arch/m68k/kernel/vmlinux-std.lds	2004-10-20 04:37:09.000000000 -0400
+++ 2.6.13-rc2a/arch/m68k/kernel/vmlinux-std.lds	2005-07-10 12:44:58.000000000 -0400
@@ -14,6 +14,7 @@
 	*(.text)
 	SCHED_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	} :text = 0x4e75
 
===================================================================
--- 2.6.13-rc2a.orig/arch/m68k/kernel/vmlinux-sun3.lds	2004-11-19 02:03:13.000000000 -0500
+++ 2.6.13-rc2a/arch/m68k/kernel/vmlinux-sun3.lds	2005-07-10 12:45:08.000000000 -0400
@@ -15,6 +15,7 @@
 	*(.text)
 	SCHED_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	} :text = 0x4e75
 	RODATA
===================================================================
--- 2.6.13-rc2a.orig/arch/m68knommu/kernel/vmlinux.lds.S	2005-01-05 21:42:10.000000000 -0500
+++ 2.6.13-rc2a/arch/m68knommu/kernel/vmlinux.lds.S	2005-07-10 12:40:27.000000000 -0400
@@ -222,6 +222,7 @@
         	*(.text)
 		SCHED_TEXT
         	*(.text.lock)
+		*(.slow.text)
 
 		. = ALIGN(16);          /* Exception table              */
 		__start___ex_table = .;
===================================================================
--- 2.6.13-rc2a.orig/arch/mips/kernel/vmlinux.lds.S	2005-01-31 01:22:40.000000000 -0500
+++ 2.6.13-rc2a/arch/mips/kernel/vmlinux.lds.S	2005-07-10 12:30:33.000000000 -0400
@@ -31,6 +31,7 @@
     SCHED_TEXT
     LOCK_TEXT
     *(.fixup)
+    *(.slow.text)
     *(.gnu.warning)
   } =0
 
===================================================================
--- 2.6.13-rc2a.orig/arch/parisc/kernel/vmlinux.lds.S	2005-06-24 00:50:19.000000000 -0400
+++ 2.6.13-rc2a/arch/parisc/kernel/vmlinux.lds.S	2005-07-10 12:48:08.000000000 -0400
@@ -60,6 +60,7 @@
 	*(.text.*)
 	*(.fixup)
 	*(.lock.text)		/* out-of-line lock text */
+	*(.slow.text)
 	*(.gnu.warning)
 	} = 0
 
===================================================================
--- 2.6.13-rc2a.orig/arch/ppc/kernel/vmlinux.lds.S	2005-06-24 00:50:19.000000000 -0400
+++ 2.6.13-rc2a/arch/ppc/kernel/vmlinux.lds.S	2005-07-09 22:21:38.000000000 -0400
@@ -34,6 +34,7 @@
     SCHED_TEXT
     LOCK_TEXT
     *(.fixup)
+    *(.slow.text)
     *(.got1)
     __got2_start = .;
     *(.got2)
===================================================================
--- 2.6.13-rc2a.orig/arch/ppc64/kernel/vmlinux.lds.S	2004-09-13 20:23:12.000000000 -0400
+++ 2.6.13-rc2a/arch/ppc64/kernel/vmlinux.lds.S	2005-07-09 22:21:59.000000000 -0400
@@ -16,6 +16,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	. = ALIGN(4096);
 	_etext = .;
 	}
===================================================================
--- 2.6.13-rc2a.orig/arch/s390/kernel/vmlinux.lds.S	2004-09-03 19:55:27.000000000 -0400
+++ 2.6.13-rc2a/arch/s390/kernel/vmlinux.lds.S	2005-07-10 12:53:03.000000000 -0400
@@ -26,6 +26,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	} = 0x0700
 
===================================================================
--- 2.6.13-rc2a.orig/arch/sh/kernel/vmlinux.lds.S	2004-09-03 19:55:27.000000000 -0400
+++ 2.6.13-rc2a/arch/sh/kernel/vmlinux.lds.S	2005-07-10 12:40:58.000000000 -0400
@@ -25,6 +25,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	} = 0x0009
 
===================================================================
--- 2.6.13-rc2a.orig/arch/sh64/kernel/vmlinux.lds.S	2004-09-03 19:55:27.000000000 -0400
+++ 2.6.13-rc2a/arch/sh64/kernel/vmlinux.lds.S	2005-07-10 12:52:23.000000000 -0400
@@ -61,6 +61,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 #ifdef CONFIG_LITTLE_ENDIAN
 	} = 0x6ff0fff0
===================================================================
--- 2.6.13-rc2a.orig/arch/sparc/kernel/vmlinux.lds.S	2004-09-03 19:55:27.000000000 -0400
+++ 2.6.13-rc2a/arch/sparc/kernel/vmlinux.lds.S	2005-07-10 12:34:42.000000000 -0400
@@ -14,6 +14,7 @@
     *(.text)
     SCHED_TEXT
     LOCK_TEXT
+    *(.slow.text)
     *(.gnu.warning)
   } =0
   _etext = .;
===================================================================
--- 2.6.13-rc2a.orig/arch/sparc64/kernel/vmlinux.lds.S	2005-06-24 00:50:20.000000000 -0400
+++ 2.6.13-rc2a/arch/sparc64/kernel/vmlinux.lds.S	2005-07-10 12:39:20.000000000 -0400
@@ -17,6 +17,7 @@
     *(.text)
     SCHED_TEXT
     LOCK_TEXT
+    *(.slow.text)
     *(.gnu.warning)
   } =0
   _etext = .;
===================================================================
--- 2.6.13-rc2a.orig/arch/um/kernel/dyn.lds.S	2005-01-15 17:01:56.000000000 -0500
+++ 2.6.13-rc2a/arch/um/kernel/dyn.lds.S	2005-07-10 12:36:51.000000000 -0400
@@ -64,6 +64,7 @@
     SCHED_TEXT
     LOCK_TEXT
     *(.fixup)
+    *(.slow.text)
     *(.stub .text.* .gnu.linkonce.t.*)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
===================================================================
--- 2.6.13-rc2a.orig/arch/um/kernel/uml.lds.S	2005-07-07 18:19:03.000000000 -0400
+++ 2.6.13-rc2a/arch/um/kernel/uml.lds.S	2005-07-10 12:37:14.000000000 -0400
@@ -36,6 +36,7 @@
     SCHED_TEXT
     LOCK_TEXT
     *(.fixup)
+    *(.slow.text)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
     *(.gnu.linkonce.t*)
===================================================================
--- 2.6.13-rc2a.orig/arch/v850/kernel/vmlinux.lds.S	2004-11-02 09:40:41.000000000 -0500
+++ 2.6.13-rc2a/arch/v850/kernel/vmlinux.lds.S	2005-07-10 12:54:02.000000000 -0400
@@ -74,6 +74,7 @@
 			*(.exit.text)	/* 2.5 convention */		      \
 			*(.text.exit)	/* 2.4 convention */		      \
 			*(.text.lock)					      \
+			*(.slow.text)
 			*(.exitcall.exit)				      \
 		__real_etext = . ;	/* There may be data after here.  */  \
 		RODATA_CONTENTS						      \
===================================================================
--- 2.6.13-rc2a.orig/arch/x86_64/kernel/vmlinux.lds.S	2005-07-07 18:19:04.000000000 -0400
+++ 2.6.13-rc2a/arch/x86_64/kernel/vmlinux.lds.S	2005-07-09 22:22:26.000000000 -0400
@@ -22,6 +22,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	} = 0x9090
   				/* out-of-line lock text */
===================================================================
--- 2.6.13-rc2a.orig/arch/xtensa/kernel/vmlinux.lds.S	2005-07-07 18:19:04.000000000 -0400
+++ 2.6.13-rc2a/arch/xtensa/kernel/vmlinux.lds.S	2005-07-10 12:54:53.000000000 -0400
@@ -88,6 +88,7 @@
     /* The .head.text section must be the first section! */
     *(.head.text)
     *(.literal .text)
+    *(.slow.text)
     *(.srom.text)
     VMLINUX_SYMBOL(__sched_text_start) = .;
     *(.sched.text.literal .sched.text)
__
Chuck
