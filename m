Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTFHGQI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 02:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbTFHGQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 02:16:08 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:28426 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264619AbTFHGPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 02:15:38 -0400
Date: Sun, 8 Jun 2003 08:28:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Cc: davem@redhat.com, bjornw@axis.com, davidm@hpl.hp.com, paulus@au.ibm.com,
       anton@au.ibm.com, jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx,
       schwidefsky@de.ibm.com, kkojima@rr.iij4u.or.jp, ak@suse.de,
       rmk@arm.linux.org.uk, gerg@snapgear.com
Subject: [PATCH] all archs: Replace O_TARGET with lib-y
Message-ID: <20030608062856.GA1573@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, davem@redhat.com, bjornw@axis.com,
	davidm@hpl.hp.com, paulus@au.ibm.com, anton@au.ibm.com,
	jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx,
	schwidefsky@de.ibm.com, kkojima@rr.iij4u.or.jp, ak@suse.de,
	rmk@arm.linux.org.uk, gerg@snapgear.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lib-y is the new way to define what objects belongs to a library.
The implementation was not made backwards compatible and therefore
an update to all architectures are needed.
This is a simple replacement of obj-* to lib-* and deletion of
L_TARGET. The new mechanish where lib.a can be mixed with built-in.o is
not utilised.

Trivial patch follows, please apply.
Relevant maintainers cc:ed.

	Sam

 alpha/lib/Makefile       |    6 ++----
 arm/lib/Makefile         |   28 ++++++++++++----------------
 cris/lib/Makefile        |    4 +---
 h8300/lib/Makefile       |    3 +--
 ia64/lib/Makefile        |   10 ++++------
 m68k/lib/Makefile        |    4 +---
 m68knommu/lib/Makefile   |    3 +--
 mips/arc/Makefile        |    6 ++----
 mips/baget/prom/Makefile |    4 +---
 mips/dec/prom/Makefile   |    4 +---
 mips/lib/Makefile        |   14 ++++++--------
 mips64/arc/Makefile      |    7 +++----
 mips64/lib/Makefile      |    4 +---
 mips64/sgi-ip22/Makefile |    4 +---
 parisc/lib/Makefile      |    3 +--
 ppc/boot/common/Makefile |   12 +++++-------
 ppc/boot/lib/Makefile    |    4 +---
 ppc/boot/of1275/Makefile |    4 +---
 ppc64/lib/Makefile       |    6 ++----
 s390/lib/Makefile        |    8 +++-----
 sh/lib/Makefile          |    3 +--
 sparc/lib/Makefile       |    4 +---
 sparc/prom/Makefile      |    6 ++----
 sparc64/lib/Makefile     |    3 +--
 sparc64/prom/Makefile    |    3 +--
 v850/lib/Makefile        |    3 +--
 x86_64/lib/Makefile      |    9 ++++-----
 27 files changed, 61 insertions(+), 108 deletions(-)


===== arch/alpha/lib/Makefile 1.14 vs edited =====
--- 1.14/arch/alpha/lib/Makefile	Thu Feb 20 22:52:41 2003
+++ edited/arch/alpha/lib/Makefile	Sun Jun  8 08:06:47 2003
@@ -5,8 +5,6 @@
 EXTRA_AFLAGS := $(CFLAGS)
 EXTRA_CFLAGS := -Werror
 
-L_TARGET := lib.a
-
 # Many of these routines have implementations tuned for ev6.
 # Choose them iff we're targeting ev6 specifically.
 ev6-$(CONFIG_ALPHA_EV6) := ev6-
@@ -14,7 +12,7 @@
 # Several make use of the cttz instruction introduced in ev67.
 ev67-$(CONFIG_ALPHA_EV67) := ev67-
 
-obj-y =	__divqu.o __remqu.o __divlu.o __remlu.o \
+lib-y =	__divqu.o __remqu.o __divlu.o __remlu.o \
 	udelay.o \
 	$(ev6-y)memset.o \
 	$(ev6-y)memcpy.o \
@@ -43,7 +41,7 @@
 	fpreg.o \
 	callback_srm.o srm_puts.o srm_printk.o
 
-obj-$(CONFIG_SMP) += dec_and_lock.o
+lib-$(CONFIG_SMP) += dec_and_lock.o
 
 # The division routines are built from single source, with different defines.
 AFLAGS___divqu.o = -DDIV
