Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269023AbUHMIN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269023AbUHMIN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 04:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUHMIN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 04:13:27 -0400
Received: from imap.gmx.net ([213.165.64.20]:58544 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269023AbUHMIL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 04:11:57 -0400
X-Authenticated: #12437197
Date: Fri, 13 Aug 2004 11:12:16 +0300
From: Dan Aloni <da-x@colinux.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Benno <benjl@cse.unsw.edu.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Generation of *.s files from *.S files in kbuild
Message-ID: <20040813081216.GB7639@callisto.yi.org>
References: <20040812192535.GA20953@callisto.yi.org> <20040813003743.GF30576@cse.unsw.edu.au> <20040813050424.GA7417@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813050424.GA7417@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 07:04:24AM +0200, Sam Ravnborg wrote:
> On Fri, Aug 13, 2004 at 10:37:43AM +1000, Benno wrote:
> > 
> > The solution is fairly striaght forward -- just change the suffixes,
> > the problem is exactly how to change them. I would propose changing it
> > such that was stick with "vmlinux.lds.S" and have it generate "vmlinux.lds"
> > 
> > This would require the fewest changes to implement, just
> > 1/ change %.s %.S rule to %.lds %.lds.S
> > 2/ change the link flags from "-T vmlinux.lds.s" -> "-T vmlinux.lds"
> 
> I agree with this approach, and see no defencies.
> 
> Care to send two patches.
> One that do what you suggest for i386, and another that cover the rest
> of the architectures?

.. and the second patch:

Signed-off-by: Dan Aloni <da-x@colinux.org>

diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/alpha/kernel/Makefile linux-2.6.7-work/arch/alpha/kernel/Makefile
--- linux-2.6.7/arch/alpha/kernel/Makefile	2004-06-16 08:19:22.000000000 +0300
+++ linux-2.6.7-work/arch/alpha/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= head.o vmlinux.lds.s
+extra-y		:= head.o vmlinux.lds
 EXTRA_AFLAGS	:= $(CFLAGS)
 EXTRA_CFLAGS	:= -Werror -Wno-sign-compare
 
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/arm/kernel/Makefile linux-2.6.7-work/arch/arm/kernel/Makefile
--- linux-2.6.7/arch/arm/kernel/Makefile	2004-06-16 08:20:03.000000000 +0300
+++ linux-2.6.7-work/arch/arm/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -27,7 +27,7 @@
 head-y			:= head.o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
-extra-y := $(head-y) init_task.o vmlinux.lds.s
+extra-y := $(head-y) init_task.o vmlinux.lds
 
 # Spell out some dependencies that aren't automatically figured out
 $(obj)/entry-armv.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/arm26/kernel/Makefile linux-2.6.7-work/arch/arm26/kernel/Makefile
--- linux-2.6.7/arch/arm26/kernel/Makefile	2004-06-16 08:19:22.000000000 +0300
+++ linux-2.6.7-work/arch/arm26/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -14,5 +14,5 @@
 obj-$(CONFIG_FIQ)		+= fiq.o
 obj-$(CONFIG_MODULES)		+= armksyms.o
 
-extra-y := init_task.o vmlinux.lds.s
+extra-y := init_task.o vmlinux.lds
 
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/cris/kernel/Makefile linux-2.6.7-work/arch/cris/kernel/Makefile
--- linux-2.6.7/arch/cris/kernel/Makefile	2004-06-16 08:19:36.000000000 +0300
+++ linux-2.6.7-work/arch/cris/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -3,7 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= vmlinux.lds.s
+extra-y	:= vmlinux.lds
 
 obj-y   := process.o traps.o irq.o ptrace.o setup.o \
 	   time.o sys_cris.o semaphore.o
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/h8300/kernel/Makefile linux-2.6.7-work/arch/h8300/kernel/Makefile
--- linux-2.6.7/arch/h8300/kernel/Makefile	2004-06-16 08:19:36.000000000 +0300
+++ linux-2.6.7-work/arch/h8300/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds
 
 obj-y := process.o traps.o ptrace.o ints.o \
 	 sys_h8300.o time.o semaphore.o signal.o \
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/ia64/kernel/Makefile linux-2.6.7-work/arch/ia64/kernel/Makefile
--- linux-2.6.7/arch/ia64/kernel/Makefile	2004-06-16 08:20:26.000000000 +0300
+++ linux-2.6.7-work/arch/ia64/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= head.o init_task.o vmlinux.lds.s
+extra-y	:= head.o init_task.o vmlinux.lds
 
 obj-y := acpi.o entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o machvec.o pal.o patch.o process.o perfmon.o ptrace.o sal.o		\
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/m68k/kernel/Makefile linux-2.6.7-work/arch/m68k/kernel/Makefile
--- linux-2.6.7/arch/m68k/kernel/Makefile	2004-06-16 08:19:44.000000000 +0300
+++ linux-2.6.7-work/arch/m68k/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -7,7 +7,7 @@
 else
   extra-y := sun3-head.o
 endif
-extra-y	+= vmlinux.lds.s
+extra-y	+= vmlinux.lds
 
 obj-y		:= entry.o process.o traps.o ints.o signal.o ptrace.o \
 			sys_m68k.o time.o semaphore.o setup.o m68k_ksyms.o
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/m68knommu/kernel/Makefile linux-2.6.7-work/arch/m68knommu/kernel/Makefile
--- linux-2.6.7/arch/m68knommu/kernel/Makefile	2004-06-16 08:19:03.000000000 +0300
+++ linux-2.6.7-work/arch/m68knommu/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for arch/m68knommu/kernel.
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds
 
 obj-y += dma.o entry.o init_task.o m68k_ksyms.o process.o ptrace.o semaphore.o \
 	 setup.o signal.o syscalltable.o sys_m68k.o time.o traps.o
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/mips/kernel/Makefile linux-2.6.7-work/arch/mips/kernel/Makefile
--- linux-2.6.7/arch/mips/kernel/Makefile	2004-06-16 08:19:22.000000000 +0300
+++ linux-2.6.7-work/arch/mips/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the Linux/MIPS kernel.
 #
 
-extra-y		:= head.o init_task.o vmlinux.lds.s
+extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/parisc/kernel/Makefile linux-2.6.7-work/arch/parisc/kernel/Makefile
--- linux-2.6.7/arch/parisc/kernel/Makefile	2004-06-16 08:19:09.000000000 +0300
+++ linux-2.6.7-work/arch/parisc/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -4,7 +4,7 @@
 
 head-y			:= head.o
 head-$(CONFIG_PARISC64)	:= head64.o
-extra-y			:= init_task.o $(head-y) vmlinux.lds.s
+extra-y			:= init_task.o $(head-y) vmlinux.lds
 
 AFLAGS_entry.o	:= -traditional
 AFLAGS_pacache.o := -traditional
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/ppc/kernel/Makefile linux-2.6.7-work/arch/ppc/kernel/Makefile
--- linux-2.6.7/arch/ppc/kernel/Makefile	2004-06-16 08:19:53.000000000 +0300
+++ linux-2.6.7-work/arch/ppc/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -15,7 +15,7 @@
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-$(CONFIG_6xx)		+= idle_6xx.o
 extra-$(CONFIG_POWER4)		+= idle_power4.o
-extra-y				+= vmlinux.lds.s
+extra-y				+= vmlinux.lds
 
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/ppc64/kernel/Makefile linux-2.6.7-work/arch/ppc64/kernel/Makefile
--- linux-2.6.7/arch/ppc64/kernel/Makefile	2004-06-16 08:20:19.000000000 +0300
+++ linux-2.6.7-work/arch/ppc64/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -3,7 +3,7 @@
 #
 
 EXTRA_CFLAGS	+= -mno-minimal-toc
-extra-y		:= head.o vmlinux.lds.s
+extra-y		:= head.o vmlinux.lds
 
 obj-y               :=	setup.o entry.o traps.o irq.o idle.o dma.o \
 			time.o process.o signal.o syscalls.o misc.o ptrace.o \
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/s390/kernel/Makefile linux-2.6.7-work/arch/s390/kernel/Makefile
--- linux-2.6.7/arch/s390/kernel/Makefile	2004-06-16 08:20:04.000000000 +0300
+++ linux-2.6.7-work/arch/s390/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -10,7 +10,7 @@
 
 extra-$(CONFIG_ARCH_S390_31)	+= head.o 
 extra-$(CONFIG_ARCH_S390X)	+= head64.o 
-extra-y				+= init_task.o vmlinux.lds.s
+extra-y				+= init_task.o vmlinux.lds
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/sh/boot/compressed/Makefile linux-2.6.7-work/arch/sh/boot/compressed/Makefile
--- linux-2.6.7/arch/sh/boot/compressed/Makefile	2004-06-16 08:19:26.000000000 +0300
+++ linux-2.6.7-work/arch/sh/boot/compressed/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -18,7 +18,7 @@
 #
 IMAGE_OFFSET := $(shell printf "0x%8x" $$[0x80000000+$(CONFIG_MEMORY_START)+$(CONFIG_BOOT_LINK_OFFSET)])
 
-LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T $(obj)/../../kernel/vmlinux.lds.s
+LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T $(obj)/../../kernel/vmlinux.lds
 
 $(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/sh/kernel/Makefile linux-2.6.7-work/arch/sh/kernel/Makefile
--- linux-2.6.7/arch/sh/kernel/Makefile	2004-06-16 08:19:36.000000000 +0300
+++ linux-2.6.7-work/arch/sh/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the Linux/SuperH kernel.
 #
 
-extra-y	:= head.o init_task.o vmlinux.lds.s
+extra-y	:= head.o init_task.o vmlinux.lds
 
 obj-y	:= process.o signal.o entry.o traps.o irq.o \
 	ptrace.o setup.o time.o sys_sh.o semaphore.o \
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/sparc/boot/Makefile linux-2.6.7-work/arch/sparc/boot/Makefile
--- linux-2.6.7/arch/sparc/boot/Makefile	2004-06-16 08:20:03.000000000 +0300
+++ linux-2.6.7-work/arch/sparc/boot/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -19,7 +19,7 @@
 
 BTOBJS := $(HEAD_Y) $(INIT_Y)
 BTLIBS := $(CORE_Y) $(LIBS_Y) $(DRIVERS_Y) $(NET_Y)
-LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds.s $(BTOBJS) --start-group $(BTLIBS) --end-group $(kallsyms.o)
+LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds $(BTOBJS) --start-group $(BTLIBS) --end-group $(kallsyms.o)
 
 # Actual linking
 $(obj)/image: $(obj)/btfix.o FORCE
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/sparc/kernel/Makefile linux-2.6.7-work/arch/sparc/kernel/Makefile
--- linux-2.6.7/arch/sparc/kernel/Makefile	2004-06-16 08:19:52.000000000 +0300
+++ linux-2.6.7-work/arch/sparc/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= head.o init_task.o vmlinux.lds.s
+extra-y		:= head.o init_task.o vmlinux.lds
 
 EXTRA_AFLAGS	:= -ansi
 
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/sparc64/kernel/Makefile linux-2.6.7-work/arch/sparc64/kernel/Makefile
--- linux-2.6.7/arch/sparc64/kernel/Makefile	2004-06-16 08:19:01.000000000 +0300
+++ linux-2.6.7-work/arch/sparc64/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -5,7 +5,7 @@
 EXTRA_AFLAGS := -ansi
 EXTRA_CFLAGS := -Werror
 
-extra-y		:= head.o init_task.o vmlinux.lds.s
+extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		:= process.o setup.o cpu.o idprom.o \
 		   traps.o devices.o auxio.o \
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/um/kernel/Makefile linux-2.6.7-work/arch/um/kernel/Makefile
--- linux-2.6.7/arch/um/kernel/Makefile	2004-06-16 08:19:42.000000000 +0300
+++ linux-2.6.7-work/arch/um/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o mem.o mem_user.o \
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/v850/kernel/Makefile linux-2.6.7-work/arch/v850/kernel/Makefile
--- linux-2.6.7/arch/v850/kernel/Makefile	2004-06-16 08:20:26.000000000 +0300
+++ linux-2.6.7-work/arch/v850/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -9,7 +9,7 @@
 # for more details.
 #
 
-extra-y := head.o init_task.o vmlinux.lds.s
+extra-y := head.o init_task.o vmlinux.lds
 
 obj-y += intv.o entry.o process.o syscalls.o time.o semaphore.o setup.o \
 	 signal.o irq.o mach.o ptrace.o bug.o
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/x86_64/kernel/Makefile linux-2.6.7-work/arch/x86_64/kernel/Makefile
--- linux-2.6.7/arch/x86_64/kernel/Makefile	2004-06-16 08:19:43.000000000 +0300
+++ linux-2.6.7-work/arch/x86_64/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y 	:= head.o head64.o init_task.o vmlinux.lds.s
+extra-y 	:= head.o head64.o init_task.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/x86_64/kernel/Makefile-HEAD linux-2.6.7-work/arch/x86_64/kernel/Makefile-HEAD
--- linux-2.6.7/arch/x86_64/kernel/Makefile-HEAD	2004-06-16 08:19:52.000000000 +0300
+++ linux-2.6.7-work/arch/x86_64/kernel/Makefile-HEAD	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y 	:= head.o head64.o init_task.o vmlinux.lds.s
+extra-y 	:= head.o head64.o init_task.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \


-- 
Dan Aloni
da-x@colinux.org
