Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269617AbTGJRVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269598AbTGJRUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:20:41 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:16295 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S266395AbTGJRNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:13:36 -0400
Date: Thu, 10 Jul 2003 19:28:02 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add xbox subarchitecture
Message-ID: <20030710172802.GB27744@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19afD8-0002m0-00*2QXqOb5JrOo*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please apply the following patch that adds the xbox subarchitecture.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet
  1.1380 03/07/10 18:06:17 andersg@0x63.nu +10 -0
  Added configure option for the XBox Gaming System subarchitecture.

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.1 03/07/10 18:05:50 andersg@0x63.nu +6 -0

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.0 03/07/10 18:05:50 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-xbox/mach_pci_blacklist.h

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.1 03/07/10 18:05:49 andersg@0x63.nu +6 -0

  arch/i386/mach-xbox/setup.c
    1.1 03/07/10 18:05:49 andersg@0x63.nu +79 -0

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.0 03/07/10 18:05:49 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-default/mach_pci_blacklist.h

  arch/i386/mach-xbox/setup.c
    1.0 03/07/10 18:05:49 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/setup.c

  arch/i386/mach-xbox/reboot.c
    1.1 03/07/10 18:05:48 andersg@0x63.nu +51 -0

  arch/i386/mach-xbox/reboot.c
    1.0 03/07/10 18:05:48 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/reboot.c

  arch/i386/mach-xbox/Makefile
    1.1 03/07/10 18:05:44 andersg@0x63.nu +5 -0

  include/asm-i386/timex.h
    1.6 03/07/10 18:05:44 andersg@0x63.nu +5 -1
    The xbox has a different CLOCK_TICK_RATE.

  arch/i386/pci/direct.c
    1.19 03/07/10 18:05:44 andersg@0x63.nu +4 -0
    Added a mach-hook for blacklisting pci-devices.
        The xbox uses this to prevent it from touching some devices that makes it ha
    ng solid.

  arch/i386/mach-xbox/Makefile
    1.0 03/07/10 18:05:44 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/Makefile

  arch/i386/boot/compressed/Makefile
    1.17 03/07/10 18:05:44 andersg@0x63.nu +5 -0
    There is some strange interaction when paging is off, that makes 1.1 xboxen
    crash while decompressing kernel. Compiling the decompressor without
    optimization works around this problem.

  arch/i386/Makefile
    1.53 03/07/10 18:05:44 andersg@0x63.nu +4 -0
    Added XBox Gaming System subarchitecture.

  arch/i386/Kconfig
    1.66 03/07/10 18:05:44 andersg@0x63.nu +19 -2
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
--- a/arch/i386/Kconfig	Thu Jul 10 18:07:08 2003
+++ b/arch/i386/Kconfig	Thu Jul 10 18:07:08 2003
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
--- a/arch/i386/Makefile	Thu Jul 10 18:07:08 2003
+++ b/arch/i386/Makefile	Thu Jul 10 18:07:08 2003
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
--- a/arch/i386/boot/compressed/Makefile	Thu Jul 10 18:07:08 2003
+++ b/arch/i386/boot/compressed/Makefile	Thu Jul 10 18:07:08 2003
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
+++ b/arch/i386/mach-xbox/Makefile	Thu Jul 10 18:07:08 2003
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= setup.o reboot.o
diff -Nru a/arch/i386/mach-xbox/reboot.c b/arch/i386/mach-xbox/reboot.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/reboot.c	Thu Jul 10 18:07:08 2003
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
+++ b/arch/i386/mach-xbox/setup.c	Thu Jul 10 18:07:08 2003
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
--- a/arch/i386/pci/direct.c	Thu Jul 10 18:07:08 2003
+++ b/arch/i386/pci/direct.c	Thu Jul 10 18:07:08 2003
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
+++ b/include/asm-i386/mach-default/mach_pci_blacklist.h	Thu Jul 10 18:07:08 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) 0
+
+#endif
diff -Nru a/include/asm-i386/mach-xbox/mach_pci_blacklist.h b/include/asm-i386/mach-xbox/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-xbox/mach_pci_blacklist.h	Thu Jul 10 18:07:08 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) ( (bus>1) || (bus&&(dev||fn)) || ((bus==0 && dev==0) && ((fn==1)||(fn==2))) )
+
+#endif
diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Thu Jul 10 18:07:08 2003
+++ b/include/asm-i386/timex.h	Thu Jul 10 18:07:08 2003
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
1.1380
## Wrapped with uu ##