===== arch/arm/lib/Makefile 1.16 vs edited =====
--- 1.16/arch/arm/lib/Makefile	Thu Mar 27 10:53:04 2003
+++ edited/arch/arm/lib/Makefile	Sun Jun  8 08:08:21 2003
@@ -4,9 +4,7 @@
 # Copyright (C) 1995-2000 Russell King
 #
 
-L_TARGET	:= lib.a
-
-obj-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
+lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
 		   csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
 		   copy_page.o delay.o findbit.o memchr.o memcpy.o    \
 		   memset.o memzero.o setbit.o strncpy_from_user.o    \
@@ -14,17 +12,15 @@
 		   testclearbit.o testsetbit.o uaccess.o getuser.o    \
 		   putuser.o ashldi3.o ashrdi3.o lshrdi3.o muldi3.o   \
 		   ucmpdi2.o udivdi3.o lib1funcs.o div64.o
-obj-m		:=
-obj-n		:=
 
-obj-arc		:= ecard.o io-acorn.o floppydma.o
-obj-rpc		:= ecard.o io-acorn.o floppydma.o
-obj-clps7500	:= io-acorn.o
-obj-l7200     	:= io-acorn.o
-obj-shark	:= io-shark.o
-obj-edb7211	:= io-acorn.o
+lib-arc		:= ecard.o io-acorn.o floppydma.o
+lib-rpc		:= ecard.o io-acorn.o floppydma.o
+lib-clps7500	:= io-acorn.o
+lib-l7200     	:= io-acorn.o
+lib-shark	:= io-shark.o
+lib-edb7211	:= io-acorn.o
 
-obj-y		+= $(obj-$(MACHINE))
+lib-y		+= $(lib-$(MACHINE))
 
 ifeq ($(CONFIG_CPU_32v3),y)
   v3		:= y
@@ -34,10 +30,10 @@
   v4		:= y
 endif
 
-obj-y		+= io-readsb.o io-writesb.o
-obj-$(v3)	+= io-readsw-armv3.o io-writesw-armv3.o io-readsl-armv3.o
-obj-$(v4)	+= io-readsw-armv4.o io-writesw-armv4.o io-readsl-armv4.o
-obj-y		+= io-writesl.o
+lib-y		+= io-readsb.o io-writesb.o
+lib-$(v3)	+= io-readsw-armv3.o io-writesw-armv3.o io-readsl-armv3.o
+lib-$(v4)	+= io-readsw-armv4.o io-writesw-armv4.o io-readsl-armv4.o
+lib-y		+= io-writesl.o
 
 $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
===== arch/cris/lib/Makefile 1.5 vs edited =====
--- 1.5/arch/cris/lib/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/cris/lib/Makefile	Sun Jun  8 08:08:34 2003
@@ -2,8 +2,6 @@
 # Makefile for Etrax-specific library files..
 #
 
-L_TARGET = lib.a
-
 EXTRA_AFLAGS := -traditional
 
-obj-y  = checksum.o checksumcopy.o string.o usercopy.o memset.o csumcpfruser.o
+lib-y  = checksum.o checksumcopy.o string.o usercopy.o memset.o csumcpfruser.o
===== arch/h8300/lib/Makefile 1.1 vs edited =====
--- 1.1/arch/h8300/lib/Makefile	Thu Apr 17 21:30:45 2003
+++ edited/arch/h8300/lib/Makefile	Sun Jun  8 08:08:56 2003
@@ -5,5 +5,4 @@
 .S.o:
 	$(CC) $(AFLAGS) -D__ASSEMBLY__ -c $< -o $@
 
-L_TARGET = lib.a
-obj-y  = ashrdi3.o checksum.o memcpy.o memset.o abs.o
+lib-y  = ashrdi3.o checksum.o memcpy.o memset.o abs.o
===== arch/ia64/lib/Makefile 1.16 vs edited =====
--- 1.16/arch/ia64/lib/Makefile	Mon Feb  3 23:19:35 2003
+++ edited/arch/ia64/lib/Makefile	Sun Jun  8 08:09:45 2003
@@ -2,18 +2,16 @@
 # Makefile for ia64-specific library routines..
 #
 
