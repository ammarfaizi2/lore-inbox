Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275380AbTHITet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275385AbTHITet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:34:49 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:23292 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S275380AbTHITer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:34:47 -0400
Date: Sat, 9 Aug 2003 21:34:45 +0200 (MEST)
Message-Id: <200308091934.h79JYjMP022060@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH] fix 2.4.22-rc2 x86-64 compile failure
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_SYMBOL(mmu_cr4_features) was added recently to
arch/x86-64/kernel/setup.c but arch/x86-64/kernel/Makefile
wasn't simultaneously updated to list setup.o in export-objs.
This causes a CONFIG_MODULES=y build to fail with:

x86_64-unknown-linux-gcc -D__KERNEL__ -I/tmp/linux-2.4.22-rc2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -mno-red-zone -mcmodel=kernel -pipe -fno-reorder-blocks -finline-limit=2000 -fno-strength-reduce -Wno-sign-compare -fno-asynchronous-unwind-tables   -nostdinc -iwithprefix include -DKBUILD_BASENAME=setup  -c -o setup.o setup.c
setup.c:62: syntax error before "this_object_must_be_defined_as_export_objs_in_the_Makefile"
setup.c:62: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'
setup.c:62: warning: data definition has no type or storage class
make[1]: *** [setup.o] Error 1
make[1]: Leaving directory `/tmp/linux-2.4.22-rc2/arch/x86_64/kernel'
make: *** [_dir_arch/x86_64/kernel] Error 2

Fixed by the trivial patch below.

/Mikael

--- linux-2.4.22-rc2/arch/x86_64/kernel/Makefile.~1~	2003-08-09 20:15:54.000000000 +0200
+++ linux-2.4.22-rc2/arch/x86_64/kernel/Makefile	2003-08-09 20:26:17.000000000 +0200
@@ -15,7 +15,7 @@
 O_TARGET := kernel.o
 
 
-export-objs     := mtrr.o msr.o cpuid.o x8664_ksyms.o pci-gart.o
+export-objs     := mtrr.o msr.o cpuid.o x8664_ksyms.o pci-gart.o setup.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
