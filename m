Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269825AbTGKIRj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269823AbTGKIRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:17:39 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:3760 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S269818AbTGKIPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:15:13 -0400
Date: Fri, 11 Jul 2003 10:29:37 +0200
To: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add xbox subarchitecture
Message-ID: <20030711082937.GA2838@h55p111.delphi.afb.lu.se>
References: <20030710172802.GB27744@h55p111.delphi.afb.lu.se> <20030710190918.A12653@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710190918.A12653@infradead.org>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19atHd-0000tN-00*eyPARFY.YSM*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 07:09:18PM +0100, Christoph Hellwig wrote:
> >  targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
> > +ifeq ($(CONFIG_X86_XBOX),y)
> > +#XXX Compiling with optimization makes 1.1-xboxen 
> > +#    crash while decompressing the kernel
> > +CFLAGS_misc.o   := -O0
> > +endif
> 
> I don't think this should go in until it's clear that it's not a gcc
> problem.

I don't really know how to make clear it's not a gcc problem. But if it was,
why doesn't it crash on pc and 1.0 xboxen? And why does it crash on kernels
compiled with 2.95, with or without optimization? I really wish I had the
explaination to this problem.

Updated patch according to other comments attached.

(btw, everyone at LinuxTag should come to the xbox-linux booth and say hi :)

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet
  1.1404 03/07/11 09:49:29 andersg@0x63.nu +10 -0
  Added XBox Gaming System subarchitecture.

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.1 03/07/11 09:42:47 andersg@0x63.nu +6 -0

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.0 03/07/11 09:42:47 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-xbox/mach_pci_blacklist.h

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.1 03/07/11 09:42:46 andersg@0x63.nu +6 -0

  arch/i386/mach-xbox/setup.c
    1.1 03/07/11 09:42:46 andersg@0x63.nu +79 -0

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.0 03/07/11 09:42:46 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-default/mach_pci_blacklist.h

  arch/i386/mach-xbox/setup.c
    1.0 03/07/11 09:42:46 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/setup.c

  arch/i386/mach-xbox/reboot.c
    1.1 03/07/11 09:42:45 andersg@0x63.nu +51 -0

  arch/i386/mach-xbox/reboot.c
    1.0 03/07/11 09:42:45 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/reboot.c

  arch/i386/mach-xbox/Makefile
    1.1 03/07/11 09:42:44 andersg@0x63.nu +5 -0

  include/asm-i386/timex.h
    1.6 03/07/11 09:42:44 andersg@0x63.nu +5 -1
    The xbox has a different CLOCK_TICK_RATE.

  arch/i386/pci/direct.c
    1.19 03/07/11 09:42:44 andersg@0x63.nu +4 -0
    Added a mach-hook for blacklisting pci-devices.
    The xbox uses this to prevent it from touching some devices that makes
    it hang.

  arch/i386/mach-xbox/Makefile
    1.0 03/07/11 09:42:44 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/Makefile

  arch/i386/boot/compressed/Makefile
    1.17 03/07/11 09:42:44 andersg@0x63.nu +5 -0
    There is some strange interaction when paging is off, that makes 1.1 xboxen
    crash while decompressing kernel. Compiling the decompressor without
    optimization works around this problem.

  arch/i386/Makefile
    1.53 03/07/11 09:42:44 andersg@0x63.nu +4 -0
    Added XBox Gaming System subarchitecture.

  arch/i386/Kconfig
    1.66 03/07/11 09:42:44 andersg@0x63.nu +19 -2
    Added configure option for the XBox Gaming System subarchitecture.


 arch/i386/Kconfig                                  |   21 +++++
 arch/i386/Makefile                                 |    4 +
 arch/i386/boot/compressed/Makefile                 |    5 +
 arch/i386/mach-xbox/Makefile                       |    5 +
 arch/i386/mach-xbox/reboot.c                       |   51 +++++++++++++
 arch/i386/mach-xbox/setup.c                        |   79 +++++++++++++++++++++
 arch/i386/pci/direct.c                             |    4 +
 include/asm-i386/mach-default/mach_pci_blacklist.h |    6 +
 include/asm-i386/mach-xbox/mach_pci_blacklist.h    |    6 +
 include/asm-i386/timex.h                           |    6 +
 10 files changed, 184 insertions(+), 3 deletions(-)


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Fri Jul 11 09:56:33 2003
+++ b/arch/i386/Kconfig	Fri Jul 11 09:56:33 2003
@@ -43,6 +43,22 @@
 	help
 	  Choose this option if your computer is a standard PC or compatible.
 
+config X86_XBOX
+	bool "XBox Gaming System"
+	help
+	  This option is needed to make Linux boot on XBox Gaming Systems.
+	  
+	  The XBox can be considered as a standard PC with a Coppermine-based Celeron 733 MHz,
+	  IDE harddrive, DVD, Ethernet, USB and graphics. 
+	  
+	  To boot the kernel you need "_romwell", either used as a replacement BIOS (cromwell)
+	  or as a bootloader.
+	  
+	  For more information see http://xbox-linux.sourceforge.net/ 
+	  
+	  If you do not specifically need a kernel for XBOX machine,
+	  say N here otherwise the kernel you build will not be bootable.
+
 config X86_VOYAGER
 	bool "Voyager (NCR)"
 	help
@@ -409,6 +425,7 @@
 	  Otherwise, say N.
 
 config SMP
+	depends on !X86_XBOX
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
@@ -1104,7 +1121,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
@@ -1410,7 +1427,7 @@
 
 config X86_BIOS_REBOOT
 	bool
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	default y
 
 config X86_TRAMPOLINE
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Fri Jul 11 09:56:33 2003
+++ b/arch/i386/Makefile	Fri Jul 11 09:56:33 2003
@@ -53,6 +53,10 @@
 # Default subarch .c files
 mcore-y  := mach-default
 
+# Xbox subarch support
+mflags-$(CONFIG_X86_XBOX)	:= -Iinclude/asm-i386/mach-xbox
+mcore-$(CONFIG_X86_XBOX)	:= mach-xbox
+
 # Voyager subarch support
 mflags-$(CONFIG_X86_VOYAGER)	:= -Iinclude/asm-i386/mach-voyager
 mcore-$(CONFIG_X86_VOYAGER)	:= mach-voyager
