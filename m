Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264849AbTFCI6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 04:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbTFCI6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 04:58:52 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:49568 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S264849AbTFCI55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 04:57:57 -0400
Date: Tue, 3 Jun 2003 11:11:13 +0200
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, mikpe@csd.uu.se, torvalds@transmeta.com
Subject: [PATCH] Support for mach-xbox (updated)
Message-ID: <20030603091113.GD13285@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19N7p3-0004lp-00*VvDSeMa7H0o*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated according to Sam and Mikaels comments.

This patch that adds a new subachitecture for the xbox gaming system. All it
does outside the subarchitecture is adding posibility to blacklist
pci-devices through an mach-hook.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet
  1.1266 03/06/03 10:14:24 andersg@0x63.nu +10 -0
  Added XBOX subarch

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.1 03/06/03 10:14:07 andersg@0x63.nu +6 -0

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.1 03/06/03 10:14:07 andersg@0x63.nu +6 -0

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.0 03/06/03 10:14:07 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-xbox/mach_pci_blacklist.h

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.0 03/06/03 10:14:07 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-default/mach_pci_blacklist.h

  arch/i386/mach-xbox/setup.c
    1.1 03/06/03 10:14:06 andersg@0x63.nu +79 -0

  arch/i386/mach-xbox/reboot.c
    1.1 03/06/03 10:14:06 andersg@0x63.nu +51 -0

  arch/i386/mach-xbox/setup.c
    1.0 03/06/03 10:14:06 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/setup.c

  arch/i386/mach-xbox/reboot.c
    1.0 03/06/03 10:14:06 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/reboot.c

  arch/i386/mach-xbox/Makefile
    1.1 03/06/03 10:14:05 andersg@0x63.nu +5 -0

  include/asm-i386/timex.h
    1.5 03/06/03 10:14:05 andersg@0x63.nu +9 -5
    Added XBOX subarch

  arch/i386/pci/direct.c
    1.15 03/06/03 10:14:05 andersg@0x63.nu +4 -0
    Added XBOX subarch
    Added a mach-hook for blacklisting pci-devices. The xbox hangs solid
    if you touch some pci devices.

  arch/i386/mach-xbox/Makefile
    1.0 03/06/03 10:14:05 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/Makefile

  arch/i386/boot/compressed/Makefile
    1.17 03/06/03 10:14:05 andersg@0x63.nu +5 -0
    Added XBOX subarch
    There is some strange interaction when paging is off, that makes 1.1 xboxen
    crash while decompressing kernel, unless decompressor is compiled without
    optimization.

  arch/i386/Makefile
    1.52 03/06/03 10:14:05 andersg@0x63.nu +4 -0
    Added XBOX subarch

  arch/i386/Kconfig
    1.58 03/06/03 10:14:05 andersg@0x63.nu +19 -2
    Added XBOX subarch


 arch/i386/Kconfig                                  |   21 +++++
 arch/i386/Makefile                                 |    4 +
 arch/i386/boot/compressed/Makefile                 |    5 +
 arch/i386/mach-xbox/Makefile                       |    5 +
 arch/i386/mach-xbox/reboot.c                       |   51 +++++++++++++
 arch/i386/mach-xbox/setup.c                        |   79 +++++++++++++++++++++
 arch/i386/pci/direct.c                             |    4 +
 include/asm-i386/mach-default/mach_pci_blacklist.h |    6 +
 include/asm-i386/mach-xbox/mach_pci_blacklist.h    |    6 +
 include/asm-i386/timex.h                           |   14 ++-
 10 files changed, 188 insertions(+), 7 deletions(-)


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Jun  3 10:17:30 2003
+++ b/arch/i386/Kconfig	Tue Jun  3 10:17:30 2003
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
@@ -395,6 +411,7 @@
 	  Otherwise, say N.
 
 config SMP
