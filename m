Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293546AbSCGHeR>; Thu, 7 Mar 2002 02:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293541AbSCGHeH>; Thu, 7 Mar 2002 02:34:07 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:43781 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293543AbSCGHdw>; Thu, 7 Mar 2002 02:33:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL III: 2.5.6-pre3. time.c fix.
Date: Thu, 07 Mar 2002 18:37:10 +1100
Message-Id: <E16isSd-0006al-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

As of 2.5.6-pre2, arch/i386/kernel/time.c has an
EXPORT_SYMBOL(i8253_lock).  Amazingly, this compiles without
the EXPORT_SYMBOL definition (with various warnings).

Thanks,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/arch/i386/kernel/time.c trivial-2.5.6-pre3/arch/i386/kernel/time.c
--- linux-2.5.6-pre3/arch/i386/kernel/time.c	Thu Mar  7 15:13:38 2002
+++ trivial-2.5.6-pre3/arch/i386/kernel/time.c	Thu Mar  7 18:20:33 2002
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/arch/i386/kernel/Makefile trivial-2.5.6-pre3/arch/i386/kernel/Makefile
--- linux-2.5.6-pre3/arch/i386/kernel/Makefile	Wed Feb 20 17:55:22 2002
+++ trivial-2.5.6-pre3/arch/i386/kernel/Makefile	Thu Mar  7 18:20:33 2002
@@ -14,7 +14,7 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