-L_TARGET = lib.a
-
-obj-y := __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o			\
+lib-y := __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o			\
 	__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o			\
 	checksum.o clear_page.o csum_partial_copy.o copy_page.o		\
 	clear_user.o strncpy_from_user.o strlen_user.o strnlen_user.o	\
 	flush.o io.o ip_fast_csum.o do_csum.o				\
 	memset.o strlen.o swiotlb.o
 
-obj-$(CONFIG_ITANIUM)	+= copy_page.o copy_user.o memcpy.o
-obj-$(CONFIG_MCKINLEY)	+= copy_page_mck.o memcpy_mck.o
-obj-$(CONFIG_PERFMON)	+= carta_random.o
+lib-$(CONFIG_ITANIUM)	+= copy_page.o copy_user.o memcpy.o
+lib-$(CONFIG_MCKINLEY)	+= copy_page_mck.o memcpy_mck.o
+lib-$(CONFIG_PERFMON)	+= carta_random.o
 
 IGNORE_FLAGS_OBJS =	__divsi3.o __udivsi3.o __modsi3.o __umodsi3.o \
 			__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o
===== arch/m68k/lib/Makefile 1.4 vs edited =====
--- 1.4/arch/m68k/lib/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/m68k/lib/Makefile	Sun Jun  8 08:09:54 2003
@@ -2,9 +2,7 @@
 # Makefile for m68k-specific library files..
 #
 
-L_TARGET = lib.a
-
 EXTRA_AFLAGS := -traditional
 
-obj-y		:= ashldi3.o ashrdi3.o lshrdi3.o muldi3.o \
+lib-y		:= ashldi3.o ashrdi3.o lshrdi3.o muldi3.o \
 			checksum.o memcmp.o memcpy.o memset.o semaphore.o
===== arch/m68knommu/lib/Makefile 1.2 vs edited =====
--- 1.2/arch/m68knommu/lib/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/m68knommu/lib/Makefile	Sun Jun  8 08:10:04 2003
@@ -2,7 +2,6 @@
 # Makefile for m68knommu specific library files..
 #
 
-L_TARGET = lib.a
-obj-y	:= ashldi3.o ashrdi3.o lshrdi3.o \
+lib-y	:= ashldi3.o ashrdi3.o lshrdi3.o \
 	   muldi3.o mulsi3.o divsi3.o udivsi3.o modsi3.o umodsi3.o \
 	   checksum.o semaphore.o memcpy.o memset.o
===== arch/mips/arc/Makefile 1.4 vs edited =====
--- 1.4/arch/mips/arc/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/mips/arc/Makefile	Sun Jun  8 08:10:19 2003
@@ -3,9 +3,7 @@
 # under Linux.
 #
 
-L_TARGET = lib.a
-
-obj-y		+= console.o init.o memory.o tree.o env.o cmdline.o misc.o \
+lib-y		+= console.o init.o memory.o tree.o env.o cmdline.o misc.o \
 		   time.o file.o identify.o
 
-obj-$(CONFIG_ARC_CONSOLE)   += arc_con.o
+lib-$(CONFIG_ARC_CONSOLE)   += arc_con.o
===== arch/mips/baget/prom/Makefile 1.4 vs edited =====
--- 1.4/arch/mips/baget/prom/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/mips/baget/prom/Makefile	Sun Jun  8 08:10:35 2003
@@ -2,6 +2,4 @@
 # Makefile for the Baget/MIPS prom emulator library routines.
 #
 
-L_TARGET := lib.a
-
-obj-y	:= init.o
+lib-y	:= init.o
===== arch/mips/dec/prom/Makefile 1.6 vs edited =====
--- 1.6/arch/mips/dec/prom/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/mips/dec/prom/Makefile	Sun Jun  8 08:10:59 2003
@@ -3,9 +3,7 @@
 # under Linux.
 #
 
-L_TARGET := lib.a
-
-obj-y := init.o memory.o cmdline.o identify.o locore.o
+lib-y := init.o memory.o cmdline.o identify.o locore.o
 
 EXTRA_AFLAGS := $(CFLAGS)
 
===== arch/mips/lib/Makefile 1.6 vs edited =====
--- 1.6/arch/mips/lib/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/mips/lib/Makefile	Sun Jun  8 08:11:33 2003
@@ -2,21 +2,19 @@
 # Makefile for MIPS-specific library files..
 #
 
-L_TARGET = lib.a
-
 EXTRA_AFLAGS := $(CFLAGS)
 