+	depends on !X86_XBOX
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
@@ -1090,7 +1107,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
@@ -1571,7 +1588,7 @@
 
 config X86_BIOS_REBOOT
 	bool
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	default y
 
 config X86_TRAMPOLINE
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Tue Jun  3 10:17:30 2003
+++ b/arch/i386/Makefile	Tue Jun  3 10:17:30 2003
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
--- a/arch/i386/boot/compressed/Makefile	Tue Jun  3 10:17:30 2003
+++ b/arch/i386/boot/compressed/Makefile	Tue Jun  3 10:17:30 2003
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
+++ b/arch/i386/mach-xbox/Makefile	Tue Jun  3 10:17:30 2003
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= setup.o reboot.o
diff -Nru a/arch/i386/mach-xbox/reboot.c b/arch/i386/mach-xbox/reboot.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/reboot.c	Tue Jun  3 10:17:30 2003
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
+#define XBOX_SMB_GLOBAL_ENABLE       (0x2 + XBOX_SMB_IO_BASE)
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
+        outb_p(SMC_CMD_POWER, XBOX_SMB_HOST_COMMAND);
+        outw_p(command, XBOX_SMB_HOST_DATA);
+        outw_p(inw(XBOX_SMB_IO_BASE),XBOX_SMB_IO_BASE);
+        outb_p(0x0a,XBOX_SMB_GLOBAL_ENABLE);
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
+++ b/arch/i386/mach-xbox/setup.c	Tue Jun  3 10:17:30 2003
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
--- a/arch/i386/pci/direct.c	Tue Jun  3 10:17:30 2003
+++ b/arch/i386/pci/direct.c	Tue Jun  3 10:17:30 2003
@@ -4,6 +4,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include "mach_pci_blacklist.h"
 #include "pci.h"
 
 /*
@@ -20,6 +21,9 @@
 	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
 		return -EINVAL;
 
+	if (mach_pci_is_blacklisted(bus,dev,fn))
+		return -EINVAL;
+	
 	spin_lock_irqsave(&pci_config_lock, flags);
 
 	outl(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8);
diff -Nru a/include/asm-i386/mach-default/mach_pci_blacklist.h b/include/asm-i386/mach-default/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-default/mach_pci_blacklist.h	Tue Jun  3 10:17:30 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) 0
+
+#endif
diff -Nru a/include/asm-i386/mach-xbox/mach_pci_blacklist.h b/include/asm-i386/mach-xbox/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-xbox/mach_pci_blacklist.h	Tue Jun  3 10:17:30 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) ( (bus>1) || (bus&&(dev||fn)) || ((bus==0 && dev==0) && ((fn==1)||(fn==2))) )
+
+#endif
diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Tue Jun  3 10:17:30 2003
+++ b/include/asm-i386/timex.h	Tue Jun  3 10:17:30 2003
@@ -12,11 +12,15 @@
 #ifdef CONFIG_X86_PC9800
    extern int CLOCK_TICK_RATE;
 #else
-#ifdef CONFIG_MELAN
-#  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
-#else
-#  define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
-#endif
+#  ifdef CONFIG_MELAN
+#    define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
+#  else
+#    ifdef CONFIG_X86_XBOX
+#      define CLOCK_TICK_RATE 1124998 /* so has the Xbox */
+#    else 
+#      define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
+#    endif
+#  endif
 #endif
 
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */

===================================================================


This BitKeeper patch contains the following changesets:
1.1266
## Wrapped with uu ##