diff -Nru a/arch/i386/boot/compressed/Makefile b/arch/i386/boot/compressed/Makefile
--- a/arch/i386/boot/compressed/Makefile	Fri Jul 11 09:56:33 2003
+++ b/arch/i386/boot/compressed/Makefile	Fri Jul 11 09:56:33 2003
@@ -5,6 +5,11 @@
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+ifeq ($(CONFIG_X86_XBOX),y)
+#XXX Compiling with optimization makes 1.1-xboxen 
+#    crash while decompressing the kernel
+CFLAGS_misc.o   := -O0
+endif
 EXTRA_AFLAGS	:= -traditional
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
diff -Nru a/arch/i386/mach-xbox/Makefile b/arch/i386/mach-xbox/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/Makefile	Fri Jul 11 09:56:33 2003
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= setup.o reboot.o
diff -Nru a/arch/i386/mach-xbox/reboot.c b/arch/i386/mach-xbox/reboot.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/reboot.c	Fri Jul 11 09:56:33 2003
@@ -0,0 +1,51 @@
+/*
+ * arch/i386/mach-xbox/reboot.c 
+ * Olivier Fauchon <olivier.fauchon@free.fr>
+ * Anders Gustafsson <andersg@0x63.nu>
+ *
+ */
+
+#include <asm/io.h>
+
+/* we don't use any of those, but dmi_scan.c needs 'em */
+void (*pm_power_off)(void);
+int reboot_thru_bios;
+
+#define XBOX_SMB_IO_BASE 0xC000
+#define XBOX_SMB_HOST_ADDRESS       (0x4 + XBOX_SMB_IO_BASE)
+#define XBOX_SMB_HOST_COMMAND       (0x8 + XBOX_SMB_IO_BASE)
+#define XBOX_SMB_HOST_DATA          (0x6 + XBOX_SMB_IO_BASE)
+#define XBOX_SMB_GLOBAL_ENABLE      (0x2 + XBOX_SMB_IO_BASE)
+
+#define XBOX_PIC_ADDRESS 0x10
+
+#define SMC_CMD_POWER 0x02
+#define SMC_SUBCMD_POWER_RESET 0x01
+#define SMC_SUBCMD_POWER_CYCLE 0x40
+#define SMC_SUBCMD_POWER_OFF 0x80
+
+
+static void xbox_pic_cmd(u8 command)
+{
+	outw_p(((XBOX_PIC_ADDRESS) << 1),XBOX_SMB_HOST_ADDRESS);
+	outb_p(SMC_CMD_POWER, XBOX_SMB_HOST_COMMAND);
+	outw_p(command, XBOX_SMB_HOST_DATA);
+	outw_p(inw(XBOX_SMB_IO_BASE),XBOX_SMB_IO_BASE);
+	outb_p(0x0a,XBOX_SMB_GLOBAL_ENABLE);
+}
+
+void machine_restart(char * __unused)
+{
+	printk(KERN_INFO "Sending POWER_RESET to XBOX-PIC.\n");
+	xbox_pic_cmd(SMC_SUBCMD_POWER_RESET);  
+}
+
+void machine_power_off(void)
+{
+	printk(KERN_INFO "Sending POWER_OFF to XBOX-PIC.\n");
+	xbox_pic_cmd(SMC_SUBCMD_POWER_OFF);  
+}
+
+void machine_halt(void)
+{
+}
diff -Nru a/arch/i386/mach-xbox/setup.c b/arch/i386/mach-xbox/setup.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/setup.c	Fri Jul 11 09:56:33 2003
@@ -0,0 +1,79 @@
+/*
+ *	Machine specific setup for xbox
+ */
+
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/arch_hooks.h>
+
+/**
+ * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
+ *
+ * Description:
+ *	Perform any necessary interrupt initialisation prior to setting up
+ *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
+ *	interrupts should be initialised here if the machine emulates a PC
+ *	in any way.
+ **/
+void __init pre_intr_init_hook(void)
+{
+	init_ISA_irqs();
+}
+
+/**
+ * intr_init_hook - post gate setup interrupt initialisation
+ *
+ * Description:
+ *	Fill in any interrupts that may have been left out by the general
+ *	init_IRQ() routine.  interrupts having to do with the machine rather
+ *	than the devices on the I/O bus (like APIC interrupts in intel MP
+ *	systems) are started here.
+ **/
+void __init intr_init_hook(void)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	apic_intr_init();
+#endif
+
+}
+
+/**
+ * pre_setup_arch_hook - hook called prior to any setup_arch() execution
+ *
+ * Description:
+ *	generally used to activate any machine specific identification
+ *	routines that may be needed before setup_arch() runs.  On VISWS
+ *	this is used to get the board revision and type.
+ **/
+void __init pre_setup_arch_hook(void)
+{
+}
+
+/**
+ * trap_init_hook - initialise system specific traps
+ *
+ * Description:
+ *	Called as the final act of trap_init().  Used in VISWS to initialise
+ *	the various board specific APIC traps.
+ **/
+void __init trap_init_hook(void)
+{
+}
+
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+
+/**
+ * time_init_hook - do any specific initialisations for the system timer.
+ *
+ * Description:
+ *	Must plug the system timer interrupt source at HZ into the IRQ listed
+ *	in irq_vectors.h:TIMER_IRQ
+ **/
+void __init time_init_hook(void)
+{
+	setup_irq(0, &irq0);
+}
+
diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Fri Jul 11 09:56:33 2003
+++ b/arch/i386/pci/direct.c	Fri Jul 11 09:56:33 2003
@@ -4,6 +4,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include "mach_pci_blacklist.h"
 #include "pci.h"
 
 /*
@@ -20,6 +21,9 @@
 	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
+	if (mach_pci_is_blacklisted(bus,PCI_SLOT(devfn),PCI_FUNC(devfn)))
+		return -EINVAL;
+	
 	spin_lock_irqsave(&pci_config_lock, flags);
 
 	outl(PCI_CONF1_ADDRESS(bus, devfn, reg), 0xCF8);
diff -Nru a/include/asm-i386/mach-default/mach_pci_blacklist.h b/include/asm-i386/mach-default/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-default/mach_pci_blacklist.h	Fri Jul 11 09:56:33 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) 0
+
+#endif
diff -Nru a/include/asm-i386/mach-xbox/mach_pci_blacklist.h b/include/asm-i386/mach-xbox/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-xbox/mach_pci_blacklist.h	Fri Jul 11 09:56:33 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) ( (bus>1) || (bus&&(dev||fn)) || ((bus==0 && dev==0) && ((fn==1)||(fn==2))) )
+
+#endif
diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Fri Jul 11 09:56:33 2003
+++ b/include/asm-i386/timex.h	Fri Jul 11 09:56:33 2003
@@ -15,7 +15,11 @@
 #ifdef CONFIG_MELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
-#  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
+#  ifdef CONFIG_X86_XBOX
+#    define CLOCK_TICK_RATE 1124998 /* so has the Xbox */
+#  else 
+#    define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
+#  endif
 #endif
 #endif
 