-obj-y				+= csum_partial.o csum_partial_copy.o \
+lib-y				+= csum_partial.o csum_partial_copy.o \
 				   rtc-std.o rtc-no.o memcpy.o memset.o \
 				   watch.o strlen_user.o strncpy_user.o \
 				   strnlen_user.o
 
 ifdef CONFIG_CPU_R3000
-  obj-y	+= r3k_dump_tlb.o 
+  lib-y	+= r3k_dump_tlb.o 
 else
-  obj-y	+= dump_tlb.o 
+  lib-y	+= dump_tlb.o 
 endif
 
-obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
-obj-$(CONFIG_IDE)		+= ide-std.o ide-no.o
-obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
+lib-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
+lib-$(CONFIG_IDE)		+= ide-std.o ide-no.o
+lib-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
===== arch/mips64/arc/Makefile 1.5 vs edited =====
--- 1.5/arch/mips64/arc/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/mips64/arc/Makefile	Sun Jun  8 08:11:44 2003
@@ -2,9 +2,8 @@
 # Makefile for the ARC prom monitor library routines under Linux.
 #
 
-L_TARGET = lib.a
-obj-y	:= console.o init.o identify.o tree.o env.o cmdline.o misc.o time.o \
+lib-y	:= console.o init.o identify.o tree.o env.o cmdline.o misc.o time.o \
 	   file.o
 
-obj-$(CONFIG_ARC_MEMORY) += memory.o
-obj-$(CONFIG_ARC_CONSOLE) += arc_con.o
+lib-$(CONFIG_ARC_MEMORY) += memory.o
+lib-$(CONFIG_ARC_CONSOLE) += arc_con.o
===== arch/mips64/lib/Makefile 1.5 vs edited =====
--- 1.5/arch/mips64/lib/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/mips64/lib/Makefile	Sun Jun  8 08:11:54 2003
@@ -4,9 +4,7 @@
 
 EXTRA_AFLAGS := $(CFLAGS)
 
-L_TARGET = lib.a
-
-obj-y	+= csum_partial.o csum_partial_copy.o dump_tlb.o floppy-std.o \
+lib-y	+= csum_partial.o csum_partial_copy.o dump_tlb.o floppy-std.o \
 	  floppy-no.o ide-std.o ide-no.o kbd-std.o kbd-no.o rtc-std.o \
 	  rtc-no.o memset.o memcpy.o strlen_user.o strncpy_user.o \
 	  strnlen_user.o watch.o
===== arch/mips64/sgi-ip22/Makefile 1.6 vs edited =====
--- 1.6/arch/mips64/sgi-ip22/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/mips64/sgi-ip22/Makefile	Sun Jun  8 08:12:02 2003
@@ -5,7 +5,5 @@
 
 EXTRA_AFLAGS := $(CFLAGS)
 
-L_TARGET = lib.a
-
-obj-y	+= ip22-berr.o ip22-mc.o ip22-sc.o ip22-hpc.o ip22-int.o ip22-rtc.o \
+lib-y	+= ip22-berr.o ip22-mc.o ip22-sc.o ip22-hpc.o ip22-int.o ip22-rtc.o \
 	   ip22-setup.o system.o ip22-timer.o ip22-irq.o ip22-reset.o time.o
===== arch/parisc/lib/Makefile 1.6 vs edited =====
--- 1.6/arch/parisc/lib/Makefile	Sun Nov  3 16:08:06 2002
+++ edited/arch/parisc/lib/Makefile	Sun Jun  8 08:12:09 2003
@@ -2,5 +2,4 @@
 # Makefile for parisc-specific library files
 #
 
-L_TARGET := lib.a
-obj-y	:= lusercopy.o bitops.o checksum.o io.o memset.o
+lib-y	:= lusercopy.o bitops.o checksum.o io.o memset.o
===== arch/ppc/boot/common/Makefile 1.6 vs edited =====
--- 1.6/arch/ppc/boot/common/Makefile	Thu Jun  5 05:07:10 2003
+++ edited/arch/ppc/boot/common/Makefile	Sun Jun  8 08:12:26 2003
@@ -8,10 +8,8 @@
 # Tom Rini	January 2001
 #
 
