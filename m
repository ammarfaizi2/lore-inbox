Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUHNTwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUHNTwV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUHNTwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:52:01 -0400
Received: from pop.gmx.net ([213.165.64.20]:17551 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265127AbUHNTtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:49:14 -0400
X-Authenticated: #12437197
Date: Sat, 14 Aug 2004 22:49:28 +0300
From: Dan Aloni <da-x@colinux.org>
To: Sam Ravnborg <sam@ravnborg.org>, Benno <benjl@cse.unsw.edu.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [#3 2/2] Generate vmlinux.lds instead of vmlinux.lds.s
Message-ID: <20040814194928.GB20753@callisto.yi.org>
References: <20040812192535.GA20953@callisto.yi.org> <20040813003743.GF30576@cse.unsw.edu.au> <20040813050424.GA7417@mars.ravnborg.org> <20040813080941.GA7639@callisto.yi.org> <20040813092426.GA27895@callisto.yi.org> <20040813183347.GA9098@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813183347.GA9098@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

This is for the other architectures. I haven't test-compiled it, though.

diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/alpha/kernel/Makefile linux-2.6.8.1-callisto-work/arch/alpha/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/alpha/kernel/Makefile	2004-06-16 08:19:22.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/alpha/kernel/Makefile	2004-08-14 21:15:28.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= head.o vmlinux.lds.s
+extra-y		:= head.o vmlinux.lds
 EXTRA_AFLAGS	:= $(CFLAGS)
 EXTRA_CFLAGS	:= -Werror -Wno-sign-compare
 
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/arm/Makefile linux-2.6.8.1-callisto-work/arch/arm/Makefile
--- linux-2.6.8.1-callisto/arch/arm/Makefile	2004-08-14 18:00:03.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/arm/Makefile	2004-08-14 21:23:58.000000000 +0300
@@ -9,7 +9,7 @@
 
 LDFLAGS_vmlinux	:=-p --no-undefined -X
 LDFLAGS_BLOB	:=--format binary
-AFLAGS_vmlinux.lds.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
+PPFLAGS_vmlinux.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
 OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
 #CFLAGS		+=-pipe
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/arm/kernel/Makefile linux-2.6.8.1-callisto-work/arch/arm/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/arm/kernel/Makefile	2004-08-14 18:00:04.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/arm/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -26,7 +26,7 @@
 head-y			:= head.o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
-extra-y := $(head-y) init_task.o vmlinux.lds.s
+extra-y := $(head-y) init_task.o vmlinux.lds
 
 # Spell out some dependencies that aren't automatically figured out
 $(obj)/entry-armv.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/arm26/Makefile linux-2.6.8.1-callisto-work/arch/arm26/Makefile
--- linux-2.6.8.1-callisto/arch/arm26/Makefile	2004-06-16 08:19:22.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/arm26/Makefile	2004-08-14 21:23:34.000000000 +0300
@@ -9,7 +9,7 @@
 
 LDFLAGS_vmlinux	:=-p -X
 LDFLAGS_BLOB	:=--format binary
-AFLAGS_vmlinux.lds.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
+PPFLAGS_vmlinux.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
 OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
 
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/arm26/kernel/Makefile linux-2.6.8.1-callisto-work/arch/arm26/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/arm26/kernel/Makefile	2004-06-16 08:19:22.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/arm26/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -14,5 +14,5 @@
 obj-$(CONFIG_FIQ)		+= fiq.o
 obj-$(CONFIG_MODULES)		+= armksyms.o
 
-extra-y := init_task.o vmlinux.lds.s
+extra-y := init_task.o vmlinux.lds
 
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/cris/Makefile linux-2.6.8.1-callisto-work/arch/cris/Makefile
--- linux-2.6.8.1-callisto/arch/cris/Makefile	2004-06-16 08:19:22.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/cris/Makefile	2004-08-14 21:22:49.000000000 +0300
@@ -29,7 +29,7 @@
 
 OBJCOPYFLAGS := -O binary -R .note -R .comment -S
 
-AFLAGS_vmlinux.lds.o = -DDRAM_VIRTUAL_BASE=0x$(CONFIG_ETRAX_DRAM_VIRTUAL_BASE)
+PPFLAGS_vmlinux.o = -DDRAM_VIRTUAL_BASE=0x$(CONFIG_ETRAX_DRAM_VIRTUAL_BASE)
 AFLAGS += -mlinux
 
 CFLAGS := $(CFLAGS) -mlinux -march=$(arch-y) -pipe
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/cris/kernel/Makefile linux-2.6.8.1-callisto-work/arch/cris/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/cris/kernel/Makefile	2004-06-16 08:19:36.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/cris/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -3,7 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= vmlinux.lds.s
+extra-y	:= vmlinux.lds
 
 obj-y   := process.o traps.o irq.o ptrace.o setup.o \
 	   time.o sys_cris.o semaphore.o
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/h8300/kernel/Makefile linux-2.6.8.1-callisto-work/arch/h8300/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/h8300/kernel/Makefile	2004-06-16 08:19:36.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/h8300/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds
 
 obj-y := process.o traps.o ptrace.o ints.o \
 	 sys_h8300.o time.o semaphore.o signal.o \
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/ia64/kernel/Makefile linux-2.6.8.1-callisto-work/arch/ia64/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/ia64/kernel/Makefile	2004-06-16 08:20:26.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/ia64/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= head.o init_task.o vmlinux.lds.s
+extra-y	:= head.o init_task.o vmlinux.lds
 
 obj-y := acpi.o entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o machvec.o pal.o patch.o process.o perfmon.o ptrace.o sal.o		\
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/m68k/kernel/Makefile linux-2.6.8.1-callisto-work/arch/m68k/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/m68k/kernel/Makefile	2004-06-16 08:19:44.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/m68k/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -7,7 +7,7 @@
 else
   extra-y := sun3-head.o
 endif
-extra-y	+= vmlinux.lds.s
+extra-y	+= vmlinux.lds
 
 obj-y		:= entry.o process.o traps.o ints.o signal.o ptrace.o \
 			sys_m68k.o time.o semaphore.o setup.o m68k_ksyms.o
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/m68knommu/kernel/Makefile linux-2.6.8.1-callisto-work/arch/m68knommu/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/m68knommu/kernel/Makefile	2004-06-16 08:19:03.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/m68knommu/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for arch/m68knommu/kernel.
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds
 
 obj-y += dma.o entry.o init_task.o m68k_ksyms.o process.o ptrace.o semaphore.o \
 	 setup.o signal.o syscalltable.o sys_m68k.o time.o traps.o
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/mips/Makefile linux-2.6.8.1-callisto-work/arch/mips/Makefile
--- linux-2.6.8.1-callisto/arch/mips/Makefile	2004-08-14 18:00:05.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/mips/Makefile	2004-08-14 21:21:01.000000000 +0300
@@ -643,7 +643,7 @@
 # none has been choosen above.
 #
 
-AFLAGS_vmlinux.lds.o := \
+PPFLAGS_vmlinux.o := \
 	-D"LOADADDR=$(load-y)" \
 	-D"JIFFIES=$(JIFFIES)" \
 	-imacros $(srctree)/include/asm-$(ARCH)/sn/mapped_kernel.h
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/mips/kernel/Makefile linux-2.6.8.1-callisto-work/arch/mips/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/mips/kernel/Makefile	2004-08-14 18:00:05.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/mips/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the Linux/MIPS kernel.
 #
 
-extra-y		:= head.o init_task.o vmlinux.lds.s
+extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/parisc/kernel/Makefile linux-2.6.8.1-callisto-work/arch/parisc/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/parisc/kernel/Makefile	2004-06-16 08:19:09.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/parisc/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -4,7 +4,7 @@
 
 head-y			:= head.o
 head-$(CONFIG_PARISC64)	:= head64.o
-extra-y			:= init_task.o $(head-y) vmlinux.lds.s
+extra-y			:= init_task.o $(head-y) vmlinux.lds
 
 AFLAGS_entry.o	:= -traditional
 AFLAGS_pacache.o := -traditional
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/ppc/Makefile linux-2.6.8.1-callisto-work/arch/ppc/Makefile
--- linux-2.6.8.1-callisto/arch/ppc/Makefile	2004-08-14 18:00:05.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/ppc/Makefile	2004-08-14 21:20:56.000000000 +0300
@@ -70,7 +70,7 @@
 
 all: zImage
 
-AFLAGS_vmlinux.lds.o	:= -Upowerpc
+PPFLAGS_vmlinux.o	:= -Upowerpc
 
 # All the instructions talk about "make bzImage".
 bzImage: zImage
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/ppc/kernel/Makefile linux-2.6.8.1-callisto-work/arch/ppc/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/ppc/kernel/Makefile	2004-08-14 18:00:06.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/ppc/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -9,7 +9,7 @@
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-$(CONFIG_6xx)		+= idle_6xx.o
 extra-$(CONFIG_POWER4)		+= idle_power4.o
-extra-y				+= vmlinux.lds.s
+extra-y				+= vmlinux.lds
 
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/ppc64/kernel/Makefile linux-2.6.8.1-callisto-work/arch/ppc64/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/ppc64/kernel/Makefile	2004-08-14 18:00:06.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/ppc64/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -3,7 +3,7 @@
 #
 
 EXTRA_CFLAGS	+= -mno-minimal-toc
-extra-y		:= head.o vmlinux.lds.s
+extra-y		:= head.o vmlinux.lds
 
 obj-y               :=	setup.o entry.o traps.o irq.o idle.o dma.o \
 			time.o process.o signal.o syscalls.o misc.o ptrace.o \
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/s390/kernel/Makefile linux-2.6.8.1-callisto-work/arch/s390/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/s390/kernel/Makefile	2004-08-14 18:00:06.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/s390/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -10,7 +10,7 @@
 
 extra-$(CONFIG_ARCH_S390_31)	+= head.o 
 extra-$(CONFIG_ARCH_S390X)	+= head64.o 
-extra-y				+= init_task.o vmlinux.lds.s
+extra-y				+= init_task.o vmlinux.lds
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/sh/Makefile linux-2.6.8.1-callisto-work/arch/sh/Makefile
--- linux-2.6.8.1-callisto/arch/sh/Makefile	2004-08-14 18:00:06.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/sh/Makefile	2004-08-14 21:21:32.000000000 +0300
@@ -122,7 +122,7 @@
 
 boot := arch/sh/boot
 
-AFLAGS_vmlinux.lds.o := -traditional
+PPFLAGS_vmlinux.o := -traditional
 
 prepare: target_links
 
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/sh/boot/compressed/Makefile linux-2.6.8.1-callisto-work/arch/sh/boot/compressed/Makefile
--- linux-2.6.8.1-callisto/arch/sh/boot/compressed/Makefile	2004-08-14 18:00:06.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/sh/boot/compressed/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -22,7 +22,7 @@
 CONFIG_BOOT_LINK_OFFSET ?= 0x00800000
 IMAGE_OFFSET := $(shell printf "0x%8x" $$[0x80000000+$(CONFIG_MEMORY_START)+$(CONFIG_BOOT_LINK_OFFSET)])
 
-LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T $(obj)/../../kernel/vmlinux.lds.s
+LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T $(obj)/../../kernel/vmlinux.lds
 
 $(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/sh/kernel/Makefile linux-2.6.8.1-callisto-work/arch/sh/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/sh/kernel/Makefile	2004-08-14 18:00:06.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/sh/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the Linux/SuperH kernel.
 #
 
-extra-y	:= head.o init_task.o vmlinux.lds.s
+extra-y	:= head.o init_task.o vmlinux.lds
 
 obj-y	:= process.o signal.o entry.o traps.o irq.o \
 	ptrace.o setup.o time.o sys_sh.o semaphore.o \
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/sparc/boot/Makefile linux-2.6.8.1-callisto-work/arch/sparc/boot/Makefile
--- linux-2.6.8.1-callisto/arch/sparc/boot/Makefile	2004-06-16 08:20:03.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/sparc/boot/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -19,7 +19,7 @@
 
 BTOBJS := $(HEAD_Y) $(INIT_Y)
 BTLIBS := $(CORE_Y) $(LIBS_Y) $(DRIVERS_Y) $(NET_Y)
-LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds.s $(BTOBJS) --start-group $(BTLIBS) --end-group $(kallsyms.o)
+LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds $(BTOBJS) --start-group $(BTLIBS) --end-group $(kallsyms.o)
 
 # Actual linking
 $(obj)/image: $(obj)/btfix.o FORCE
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/sparc/kernel/Makefile linux-2.6.8.1-callisto-work/arch/sparc/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/sparc/kernel/Makefile	2004-06-16 08:19:52.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/sparc/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= head.o init_task.o vmlinux.lds.s
+extra-y		:= head.o init_task.o vmlinux.lds
 
 EXTRA_AFLAGS	:= -ansi
 
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/sparc64/Makefile linux-2.6.8.1-callisto-work/arch/sparc64/Makefile
--- linux-2.6.8.1-callisto/arch/sparc64/Makefile	2004-06-16 08:20:25.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/sparc64/Makefile	2004-08-14 21:20:46.000000000 +0300
@@ -10,7 +10,7 @@
 
 CHECK		:= $(CHECK) -D__sparc__=1 -D__sparc_v9__=1
 
-AFLAGS_vmlinux.lds.o += -Usparc
+PPFLAGS_vmlinux.o += -Usparc
 
 CC		:= $(shell if $(CC) -m64 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo $(CC); else echo sparc64-linux-gcc; fi )
 
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/sparc64/kernel/Makefile linux-2.6.8.1-callisto-work/arch/sparc64/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/sparc64/kernel/Makefile	2004-06-16 08:19:01.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/sparc64/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -5,7 +5,7 @@
 EXTRA_AFLAGS := -ansi
 EXTRA_CFLAGS := -Werror
 
-extra-y		:= head.o init_task.o vmlinux.lds.s
+extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		:= process.o setup.o cpu.o idprom.o \
 		   traps.o devices.o auxio.o \
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/um/Makefile linux-2.6.8.1-callisto-work/arch/um/Makefile
--- linux-2.6.8.1-callisto/arch/um/Makefile	2004-06-16 08:19:37.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/um/Makefile	2004-08-14 21:22:25.000000000 +0300
@@ -98,12 +98,12 @@
 CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
 
-AFLAGS_vmlinux.lds.o = -U$(SUBARCH) \
+PPFLAGS_vmlinux.o = -U$(SUBARCH) \
 	-DSTART=$$(($(TOP_ADDR) - $(SIZE))) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE_TT) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE)
 
-AFLAGS_$(LD_SCRIPT-y:.s=).o = $(AFLAGS_vmlinux.lds.o) -P -C -Uum
+PPFLAGS_$(LD_SCRIPT-y:.s=).o = $(PPFLAGS_vmlinux.o) -P -C -Uum
 
 LD_SCRIPT-y := $(ARCH_DIR)/$(LD_SCRIPT-y)
 
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/um/kernel/Makefile linux-2.6.8.1-callisto-work/arch/um/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/um/kernel/Makefile	2004-06-16 08:19:42.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/um/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o mem.o mem_user.o \
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/v850/kernel/Makefile linux-2.6.8.1-callisto-work/arch/v850/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/v850/kernel/Makefile	2004-06-16 08:20:26.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/v850/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -9,7 +9,7 @@
 # for more details.
 #
 
-extra-y := head.o init_task.o vmlinux.lds.s
+extra-y := head.o init_task.o vmlinux.lds
 
 obj-y += intv.o entry.o process.o syscalls.o time.o semaphore.o setup.o \
 	 signal.o irq.o mach.o ptrace.o bug.o
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/x86_64/kernel/Makefile linux-2.6.8.1-callisto-work/arch/x86_64/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/x86_64/kernel/Makefile	2004-06-16 08:19:43.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/x86_64/kernel/Makefile	2004-08-14 21:15:29.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y 	:= head.o head64.o init_task.o vmlinux.lds.s
+extra-y 	:= head.o head64.o init_task.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
diff -X dontdiff -urN linux-2.6.8.1-callisto/arch/x86_64/kernel/Makefile-HEAD linux-2.6.8.1-callisto-work/arch/x86_64/kernel/Makefile-HEAD
--- linux-2.6.8.1-callisto/arch/x86_64/kernel/Makefile-HEAD	2004-06-16 08:19:52.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/x86_64/kernel/Makefile-HEAD	2004-08-14 21:15:29.000000000 +0300
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