===================================================================


This BitKeeper patch contains the following changesets:
1.1404
## Wrapped with uu ##


M(R!5<V5R.@EA;F1E<G-G"B,@2&]S=#H),'@V,RYN=0HC(%)O;W0Z"2]D871A
M+V1E=B]K97)N96PO8FLO>&)O>"TR+C4*"B,@4&%T8V@@=F5R<SH),2XS"B,@
M4&%T8V@@='EP93H)4D5'54Q!4@H*/3T@0VAA;F=E4V5T(#T]"G1O<G9A;&1S
M0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U
M-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"G1O<G9A;&1S0&AO;64N;W-D;"YO
M<F=\0VAA;F=E4V5T?#(P,#,P-S$Q,#0P-C$V?#,X,#4X"D0@,2XQ-# T(# S
M+S W+S$Q(# Y.C0Y.C(Y*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K,3 @+3 *
M0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P
M,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A-#%E9# R-#@V- I#"F,@061D960@
M6$)O>"!'86UI;F<@4WES=&5M('-U8F%R8VAI=&5C='5R92X*2R S-3(P. I0
M($-H86YG95-E= HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2T*"C!A, H^(&%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS
M.#8O;6%C:"UX8F]X+W)E8F]O="YC?#(P,#,P-S$Q,#<T,C0U?#0T,#$U?#$S
M-V,T8CAC8S(X.3<T.30@86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H
M+7AB;W@O<F5B;V]T+F-\,C P,S W,3$P-S0R-#9\,S(Y,SD*/B!T;W)V86QD
M<T!A=&AL;VXN=')A;G-M971A+F-O;7QA<F-H+VDS.#8O36%K969I;&5\,C P
M,C R,#4Q-S0P,C!\,3@W,3!\,6(X86$Q9C!C-#!A,61B9B!A;F1E<G-G0#!X
M-C,N;G5\87)C:"]I,S@V+TUA:V5F:6QE?#(P,#,P-S$Q,#<T,C0T?#,R,30U
M"CX@;6]C:&5L0'-E9V9A=6QT+F]S9&PN;W)G?&%R8V@O:3,X-B]K97)N96PO
M<&-I+V1I<F5C="YC?#(P,#(P-#$V,34P.#,P?#0T-S,R?#,X-V,U-V0P.3!A
M9#0X.#@@86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]P8VDO9&ER96-T+F-\
M,C P,S W,3$P-S0R-#1\-C$V-C<*/B!A;F1E<G-G0#!X-C,N;G5\:6YC;'5D
M92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+FA\,C P
M,S W,3$P-S0R-#=\-#(U-3=\-V8P,#9B,V(Y.6)D93-F."!A;F1E<G-G0#!X
M-C,N;G5\:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA
M8VML:7-T+FA\,C P,S W,3$P-S0R-#A\,34U,3$*/B!A;F1E<G-G0#!X-C,N
M;G5\:6YC;'5D92]A<VTM:3,X-B]M86-H+61E9F%U;'0O;6%C:%]P8VE?8FQA
M8VML:7-T+FA\,C P,S W,3$P-S0R-#9\,3 P,S!\83(W9F%B-SAB.#<Y,V8U
M-"!A;F1E<G-G0#!X-C,N;G5\:6YC;'5D92]A<VTM:3,X-B]M86-H+61E9F%U
M;'0O;6%C:%]P8VE?8FQA8VML:7-T+FA\,C P,S W,3$P-S0R-#=\,3 R,S(*
M/B!A;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC
M?#(P,#,P-S$Q,#<T,C0V?# Y,C<S?&(X.3@Y9C9B9#1E,CDV-38@86YD97)S
M9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8WPR,# S,#<Q
M,3 W-#(T-WPS-38T. H^(&%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C
M:"UX8F]X+TUA:V5F:6QE?#(P,#,P-S$Q,#<T,C0T?# S.#4U?#%F-V$S.&$U
M8S0S869D,C4@86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O
M36%K969I;&5\,C P,S W,3$P-S0R-#5\,#4R,S0*/B!T;W)V86QD<T!A=&AL
M;VXN=')A;G-M971A+F-O;7QI;F-L=61E+V%S;2UI,S@V+W1I;65X+FA\,C P
M,C R,#4Q-S,Y-#1\-C,X-C)\86$U9F0Q868Y,69E-3!F-R!A;F1E<G-G0#!X
M-C,N;G5\:6YC;'5D92]A<VTM:3,X-B]T:6UE>"YH?#(P,#,P-S$Q,#<T,C0T
M?#8P.3@X"CX@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\87)C:"]I
M,S@V+V)O;W0O8V]M<')E<W-E9"]-86ME9FEL97PR,# R,#(P-3$W-# R,'PQ
M-#(X.7QE960R-#-C,V8T-6)E9C8@86YD97)S9T P>#8S+FYU?&%R8V@O:3,X
M-B]B;V]T+V-O;7!R97-S960O36%K969I;&5\,C P,S W,3$P-S0R-#1\,# R
M,CD*/B!Z:7!P96Q ;&EN=7@M;38X:RYO<F=;=&]R=F%L9'-=?&%R8V@O:3,X
M-B]+8V]N9FEG?#(P,#(Q,#,P,#0S,C$X?#(T-C@X?#8Q,C,Q.#!A8CDQ-3<V
M,&,@86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]+8V]N9FEG?#(P,#,P-S$Q
M,#<T,C0T?# Y.#(R"@H]/2!A<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE
M(#T]"DYE=R!F:6QE.B!A<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE"E8@
M- H*86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O36%K969I
M;&5\,C P,S W,3$P-S0R-#1\,#,X-35\,68W83,X835C-#-A9F0R-0I$(#$N
M," P,R\P-R\Q,2 P.3HT,CHT-"LP,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S @
M+3 *0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\
M,C P,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A-#%E9# R-#@V- IC($)I=$ME
M97!E<B!F:6QE("]D871A+V1E=B]K97)N96PO8FLO>&)O>"TR+C4O87)C:"]I
M,S@V+VUA8V@M>&)O>"]-86ME9FEL90I+(#,X-34*4"!A<F-H+VDS.#8O;6%C
M:"UX8F]X+TUA:V5F:6QE"E(@,68W83,X835C-#-A9F0R-0I8(#!X.#(Q"BTM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+0H*"F%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F
M:6QE?#(P,#,P-S$Q,#<T,C0T?# S.#4U?#%F-V$S.&$U8S0S869D,C4*1" Q
M+C$@,#,O,#<O,3$@,#DZ-#(Z-#0K,#(Z,# @86YD97)S9T P>#8S+FYU("LU
M("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T
M?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PI&(#$*
M2R U,C,T"D\@+7)W+7)W+7(M+0I0(&%R8V@O:3,X-B]M86-H+7AB;W@O36%K
M969I;&4*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM"@I)," U"B,*(R!-86ME9FEL92!F;W(@=&AE(&QI;G5X(&ME
M<FYE;"X*(PI<"F]B:BUY"0D)"3H]('-E='5P+F\@<F5B;V]T+F\*"CT](&%R
M8V@O:3,X-B]M86-H+7AB;W@O<F5B;V]T+F,@/3T*3F5W(&9I;&4Z(&%R8V@O
M:3,X-B]M86-H+7AB;W@O<F5B;V]T+F,*5B T"@IA;F1E<G-G0#!X-C,N;G5\
M87)C:"]I,S@V+VUA8V@M>&)O>"]R96)O;W0N8WPR,# S,#<Q,3 W-#(T-7PT
M-# Q-7PQ,S=C-&(X8V,R.#DW-#DT"D0@,2XP(# S+S W+S$Q(# Y.C0R.C0U
M*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K," M, I"('1O<G9A;&1S0&%T:&QO
M;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ-C T
M-WQC,60Q,6$T,65D,#(T.#8T"F,@0FET2V5E<&5R(&9I;&4@+V1A=&$O9&5V
M+VME<FYE;"]B:R]X8F]X+3(N-2]A<F-H+VDS.#8O;6%C:"UX8F]X+W)E8F]O
M="YC"DL@-#0P,34*4"!A<F-H+VDS.#8O;6%C:"UX8F]X+W)E8F]O="YC"E(@
M,3,W8S1B.&-C,C@Y-S0Y- I8(#!X.#(Q"BTM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*"F%N9&5R<V= ,'@V,RYN
M=7QA<F-H+VDS.#8O;6%C:"UX8F]X+W)E8F]O="YC?#(P,#,P-S$Q,#<T,C0U
M?#0T,#$U?#$S-V,T8CAC8S(X.3<T.30*1" Q+C$@,#,O,#<O,3$@,#DZ-#(Z
M-#4K,#(Z,# @86YD97)S9T P>#8S+FYU("LU,2 M, I"('1O<G9A;&1S0&%T
M:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ
M-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*1B Q"DL@,S(Y,SD*3R M<G<M<G<M
M<BTM"E @87)C:"]I,S@V+VUA8V@M>&)O>"]R96)O;W0N8PHM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDP(#4Q
M"B\J"B J(&%R8V@O:3,X-B]M86-H+7AB;W@O<F5B;V]T+F,@"B J($]L:79I
M97(@1F%U8VAO;B \;VQI=FEE<BYF875C:&]N0&9R964N9G(^"B J($%N9&5R
M<R!'=7-T869S<V]N(#QA;F1E<G-G0#!X-C,N;G4^"B J"B J+PI<"B-I;F-L
M=61E(#QA<VTO:6\N:#X*7 HO*B!W92!D;VXG="!U<V4@86YY(&]F('1H;W-E
M+"!B=70@9&UI7W-C86XN8R!N965D<R G96T@*B\*=F]I9" H*G!M7W!O=V5R
M7V]F9BDH=F]I9"D["FEN="!R96)O;W1?=&AR=5]B:6]S.PI<"B-D969I;F4@
M6$)/6%]334)?24]?0D%312 P>$,P,# *(V1E9FEN92!80D]87U--0E](3U-4
M7T%$1%)%4U,@(" @(" @*#!X-" K(%A"3UA?4TU"7TE/7T)!4T4I"B-D969I
M;F4@6$)/6%]334)?2$]35%]#3TU-04Y$(" @(" @("@P>#@@*R!80D]87U--
M0E])3U]"05-%*0HC9&5F:6YE(%A"3UA?4TU"7TA/4U1?1$%402 @(" @(" @
M(" H,'@V("L@6$)/6%]334)?24]?0D%312D*(V1E9FEN92!80D]87U--0E]'
M3$]"04Q?14Y!0DQ%(" @(" @*#!X,B K(%A"3UA?4TU"7TE/7T)!4T4I"EP*
M(V1E9FEN92!80D]87U!)0U]!1$1215-3(#!X,3 *7 HC9&5F:6YE(%--0U]#
M341?4$]715(@,'@P,@HC9&5F:6YE(%--0U]354)#341?4$]715)?4D53150@
M,'@P,0HC9&5F:6YE(%--0U]354)#341?4$]715)?0UE#3$4@,'@T, HC9&5F
M:6YE(%--0U]354)#341?4$]715)?3T9&(#!X.# *7 I<"G-T871I8R!V;VED
M('AB;WA?<&EC7V-M9"AU."!C;VUM86YD*0I["@EO=71W7W H*"A80D]87U!)
M0U]!1$1215-3*2 \/" Q*2Q80D]87U--0E](3U-47T%$1%)%4U,I.PH);W5T
M8E]P*%--0U]#341?4$]715(L(%A"3UA?4TU"7TA/4U1?0T]-34%.1"D["@EO
M=71W7W H8V]M;6%N9"P@6$)/6%]334)?2$]35%]$051!*3L*"6]U='=?<"AI
M;G<H6$)/6%]334)?24]?0D%312DL6$)/6%]334)?24]?0D%312D["@EO=71B
M7W H,'@P82Q80D]87U--0E]'3$]"04Q?14Y!0DQ%*3L*?0I<"G9O:60@;6%C
M:&EN95]R97-T87)T*&-H87(@*B!?7W5N=7-E9"D*>PH)<')I;G1K*$M%4DY?
M24Y&3R B4V5N9&EN9R!03U=%4E]215-%5"!T;R!80D]8+5!)0RY<;B(I.PH)
M>&)O>%]P:6-?8VUD*%--0U]354)#341?4$]715)?4D53150I.R @"GT*7 IV
M;VED(&UA8VAI;F5?<&]W97)?;V9F*'9O:60I"GL*"7!R:6YT:RA+15).7TE.
M1D\@(E-E;F1I;F<@4$]715)?3T9&('1O(%A"3U@M4$E#+EQN(BD["@EX8F]X
M7W!I8U]C;60H4TU#7U-50D--1%]03U=%4E]/1D8I.R @"GT*7 IV;VED(&UA
M8VAI;F5?:&%L="AV;VED*0I["GT*"CT](&%R8V@O:3,X-B]M86-H+7AB;W@O
M<V5T=7 N8R ]/0I.97<@9FEL93H@87)C:"]I,S@V+VUA8V@M>&)O>"]S971U
M<"YC"E8@- H*86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O
M<V5T=7 N8WPR,# S,#<Q,3 W-#(T-GPP.3(W,WQB.#DX.68V8F0T93(Y-C4V
M"D0@,2XP(# S+S W+S$Q(# Y.C0R.C0V*S R.C P(&%N9&5R<V= ,'@V,RYN
M=2 K," M, I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG
M95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"F,@
M0FET2V5E<&5R(&9I;&4@+V1A=&$O9&5V+VME<FYE;"]B:R]X8F]X+3(N-2]A
M<F-H+VDS.#8O;6%C:"UX8F]X+W-E='5P+F,*2R Y,C<S"E @87)C:"]I,S@V
M+VUA8V@M>&)O>"]S971U<"YC"E(@8C@Y.#EF-F)D-&4R.38U-@I8(#!X.#(Q
M"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+0H*"F%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C:"UX8F]X+W-E
M='5P+F-\,C P,S W,3$P-S0R-#9\,#DR-S-\8C@Y.#EF-F)D-&4R.38U-@I$
M(#$N,2 P,R\P-R\Q,2 P.3HT,CHT-BLP,CHP,"!A;F1E<G-G0#!X-C,N;G4@
M*S<Y("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E
M4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PI&
M(#$*2R S-38T. I/("UR=RUR=RUR+2T*4"!A<F-H+VDS.#8O;6%C:"UX8F]X
M+W-E='5P+F,*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM"@I)," W.0HO*@H@*@E-86-H:6YE('-P96-I9FEC('-E
M='5P(&9O<B!X8F]X"B J+PI<"B-I;F-L=61E(#QL:6YU>"]C;VYF:6<N:#X*
M(VEN8VQU9&4@/&QI;G5X+W-M<"YH/@HC:6YC;'5D92 \;&EN=7@O:6YI="YH
M/@HC:6YC;'5D92 \;&EN=7@O:7)Q+F@^"B-I;F-L=61E(#QL:6YU>"]I;G1E
M<G)U<'0N:#X*(VEN8VQU9&4@/&%S;2]A<F-H7VAO;VMS+F@^"EP*+RHJ"B J
M('!R95]I;G1R7VEN:71?:&]O:R M(&EN:71I86QI<V%T:6]N('!R:6]R('1O
M('-E='1I;F<@=7 @:6YT97)R=7!T('9E8W1O<G,*("H*("H@1&5S8W)I<'1I
M;VXZ"B J"5!E<F9O<FT@86YY(&YE8V5S<V%R>2!I;G1E<G)U<'0@:6YI=&EA
M;&ES871I;VX@<')I;W(@=&\@<V5T=&EN9R!U< H@*@ET:&4@(F]R9&EN87)Y
M(B!I;G1E<G)U<'0@8V%L;"!G871E<RX@($9O<B!L96=A8WD@<F5A<V]N<RP@
M=&AE($E300H@*@EI;G1E<G)U<'1S('-H;W5L9"!B92!I;FET:6%L:7-E9"!H
M97)E(&EF('1H92!M86-H:6YE(&5M=6QA=&5S(&$@4$,*("H):6X@86YY('=A
M>2X*("HJ+PIV;VED(%]?:6YI="!P<F5?:6YT<E]I;FET7VAO;VLH=F]I9"D*
M>PH):6YI=%])4T%?:7)Q<R@I.PI]"EP*+RHJ"B J(&EN=')?:6YI=%]H;V]K
M("T@<&]S="!G871E('-E='5P(&EN=&5R<G5P="!I;FET:6%L:7-A=&EO;@H@
M*@H@*B!$97-C<FEP=&EO;CH*("H)1FEL;"!I;B!A;GD@:6YT97)R=7!T<R!T
M:&%T(&UA>2!H879E(&)E96X@;&5F="!O=70@8GD@=&AE(&=E;F5R86P*("H)
M:6YI=%])4E$H*2!R;W5T:6YE+B @:6YT97)R=7!T<R!H879I;F<@=&\@9&\@
M=VET:"!T:&4@;6%C:&EN92!R871H97(*("H)=&AA;B!T:&4@9&5V:6-E<R!O
M;B!T:&4@22]/(&)U<R H;&EK92!!4$E#(&EN=&5R<G5P=',@:6X@:6YT96P@
M35 *("H)<WES=&5M<RD@87)E('-T87)T960@:&5R92X*("HJ+PIV;VED(%]?
M:6YI="!I;G1R7VEN:71?:&]O:RAV;VED*0I["B-I9F1E9B!#3TY&24=?6#@V
M7TQ/0T%,7T%024,*"6%P:6-?:6YT<E]I;FET*"D["B-E;F1I9@I<"GT*7 HO
M*BH*("H@<')E7W-E='5P7V%R8VA?:&]O:R M(&AO;VL@8V%L;&5D('!R:6]R
M('1O(&%N>2!S971U<%]A<F-H*"D@97AE8W5T:6]N"B J"B J($1E<V-R:7!T
M:6]N.@H@*@EG96YE<F%L;'D@=7-E9"!T;R!A8W1I=F%T92!A;GD@;6%C:&EN
M92!S<&5C:69I8R!I9&5N=&EF:6-A=&EO;@H@*@ER;W5T:6YE<R!T:&%T(&UA
M>2!B92!N965D960@8F5F;W)E('-E='5P7V%R8V@H*2!R=6YS+B @3VX@5DE3
M5U,*("H)=&AI<R!I<R!U<V5D('1O(&=E="!T:&4@8F]A<F0@<F5V:7-I;VX@
M86YD('1Y<&4N"B J*B\*=F]I9"!?7VEN:70@<')E7W-E='5P7V%R8VA?:&]O
M:RAV;VED*0I["GT*7 HO*BH*("H@=')A<%]I;FET7VAO;VL@+2!I;FET:6%L
M:7-E('-Y<W1E;2!S<&5C:69I8R!T<F%P<PH@*@H@*B!$97-C<FEP=&EO;CH*
M("H)0V%L;&5D(&%S('1H92!F:6YA;"!A8W0@;V8@=')A<%]I;FET*"DN("!5
M<V5D(&EN(%9)4U=3('1O(&EN:71I86QI<V4*("H)=&AE('9A<FEO=7,@8F]A
M<F0@<W!E8VEF:6,@05!)0R!T<F%P<RX*("HJ+PIV;VED(%]?:6YI="!T<F%P
M7VEN:71?:&]O:RAV;VED*0I["GT*7 IS=&%T:6,@<W1R=6-T(&ER<6%C=&EO
M;B!I<G$P(" ]('L@=&EM97)?:6YT97)R=7!T+"!305])3E1%4E)54%0L(# L
M(")T:6UE<B(L($Y53$PL($Y53$Q].PI<"B\J*@H@*B!T:6UE7VEN:71?:&]O
M:R M(&1O(&%N>2!S<&5C:69I8R!I;FET:6%L:7-A=&EO;G,@9F]R('1H92!S
M>7-T96T@=&EM97(N"B J"B J($1E<V-R:7!T:6]N.@H@*@E-=7-T('!L=6<@
M=&AE('-Y<W1E;2!T:6UE<B!I;G1E<G)U<'0@<V]U<F-E(&%T($A:(&EN=&\@
M=&AE($E242!L:7-T960*("H):6X@:7)Q7W9E8W1O<G,N:#I424U%4E])4E$*
M("HJ+PIV;VED(%]?:6YI="!T:6UE7VEN:71?:&]O:RAV;VED*0I["@ES971U
M<%]I<G$H,"P@)FER<3 I.PI]"EP*"CT](&EN8VQU9&4O87-M+6DS.#8O;6%C
M:"UD969A=6QT+VUA8VA?<&-I7V)L86-K;&ES="YH(#T]"DYE=R!F:6QE.B!I
M;F-L=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI
M<W0N: I6(#0*"F%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI,S@V+VUA
M8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#<Q,3 W-#(T
M-GPQ,# S,'QA,C=F86(W.&(X-SDS9C4T"D0@,2XP(# S+S W+S$Q(# Y.C0R
M.C0V*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K," M, I"('1O<G9A;&1S0&%T
M:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ
M-C T-WQC,60Q,6$T,65D,#(T.#8T"F,@0FET2V5E<&5R(&9I;&4@+V1A=&$O
M9&5V+VME<FYE;"]B:R]X8F]X+3(N-2]I;F-L=61E+V%S;2UI,S@V+VUA8V@M
M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N: I+(#$P,#,P"E @:6YC;'5D
M92]A<VTM:3,X-B]M86-H+61E9F%U;'0O;6%C:%]P8VE?8FQA8VML:7-T+F@*
M4B!A,C=F86(W.&(X-SDS9C4T"E@@,'@X,C$*+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@H*86YD97)S9T P>#8S
M+FYU?&EN8VQU9&4O87-M+6DS.#8O;6%C:"UD969A=6QT+VUA8VA?<&-I7V)L
M86-K;&ES="YH?#(P,#,P-S$Q,#<T,C0V?#$P,#,P?&$R-V9A8C<X8C@W.3-F
M-30*1" Q+C$@,#,O,#<O,3$@,#DZ-#(Z-#8K,#(Z,# @86YD97)S9T P>#8S
M+FYU("LV("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA
M;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*
M0PI&(#$*2R Q,#(S,@I/("UR=RUR=RUR+2T*4"!I;F-L=61E+V%S;2UI,S@V
M+VUA8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N: HM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDP(#8*
M(VEF;F1E9B!?7T%335]-04-(7U!#25]"3$%#2TQ)4U1?2 HC9&5F:6YE(%]?
M05--7TU!0TA?4$-)7T),04-+3$E35%]("EP*(V1E9FEN92!M86-H7W!C:5]I
M<U]B;&%C:VQI<W1E9"AB=7,L9&5V+&9N*2 P"EP*(V5N9&EF"@H]/2!I;F-L
M=61E+V%S;2UI,S@V+VUA8V@M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N:" ]
M/0I.97<@9FEL93H@:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P
M8VE?8FQA8VML:7-T+F@*5B T"@IA;F1E<G-G0#!X-C,N;G5\:6YC;'5D92]A
M<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+FA\,C P,S W
M,3$P-S0R-#=\-#(U-3=\-V8P,#9B,V(Y.6)D93-F. I$(#$N," P,R\P-R\Q
M,2 P.3HT,CHT-RLP,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S @+3 *0B!T;W)V
M86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q
M-S,P-39\,38P-#=\8S%D,3%A-#%E9# R-#@V- IC($)I=$ME97!E<B!F:6QE
M("]D871A+V1E=B]K97)N96PO8FLO>&)O>"TR+C4O:6YC;'5D92]A<VTM:3,X
M-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+F@*2R T,C4U-PI0(&EN
M8VQU9&4O87-M+6DS.#8O;6%C:"UX8F]X+VUA8VA?<&-I7V)L86-K;&ES="YH
M"E(@-V8P,#9B,V(Y.6)D93-F. I8(#!X.#(Q"BTM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*"F%N9&5R<V= ,'@V
M,RYN=7QI;F-L=61E+V%S;2UI,S@V+VUA8V@M>&)O>"]M86-H7W!C:5]B;&%C
M:VQI<W0N:'PR,# S,#<Q,3 W-#(T-WPT,C4U-WPW9C P-F(S8CDY8F1E,V8X
M"D0@,2XQ(# S+S W+S$Q(# Y.C0R.C0W*S R.C P(&%N9&5R<V= ,'@V,RYN
M=2 K-B M, I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG
M95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*
M1B Q"DL@,34U,3$*3R M<G<M<G<M<BTM"E @:6YC;'5D92]A<VTM:3,X-B]M
M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+F@*+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I)," V"B-I9FYD
M968@7U]!4TU?34%#2%]00TE?0DQ!0TM,25-47T@*(V1E9FEN92!?7T%335]-
M04-(7U!#25]"3$%#2TQ)4U1?2 I<"B-D969I;F4@;6%C:%]P8VE?:7-?8FQA
M8VML:7-T960H8G5S+&1E=BQF;BD@*" H8G5S/C$I('Q\("AB=7,F)BAD979\
M?&9N*2D@?'P@*"AB=7,]/3 @)B8@9&5V/3TP*2 F)B H*&9N/3TQ*7Q\*&9N
M/3TR*2DI("D*7 HC96YD:68*"CT](&%R8V@O:3,X-B]P8VDO9&ER96-T+F,@
M/3T*;6]C:&5L0'-E9V9A=6QT+F]S9&PN;W)G?&%R8V@O:3,X-B]K97)N96PO
M<&-I+V1I<F5C="YC?#(P,#(P-#$V,34P.#,P?#0T-S,R?#,X-V,U-V0P.3!A
M9#0X.#@*=VEL;'E 9&5B:6%N+F]R9UMG<F5G77QA<F-H+VDS.#8O<&-I+V1I
M<F5C="YC?#(P,#,P-S S,C(U,#0W?#4Q-S8T"D0@,2XQ.2 P,R\P-R\Q,2 P
M.3HT,CHT-"LP,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S0@+3 *0B!T;W)V86QD
M<T!A=&AL;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P
M-39\,38P-#=\8S%D,3%A-#%E9# R-#@V- I#"F,@061D960@82!M86-H+6AO
M;VL@9F]R(&)L86-K;&ES=&EN9R!P8VDM9&5V:6-E<RX*8R!4:&4@>&)O>"!U
M<V5S('1H:7,@=&\@<')E=F5N="!I="!F<F]M('1O=6-H:6YG('-O;64@9&5V
M:6-E<R!T:&%T(&UA:V5S"F,@:70@:&%N9RX*2R V,38V-PI/("UR=RUR=RUR
M+2T*4"!A<F-H+VDS.#8O<&-I+V1I<F5C="YC"BTM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*238@,0HC:6YC;'5D
M92 B;6%C:%]P8VE?8FQA8VML:7-T+F@B"DDR,B S"@EI9B H;6%C:%]P8VE?
M:7-?8FQA8VML:7-T960H8G5S+%!#25]33$]4*&1E=F9N*2Q00TE?1E5.0RAD
M979F;BDI*0H)"7)E='5R;B M14E.5D%,.PH)"@H]/2!A<F-H+VDS.#8O36%K
M969I;&4@/3T*=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\87)C:"]I
M,S@V+TUA:V5F:6QE?#(P,#(P,C U,3<T,#(P?#$X-S$P?#%B.&%A,68P8S0P
M83%D8F8*86MP;4!D:6=E;RYC;VU;=&]R=F%L9'-=?&%R8V@O:3,X-B]-86ME
M9FEL97PR,# S,#8Q-3 T,3DP-7PR,C4R, I$(#$N-3,@,#,O,#<O,3$@,#DZ
M-#(Z-#0K,#(Z,# @86YD97)S9T P>#8S+FYU("LT("TP"D(@=&]R=F%L9'- 
M871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V
M?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PIC($%D9&5D(%A";W@@1V%M:6YG
M(%-Y<W1E;2!S=6)A<F-H:71E8W1U<F4N"DL@,S(Q-#4*3R M<G<M<G<M<BTM
M"E @87)C:"]I,S@V+TUA:V5F:6QE"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*234U(#0*(R!88F]X('-U8F%R
M8V@@<W5P<&]R= IM9FQA9W,M)"A#3TY&24=?6#@V7UA"3U@I"3H]("U):6YC
M;'5D92]A<VTM:3,X-B]M86-H+7AB;W@*;6-O<F4M)"A#3TY&24=?6#@V7UA"
M3U@I"3H](&UA8V@M>&)O> I<"@H]/2!A<F-H+VDS.#8O8F]O="]C;VUP<F5S
M<V5D+TUA:V5F:6QE(#T]"G1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M
M?&%R8V@O:3,X-B]B;V]T+V-O;7!R97-S960O36%K969I;&5\,C P,C R,#4Q
M-S0P,C!\,30R.#E\965D,C0S8S-F-#5B968V"G-A;4!M87)S+G)A=FYB;W)G
M+F]R9WQA<F-H+VDS.#8O8F]O="]C;VUP<F5S<V5D+TUA:V5F:6QE?#(P,#,P
M,S Y,C$T-S0Q?#4S-#(W"D0@,2XQ-R P,R\P-R\Q,2 P.3HT,CHT-"LP,CHP
M,"!A;F1E<G-G0#!X-C,N;G4@*S4@+3 *0B!T;W)V86QD<T!A=&AL;VXN=')A
M;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\8S%D
M,3%A-#%E9# R-#@V- I#"F,@5&AE<F4@:7,@<V]M92!S=')A;F=E(&EN=&5R
M86-T:6]N('=H96X@<&%G:6YG(&ES(&]F9BP@=&AA="!M86ME<R Q+C$@>&)O
M>&5N"F,@8W)A<V@@=VAI;&4@9&5C;VUP<F5S<VEN9R!K97)N96PN($-O;7!I
M;&EN9R!T:&4@9&5C;VUP<F5S<V]R('=I=&AO=70*8R!O<'1I;6EZ871I;VX@
M=V]R:W,@87)O=6YD('1H:7,@<')O8FQE;2X*2R R,CD*3R M<G<M<G<M<BTM
M"E @87)C:"]I,S@V+V)O;W0O8V]M<')E<W-E9"]-86ME9FEL90HM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDW
M(#4*:69E<2 H)"A#3TY&24=?6#@V7UA"3U@I+'DI"B-86%@@0V]M<&EL:6YG
M('=I=&@@;W!T:6UI>F%T:6]N(&UA:V5S(#$N,2UX8F]X96X@"B,@(" @8W)A
M<V@@=VAI;&4@9&5C;VUP<F5S<VEN9R!T:&4@:V5R;F5L"D-&3$%'4U]M:7-C
M+F\@(" Z/2 M3S *96YD:68*"CT](&EN8VQU9&4O87-M+6DS.#8O=&EM97@N
M:" ]/0IT;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7QI;F-L=61E+V%S
M;2UI,S@V+W1I;65X+FA\,C P,C R,#4Q-S,Y-#1\-C,X-C)\86$U9F0Q868Y
M,69E-3!F-PIV;VIT96-H0'-U<V4N8WI\:6YC;'5D92]A<VTM:3,X-B]T:6UE
M>"YH?#(P,#,P-C Y,3(T,3(S?#4S.3 V"D0@,2XV(# S+S W+S$Q(# Y.C0R
M.C0T*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K-2 M,0I"('1O<G9A;&1S0&%T
M:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ
M-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*8R!4:&4@>&)O>"!H87,@82!D:69F
M97)E;G0@0TQ/0TM?5$E#2U]2051%+@I+(#8P.3@X"D\@+7)W+7)W+7(M+0I0
M(&EN8VQU9&4O87-M+6DS.#8O=&EM97@N: HM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"D0Q." Q"DDQ." U"B,@
M(&EF9&5F($-/3D9)1U]8.#9?6$)/6 HC(" @(&1E9FEN92!#3$]#2U]424-+
M7U)!5$4@,3$R-#DY." O*B!S;R!H87,@=&AE(%AB;W@@*B\*(R @96QS92 *
M(R @("!D969I;F4@0TQ/0TM?5$E#2U]2051%(#$Q.3,Q.# @+RH@56YD97)L
M>6EN9R!(6B J+PHC("!E;F1I9@H*/3T@87)C:"]I,S@V+TMC;VYF:6<@/3T*
M>FEP<&5L0&QI;G5X+6TV.&LN;W)G6W1O<G9A;&1S77QA<F-H+VDS.#8O2V-O
M;F9I9WPR,# R,3 S,# T,S(Q.'PR-#8X.'PV,3(S,3@P86(Y,34W-C!C"F%K
M<&U ;W-D;"YO<F=;=&]R=F%L9'-=?&%R8V@O:3,X-B]+8V]N9FEG?#(P,#,P
M-S S,#4T-S(V?#(S-34W"D0@,2XV-B P,R\P-R\Q,2 P.3HT,CHT-"LP,CHP
M,"!A;F1E<G-G0#!X-C,N;G4@*S$Y("TR"D(@=&]R=F%L9'- 871H;&]N+G1R
M86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q
M9#$Q830Q960P,C0X-C0*0PIC($%D9&5D(&-O;F9I9W5R92!O<'1I;VX@9F]R
M('1H92!80F]X($=A;6EN9R!3>7-T96T@<W5B87)C:&ET96-T=7)E+@I+(#DX
M,C(*3R M<G<M<G<M<BTM"E @87)C:"]I,S@V+TMC;VYF:6<*+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I)-#4@
M,38*8V]N9FEG(%@X-E]80D]8"@EB;V]L(")80F]X($=A;6EN9R!3>7-T96TB
M"@EH96QP"@D@(%1H:7,@;W!T:6]N(&ES(&YE961E9"!T;R!M86ME($QI;G5X
M(&)O;W0@;VX@6$)O>"!'86UI;F<@4WES=&5M<RX*"2 @"@D@(%1H92!80F]X
M(&-A;B!B92!C;VYS:61E<F5D(&%S(&$@<W1A;F1A<F0@4$,@=VET:"!A($-O
M<'!E<FUI;F4M8F%S960@0V5L97)O;B W,S,@34AZ+ H)("!)1$4@:&%R9&1R
M:79E+"!$5D0L($5T:&5R;F5T+"!54T(@86YD(&=R87!H:6-S+B *"2 @"@D@
M(%1O(&)O;W0@=&AE(&ME<FYE;"!Y;W4@;F5E9" B7W)O;7=E;&PB+"!E:71H
M97(@=7-E9"!A<R!A(')E<&QA8V5M96YT($))3U,@*&-R;VUW96QL*0H)("!O
M<B!A<R!A(&)O;W1L;V%D97(N"@D@( H)("!&;W(@;6]R92!I;F9O<FUA=&EO
M;B!S964@:'1T<#HO+WAB;W@M;&EN=7@N<V]U<F-E9F]R9V4N;F5T+R *"2 @
M"@D@($EF('EO=2!D;R!N;W0@<W!E8VEF:6-A;&QY(&YE960@82!K97)N96P@
M9F]R(%A"3U@@;6%C:&EN92P*"2 @<V%Y($X@:&5R92!O=&AE<G=I<V4@=&AE
M(&ME<FYE;"!Y;W4@8G5I;&0@=VEL;"!N;W0@8F4@8F]O=&%B;&4N"EP*230Q
M,2 Q"@ED97!E;F1S(&]N("%8.#9?6$)/6 I$,3$P-R Q"DDQ,3 W(#$*"61E
M<&5N9',@;VX@(2A8.#9?5DE35U,@?'P@6#@V7U9/64%'15(@?'P@6#@V7UA"
M3U@I"D0Q-#$S(#$*23$T,3,@,0H)9&5P96YD<R!O;B A*%@X-E]625-74R!\
M?"!8.#9?5D]904=%4B!\?"!8.#9?6$)/6"D*"B,@4&%T8V@@8VAE8VMS=6T]
)939E-SAD8V8*
 