-L_TARGET				:= lib.a
-
-obj-y					:= string.o util.o misc-common.o
-obj-$(CONFIG_PPC_PREP)			+= mpc10x_memory.o
-obj-$(CONFIG_LOPEC)			+= mpc10x_memory.o
-obj-$(CONFIG_PAL4)			+= cpc700_memory.o
-obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= ns16550.o
+lib-y					:= string.o util.o misc-common.o
+lib-$(CONFIG_PPC_PREP)			+= mpc10x_memory.o
+lib-$(CONFIG_LOPEC)			+= mpc10x_memory.o
+lib-$(CONFIG_PAL4)			+= cpc700_memory.o
+lib-$(CONFIG_SERIAL_8250_CONSOLE)	+= ns16550.o
===== arch/ppc/boot/lib/Makefile 1.4 vs edited =====
--- 1.4/arch/ppc/boot/lib/Makefile	Wed Nov 20 12:10:01 2002
+++ edited/arch/ppc/boot/lib/Makefile	Sun Jun  8 08:12:35 2003
@@ -2,6 +2,4 @@
 # Makefile for some libs needed by zImage.
 #
 
-L_TARGET := lib.a
-
-obj-y := zlib.o div64.o
+lib-y := zlib.o div64.o
===== arch/ppc/boot/of1275/Makefile 1.3 vs edited =====
--- 1.3/arch/ppc/boot/of1275/Makefile	Wed Nov 20 12:10:01 2002
+++ edited/arch/ppc/boot/of1275/Makefile	Sun Jun  8 08:12:49 2003
@@ -2,7 +2,5 @@
 # Makefile of1275 stuff
 #
 
-L_TARGET := lib.a
-
-obj-y := claim.o enter.o exit.o finddevice.o getprop.o ofinit.o	\
+lib-y := claim.o enter.o exit.o finddevice.o getprop.o ofinit.o	\
 	 ofstdio.o read.o release.o write.o
===== arch/ppc64/lib/Makefile 1.8 vs edited =====
--- 1.8/arch/ppc64/lib/Makefile	Mon Feb  3 23:19:36 2003
+++ edited/arch/ppc64/lib/Makefile	Sun Jun  8 08:13:00 2003
@@ -2,7 +2,5 @@
 # Makefile for ppc64-specific library files..
 #
 
-L_TARGET = lib.a
-
-obj-y := checksum.o dec_and_lock.o string.o strcase.o
-obj-y += copypage.o memcpy.o copyuser.o
+lib-y := checksum.o dec_and_lock.o string.o strcase.o
+lib-y += copypage.o memcpy.o copyuser.o
===== arch/s390/lib/Makefile 1.9 vs edited =====
--- 1.9/arch/s390/lib/Makefile	Mon Apr 14 21:11:57 2003
+++ edited/arch/s390/lib/Makefile	Sun Jun  8 08:13:19 2003
@@ -2,10 +2,8 @@
 # Makefile for s390-specific library files..
 #
 
-L_TARGET = lib.a
-
 EXTRA_AFLAGS := -traditional
 
-obj-y += delay.o 
-obj-$(CONFIG_ARCH_S390_31) += memset.o strcmp.o strncpy.o uaccess.o
-obj-$(CONFIG_ARCH_S390X) += memset64.o strcmp64.o strncpy64.o uaccess64.o
+lib-y += delay.o 
+lib-$(CONFIG_ARCH_S390_31) += memset.o strcmp.o strncpy.o uaccess.o
+lib-$(CONFIG_ARCH_S390X) += memset64.o strcmp64.o strncpy64.o uaccess64.o
===== arch/sh/lib/Makefile 1.6 vs edited =====
--- 1.6/arch/sh/lib/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/sh/lib/Makefile	Sun Jun  8 08:13:29 2003
@@ -2,6 +2,5 @@
 # Makefile for SuperH-specific library files..
 #
 
-L_TARGET = lib.a
-obj-y  = delay.o memcpy.o memset.o memmove.o memchr.o \
+lib-y  = delay.o memcpy.o memset.o memmove.o memchr.o \
 	 checksum.o strcasecmp.o strlen.o
===== arch/sparc/lib/Makefile 1.5 vs edited =====
--- 1.5/arch/sparc/lib/Makefile	Wed Apr 30 10:05:52 2003
+++ edited/arch/sparc/lib/Makefile	Sun Jun  8 08:13:37 2003
@@ -2,11 +2,9 @@
 # Makefile for Sparc library files..
 #
 
-L_TARGET = lib.a
-
 EXTRA_AFLAGS := -ansi -DST_DIV0=0x02
 