M(R!5<V5R.@EA;F1E<G-G"B,@2&]S=#H),'@V,RYN=0HC(%)O;W0Z"2]D871A
M+V1E=B]K97)N96PO8FLO>&)O>"TR+C4*"B,@4&%T8V@@=F5R<SH),2XS"B,@
M4&%T8V@@='EP93H)4D5'54Q!4@H*/3T@0VAA;F=E4V5T(#T]"G1O<G9A;&1S
M0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U
M-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"G1O<G9A;&1S0&AO;64N;W-D;"YO
M<F=\0VAA;F=E4V5T?#(P,#,P-S$P,#0U.# P?#0P-C(W"D0@,2XQ,S@P(# S
M+S W+S$P(#$X.C V.C$W*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K,3 @+3 *
M0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P
M,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A-#%E9# R-#@V- I#"F,@061D960@
M8V]N9FEG=7)E(&]P=&EO;B!F;W(@=&AE(%A";W@@1V%M:6YG(%-Y<W1E;2!S
M=6)A<F-H:71E8W1U<F4N"DL@,S<X,C0*4"!#:&%N9V53970*+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@HP83 *
M/B!A;F1E<G-G0#!X-C,N;G5\:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O
M;6%C:%]P8VE?8FQA8VML:7-T+FA\,C P,S W,3 Q-C U-3!\,S(W-S1\83AD
M9&$V8C-C,C<V,F4W,B!A;F1E<G-G0#!X-C,N;G5\:6YC;'5D92]A<VTM:3,X
M-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+FA\,C P,S W,3 Q-C U
M-3%\,34U,3$*/B!A;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O
M>"]-86ME9FEL97PR,# S,#<Q,#$V,#4T-'PQ,3 R,'PU.3$P.60Q8S-C,3,V
M-&1B(&%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F
M:6QE?#(P,#,P-S$P,38P-30U?# U,C,T"CX@=&]R=F%L9'- 871H;&]N+G1R
M86YS;65T82YC;VU\87)C:"]I,S@V+V)O;W0O8V]M<')E<W-E9"]-86ME9FEL
M97PR,# R,#(P-3$W-# R,'PQ-#(X.7QE960R-#-C,V8T-6)E9C8@86YD97)S
M9T P>#8S+FYU?&%R8V@O:3,X-B]B;V]T+V-O;7!R97-S960O36%K969I;&5\
M,C P,S W,3 Q-C U-#1\,# R,CD*/B!T;W)V86QD<T!A=&AL;VXN=')A;G-M
M971A+F-O;7QA<F-H+VDS.#8O36%K969I;&5\,C P,C R,#4Q-S0P,C!\,3@W
M,3!\,6(X86$Q9C!C-#!A,61B9B!A;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V
M+TUA:V5F:6QE?#(P,#,P-S$P,38P-30T?#,R,30U"CX@86YD97)S9T P>#8S
M+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8WPR,# S,#<Q,#$V,#4T
M.7PP-S U,GPR939C9#@W,C,X8V-D93 Y(&%N9&5R<V= ,'@V,RYN=7QA<F-H
M+VDS.#8O;6%C:"UX8F]X+W-E='5P+F-\,C P,S W,3 Q-C U-3!\,S4V-#@*
M/B!Z:7!P96Q ;&EN=7@M;38X:RYO<F=;=&]R=F%L9'-=?&%R8V@O:3,X-B]+
M8V]N9FEG?#(P,#(Q,#,P,#0S,C$X?#(T-C@X?#8Q,C,Q.#!A8CDQ-3<V,&,@
M86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]+8V]N9FEG?#(P,#,P-S$P,38P
M-30T?# Y.#(R"CX@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\:6YC
M;'5D92]A<VTM:3,X-B]T:6UE>"YH?#(P,#(P,C U,3<S.30T?#8S.#8R?&%A
M-69D,6%F.3%F934P9C<@86YD97)S9T P>#8S+FYU?&EN8VQU9&4O87-M+6DS
M.#8O=&EM97@N:'PR,# S,#<Q,#$V,#4T-'PV,#DX. H^(&%N9&5R<V= ,'@V
M,RYN=7QA<F-H+VDS.#8O;6%C:"UX8F]X+W)E8F]O="YC?#(P,#,P-S$P,38P
M-30X?#0S,C8S?&,Y8V8Y9&9D,3@Q,V-B8SD@86YD97)S9T P>#8S+FYU?&%R
M8V@O:3,X-B]M86-H+7AB;W@O<F5B;V]T+F-\,C P,S W,3 Q-C U-#E\,S(Y
M,SD*/B!M;V-H96Q <V5G9F%U;'0N;W-D;"YO<F=\87)C:"]I,S@V+VME<FYE
M;"]P8VDO9&ER96-T+F-\,C P,C T,38Q-3 X,S!\-#0W,S)\,S@W8S4W9# Y
M,&%D-#@X."!A;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+W!C:2]D:7)E8W0N
M8WPR,# S,#<Q,#$V,#4T-'PV,38V-PH^(&%N9&5R<V= ,'@V,RYN=7QI;F-L
M=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N
M:'PR,# S,#<Q,#$V,#4T.7PP-#DR,GQE83$T-S!D,SDT93(U,SDQ(&%N9&5R
M<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H
M7W!C:5]B;&%C:VQI<W0N:'PR,# S,#<Q,#$V,#4U,'PQ,#(S,@H*/3T@87)C
M:"]I,S@V+VUA8V@M>&)O>"]-86ME9FEL92 ]/0I.97<@9FEL93H@87)C:"]I
M,S@V+VUA8V@M>&)O>"]-86ME9FEL90I6(#0*"F%N9&5R<V= ,'@V,RYN=7QA
M<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE?#(P,#,P-S$P,38P-30T?#$Q
M,#(P?#4Y,3 Y9#%C,V,Q,S8T9&(*1" Q+C @,#,O,#<O,3 @,3@Z,#4Z-#0K
M,#(Z,# @86YD97)S9T P>#8S+FYU("LP("TP"D(@=&]R=F%L9'- 871H;&]N
M+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W
M?&,Q9#$Q830Q960P,C0X-C0*8R!":71+965P97(@9FEL92 O9&%T82]D978O
M:V5R;F5L+V)K+WAB;W@M,BXU+V%R8V@O:3,X-B]M86-H+7AB;W@O36%K969I
M;&4*2R Q,3 R, I0(&%R8V@O:3,X-B]M86-H+7AB;W@O36%K969I;&4*4B U
M.3$P.60Q8S-C,3,V-&1B"E@@,'@X,C$*+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@H*86YD97)S9T P>#8S+FYU
M?&%R8V@O:3,X-B]M86-H+7AB;W@O36%K969I;&5\,C P,S W,3 Q-C U-#1\
M,3$P,C!\-3DQ,#ED,6,S8S$S-C1D8@I$(#$N,2 P,R\P-R\Q," Q.#HP-3HT
M-"LP,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S4@+3 *0B!T;W)V86QD<T!A=&AL
M;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P
M-#=\8S%D,3%A-#%E9# R-#@V- I#"D8@,0I+(#4R,S0*3R M<G<M<G<M<BTM
M"E @87)C:"]I,S@V+VUA8V@M>&)O>"]-86ME9FEL90HM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDP(#4*(PHC
M($UA:V5F:6QE(&9O<B!T:&4@;&EN=7@@:V5R;F5L+@HC"EP*;V)J+7D)"0D)
M.CT@<V5T=7 N;R!R96)O;W0N;PH*/3T@87)C:"]I,S@V+VUA8V@M>&)O>"]R
M96)O;W0N8R ]/0I.97<@9FEL93H@87)C:"]I,S@V+VUA8V@M>&)O>"]R96)O
M;W0N8PI6(#0*"F%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C:"UX8F]X
M+W)E8F]O="YC?#(P,#,P-S$P,38P-30X?#0S,C8S?&,Y8V8Y9&9D,3@Q,V-B
M8SD*1" Q+C @,#,O,#<O,3 @,3@Z,#4Z-#@K,#(Z,# @86YD97)S9T P>#8S
M+FYU("LP("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA
M;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*
M8R!":71+965P97(@9FEL92 O9&%T82]D978O:V5R;F5L+V)K+WAB;W@M,BXU
M+V%R8V@O:3,X-B]M86-H+7AB;W@O<F5B;V]T+F,*2R T,S(V,PI0(&%R8V@O
M:3,X-B]M86-H+7AB;W@O<F5B;V]T+F,*4B!C.6-F.61F9#$X,3-C8F,Y"E@@
M,'@X,C$*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM"@H*86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB
M;W@O<F5B;V]T+F-\,C P,S W,3 Q-C U-#A\-#,R-C-\8SEC9CED9F0Q.#$S
M8V)C.0I$(#$N,2 P,R\P-R\Q," Q.#HP-3HT."LP,CHP,"!A;F1E<G-G0#!X
M-C,N;G4@*S4Q("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\
M0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X
M-C0*0PI&(#$*2R S,CDS.0I/("UR=RUR=RUR+2T*4"!A<F-H+VDS.#8O;6%C
M:"UX8F]X+W)E8F]O="YC"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+0H*23 @-3$*+RH*("H@87)C:"]I,S@V+VUA
M8V@M>&)O>"]R96)O;W0N8R *("H@3VQI=FEE<B!&875C:&]N(#QO;&EV:65R
M+F9A=6-H;VY 9G)E92YF<CX*("H@06YD97)S($=U<W1A9G-S;VX@/&%N9&5R
M<V= ,'@V,RYN=3X*("H*("HO"EP*(VEN8VQU9&4@/&%S;2]I;RYH/@I<"B\J
M('=E(&1O;B=T('5S92!A;GD@;V8@=&AO<V4L(&)U="!D;6E?<V-A;BYC(&YE
M961S("=E;2 J+PIV;VED("@J<&U?<&]W97)?;V9F*2AV;VED*3L*:6YT(')E
M8F]O=%]T:')U7V)I;W,["EP*(V1E9FEN92!80D]87U--0E])3U]"05-%(#!X
M0S P, HC9&5F:6YE(%A"3UA?4TU"7TA/4U1?041$4D534R @(" @(" H,'@T
M("L@6$)/6%]334)?24]?0D%312D*(V1E9FEN92!80D]87U--0E](3U-47T-/
M34U!3D0@(" @(" @*#!X." K(%A"3UA?4TU"7TE/7T)!4T4I"B-D969I;F4@
M6$)/6%]334)?2$]35%]$051!(" @(" @(" @("@P>#8@*R!80D]87U--0E])
M3U]"05-%*0HC9&5F:6YE(%A"3UA?4TU"7T=,3T)!3%]%3D%"3$4@(" @(" H
M,'@R("L@6$)/6%]334)?24]?0D%312D*7 HC9&5F:6YE(%A"3UA?4$E#7T%$
M1%)%4U,@,'@Q, I<"B-D969I;F4@4TU#7T--1%]03U=%4B P># R"B-D969I
M;F4@4TU#7U-50D--1%]03U=%4E]215-%5" P># Q"B-D969I;F4@4TU#7U-5
M0D--1%]03U=%4E]#64-,12 P>#0P"B-D969I;F4@4TU#7U-50D--1%]03U=%
M4E]/1D8@,'@X, I<"EP*<W1A=&EC('9O:60@>&)O>%]P:6-?8VUD*'4X(&-O
M;6UA;F0I"GL*"6]U='=?<"@H*%A"3UA?4$E#7T%$1%)%4U,I(#P\(#$I+%A"
M3UA?4TU"7TA/4U1?041$4D534RD["@EO=71B7W H4TU#7T--1%]03U=%4BP@
M6$)/6%]334)?2$]35%]#3TU-04Y$*3L*"6]U='=?<"AC;VUM86YD+"!80D]8
M7U--0E](3U-47T1!5$$I.PH);W5T=U]P*&EN=RA80D]87U--0E])3U]"05-%
M*2Q80D]87U--0E])3U]"05-%*3L*"6]U=&)?<"@P>#!A+%A"3UA?4TU"7T=,
M3T)!3%]%3D%"3$4I.PI]"EP*=F]I9"!M86-H:6YE7W)E<W1A<G0H8VAA<B J
M(%]?=6YU<V5D*0I["@EP<FEN=&LH2T523E])3D9/(")396YD:6YG(%!/5T52
M7U)%4T54('1O(%A"3U@M4$E#+EQN(BD["@EX8F]X7W!I8U]C;60H4TU#7U-5
M0D--1%]03U=%4E]215-%5"D[(" *?0I<"G9O:60@;6%C:&EN95]P;W=E<E]O
M9F8H=F]I9"D*>PH)<')I;G1K*$M%4DY?24Y&3R B4V5N9&EN9R!03U=%4E]/
M1D8@=&\@6$)/6"U024,N7&XB*3L*"7AB;WA?<&EC7V-M9"A334-?4U5"0TU$
M7U!/5T527T]&1BD[(" *?0I<"G9O:60@;6%C:&EN95]H86QT*'9O:60I"GL*
M?0H*/3T@87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC(#T]"DYE=R!F:6QE
M.B!A<F-H+VDS.#8O;6%C:"UX8F]X+W-E='5P+F,*5B T"@IA;F1E<G-G0#!X
M-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC?#(P,#,P-S$P,38P
M-30Y?# W,#4R?#)E-F-D.#<R,SAC8V1E,#D*1" Q+C @,#,O,#<O,3 @,3@Z
M,#4Z-#DK,#(Z,# @86YD97)S9T P>#8S+FYU("LP("TP"D(@=&]R=F%L9'- 
M871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V
M?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*8R!":71+965P97(@9FEL92 O9&%T
M82]D978O:V5R;F5L+V)K+WAB;W@M,BXU+V%R8V@O:3,X-B]M86-H+7AB;W@O
M<V5T=7 N8PI+(#<P-3(*4"!A<F-H+VDS.#8O;6%C:"UX8F]X+W-E='5P+F,*
M4B R939C9#@W,C,X8V-D93 Y"E@@,'@X,C$*+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@H*86YD97)S9T P>#8S
M+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8WPR,# S,#<Q,#$V,#4T
M.7PP-S U,GPR939C9#@W,C,X8V-D93 Y"D0@,2XQ(# S+S W+S$P(#$X.C U
M.C0Y*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K-SD@+3 *0B!T;W)V86QD<T!A
M=&AL;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\
M,38P-#=\8S%D,3%A-#%E9# R-#@V- I#"D8@,0I+(#,U-C0X"D\@+7)W+7)W
M+7(M+0I0(&%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8PHM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDP(#<Y
M"B\J"B J"4UA8VAI;F4@<W!E8VEF:6,@<V5T=7 @9F]R('AB;W@*("HO"EP*
M(VEN8VQU9&4@/&QI;G5X+V-O;F9I9RYH/@HC:6YC;'5D92 \;&EN=7@O<VUP
M+F@^"B-I;F-L=61E(#QL:6YU>"]I;FET+F@^"B-I;F-L=61E(#QL:6YU>"]I
M<G$N:#X*(VEN8VQU9&4@/&QI;G5X+VEN=&5R<G5P="YH/@HC:6YC;'5D92 \
M87-M+V%R8VA?:&]O:W,N:#X*7 HO*BH*("H@<')E7VEN=')?:6YI=%]H;V]K
M("T@:6YI=&EA;&ES871I;VX@<')I;W(@=&\@<V5T=&EN9R!U<"!I;G1E<G)U
M<'0@=F5C=&]R<PH@*@H@*B!$97-C<FEP=&EO;CH*("H)4&5R9F]R;2!A;GD@
M;F5C97-S87)Y(&EN=&5R<G5P="!I;FET:6%L:7-A=&EO;B!P<FEO<B!T;R!S
M971T:6YG('5P"B J"71H92 B;W)D:6YA<GDB(&EN=&5R<G5P="!C86QL(&=A
M=&5S+B @1F]R(&QE9V%C>2!R96%S;VYS+"!T:&4@25-!"B J"6EN=&5R<G5P
M=',@<VAO=6QD(&)E(&EN:71I86QI<V5D(&AE<F4@:68@=&AE(&UA8VAI;F4@
M96UU;&%T97,@82!00PH@*@EI;B!A;GD@=V%Y+@H@*BHO"G9O:60@7U]I;FET
M('!R95]I;G1R7VEN:71?:&]O:RAV;VED*0I["@EI;FET7TE305]I<G%S*"D[
M"GT*7 HO*BH*("H@:6YT<E]I;FET7VAO;VL@+2!P;W-T(&=A=&4@<V5T=7 @
M:6YT97)R=7!T(&EN:71I86QI<V%T:6]N"B J"B J($1E<V-R:7!T:6]N.@H@
M*@E&:6QL(&EN(&%N>2!I;G1E<G)U<'1S('1H870@;6%Y(&AA=F4@8F5E;B!L
M969T(&]U="!B>2!T:&4@9V5N97)A; H@*@EI;FET7TE242@I(')O=71I;F4N
M("!I;G1E<G)U<'1S(&AA=FEN9R!T;R!D;R!W:71H('1H92!M86-H:6YE(')A
M=&AE<@H@*@ET:&%N('1H92!D979I8V5S(&]N('1H92!)+T\@8G5S("AL:6ME
M($%024,@:6YT97)R=7!T<R!I;B!I;G1E;"!-4 H@*@ES>7-T96US*2!A<F4@
M<W1A<G1E9"!H97)E+@H@*BHO"G9O:60@7U]I;FET(&EN=')?:6YI=%]H;V]K
M*'9O:60I"GL*(VEF9&5F($-/3D9)1U]8.#9?3$]#04Q?05!)0PH)87!I8U]I
M;G1R7VEN:70H*3L*(V5N9&EF"EP*?0I<"B\J*@H@*B!P<F5?<V5T=7!?87)C
M:%]H;V]K("T@:&]O:R!C86QL960@<')I;W(@=&\@86YY('-E='5P7V%R8V@H
M*2!E>&5C=71I;VX*("H*("H@1&5S8W)I<'1I;VXZ"B J"6=E;F5R86QL>2!U
M<V5D('1O(&%C=&EV871E(&%N>2!M86-H:6YE('-P96-I9FEC(&ED96YT:69I
M8V%T:6]N"B J"7)O=71I;F5S('1H870@;6%Y(&)E(&YE961E9"!B969O<F4@
M<V5T=7!?87)C:"@I(')U;G,N("!/;B!625-74PH@*@ET:&ES(&ES('5S960@
M=&\@9V5T('1H92!B;V%R9"!R979I<VEO;B!A;F0@='EP92X*("HJ+PIV;VED
M(%]?:6YI="!P<F5?<V5T=7!?87)C:%]H;V]K*'9O:60I"GL*?0I<"B\J*@H@
M*B!T<F%P7VEN:71?:&]O:R M(&EN:71I86QI<V4@<WES=&5M('-P96-I9FEC
M('1R87!S"B J"B J($1E<V-R:7!T:6]N.@H@*@E#86QL960@87,@=&AE(&9I
M;F%L(&%C="!O9B!T<F%P7VEN:70H*2X@(%5S960@:6X@5DE35U,@=&\@:6YI
M=&EA;&ES90H@*@ET:&4@=F%R:6]U<R!B;V%R9"!S<&5C:69I8R!!4$E#('1R
M87!S+@H@*BHO"G9O:60@7U]I;FET('1R87!?:6YI=%]H;V]K*'9O:60I"GL*
M?0I<"G-T871I8R!S=')U8W0@:7)Q86-T:6]N(&ER<3 @(#T@>R!T:6UE<E]I
M;G1E<G)U<'0L(%-!7TE.5$524E505"P@,"P@(G1I;65R(BP@3E5,3"P@3E5,
M3'T["EP*+RHJ"B J('1I;65?:6YI=%]H;V]K("T@9&\@86YY('-P96-I9FEC
M(&EN:71I86QI<V%T:6]N<R!F;W(@=&AE('-Y<W1E;2!T:6UE<BX*("H*("H@
M1&5S8W)I<'1I;VXZ"B J"4UU<W0@<&QU9R!T:&4@<WES=&5M('1I;65R(&EN
M=&5R<G5P="!S;W5R8V4@870@2%H@:6YT;R!T:&4@25)1(&QI<W1E9 H@*@EI
M;B!I<G%?=F5C=&]R<RYH.E1)34527TE240H@*BHO"G9O:60@7U]I;FET('1I
M;65?:6YI=%]H;V]K*'9O:60I"GL*"7-E='5P7VER<2@P+" F:7)Q,"D["GT*
M7 H*/3T@:6YC;'5D92]A<VTM:3,X-B]M86-H+61E9F%U;'0O;6%C:%]P8VE?
M8FQA8VML:7-T+F@@/3T*3F5W(&9I;&4Z(&EN8VQU9&4O87-M+6DS.#8O;6%C
M:"UD969A=6QT+VUA8VA?<&-I7V)L86-K;&ES="YH"E8@- H*86YD97)S9T P
M>#8S+FYU?&EN8VQU9&4O87-M+6DS.#8O;6%C:"UD969A=6QT+VUA8VA?<&-I
M7V)L86-K;&ES="YH?#(P,#,P-S$P,38P-30Y?# T.3(R?&5A,30W,&0S.31E
M,C4S.3$*1" Q+C @,#,O,#<O,3 @,3@Z,#4Z-#DK,#(Z,# @86YD97)S9T P
M>#8S+FYU("LP("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\
M0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X
M-C0*8R!":71+965P97(@9FEL92 O9&%T82]D978O:V5R;F5L+V)K+WAB;W@M
M,BXU+VEN8VQU9&4O87-M+6DS.#8O;6%C:"UD969A=6QT+VUA8VA?<&-I7V)L
M86-K;&ES="YH"DL@-#DR,@I0(&EN8VQU9&4O87-M+6DS.#8O;6%C:"UD969A
M=6QT+VUA8VA?<&-I7V)L86-K;&ES="YH"E(@96$Q-#<P9#,Y-&4R-3,Y,0I8
M(#!X.#(Q"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+0H*"F%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI,S@V
M+VUA8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#<Q,#$V
M,#4T.7PP-#DR,GQE83$T-S!D,SDT93(U,SDQ"D0@,2XQ(# S+S W+S$P(#$X
M.C U.C0Y*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K-B M, I"('1O<G9A;&1S
M0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U
M-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*1B Q"DL@,3 R,S(*3R M<G<M
M<G<M<BTM"E @:6YC;'5D92]A<VTM:3,X-B]M86-H+61E9F%U;'0O;6%C:%]P
M8VE?8FQA8VML:7-T+F@*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM"@I)," V"B-I9FYD968@7U]!4TU?34%#2%]0
M0TE?0DQ!0TM,25-47T@*(V1E9FEN92!?7T%335]-04-(7U!#25]"3$%#2TQ)
M4U1?2 I<"B-D969I;F4@;6%C:%]P8VE?:7-?8FQA8VML:7-T960H8G5S+&1E
M=BQF;BD@, I<"B-E;F1I9@H*/3T@:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB
M;W@O;6%C:%]P8VE?8FQA8VML:7-T+F@@/3T*3F5W(&9I;&4Z(&EN8VQU9&4O
M87-M+6DS.#8O;6%C:"UX8F]X+VUA8VA?<&-I7V)L86-K;&ES="YH"E8@- H*
M86YD97)S9T P>#8S+FYU?&EN8VQU9&4O87-M+6DS.#8O;6%C:"UX8F]X+VUA
M8VA?<&-I7V)L86-K;&ES="YH?#(P,#,P-S$P,38P-34P?#,R-S<T?&$X9&1A
M-F(S8S(W-C)E-S(*1" Q+C @,#,O,#<O,3 @,3@Z,#4Z-3 K,#(Z,# @86YD
M97)S9T P>#8S+FYU("LP("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T
M82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q
M960P,C0X-C0*8R!":71+965P97(@9FEL92 O9&%T82]D978O:V5R;F5L+V)K
M+WAB;W@M,BXU+VEN8VQU9&4O87-M+6DS.#8O;6%C:"UX8F]X+VUA8VA?<&-I
M7V)L86-K;&ES="YH"DL@,S(W-S0*4"!I;F-L=61E+V%S;2UI,S@V+VUA8V@M
M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N: I2(&$X9&1A-F(S8S(W-C)E-S(*
M6" P>#@R,0HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2T*"@IA;F1E<G-G0#!X-C,N;G5\:6YC;'5D92]A<VTM:3,X
M-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+FA\,C P,S W,3 Q-C U
M-3!\,S(W-S1\83AD9&$V8C-C,C<V,F4W,@I$(#$N,2 P,R\P-R\Q," Q.#HP
M-3HU,"LP,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S8@+3 *0B!T;W)V86QD<T!A
M=&AL;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\
M,38P-#=\8S%D,3%A-#%E9# R-#@V- I#"D8@,0I+(#$U-3$Q"D\@+7)W+7)W
M+7(M+0I0(&EN8VQU9&4O87-M+6DS.#8O;6%C:"UX8F]X+VUA8VA?<&-I7V)L
M86-K;&ES="YH"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+0H*23 @-@HC:69N9&5F(%]?05--7TU!0TA?4$-)7T),
M04-+3$E35%]("B-D969I;F4@7U]!4TU?34%#2%]00TE?0DQ!0TM,25-47T@*
M7 HC9&5F:6YE(&UA8VA?<&-I7VES7V)L86-K;&ES=&5D*&)U<RQD978L9FXI
M("@@*&)U<SXQ*2!\?" H8G5S)B8H9&5V?'QF;BDI('Q\("@H8G5S/3TP("8F
M(&1E=CT],"D@)B8@*"AF;CT],2E\?"AF;CT],BDI*2 I"EP*(V5N9&EF"@H]
M/2!A<F-H+VDS.#8O<&-I+V1I<F5C="YC(#T]"FUO8VAE;$!S96=F875L="YO
M<V1L+F]R9WQA<F-H+VDS.#8O:V5R;F5L+W!C:2]D:7)E8W0N8WPR,# R,#0Q
M-C$U,#@S,'PT-#<S,GPS.#=C-3=D,#DP860T.#@X"G=I;&QY0&1E8FEA;BYO
M<F=;9W)E9UU\87)C:"]I,S@V+W!C:2]D:7)E8W0N8WPR,# S,#<P,S(R-3 T
M-WPU,3<V- I$(#$N,3D@,#,O,#<O,3 @,3@Z,#4Z-#0K,#(Z,# @86YD97)S
M9T P>#8S+FYU("LT("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC
M;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P
M,C0X-C0*0PIC($%D9&5D(&$@;6%C:"UH;V]K(&9O<B!B;&%C:VQI<W1I;F<@
M<&-I+61E=FEC97,N"F,@(" @(%1H92!X8F]X('5S97,@=&AI<R!T;R!P<F5V
M96YT(&ET(&9R;VT@=&]U8VAI;F<@<V]M92!D979I8V5S('1H870@;6%K97,@
M:70@:&$*8R!N9R!S;VQI9"X*2R V,38V-PI/("UR=RUR=RUR+2T*4"!A<F-H
M+VDS.#8O<&-I+V1I<F5C="YC"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*238@,0HC:6YC;'5D92 B;6%C:%]P
M8VE?8FQA8VML:7-T+F@B"DDR,B S"@EI9B H;6%C:%]P8VE?:7-?8FQA8VML
M:7-T960H8G5S+%!#25]33$]4*&1E=F9N*2Q00TE?1E5.0RAD979F;BDI*0H)
M"7)E='5R;B M14E.5D%,.PH)"@H]/2!A<F-H+VDS.#8O36%K969I;&4@/3T*
M=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\87)C:"]I,S@V+TUA:V5F
M:6QE?#(P,#(P,C U,3<T,#(P?#$X-S$P?#%B.&%A,68P8S0P83%D8F8*86MP
M;4!D:6=E;RYC;VU;=&]R=F%L9'-=?&%R8V@O:3,X-B]-86ME9FEL97PR,# S
M,#8Q-3 T,3DP-7PR,C4R, I$(#$N-3,@,#,O,#<O,3 @,3@Z,#4Z-#0K,#(Z
M,# @86YD97)S9T P>#8S+FYU("LT("TP"D(@=&]R=F%L9'- 871H;&]N+G1R
M86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q
M9#$Q830Q960P,C0X-C0*0PIC($%D9&5D(%A";W@@1V%M:6YG(%-Y<W1E;2!S
M=6)A<F-H:71E8W1U<F4N"DL@,S(Q-#4*3R M<G<M<G<M<BTM"E @87)C:"]I
M,S@V+TUA:V5F:6QE"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+0H*234U(#0*(R!88F]X('-U8F%R8V@@<W5P<&]R
M= IM9FQA9W,M)"A#3TY&24=?6#@V7UA"3U@I"3H]("U):6YC;'5D92]A<VTM
M:3,X-B]M86-H+7AB;W@*;6-O<F4M)"A#3TY&24=?6#@V7UA"3U@I"3H](&UA
M8V@M>&)O> I<"@H]/2!A<F-H+VDS.#8O8F]O="]C;VUP<F5S<V5D+TUA:V5F
M:6QE(#T]"G1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?&%R8V@O:3,X
M-B]B;V]T+V-O;7!R97-S960O36%K969I;&5\,C P,C R,#4Q-S0P,C!\,30R
M.#E\965D,C0S8S-F-#5B968V"G-A;4!M87)S+G)A=FYB;W)G+F]R9WQA<F-H
M+VDS.#8O8F]O="]C;VUP<F5S<V5D+TUA:V5F:6QE?#(P,#,P,S Y,C$T-S0Q
M?#4S-#(W"D0@,2XQ-R P,R\P-R\Q," Q.#HP-3HT-"LP,CHP,"!A;F1E<G-G
M0#!X-C,N;G4@*S4@+3 *0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O
M;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A-#%E9# R
M-#@V- I#"F,@5&AE<F4@:7,@<V]M92!S=')A;F=E(&EN=&5R86-T:6]N('=H
M96X@<&%G:6YG(&ES(&]F9BP@=&AA="!M86ME<R Q+C$@>&)O>&5N"F,@8W)A
M<V@@=VAI;&4@9&5C;VUP<F5S<VEN9R!K97)N96PN($-O;7!I;&EN9R!T:&4@
M9&5C;VUP<F5S<V]R('=I=&AO=70*8R!O<'1I;6EZ871I;VX@=V]R:W,@87)O
M=6YD('1H:7,@<')O8FQE;2X*2R R,CD*3R M<G<M<G<M<BTM"E @87)C:"]I
M,S@V+V)O;W0O8V]M<')E<W-E9"]-86ME9FEL90HM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDW(#4*:69E<2 H
M)"A#3TY&24=?6#@V7UA"3U@I+'DI"B-86%@@0V]M<&EL:6YG('=I=&@@;W!T
M:6UI>F%T:6]N(&UA:V5S(#$N,2UX8F]X96X@"B,@(" @8W)A<V@@=VAI;&4@
M9&5C;VUP<F5S<VEN9R!T:&4@:V5R;F5L"D-&3$%'4U]M:7-C+F\@(" Z/2 M
M3S *96YD:68*"CT](&EN8VQU9&4O87-M+6DS.#8O=&EM97@N:" ]/0IT;W)V
M86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7QI;F-L=61E+V%S;2UI,S@V+W1I
M;65X+FA\,C P,C R,#4Q-S,Y-#1\-C,X-C)\86$U9F0Q868Y,69E-3!F-PIV
M;VIT96-H0'-U<V4N8WI\:6YC;'5D92]A<VTM:3,X-B]T:6UE>"YH?#(P,#,P
M-C Y,3(T,3(S?#4S.3 V"D0@,2XV(# S+S W+S$P(#$X.C U.C0T*S R.C P
M(&%N9&5R<V= ,'@V,RYN=2 K-2 M,0I"('1O<G9A;&1S0&%T:&QO;BYT<F%N
M<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q
M,6$T,65D,#(T.#8T"D,*8R!4:&4@>&)O>"!H87,@82!D:69F97)E;G0@0TQ/
M0TM?5$E#2U]2051%+@I+(#8P.3@X"D\@+7)W+7)W+7(M+0I0(&EN8VQU9&4O
M87-M+6DS.#8O=&EM97@N: HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2T*"D0Q." Q"DDQ." U"B,@(&EF9&5F($-/
M3D9)1U]8.#9?6$)/6 HC(" @(&1E9FEN92!#3$]#2U]424-+7U)!5$4@,3$R
M-#DY." O*B!S;R!H87,@=&AE(%AB;W@@*B\*(R @96QS92 *(R @("!D969I
M;F4@0TQ/0TM?5$E#2U]2051%(#$Q.3,Q.# @+RH@56YD97)L>6EN9R!(6B J
M+PHC("!E;F1I9@H*/3T@87)C:"]I,S@V+TMC;VYF:6<@/3T*>FEP<&5L0&QI
M;G5X+6TV.&LN;W)G6W1O<G9A;&1S77QA<F-H+VDS.#8O2V-O;F9I9WPR,# R
M,3 S,# T,S(Q.'PR-#8X.'PV,3(S,3@P86(Y,34W-C!C"F%K<&U ;W-D;"YO
M<F=;=&]R=F%L9'-=?&%R8V@O:3,X-B]+8V]N9FEG?#(P,#,P-S S,#4T-S(V
M?#(S-34W"D0@,2XV-B P,R\P-R\Q," Q.#HP-3HT-"LP,CHP,"!A;F1E<G-G
M0#!X-C,N;G4@*S$Y("TR"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC
M;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P
M,C0X-C0*0PIC($%D9&5D(&-O;F9I9W5R92!O<'1I;VX@9F]R('1H92!80F]X
M($=A;6EN9R!3>7-T96T@<W5B87)C:&ET96-T=7)E+@I+(#DX,C(*3R M<G<M
M<G<M<BTM"E @87)C:"]I,S@V+TMC;VYF:6<*+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I)-#4@,38*8V]N9FEG
M(%@X-E]80D]8"@EB;V]L(")80F]X($=A;6EN9R!3>7-T96TB"@EH96QP"@D@
M(%1H:7,@;W!T:6]N(&ES(&YE961E9"!T;R!M86ME($QI;G5X(&)O;W0@;VX@
M6$)O>"!'86UI;F<@4WES=&5M<RX*"2 @"@D@(%1H92!80F]X(&-A;B!B92!C
M;VYS:61E<F5D(&%S(&$@<W1A;F1A<F0@4$,@=VET:"!A($-O<'!E<FUI;F4M
M8F%S960@0V5L97)O;B W,S,@34AZ+ H)("!)1$4@:&%R9&1R:79E+"!$5D0L
M($5T:&5R;F5T+"!54T(@86YD(&=R87!H:6-S+B *"2 @"@D@(%1O(&)O;W0@
M=&AE(&ME<FYE;"!Y;W4@;F5E9" B7W)O;7=E;&PB+"!E:71H97(@=7-E9"!A
M<R!A(')E<&QA8V5M96YT($))3U,@*&-R;VUW96QL*0H)("!O<B!A<R!A(&)O
M;W1L;V%D97(N"@D@( H)("!&;W(@;6]R92!I;F9O<FUA=&EO;B!S964@:'1T
M<#HO+WAB;W@M;&EN=7@N<V]U<F-E9F]R9V4N;F5T+R *"2 @"@D@($EF('EO
M=2!D;R!N;W0@<W!E8VEF:6-A;&QY(&YE960@82!K97)N96P@9F]R(%A"3U@@
M;6%C:&EN92P*"2 @<V%Y($X@:&5R92!O=&AE<G=I<V4@=&AE(&ME<FYE;"!Y
M;W4@8G5I;&0@=VEL;"!N;W0@8F4@8F]O=&%B;&4N"EP*230Q,2 Q"@ED97!E
M;F1S(&]N("%8.#9?6$)/6 I$,3$P-R Q"DDQ,3 W(#$*"61E<&5N9',@;VX@
M(2A8.#9?5DE35U,@?'P@6#@V7U9/64%'15(@?'P@6#@V7UA"3U@I"D0Q-#$S
M(#$*23$T,3,@,0H)9&5P96YD<R!O;B A*%@X-E]625-74R!\?"!8.#9?5D]9
M04=%4B!\?"!8.#9?6$)/6"D*"B,@4&%T8V@@8VAE8VMS=6T]-C%F8SEB,3D*
 