M(R!5<V5R.@EA;F1E<G-G"B,@2&]S=#H),'@V,RYN=0HC(%)O;W0Z"2]D871A
M+V1E=B]K97)N96PO8FLO>&)O>"TR+C4*"B,@4&%T8V@@=F5R<SH),2XS"B,@
M4&%T8V@@='EP93H)4D5'54Q!4@H*/3T@0VAA;F=E4V5T(#T]"G1O<G9A;&1S
M0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U
M-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"G1O<G9A;&1S0&AO;64N=')A;G-M
M971A+F-O;7Q#:&%N9V53971\,C P,S V,#,P,3(X-35\-38S.#@*1" Q+C$R
M-C8@,#,O,#8O,#,@,3 Z,30Z,C0K,#(Z,# @86YD97)S9T P>#8S+FYU("LQ
M," M, I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E
M='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*8R!!
M9&1E9"!80D]8('-U8F%R8V@*2R U,3,Q.0I0($-H86YG95-E= HM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"C!A
M, H^(&%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI,S@V+VUA8V@M>&)O
M>"]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,S X,30P-WPQ,S V.7QA
M-#,P,65A-C4X835F8V4U(&%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI
M,S@V+VUA8V@M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,S X
M,30P.'PQ-34Q,0H^(&%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C:"UX
M8F]X+TUA:V5F:6QE?#(P,#,P-C S,#@Q-# U?#,Q-30S?#AC,S@R.&5D.6$U
M,C$R.3(@86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O36%K
M969I;&5\,C P,S V,#,P.#$T,#9\,#4R,S0*/B!T;W)V86QD<T!A=&AL;VXN
M=')A;G-M971A+F-O;7QA<F-H+VDS.#8O8F]O="]C;VUP<F5S<V5D+TUA:V5F
M:6QE?#(P,#(P,C U,3<T,#(P?#$T,C@Y?&5E9#(T,V,S9C0U8F5F-B!A;F1E
M<G-G0#!X-C,N;G5\87)C:"]I,S@V+V)O;W0O8V]M<')E<W-E9"]-86ME9FEL
M97PR,# S,#8P,S X,30P-7PP,#(R.0H^('1O<G9A;&1S0&%T:&QO;BYT<F%N
M<VUE=&$N8V]M?&%R8V@O:3,X-B]-86ME9FEL97PR,# R,#(P-3$W-# R,'PQ
M.#<Q,'PQ8CAA83%F,&,T,&$Q9&)F(&%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS
M.#8O36%K969I;&5\,C P,S V,#,P.#$T,#5\,C(U.30*/B!A;F1E<G-G0#!X
M-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC?#(P,#,P-C S,#@Q
M-# V?#(R-# Y?#0Q,SAB,C1D,S@U-34U-&8@86YD97)S9T P>#8S+FYU?&%R
M8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8WPR,# S,#8P,S X,30P-WPS-38T
M. H^('II<'!E;$!L:6YU>"UM-CAK+F]R9UMT;W)V86QD<UU\87)C:"]I,S@V
M+TMC;VYF:6=\,C P,C$P,S P-#,R,3A\,C0V.#A\-C$R,S$X,&%B.3$U-S8P
M8R!A;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+TMC;VYF:6=\,C P,S V,#,P
M.#$T,#5\,30X,C8*/B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7QI
M;F-L=61E+V%S;2UI,S@V+W1I;65X+FA\,C P,C R,#4Q-S,Y-#1\-C,X-C)\
M86$U9F0Q868Y,69E-3!F-R!A;F1E<G-G0#!X-C,N;G5\:6YC;'5D92]A<VTM
M:3,X-B]T:6UE>"YH?#(P,#,P-C S,#@Q-# U?#8Q-38T"CX@86YD97)S9T P
M>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O<F5B;V]T+F-\,C P,S V,#,P
M.#$T,#9\-#,P,#)\-C=D-#(X,C,T9#4X9#,Y(&%N9&5R<V= ,'@V,RYN=7QA
M<F-H+VDS.#8O;6%C:"UX8F]X+W)E8F]O="YC?#(P,#,P-C S,#@Q-# W?#,S
M.34Y"CX@;6]C:&5L0'-E9V9A=6QT+F]S9&PN;W)G?&%R8V@O:3,X-B]K97)N
M96PO<&-I+V1I<F5C="YC?#(P,#(P-#$V,34P.#,P?#0T-S,R?#,X-V,U-V0P
M.3!A9#0X.#@@86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]P8VDO9&ER96-T
M+F-\,C P,S V,#,P.#$T,#5\-30S,3(*/B!A;F1E<G-G0#!X-C,N;G5\:6YC
M;'5D92]A<VTM:3,X-B]M86-H+61E9F%U;'0O;6%C:%]P8VE?8FQA8VML:7-T
M+FA\,C P,S V,#,P.#$T,#=\,S0P-S)\,F4T93(T8S,Q86$U9C8V-R!A;F1E
M<G-G0#!X-C,N;G5\:6YC;'5D92]A<VTM:3,X-B]M86-H+61E9F%U;'0O;6%C
M:%]P8VE?8FQA8VML:7-T+FA\,C P,S V,#,P.#$T,#A\,3 R,S(*"CT](&%R
M8V@O:3,X-B]M86-H+7AB;W@O36%K969I;&4@/3T*3F5W(&9I;&4Z(&%R8V@O
M:3,X-B]M86-H+7AB;W@O36%K969I;&4*5B T"@IA;F1E<G-G0#!X-C,N;G5\
M87)C:"]I,S@V+VUA8V@M>&)O>"]-86ME9FEL97PR,# S,#8P,S X,30P-7PS
M,34T,WPX8S,X,CAE9#EA-3(Q,CDR"D0@,2XP(# S+S V+S S(#$P.C$T.C U
M*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K," M, I"('1O<G9A;&1S0&%T:&QO
M;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ-C T
M-WQC,60Q,6$T,65D,#(T.#8T"F,@0FET2V5E<&5R(&9I;&4@+V1A=&$O9&5V
M+VME<FYE;"]B:R]X8F]X+3(N-2]A<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F
M:6QE"DL@,S$U-#,*4"!A<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE"E(@
M.&,S.#(X960Y834R,3(Y,@I8(#!X.#(Q"BTM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*"F%N9&5R<V= ,'@V,RYN
M=7QA<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE?#(P,#,P-C S,#@Q-# U
M?#,Q-30S?#AC,S@R.&5D.6$U,C$R.3(*1" Q+C$@,#,O,#8O,#,@,3 Z,30Z
M,#4K,#(Z,# @86YD97)S9T P>#8S+FYU("LU("TP"D(@=&]R=F%L9'- 871H
M;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V
M,#0W?&,Q9#$Q830Q960P,C0X-C0*0PI&(#$*2R U,C,T"D\@+7)W+7)W+7(M
M+0I0(&%R8V@O:3,X-B]M86-H+7AB;W@O36%K969I;&4*+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I)," U"B,*
M(R!-86ME9FEL92!F;W(@=&AE(&QI;G5X(&ME<FYE;"X*(PI<"F]B:BUY"0D)
M"3H]('-E='5P+F\@<F5B;V]T+F\*"CT](&%R8V@O:3,X-B]M86-H+7AB;W@O
M<F5B;V]T+F,@/3T*3F5W(&9I;&4Z(&%R8V@O:3,X-B]M86-H+7AB;W@O<F5B
M;V]T+F,*5B T"@IA;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O
M>"]R96)O;W0N8WPR,# S,#8P,S X,30P-GPT,S P,GPV-V0T,C@R,S1D-3AD
M,SD*1" Q+C @,#,O,#8O,#,@,3 Z,30Z,#8K,#(Z,# @86YD97)S9T P>#8S
M+FYU("LP("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA
M;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*
M8R!":71+965P97(@9FEL92 O9&%T82]D978O:V5R;F5L+V)K+WAB;W@M,BXU
M+V%R8V@O:3,X-B]M86-H+7AB;W@O<F5B;V]T+F,*2R T,S P,@I0(&%R8V@O
M:3,X-B]M86-H+7AB;W@O<F5B;V]T+F,*4B V-V0T,C@R,S1D-3AD,SD*6" P
M>#@R,0HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2T*"@IA;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O
M>"]R96)O;W0N8WPR,# S,#8P,S X,30P-GPT,S P,GPV-V0T,C@R,S1D-3AD
M,SD*1" Q+C$@,#,O,#8O,#,@,3 Z,30Z,#8K,#(Z,# @86YD97)S9T P>#8S
M+FYU("LU,2 M, I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H
M86YG95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T
M"D,*1B Q"DL@,S,Y-3D*3R M<G<M<G<M<BTM"E @87)C:"]I,S@V+VUA8V@M
M>&)O>"]R96)O;W0N8PHM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2T*"DDP(#4Q"B\J"B J(&%R8V@O:3,X-B]M86-H
M+7AB;W@O<F5B;V]T+F,@"B J($]L:79I97(@1F%U8VAO;B \;VQI=FEE<BYF
M875C:&]N0&9R964N9G(^"B J($%N9&5R<R!'=7-T869S<V]N(#QA;F1E<G-G
M0#!X-C,N;G4^"B J"B J+PI<"B-I;F-L=61E(#QA<VTO:6\N:#X*7 HO*B!W
M92!D;VXG="!U<V4@86YY(&]F('1H;W-E+"!B=70@9&UI7W-C86XN8R!N965D
M<R G96T@*B\*=F]I9" H*G!M7W!O=V5R7V]F9BDH=F]I9"D["FEN="!R96)O
M;W1?=&AR=5]B:6]S.PI<"B-D969I;F4@6$)/6%]334)?24]?0D%312 P>$,P
M,# *(V1E9FEN92!80D]87U--0E](3U-47T%$1%)%4U,@(" @(" @*#!X-" K
M(%A"3UA?4TU"7TE/7T)!4T4I"B-D969I;F4@6$)/6%]334)?2$]35%]#3TU-
M04Y$(" @(" @("@P>#@@*R!80D]87U--0E])3U]"05-%*0HC9&5F:6YE(%A"
M3UA?4TU"7TA/4U1?1$%402 @(" @(" @(" H,'@V("L@6$)/6%]334)?24]?
M0D%312D*(V1E9FEN92!80D]87U--0E]'3$]"04Q?14Y!0DQ%(" @(" @("@P
M>#(@*R!80D]87U--0E])3U]"05-%*0I<"B-D969I;F4@6$)/6%]024-?041$
M4D534R P>#$P"EP*(V1E9FEN92!334-?0TU$7U!/5T52(#!X,#(*(V1E9FEN
M92!334-?4U5"0TU$7U!/5T527U)%4T54(#!X,#$*(V1E9FEN92!334-?4U5"
M0TU$7U!/5T527T-90TQ%(#!X-# *(V1E9FEN92!334-?4U5"0TU$7U!/5T52
M7T]&1B P>#@P"EP*7 IS=&%T:6,@=F]I9"!X8F]X7W!I8U]C;60H=3@@8V]M
M;6%N9"D*>PH);W5T=U]P*"@H6$)/6%]024-?041$4D534RD@/#P@,2DL6$)/
M6%]334)?2$]35%]!1$1215-3*3L*(" @(" @("!O=71B7W H4TU#7T--1%]0
M3U=%4BP@6$)/6%]334)?2$]35%]#3TU-04Y$*3L*(" @(" @("!O=71W7W H
M8V]M;6%N9"P@6$)/6%]334)?2$]35%]$051!*3L*(" @(" @("!O=71W7W H
M:6YW*%A"3UA?4TU"7TE/7T)!4T4I+%A"3UA?4TU"7TE/7T)!4T4I.PH@(" @
M(" @(&]U=&)?<"@P>#!A+%A"3UA?4TU"7T=,3T)!3%]%3D%"3$4I.PI]"EP*
M=F]I9"!M86-H:6YE7W)E<W1A<G0H8VAA<B J(%]?=6YU<V5D*0I["@EP<FEN
M=&LH2T523E])3D9/(")396YD:6YG(%!/5T527U)%4T54('1O(%A"3U@M4$E#
M+EQN(BD["@EX8F]X7W!I8U]C;60H4TU#7U-50D--1%]03U=%4E]215-%5"D[
M(" *?0I<"G9O:60@;6%C:&EN95]P;W=E<E]O9F8H=F]I9"D*>PH)<')I;G1K
M*$M%4DY?24Y&3R B4V5N9&EN9R!03U=%4E]/1D8@=&\@6$)/6"U024,N7&XB
M*3L*"7AB;WA?<&EC7V-M9"A334-?4U5"0TU$7U!/5T527T]&1BD[(" *?0I<
M"G9O:60@;6%C:&EN95]H86QT*'9O:60I"GL*?0H*/3T@87)C:"]I,S@V+VUA
M8V@M>&)O>"]S971U<"YC(#T]"DYE=R!F:6QE.B!A<F-H+VDS.#8O;6%C:"UX
M8F]X+W-E='5P+F,*5B T"@IA;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+VUA
M8V@M>&)O>"]S971U<"YC?#(P,#,P-C S,#@Q-# V?#(R-# Y?#0Q,SAB,C1D
M,S@U-34U-&8*1" Q+C @,#,O,#8O,#,@,3 Z,30Z,#8K,#(Z,# @86YD97)S
M9T P>#8S+FYU("LP("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC
M;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P
M,C0X-C0*8R!":71+965P97(@9FEL92 O9&%T82]D978O:V5R;F5L+V)K+WAB
M;W@M,BXU+V%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8PI+(#(R-# Y"E @
M87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC"E(@-#$S.&(R-&0S.#4U-34T
M9@I8(#!X.#(Q"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+0H*"F%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C
M:"UX8F]X+W-E='5P+F-\,C P,S V,#,P.#$T,#9\,C(T,#E\-#$S.&(R-&0S
M.#4U-34T9@I$(#$N,2 P,R\P-B\P,R Q,#HQ-#HP-BLP,CHP,"!A;F1E<G-G
M0#!X-C,N;G4@*S<Y("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC
M;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P
M,C0X-C0*0PI&(#$*2R S-38T. I/("UR=RUR=RUR+2T*4"!A<F-H+VDS.#8O
M;6%C:"UX8F]X+W-E='5P+F,*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I)," W.0HO*@H@*@E-86-H:6YE('-P
M96-I9FEC('-E='5P(&9O<B!X8F]X"B J+PI<"B-I;F-L=61E(#QL:6YU>"]C
M;VYF:6<N:#X*(VEN8VQU9&4@/&QI;G5X+W-M<"YH/@HC:6YC;'5D92 \;&EN
M=7@O:6YI="YH/@HC:6YC;'5D92 \;&EN=7@O:7)Q+F@^"B-I;F-L=61E(#QL
M:6YU>"]I;G1E<G)U<'0N:#X*(VEN8VQU9&4@/&%S;2]A<F-H7VAO;VMS+F@^
M"EP*+RHJ"B J('!R95]I;G1R7VEN:71?:&]O:R M(&EN:71I86QI<V%T:6]N
M('!R:6]R('1O('-E='1I;F<@=7 @:6YT97)R=7!T('9E8W1O<G,*("H*("H@
M1&5S8W)I<'1I;VXZ"B J"5!E<F9O<FT@86YY(&YE8V5S<V%R>2!I;G1E<G)U
M<'0@:6YI=&EA;&ES871I;VX@<')I;W(@=&\@<V5T=&EN9R!U< H@*@ET:&4@
M(F]R9&EN87)Y(B!I;G1E<G)U<'0@8V%L;"!G871E<RX@($9O<B!L96=A8WD@
M<F5A<V]N<RP@=&AE($E300H@*@EI;G1E<G)U<'1S('-H;W5L9"!B92!I;FET
M:6%L:7-E9"!H97)E(&EF('1H92!M86-H:6YE(&5M=6QA=&5S(&$@4$,*("H)
M:6X@86YY('=A>2X*("HJ+PIV;VED(%]?:6YI="!P<F5?:6YT<E]I;FET7VAO
M;VLH=F]I9"D*>PH):6YI=%])4T%?:7)Q<R@I.PI]"EP*+RHJ"B J(&EN=')?
M:6YI=%]H;V]K("T@<&]S="!G871E('-E='5P(&EN=&5R<G5P="!I;FET:6%L
M:7-A=&EO;@H@*@H@*B!$97-C<FEP=&EO;CH*("H)1FEL;"!I;B!A;GD@:6YT
M97)R=7!T<R!T:&%T(&UA>2!H879E(&)E96X@;&5F="!O=70@8GD@=&AE(&=E
M;F5R86P*("H):6YI=%])4E$H*2!R;W5T:6YE+B @:6YT97)R=7!T<R!H879I
M;F<@=&\@9&\@=VET:"!T:&4@;6%C:&EN92!R871H97(*("H)=&AA;B!T:&4@
M9&5V:6-E<R!O;B!T:&4@22]/(&)U<R H;&EK92!!4$E#(&EN=&5R<G5P=',@
M:6X@:6YT96P@35 *("H)<WES=&5M<RD@87)E('-T87)T960@:&5R92X*("HJ
M+PIV;VED(%]?:6YI="!I;G1R7VEN:71?:&]O:RAV;VED*0I["B-I9F1E9B!#
M3TY&24=?6#@V7TQ/0T%,7T%024,*"6%P:6-?:6YT<E]I;FET*"D["B-E;F1I
M9@I<"GT*7 HO*BH*("H@<')E7W-E='5P7V%R8VA?:&]O:R M(&AO;VL@8V%L
M;&5D('!R:6]R('1O(&%N>2!S971U<%]A<F-H*"D@97AE8W5T:6]N"B J"B J
M($1E<V-R:7!T:6]N.@H@*@EG96YE<F%L;'D@=7-E9"!T;R!A8W1I=F%T92!A
M;GD@;6%C:&EN92!S<&5C:69I8R!I9&5N=&EF:6-A=&EO;@H@*@ER;W5T:6YE
M<R!T:&%T(&UA>2!B92!N965D960@8F5F;W)E('-E='5P7V%R8V@H*2!R=6YS
M+B @3VX@5DE35U,*("H)=&AI<R!I<R!U<V5D('1O(&=E="!T:&4@8F]A<F0@
M<F5V:7-I;VX@86YD('1Y<&4N"B J*B\*=F]I9"!?7VEN:70@<')E7W-E='5P
M7V%R8VA?:&]O:RAV;VED*0I["GT*7 HO*BH*("H@=')A<%]I;FET7VAO;VL@
M+2!I;FET:6%L:7-E('-Y<W1E;2!S<&5C:69I8R!T<F%P<PH@*@H@*B!$97-C
M<FEP=&EO;CH*("H)0V%L;&5D(&%S('1H92!F:6YA;"!A8W0@;V8@=')A<%]I
M;FET*"DN("!5<V5D(&EN(%9)4U=3('1O(&EN:71I86QI<V4*("H)=&AE('9A
M<FEO=7,@8F]A<F0@<W!E8VEF:6,@05!)0R!T<F%P<RX*("HJ+PIV;VED(%]?
M:6YI="!T<F%P7VEN:71?:&]O:RAV;VED*0I["GT*7 IS=&%T:6,@<W1R=6-T
M(&ER<6%C=&EO;B!I<G$P(" ]('L@=&EM97)?:6YT97)R=7!T+"!305])3E1%
M4E)54%0L(# L(")T:6UE<B(L($Y53$PL($Y53$Q].PI<"B\J*@H@*B!T:6UE
M7VEN:71?:&]O:R M(&1O(&%N>2!S<&5C:69I8R!I;FET:6%L:7-A=&EO;G,@
M9F]R('1H92!S>7-T96T@=&EM97(N"B J"B J($1E<V-R:7!T:6]N.@H@*@E-
M=7-T('!L=6<@=&AE('-Y<W1E;2!T:6UE<B!I;G1E<G)U<'0@<V]U<F-E(&%T
M($A:(&EN=&\@=&AE($E242!L:7-T960*("H):6X@:7)Q7W9E8W1O<G,N:#I4
M24U%4E])4E$*("HJ+PIV;VED(%]?:6YI="!T:6UE7VEN:71?:&]O:RAV;VED
M*0I["@ES971U<%]I<G$H,"P@)FER<3 I.PI]"EP*"CT](&EN8VQU9&4O87-M
M+6DS.#8O;6%C:"UD969A=6QT+VUA8VA?<&-I7V)L86-K;&ES="YH(#T]"DYE
M=R!F:6QE.B!I;F-L=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H7W!C
M:5]B;&%C:VQI<W0N: I6(#0*"F%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S
M;2UI,S@V+VUA8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S
M,#8P,S X,30P-WPS-# W,GPR931E,C1C,S%A835F-C8W"D0@,2XP(# S+S V
M+S S(#$P.C$T.C W*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K," M, I"('1O
M<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P
M-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"F,@0FET2V5E<&5R(&9I
M;&4@+V1A=&$O9&5V+VME<FYE;"]B:R]X8F]X+3(N-2]I;F-L=61E+V%S;2UI
M,S@V+VUA8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N: I+(#,T,#<R
M"E @:6YC;'5D92]A<VTM:3,X-B]M86-H+61E9F%U;'0O;6%C:%]P8VE?8FQA
M8VML:7-T+F@*4B R931E,C1C,S%A835F-C8W"E@@,'@X,C$*+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@H*86YD
M97)S9T P>#8S+FYU?&EN8VQU9&4O87-M+6DS.#8O;6%C:"UD969A=6QT+VUA
M8VA?<&-I7V)L86-K;&ES="YH?#(P,#,P-C S,#@Q-# W?#,T,#<R?#)E-&4R
M-&,S,6%A-68V-C<*1" Q+C$@,#,O,#8O,#,@,3 Z,30Z,#<K,#(Z,# @86YD
M97)S9T P>#8S+FYU("LV("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T
M82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q
M960P,C0X-C0*0PI&(#$*2R Q,#(S,@I/("UR=RUR=RUR+2T*4"!I;F-L=61E
M+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N: HM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2T*"DDP(#8*(VEF;F1E9B!?7T%335]-04-(7U!#25]"3$%#2TQ)4U1?2 HC
M9&5F:6YE(%]?05--7TU!0TA?4$-)7T),04-+3$E35%]("EP*(V1E9FEN92!M
M86-H7W!C:5]I<U]B;&%C:VQI<W1E9"AB=7,L9&5V+&9N*2 P"EP*(V5N9&EF
M"@H]/2!I;F-L=61E+V%S;2UI,S@V+VUA8V@M>&)O>"]M86-H7W!C:5]B;&%C
M:VQI<W0N:" ]/0I.97<@9FEL93H@:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB
M;W@O;6%C:%]P8VE?8FQA8VML:7-T+F@*5B T"@IA;F1E<G-G0#!X-C,N;G5\
M:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T
M+FA\,C P,S V,#,P.#$T,#=\,3,P-CE\830S,#%E838U.&$U9F-E-0I$(#$N
M," P,R\P-B\P,R Q,#HQ-#HP-RLP,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S @
M+3 *0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\
M,C P,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A-#%E9# R-#@V- IC($)I=$ME
M97!E<B!F:6QE("]D871A+V1E=B]K97)N96PO8FLO>&)O>"TR+C4O:6YC;'5D
M92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+F@*2R Q
M,S V.0I0(&EN8VQU9&4O87-M+6DS.#8O;6%C:"UX8F]X+VUA8VA?<&-I7V)L
M86-K;&ES="YH"E(@830S,#%E838U.&$U9F-E-0I8(#!X.#(Q"BTM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*"F%N
M9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI,S@V+VUA8V@M>&)O>"]M86-H
M7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,S X,30P-WPQ,S V.7QA-#,P,65A
M-C4X835F8V4U"D0@,2XQ(# S+S V+S S(#$P.C$T.C W*S R.C P(&%N9&5R
M<V= ,'@V,RYN=2 K-B M, I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N
M8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D
M,#(T.#8T"D,*1B Q"DL@,34U,3$*3R M<G<M<G<M<BTM"E @:6YC;'5D92]A
M<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+F@*+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I)
M," V"B-I9FYD968@7U]!4TU?34%#2%]00TE?0DQ!0TM,25-47T@*(V1E9FEN
M92!?7T%335]-04-(7U!#25]"3$%#2TQ)4U1?2 I<"B-D969I;F4@;6%C:%]P
M8VE?:7-?8FQA8VML:7-T960H8G5S+&1E=BQF;BD@*" H8G5S/C$I('Q\("AB
M=7,F)BAD979\?&9N*2D@?'P@*"AB=7,]/3 @)B8@9&5V/3TP*2 F)B H*&9N
M/3TQ*7Q\*&9N/3TR*2DI("D*7 HC96YD:68*"CT](&%R8V@O:3,X-B]P8VDO
M9&ER96-T+F,@/3T*;6]C:&5L0'-E9V9A=6QT+F]S9&PN;W)G?&%R8V@O:3,X
M-B]K97)N96PO<&-I+V1I<F5C="YC?#(P,#(P-#$V,34P.#,P?#0T-S,R?#,X
M-V,U-V0P.3!A9#0X.#@*9W)E9T!K<F]A:"YC;VU;9W)E9UU\87)C:"]I,S@V
M+W!C:2]D:7)E8W0N8WPR,# S,#(R,#(R,C,S-7PT-C,U- I$(#$N,34@,#,O
M,#8O,#,@,3 Z,30Z,#4K,#(Z,# @86YD97)S9T P>#8S+FYU("LT("TP"D(@
M=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P
M,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PIC($%D9&5D(%A"
M3U@@<W5B87)C: IC($%D9&5D(&$@;6%C:"UH;V]K(&9O<B!B;&%C:VQI<W1I
M;F<@<&-I+61E=FEC97,N(%1H92!X8F]X(&AA;F=S('-O;&ED"F,@:68@>6]U
M('1O=6-H('-O;64@<&-I(&1E=FEC97,N"DL@-30S,3(*3R M<G<M<G<M<BTM
M"E @87)C:"]I,S@V+W!C:2]D:7)E8W0N8PHM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDV(#$*(VEN8VQU9&4@
M(FUA8VA?<&-I7V)L86-K;&ES="YH(@I),C(@,PH):68@*&UA8VA?<&-I7VES
M7V)L86-K;&ES=&5D*&)U<RQD978L9FXI*0H)"7)E='5R;B M14E.5D%,.PH)
M"@H]/2!A<F-H+VDS.#8O36%K969I;&4@/3T*=&]R=F%L9'- 871H;&]N+G1R
M86YS;65T82YC;VU\87)C:"]I,S@V+TUA:V5F:6QE?#(P,#(P,C U,3<T,#(P
M?#$X-S$P?#%B.&%A,68P8S0P83%D8F8*86MP;4!D:6=E;RYC;VU;=&]R=F%L
M9'-=?&%R8V@O:3,X-B]-86ME9FEL97PR,# S,#4P.# U,3,Q-7PQ,CDV.0I$
M(#$N-3(@,#,O,#8O,#,@,3 Z,30Z,#4K,#(Z,# @86YD97)S9T P>#8S+FYU
M("LT("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E
M4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PIC
M($%D9&5D(%A"3U@@<W5B87)C: I+(#(R-3DT"D\@+7)W+7)W+7(M+0I0(&%R
M8V@O:3,X-B]-86ME9FEL90HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDU-2 T"B,@6&)O>"!S=6)A<F-H('-U
M<'!O<G0*;69L86=S+20H0T].1DE'7U@X-E]80D]8*0DZ/2 M26EN8VQU9&4O
M87-M+6DS.#8O;6%C:"UX8F]X"FUC;W)E+20H0T].1DE'7U@X-E]80D]8*0DZ
M/2!M86-H+7AB;W@*7 H*/3T@87)C:"]I,S@V+V)O;W0O8V]M<')E<W-E9"]-
M86ME9FEL92 ]/0IT;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7QA<F-H
M+VDS.#8O8F]O="]C;VUP<F5S<V5D+TUA:V5F:6QE?#(P,#(P,C U,3<T,#(P
M?#$T,C@Y?&5E9#(T,V,S9C0U8F5F-@IS86U ;6%R<RYR879N8F]R9RYO<F=\
M87)C:"]I,S@V+V)O;W0O8V]M<')E<W-E9"]-86ME9FEL97PR,# S,#,P.3(Q
M-#<T,7PU,S0R-PI$(#$N,3<@,#,O,#8O,#,@,3 Z,30Z,#4K,#(Z,# @86YD
M97)S9T P>#8S+FYU("LU("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T
M82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q
M960P,C0X-C0*0PIC($%D9&5D(%A"3U@@<W5B87)C: IC(%1H97)E(&ES('-O
M;64@<W1R86YG92!I;G1E<F%C=&EO;B!W:&5N('!A9VEN9R!I<R!O9F8L('1H
M870@;6%K97,@,2XQ('AB;WAE;@IC(&-R87-H('=H:6QE(&1E8V]M<')E<W-I
M;F<@:V5R;F5L+"!U;FQE<W,@9&5C;VUP<F5S<V]R(&ES(&-O;7!I;&5D('=I
M=&AO=70*8R!O<'1I;6EZ871I;VXN"DL@,C(Y"D\@+7)W+7)W+7(M+0I0(&%R
M8V@O:3,X-B]B;V]T+V-O;7!R97-S960O36%K969I;&4*+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I)-R U"FEF
M97$@*"0H0T].1DE'7U@X-E]80D]8*2QY*0HC6%A8($-O;7!I;&EN9R!W:71H
M(&]P=&EM:7IA=&EO;B!M86ME<R Q+C$M>&)O>&5N( HC(" @(&-R87-H('=H
M:6QE(&1E8V]M<')E<W-I;F<@=&AE(&ME<FYE; I#1DQ!1U-?;6ES8RYO(" @
M.CT@+4\P"F5N9&EF"@H]/2!I;F-L=61E+V%S;2UI,S@V+W1I;65X+F@@/3T*
M=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\:6YC;'5D92]A<VTM:3,X
M-B]T:6UE>"YH?#(P,#(P,C U,3<S.30T?#8S.#8R?&%A-69D,6%F.3%F934P
M9C<*86QA;D!L>&]R9W5K+G5K=74N;W)G+G5K6W1O<G9A;&1S77QI;F-L=61E
M+V%S;2UI,S@V+W1I;65X+FA\,C P,S S,C(P,C(V,C5\-3,Y,#0*1" Q+C4@
M,#,O,#8O,#,@,3 Z,30Z,#4K,#(Z,# @86YD97)S9T P>#8S+FYU("LY("TU
M"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P
M,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PIC($%D9&5D
M(%A"3U@@<W5B87)C: I+(#8Q-38T"D\@+7)W+7)W+7(M+0I0(&EN8VQU9&4O
M87-M+6DS.#8O=&EM97@N: HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2T*"D0Q-2 U"DDQ.2 Y"B,@(&EF9&5F($-/
M3D9)1U]-14Q!3@HC(" @(&1E9FEN92!#3$]#2U]424-+7U)!5$4@,3$X.3(P
M," O*B!!340@16QA;B!H87,@9&EF9F5R96YT(&9R97%U96YC>2$@*B\*(R @
M96QS90HC(" @(&EF9&5F($-/3D9)1U]8.#9?6$)/6 HC(" @(" @9&5F:6YE
M($-,3T-+7U1)0TM?4D%412 Q,3(T.3DX("\J('-O(&AA<R!T:&4@6&)O>" J
M+PHC(" @(&5L<V4@"B,@(" @("!D969I;F4@0TQ/0TM?5$E#2U]2051%(#$Q
M.3,Q.# @+RH@56YD97)L>6EN9R!(6B J+PHC(" @(&5N9&EF"B,@(&5N9&EF
M"@H]/2!A<F-H+VDS.#8O2V-O;F9I9R ]/0IZ:7!P96Q ;&EN=7@M;38X:RYO
M<F=;=&]R=F%L9'-=?&%R8V@O:3,X-B]+8V]N9FEG?#(P,#(Q,#,P,#0S,C$X
M?#(T-C@X?#8Q,C,Q.#!A8CDQ-3<V,&,*86MP;4!D:6=E;RYC;VU;=&]R=F%L
M9'-=?&%R8V@O:3,X-B]+8V]N9FEG?#(P,#,P-3 X,#4Q,S$U?#(X-38Q"D0@
M,2XU." P,R\P-B\P,R Q,#HQ-#HP-2LP,CHP,"!A;F1E<G-G0#!X-C,N;G4@
M*S$Y("TR"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E
M4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PIC
M($%D9&5D(%A"3U@@<W5B87)C: I+(#$T.#(V"D\@+7)W+7)W+7(M+0I0(&%R
M8V@O:3,X-B]+8V]N9FEG"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+0H*230U(#$V"F-O;F9I9R!8.#9?6$)/6 H)
M8F]O;" B6$)O>"!'86UI;F<@4WES=&5M(@H):&5L< H)("!4:&ES(&]P=&EO
M;B!I<R!N965D960@=&\@;6%K92!,:6YU>"!B;V]T(&]N(%A";W@@1V%M:6YG
M(%-Y<W1E;7,N"@D@( H)("!4:&4@6$)O>"!C86X@8F4@8V]N<VED97)E9"!A
M<R!A('-T86YD87)D(%!#('=I=&@@82!#;W!P97)M:6YE+6)A<V5D($-E;&5R
M;VX@-S,S($U(>BP*"2 @241%(&AA<F1D<FEV92P@1%9$+"!%=&AE<FYE="P@
M55-"(&%N9"!G<F%P:&EC<RX@"@D@( H)("!4;R!B;V]T('1H92!K97)N96P@
M>6]U(&YE960@(E]R;VUW96QL(BP@96ET:&5R('5S960@87,@82!R97!L86-E
M;65N="!"24]3("AC<F]M=V5L;"D*"2 @;W(@87,@82!B;V]T;&]A9&5R+@H)
M(" *"2 @1F]R(&UO<F4@:6YF;W)M871I;VX@<V5E(&AT=' Z+R]X8F]X+6QI
M;G5X+G-O=7)C969O<F=E+FYE="\@"@D@( H)("!)9B!Y;W4@9&\@;F]T('-P
M96-I9FEC86QL>2!N965D(&$@:V5R;F5L(&9O<B!80D]8(&UA8VAI;F4L"@D@
M('-A>2!.(&AE<F4@;W1H97)W:7-E('1H92!K97)N96P@>6]U(&)U:6QD('=I
M;&P@;F]T(&)E(&)O;W1A8FQE+@I<"DDS.3<@,0H)9&5P96YD<R!O;B A6#@V
M7UA"3U@*1#$P.3,@,0I),3 Y,R Q"@ED97!E;F1S(&]N("$H6#@V7U9)4U=3
M('Q\(%@X-E]63UE!1T52('Q\(%@X-E]80D]8*0I$,34W-" Q"DDQ-3<T(#$*
M"61E<&5N9',@;VX@(2A8.#9?5DE35U,@?'P@6#@V7U9/64%'15(@?'P@6#@V
B7UA"3U@I"@HC(%!A=&-H(&-H96-K<W5M/38P,F8W9&8Y"@  
 