-obj-y := mul.o rem.o sdiv.o udiv.o umul.o urem.o ashrdi3.o memcpy.o memset.o \
+lib-y := mul.o rem.o sdiv.o udiv.o umul.o urem.o ashrdi3.o memcpy.o memset.o \
          strlen.o checksum.o blockops.o memscan.o memcmp.o strncmp.o \
 	 strncpy_from_user.o divdi3.o udivdi3.o strlen_user.o \
 	 copy_user.o locks.o atomic.o bitops.o debuglocks.o lshrdi3.o \
===== arch/sparc/prom/Makefile 1.3 vs edited =====
--- 1.3/arch/sparc/prom/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/sparc/prom/Makefile	Sun Jun  8 08:13:52 2003
@@ -3,9 +3,7 @@
 # Linux.
 #
 
-L_TARGET = lib.a
-
-obj-y := bootstr.o devmap.o devops.o init.o memory.o misc.o mp.o \
+lib-y := bootstr.o devmap.o devops.o init.o memory.o misc.o mp.o \
 	 palloc.o ranges.o segment.o console.o printf.o tree.o
 
-obj-$(CONFIG_SUN4) += sun4prom.o
+lib-$(CONFIG_SUN4) += sun4prom.o
===== arch/sparc64/lib/Makefile 1.10 vs edited =====
--- 1.10/arch/sparc64/lib/Makefile	Tue Mar 25 16:03:45 2003
+++ edited/arch/sparc64/lib/Makefile	Sun Jun  8 08:14:00 2003
@@ -5,8 +5,7 @@
 EXTRA_AFLAGS := -ansi
 EXTRA_CFLAGS := -Werror
 
-L_TARGET = lib.a
-obj-y := PeeCeeI.o blockops.o debuglocks.o strlen.o strncmp.o \
+lib-y := PeeCeeI.o blockops.o debuglocks.o strlen.o strncmp.o \
 	 memscan.o strncpy_from_user.o strlen_user.o memcmp.o checksum.o \
 	 VIScopy.o VISbzero.o VISmemset.o VIScsum.o VIScsumcopy.o \
 	 VIScsumcopyusr.o VISsave.o atomic.o rwlock.o bitops.o \
===== arch/sparc64/prom/Makefile 1.10 vs edited =====
--- 1.10/arch/sparc64/prom/Makefile	Mon Mar  3 09:49:24 2003
+++ edited/arch/sparc64/prom/Makefile	Sun Jun  8 08:14:12 2003
@@ -6,6 +6,5 @@
 EXTRA_AFLAGS := -ansi
 EXTRA_CFLAGS := -Werror
 
-L_TARGET = lib.a
-obj-y   := bootstr.o devops.o init.o memory.o misc.o \
+lib-y   := bootstr.o devops.o init.o memory.o misc.o \
 	   tree.o console.o printf.o p1275.o map.o
===== arch/v850/lib/Makefile 1.2 vs edited =====
--- 1.2/arch/v850/lib/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/v850/lib/Makefile	Sun Jun  8 08:14:19 2003
@@ -2,6 +2,5 @@
 # arch/v850/lib/Makefile
 #
 
-L_TARGET = lib.a
-obj-y  = ashrdi3.o ashldi3.o lshrdi3.o muldi3.o negdi2.o \
+lib-y  = ashrdi3.o ashldi3.o lshrdi3.o muldi3.o negdi2.o \
 	 checksum.o memcpy.o memset.o
===== arch/x86_64/lib/Makefile 1.10 vs edited =====
--- 1.10/arch/x86_64/lib/Makefile	Mon Feb  3 23:19:36 2003
+++ edited/arch/x86_64/lib/Makefile	Sun Jun  8 08:14:43 2003
@@ -2,13 +2,12 @@
 # Makefile for x86_64-specific library files.
 #
 
-L_TARGET := lib.a
 CFLAGS_csum-partial.o := -funroll-loops
 
-obj-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
+lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
 	thunk.o io.o clear_page.o copy_page.o bitstr.o
-obj-y += memcpy.o memmove.o memset.o copy_user.o
+lib-y += memcpy.o memmove.o memset.o copy_user.o
 
-obj-$(CONFIG_IO_DEBUG) += iodebug.o
-obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
+lib-$(CONFIG_IO_DEBUG) += iodebug.o
+lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
