Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTFBUOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFBUOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:14:14 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:23956 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S261845AbTFBUN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:13:58 -0400
Date: Mon, 2 Jun 2003 22:27:14 +0200
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Support for mach-xbox
Message-ID: <20030602202714.GD18786@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19Mvti-0006yx-00*5fjhOsXZmbs*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attached is a patch that adds a new subachitecture for the xbox gaming
system. All it does outside the subarchitecture is adding posibility to
blacklist pci-devices through an mach-hook.

xbox-linux team

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet
  1.1327 03/06/02 19:11:56 andersg@0x63.nu +10 -0
  Added XBOX subarch

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.1 03/06/02 19:11:46 andersg@0x63.nu +6 -0

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.1 03/06/02 19:11:46 andersg@0x63.nu +6 -0

  arch/i386/mach-xbox/setup.c
    1.1 03/06/02 19:11:46 andersg@0x63.nu +79 -0

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.0 03/06/02 19:11:46 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-xbox/mach_pci_blacklist.h

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.0 03/06/02 19:11:46 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-default/mach_pci_blacklist.h

  arch/i386/mach-xbox/setup.c
    1.0 03/06/02 19:11:46 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/setup.c

  arch/i386/mach-xbox/reboot.c
    1.1 03/06/02 19:11:45 andersg@0x63.nu +50 -0

  arch/i386/mach-xbox/Makefile
    1.1 03/06/02 19:11:45 andersg@0x63.nu +7 -0

  include/asm-i386/timex.h
    1.5 03/06/02 19:11:45 andersg@0x63.nu +9 -5
    Added XBOX subarch

  arch/i386/pci/direct.c
    1.15 03/06/02 19:11:45 andersg@0x63.nu +4 -0
    Added XBOX subarch
    Added a mach-hook for blacklisting pci-devices. The xbox hangs solid
    if you touch some pci devices.

  arch/i386/mach-xbox/reboot.c
    1.0 03/06/02 19:11:45 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/reboot.c

  arch/i386/mach-xbox/Makefile
    1.0 03/06/02 19:11:45 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/Makefile

  arch/i386/boot/compressed/Makefile
    1.17 03/06/02 19:11:45 andersg@0x63.nu +3 -0
    Added XBOX subarch
    There is some strange interaction when paging is off, that makes 1.1 xboxen
    crash while decompressing kernel, unless decompressor is compiled without
    optimization.

  arch/i386/Makefile
    1.52 03/06/02 19:11:44 andersg@0x63.nu +4 -0
    Added XBOX subarch

  arch/i386/Kconfig
    1.58 03/06/02 19:11:44 andersg@0x63.nu +19 -2
    Added XBOX subarch


 arch/i386/Kconfig                                  |   21 +++++
 arch/i386/Makefile                                 |    4 +
 arch/i386/boot/compressed/Makefile                 |    3 
 arch/i386/mach-xbox/Makefile                       |    7 +
 arch/i386/mach-xbox/reboot.c                       |   50 +++++++++++++
 arch/i386/mach-xbox/setup.c                        |   79 +++++++++++++++++++++
 arch/i386/pci/direct.c                             |    4 +
 include/asm-i386/mach-default/mach_pci_blacklist.h |    6 +
 include/asm-i386/mach-xbox/mach_pci_blacklist.h    |    6 +
 include/asm-i386/timex.h                           |   14 ++-
 10 files changed, 187 insertions(+), 7 deletions(-)


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Jun  2 19:23:26 2003
+++ b/arch/i386/Kconfig	Mon Jun  2 19:23:26 2003
@@ -43,6 +43,22 @@
 	help
 	  Choose this option if your computer is a standard PC or compatible.
 
+config X86_XBOX
+	bool "XBox Gaming System"
+	help
+	  This option is needed to make Linux boot on XBox Gaming Systems.
+	  
+	  The XBox can be considered as a standard PC with a Pentium III Celeron 733 MHz,
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
--- a/arch/i386/Makefile	Mon Jun  2 19:23:26 2003
+++ b/arch/i386/Makefile	Mon Jun  2 19:23:26 2003
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
--- a/arch/i386/boot/compressed/Makefile	Mon Jun  2 19:23:26 2003
+++ b/arch/i386/boot/compressed/Makefile	Mon Jun  2 19:23:26 2003
@@ -5,6 +5,9 @@
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+ifeq ($(CONFIG_X86_XBOX),y)
+CFLAGS_misc.o   := -O0
+endif
 EXTRA_AFLAGS	:= -traditional
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
diff -Nru a/arch/i386/mach-xbox/Makefile b/arch/i386/mach-xbox/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/Makefile	Mon Jun  2 19:23:26 2003
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+EXTRA_CFLAGS	+= -I../kernel
+
+obj-y				:= setup.o reboot.o
diff -Nru a/arch/i386/mach-xbox/reboot.c b/arch/i386/mach-xbox/reboot.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/reboot.c	Mon Jun  2 19:23:26 2003
@@ -0,0 +1,50 @@
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
+static void xbox_pic_cmd(u8 command){
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
+++ b/arch/i386/mach-xbox/setup.c	Mon Jun  2 19:23:26 2003
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
--- a/arch/i386/pci/direct.c	Mon Jun  2 19:23:26 2003
+++ b/arch/i386/pci/direct.c	Mon Jun  2 19:23:26 2003
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
+++ b/include/asm-i386/mach-default/mach_pci_blacklist.h	Mon Jun  2 19:23:26 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) 0
+
+#endif
diff -Nru a/include/asm-i386/mach-xbox/mach_pci_blacklist.h b/include/asm-i386/mach-xbox/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-xbox/mach_pci_blacklist.h	Mon Jun  2 19:23:26 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) ( (bus>1) || (bus&&(dev||fn)) || ((bus==0 && dev==0) && ((fn==1)||(fn==2))) )
+
+#endif
diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Mon Jun  2 19:23:26 2003
+++ b/include/asm-i386/timex.h	Mon Jun  2 19:23:26 2003
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
+
## Wrapped with uu ##


M(R!5<V5R.@EA;F1E<G-G"B,@2&]S=#H),'@V,RYN=0HC(%)O;W0Z"2]D871A
M+V1E=B]K97)N96PO8FLO>&)O>"TR+C4*"B,@4&%T8V@@=F5R<SH),2XS"B,@
M4&%T8V@@='EP93H)4D5'54Q!4@H*/3T@0VAA;F=E4V5T(#T]"G1O<G9A;&1S
M0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U
M-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"G1O<G9A;&1S0'!E;F=U:6XN=')A
M;G-M971A+F-O;7Q#:&%N9V53971\,C P,S U,S Q.3,Y,S)\-#$P,C4*1" Q
M+C$S,C<@,#,O,#8O,#(@,3DZ,3$Z-38K,#(Z,# @86YD97)S9T P>#8S+FYU
M("LQ," M, I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG
M95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*
M8R!!9&1E9"!80D]8('-U8F%R8V@*2R S-C X,0I0($-H86YG95-E= HM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*
M"C!A, H^(&%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI,S@V+VUA8V@M
M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,C$W,3$T-GPS,S$T
M,'PR965C9#4T8F8U,S1E(&%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI
M,S@V+VUA8V@M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,C$W
M,3$T-WPQ-34Q,0H^(&%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C:"UX
M8F]X+TUA:V5F:6QE?#(P,#,P-C R,3<Q,30U?#$P.34T?#,X.6%F-SDY.#,X
M83$U,B!A;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O>"]-86ME
M9FEL97PR,# S,#8P,C$W,3$T-GPP-S(Q,@H^('1O<G9A;&1S0&%T:&QO;BYT
M<F%N<VUE=&$N8V]M?&%R8V@O:3,X-B]B;V]T+V-O;7!R97-S960O36%K969I
M;&5\,C P,C R,#4Q-S0P,C!\,30R.#E\965D,C0S8S-F-#5B968V(&%N9&5R
M<V= ,'@V,RYN=7QA<F-H+VDS.#8O8F]O="]C;VUP<F5S<V5D+TUA:V5F:6QE
M?#(P,#,P-C R,3<Q,30U?#4W-#8Y"CX@=&]R=F%L9'- 871H;&]N+G1R86YS
M;65T82YC;VU\87)C:"]I,S@V+TUA:V5F:6QE?#(P,#(P,C U,3<T,#(P?#$X
M-S$P?#%B.&%A,68P8S0P83%D8F8@86YD97)S9T P>#8S+FYU?&%R8V@O:3,X
M-B]-86ME9FEL97PR,# S,#8P,C$W,3$T-'PR,C4Y- H^(&%N9&5R<V= ,'@V
M,RYN=7QA<F-H+VDS.#8O;6%C:"UX8F]X+W-E='5P+F-\,C P,S V,#(Q-S$Q
M-#9\,#,Q-C5\,C%A,S<P,34U9&9F-S$R(&%N9&5R<V= ,'@V,RYN=7QA<F-H
M+VDS.#8O;6%C:"UX8F]X+W-E='5P+F-\,C P,S V,#(Q-S$Q-#=\,S4V-#@*
M/B!Z:7!P96Q ;&EN=7@M;38X:RYO<F=;=&]R=F%L9'-=?&%R8V@O:3,X-B]+
M8V]N9FEG?#(P,#(Q,#,P,#0S,C$X?#(T-C@X?#8Q,C,Q.#!A8CDQ-3<V,&,@
M86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]+8V]N9FEG?#(P,#,P-C R,3<Q
M,30T?#$T,C$W"CX@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\:6YC
M;'5D92]A<VTM:3,X-B]T:6UE>"YH?#(P,#(P,C U,3<S.30T?#8S.#8R?&%A
M-69D,6%F.3%F934P9C<@86YD97)S9T P>#8S+FYU?&EN8VQU9&4O87-M+6DS
M.#8O=&EM97@N:'PR,# S,#8P,C$W,3$T-7PV,34V- H^(&%N9&5R<V= ,'@V
M,RYN=7QA<F-H+VDS.#8O;6%C:"UX8F]X+W)E8F]O="YC?#(P,#,P-C R,3<Q
M,30U?#4W,3 S?#0P8S,Y9F1B.3AE96-A96$@86YD97)S9T P>#8S+FYU?&%R
M8V@O:3,X-B]M86-H+7AB;W@O<F5B;V]T+F-\,C P,S V,#(Q-S$Q-#9\,S,Y
M-#D*/B!M;V-H96Q <V5G9F%U;'0N;W-D;"YO<F=\87)C:"]I,S@V+VME<FYE
M;"]P8VDO9&ER96-T+F-\,C P,C T,38Q-3 X,S!\-#0W,S)\,S@W8S4W9# Y
M,&%D-#@X."!A;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+W!C:2]D:7)E8W0N
M8WPR,# S,#8P,C$W,3$T-7PU-#,Q,@H^(&%N9&5R<V= ,'@V,RYN=7QI;F-L
M=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N
M:'PR,# S,#8P,C$W,3$T-GPU,3DQ-7QC,#AF-&,W,&,Q-#5D83 X(&%N9&5R
M<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H
M7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,C$W,3$T-WPQ,#(S,@H*/3T@87)C
M:"]I,S@V+VUA8V@M>&)O>"]-86ME9FEL92 ]/0I.97<@9FEL93H@87)C:"]I
M,S@V+VUA8V@M>&)O>"]-86ME9FEL90I6(#0*"F%N9&5R<V= ,'@V,RYN=7QA
M<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE?#(P,#,P-C R,3<Q,30U?#$P
M.34T?#,X.6%F-SDY.#,X83$U,@I$(#$N," P,R\P-B\P,B Q.3HQ,3HT-2LP
M,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S @+3 *0B!T;W)V86QD<T!A=&AL;VXN
M=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\
M8S%D,3%A-#%E9# R-#@V- IC($)I=$ME97!E<B!F:6QE("]D871A+V1E=B]K
M97)N96PO8FLO>&)O>"TR+C4O87)C:"]I,S@V+VUA8V@M>&)O>"]-86ME9FEL
M90I+(#$P.34T"E @87)C:"]I,S@V+VUA8V@M>&)O>"]-86ME9FEL90I2(#,X
M.6%F-SDY.#,X83$U,@I8(#!X.#(Q"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*"F%N9&5R<V= ,'@V,RYN=7QA
M<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE?#(P,#,P-C R,3<Q,30U?#$P
M.34T?#,X.6%F-SDY.#,X83$U,@I$(#$N,2 P,R\P-B\P,B Q.3HQ,3HT-2LP
M,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S<@+3 *0B!T;W)V86QD<T!A=&AL;VXN
M=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\
M8S%D,3%A-#%E9# R-#@V- I#"D8@,0I+(#<R,3(*3R M<G<M<G<M<BTM"E @
M87)C:"]I,S@V+VUA8V@M>&)O>"]-86ME9FEL90HM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDP(#<*(PHC($UA
M:V5F:6QE(&9O<B!T:&4@;&EN=7@@:V5R;F5L+@HC"EP*15A44D%?0T9,04=3
M"2L]("U)+BXO:V5R;F5L"EP*;V)J+7D)"0D).CT@<V5T=7 N;R!R96)O;W0N
M;PH*/3T@87)C:"]I,S@V+VUA8V@M>&)O>"]R96)O;W0N8R ]/0I.97<@9FEL
M93H@87)C:"]I,S@V+VUA8V@M>&)O>"]R96)O;W0N8PI6(#0*"F%N9&5R<V= 
M,'@V,RYN=7QA<F-H+VDS.#8O;6%C:"UX8F]X+W)E8F]O="YC?#(P,#,P-C R
M,3<Q,30U?#4W,3 S?#0P8S,Y9F1B.3AE96-A96$*1" Q+C @,#,O,#8O,#(@
M,3DZ,3$Z-#4K,#(Z,# @86YD97)S9T P>#8S+FYU("LP("TP"D(@=&]R=F%L
M9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S
M,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*8R!":71+965P97(@9FEL92 O
M9&%T82]D978O:V5R;F5L+V)K+WAB;W@M,BXU+V%R8V@O:3,X-B]M86-H+7AB
M;W@O<F5B;V]T+F,*2R U-S$P,PI0(&%R8V@O:3,X-B]M86-H+7AB;W@O<F5B
M;V]T+F,*4B T,&,S.69D8CDX965C865A"E@@,'@X,C$*+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@H*86YD97)S
M9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O<F5B;V]T+F-\,C P,S V
M,#(Q-S$Q-#5\-3<Q,#-\-#!C,SEF9&(Y.&5E8V%E80I$(#$N,2 P,R\P-B\P
M,B Q.3HQ,3HT-2LP,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S4P("TP"D(@=&]R
M=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U
M,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PI&(#$*2R S,SDT.0I/
M("UR=RUR=RUR+2T*4"!A<F-H+VDS.#8O;6%C:"UX8F]X+W)E8F]O="YC"BTM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+0H*23 @-3 *+RH*("H@87)C:"]I,S@V+VUA8V@M>&)O>"]R96)O;W0N8R *
M("H@3VQI=FEE<B!&875C:&]N(#QO;&EV:65R+F9A=6-H;VY 9G)E92YF<CX*
M("H@06YD97)S($=U<W1A9G-S;VX@/&%N9&5R<V= ,'@V,RYN=3X*("H*("HO
M"EP*(VEN8VQU9&4@/&%S;2]I;RYH/@I<"B\J('=E(&1O;B=T('5S92!A;GD@
M;V8@=&AO<V4L(&)U="!D;6E?<V-A;BYC(&YE961S("=E;2 J+PIV;VED("@J
M<&U?<&]W97)?;V9F*2AV;VED*3L*:6YT(')E8F]O=%]T:')U7V)I;W,["EP*
M(V1E9FEN92!80D]87U--0E])3U]"05-%(#!X0S P, HC9&5F:6YE(%A"3UA?
M4TU"7TA/4U1?041$4D534R @(" @(" H,'@T("L@6$)/6%]334)?24]?0D%3
M12D*(V1E9FEN92!80D]87U--0E](3U-47T-/34U!3D0@(" @(" @*#!X." K
M(%A"3UA?4TU"7TE/7T)!4T4I"B-D969I;F4@6$)/6%]334)?2$]35%]$051!
M(" @(" @(" @("@P>#8@*R!80D]87U--0E])3U]"05-%*0HC9&5F:6YE(%A"
M3UA?4TU"7T=,3T)!3%]%3D%"3$4@(" @(" @*#!X,B K(%A"3UA?4TU"7TE/
M7T)!4T4I"EP*(V1E9FEN92!80D]87U!)0U]!1$1215-3(#!X,3 *7 HC9&5F
M:6YE(%--0U]#341?4$]715(@,'@P,@HC9&5F:6YE(%--0U]354)#341?4$]7
M15)?4D53150@,'@P,0HC9&5F:6YE(%--0U]354)#341?4$]715)?0UE#3$4@
M,'@T, HC9&5F:6YE(%--0U]354)#341?4$]715)?3T9&(#!X.# *7 I<"G-T
M871I8R!V;VED('AB;WA?<&EC7V-M9"AU."!C;VUM86YD*7L*"6]U='=?<"@H
M*%A"3UA?4$E#7T%$1%)%4U,I(#P\(#$I+%A"3UA?4TU"7TA/4U1?041$4D53
M4RD["B @(" @(" @;W5T8E]P*%--0U]#341?4$]715(L(%A"3UA?4TU"7TA/
M4U1?0T]-34%.1"D["B @(" @(" @;W5T=U]P*&-O;6UA;F0L(%A"3UA?4TU"
M7TA/4U1?1$%402D["B @(" @(" @;W5T=U]P*&EN=RA80D]87U--0E])3U]"
M05-%*2Q80D]87U--0E])3U]"05-%*3L*(" @(" @("!O=71B7W H,'@P82Q8
M0D]87U--0E]'3$]"04Q?14Y!0DQ%*3L*?0I<"G9O:60@;6%C:&EN95]R97-T
M87)T*&-H87(@*B!?7W5N=7-E9"D*>PH)<')I;G1K*$M%4DY?24Y&3R B4V5N
M9&EN9R!03U=%4E]215-%5"!T;R!80D]8+5!)0RY<;B(I.PH)>&)O>%]P:6-?
M8VUD*%--0U]354)#341?4$]715)?4D53150I.R @"GT*7 IV;VED(&UA8VAI
M;F5?<&]W97)?;V9F*'9O:60I"GL*"7!R:6YT:RA+15).7TE.1D\@(E-E;F1I
M;F<@4$]715)?3T9&('1O(%A"3U@M4$E#+EQN(BD["@EX8F]X7W!I8U]C;60H
M4TU#7U-50D--1%]03U=%4E]/1D8I.R @"GT*7 IV;VED(&UA8VAI;F5?:&%L
M="AV;VED*0I["GT*"CT](&%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8R ]
M/0I.97<@9FEL93H@87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC"E8@- H*
M86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8WPR
M,# S,#8P,C$W,3$T-GPP,S$V-7PR,6$S-S Q-35D9F8W,3(*1" Q+C @,#,O
M,#8O,#(@,3DZ,3$Z-#8K,#(Z,# @86YD97)S9T P>#8S+FYU("LP("TP"D(@
M=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P
M,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*8R!":71+965P97(@
M9FEL92 O9&%T82]D978O:V5R;F5L+V)K+WAB;W@M,BXU+V%R8V@O:3,X-B]M
M86-H+7AB;W@O<V5T=7 N8PI+(#,Q-C4*4"!A<F-H+VDS.#8O;6%C:"UX8F]X
M+W-E='5P+F,*4B R,6$S-S Q-35D9F8W,3(*6" P>#@R,0HM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"@IA;F1E
M<G-G0#!X-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC?#(P,#,P
M-C R,3<Q,30V?# S,38U?#(Q83,W,#$U-61F9C<Q,@I$(#$N,2 P,R\P-B\P
M,B Q.3HQ,3HT-BLP,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S<Y("TP"D(@=&]R
M=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U
M,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PI&(#$*2R S-38T. I/
M("UR=RUR=RUR+2T*4"!A<F-H+VDS.#8O;6%C:"UX8F]X+W-E='5P+F,*+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M"@I)," W.0HO*@H@*@E-86-H:6YE('-P96-I9FEC('-E='5P(&9O<B!X8F]X
M"B J+PI<"B-I;F-L=61E(#QL:6YU>"]C;VYF:6<N:#X*(VEN8VQU9&4@/&QI
M;G5X+W-M<"YH/@HC:6YC;'5D92 \;&EN=7@O:6YI="YH/@HC:6YC;'5D92 \
M;&EN=7@O:7)Q+F@^"B-I;F-L=61E(#QL:6YU>"]I;G1E<G)U<'0N:#X*(VEN
M8VQU9&4@/&%S;2]A<F-H7VAO;VMS+F@^"EP*+RHJ"B J('!R95]I;G1R7VEN
M:71?:&]O:R M(&EN:71I86QI<V%T:6]N('!R:6]R('1O('-E='1I;F<@=7 @
M:6YT97)R=7!T('9E8W1O<G,*("H*("H@1&5S8W)I<'1I;VXZ"B J"5!E<F9O
M<FT@86YY(&YE8V5S<V%R>2!I;G1E<G)U<'0@:6YI=&EA;&ES871I;VX@<')I
M;W(@=&\@<V5T=&EN9R!U< H@*@ET:&4@(F]R9&EN87)Y(B!I;G1E<G)U<'0@
M8V%L;"!G871E<RX@($9O<B!L96=A8WD@<F5A<V]N<RP@=&AE($E300H@*@EI
M;G1E<G)U<'1S('-H;W5L9"!B92!I;FET:6%L:7-E9"!H97)E(&EF('1H92!M
M86-H:6YE(&5M=6QA=&5S(&$@4$,*("H):6X@86YY('=A>2X*("HJ+PIV;VED
M(%]?:6YI="!P<F5?:6YT<E]I;FET7VAO;VLH=F]I9"D*>PH):6YI=%])4T%?
M:7)Q<R@I.PI]"EP*+RHJ"B J(&EN=')?:6YI=%]H;V]K("T@<&]S="!G871E
M('-E='5P(&EN=&5R<G5P="!I;FET:6%L:7-A=&EO;@H@*@H@*B!$97-C<FEP
M=&EO;CH*("H)1FEL;"!I;B!A;GD@:6YT97)R=7!T<R!T:&%T(&UA>2!H879E
M(&)E96X@;&5F="!O=70@8GD@=&AE(&=E;F5R86P*("H):6YI=%])4E$H*2!R
M;W5T:6YE+B @:6YT97)R=7!T<R!H879I;F<@=&\@9&\@=VET:"!T:&4@;6%C
M:&EN92!R871H97(*("H)=&AA;B!T:&4@9&5V:6-E<R!O;B!T:&4@22]/(&)U
M<R H;&EK92!!4$E#(&EN=&5R<G5P=',@:6X@:6YT96P@35 *("H)<WES=&5M
M<RD@87)E('-T87)T960@:&5R92X*("HJ+PIV;VED(%]?:6YI="!I;G1R7VEN
M:71?:&]O:RAV;VED*0I["B-I9F1E9B!#3TY&24=?6#@V7TQ/0T%,7T%024,*
M"6%P:6-?:6YT<E]I;FET*"D["B-E;F1I9@I<"GT*7 HO*BH*("H@<')E7W-E
M='5P7V%R8VA?:&]O:R M(&AO;VL@8V%L;&5D('!R:6]R('1O(&%N>2!S971U
M<%]A<F-H*"D@97AE8W5T:6]N"B J"B J($1E<V-R:7!T:6]N.@H@*@EG96YE
M<F%L;'D@=7-E9"!T;R!A8W1I=F%T92!A;GD@;6%C:&EN92!S<&5C:69I8R!I
M9&5N=&EF:6-A=&EO;@H@*@ER;W5T:6YE<R!T:&%T(&UA>2!B92!N965D960@
M8F5F;W)E('-E='5P7V%R8V@H*2!R=6YS+B @3VX@5DE35U,*("H)=&AI<R!I
M<R!U<V5D('1O(&=E="!T:&4@8F]A<F0@<F5V:7-I;VX@86YD('1Y<&4N"B J
M*B\*=F]I9"!?7VEN:70@<')E7W-E='5P7V%R8VA?:&]O:RAV;VED*0I["GT*
M7 HO*BH*("H@=')A<%]I;FET7VAO;VL@+2!I;FET:6%L:7-E('-Y<W1E;2!S
M<&5C:69I8R!T<F%P<PH@*@H@*B!$97-C<FEP=&EO;CH*("H)0V%L;&5D(&%S
M('1H92!F:6YA;"!A8W0@;V8@=')A<%]I;FET*"DN("!5<V5D(&EN(%9)4U=3
M('1O(&EN:71I86QI<V4*("H)=&AE('9A<FEO=7,@8F]A<F0@<W!E8VEF:6,@
M05!)0R!T<F%P<RX*("HJ+PIV;VED(%]?:6YI="!T<F%P7VEN:71?:&]O:RAV
M;VED*0I["GT*7 IS=&%T:6,@<W1R=6-T(&ER<6%C=&EO;B!I<G$P(" ]('L@
M=&EM97)?:6YT97)R=7!T+"!305])3E1%4E)54%0L(# L(")T:6UE<B(L($Y5
M3$PL($Y53$Q].PI<"B\J*@H@*B!T:6UE7VEN:71?:&]O:R M(&1O(&%N>2!S
M<&5C:69I8R!I;FET:6%L:7-A=&EO;G,@9F]R('1H92!S>7-T96T@=&EM97(N
M"B J"B J($1E<V-R:7!T:6]N.@H@*@E-=7-T('!L=6<@=&AE('-Y<W1E;2!T
M:6UE<B!I;G1E<G)U<'0@<V]U<F-E(&%T($A:(&EN=&\@=&AE($E242!L:7-T
M960*("H):6X@:7)Q7W9E8W1O<G,N:#I424U%4E])4E$*("HJ+PIV;VED(%]?
M:6YI="!T:6UE7VEN:71?:&]O:RAV;VED*0I["@ES971U<%]I<G$H,"P@)FER
M<3 I.PI]"EP*"CT](&EN8VQU9&4O87-M+6DS.#8O;6%C:"UD969A=6QT+VUA
M8VA?<&-I7V)L86-K;&ES="YH(#T]"DYE=R!F:6QE.B!I;F-L=61E+V%S;2UI
M,S@V+VUA8V@M9&5F875L="]M86-H7W!C:5]B;&%C:VQI<W0N: I6(#0*"F%N
M9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M
M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,C$W,3$T-GPU,3DQ-7QC,#AF
M-&,W,&,Q-#5D83 X"D0@,2XP(# S+S V+S R(#$Y.C$Q.C0V*S R.C P(&%N
M9&5R<V= ,'@V,RYN=2 K," M, I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE
M=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T
M,65D,#(T.#8T"F,@0FET2V5E<&5R(&9I;&4@+V1A=&$O9&5V+VME<FYE;"]B
M:R]X8F]X+3(N-2]I;F-L=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H
M7W!C:5]B;&%C:VQI<W0N: I+(#4Q.3$U"E @:6YC;'5D92]A<VTM:3,X-B]M
M86-H+61E9F%U;'0O;6%C:%]P8VE?8FQA8VML:7-T+F@*4B!C,#AF-&,W,&,Q
M-#5D83 X"E@@,'@X,C$*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM"@H*86YD97)S9T P>#8S+FYU?&EN8VQU9&4O
M87-M+6DS.#8O;6%C:"UD969A=6QT+VUA8VA?<&-I7V)L86-K;&ES="YH?#(P
M,#,P-C R,3<Q,30V?#4Q.3$U?&,P.&8T8S<P8S$T-61A,#@*1" Q+C$@,#,O
M,#8O,#(@,3DZ,3$Z-#8K,#(Z,# @86YD97)S9T P>#8S+FYU("LV("TP"D(@
M=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P
M,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PI&(#$*2R Q,#(S
M,@I/("UR=RUR=RUR+2T*4"!I;F-L=61E+V%S;2UI,S@V+VUA8V@M9&5F875L
M="]M86-H7W!C:5]B;&%C:VQI<W0N: HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDP(#8*(VEF;F1E9B!?7T%3
M35]-04-(7U!#25]"3$%#2TQ)4U1?2 HC9&5F:6YE(%]?05--7TU!0TA?4$-)
M7T),04-+3$E35%]("EP*(V1E9FEN92!M86-H7W!C:5]I<U]B;&%C:VQI<W1E
M9"AB=7,L9&5V+&9N*2 P"EP*(V5N9&EF"@H]/2!I;F-L=61E+V%S;2UI,S@V
M+VUA8V@M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N:" ]/0I.97<@9FEL93H@
M:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T
M+F@*5B T"@IA;F1E<G-G0#!X-C,N;G5\:6YC;'5D92]A<VTM:3,X-B]M86-H
M+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+FA\,C P,S V,#(Q-S$Q-#9\,S,Q
M-#!\,F5E8V0U-&)F-3,T90I$(#$N," P,R\P-B\P,B Q.3HQ,3HT-BLP,CHP
M,"!A;F1E<G-G0#!X-C,N;G4@*S @+3 *0B!T;W)V86QD<T!A=&AL;VXN=')A
M;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\8S%D
M,3%A-#%E9# R-#@V- IC($)I=$ME97!E<B!F:6QE("]D871A+V1E=B]K97)N
M96PO8FLO>&)O>"TR+C4O:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C
M:%]P8VE?8FQA8VML:7-T+F@*2R S,S$T, I0(&EN8VQU9&4O87-M+6DS.#8O
M;6%C:"UX8F]X+VUA8VA?<&-I7V)L86-K;&ES="YH"E(@,F5E8V0U-&)F-3,T
M90I8(#!X.#(Q"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+0H*"F%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI
M,S@V+VUA8V@M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,C$W
M,3$T-GPS,S$T,'PR965C9#4T8F8U,S1E"D0@,2XQ(# S+S V+S R(#$Y.C$Q
M.C0V*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K-B M, I"('1O<G9A;&1S0&%T
M:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ
M-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*1B Q"DL@,34U,3$*3R M<G<M<G<M
M<BTM"E @:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA
M8VML:7-T+F@*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM"@I)," V"B-I9FYD968@7U]!4TU?34%#2%]00TE?0DQ!
M0TM,25-47T@*(V1E9FEN92!?7T%335]-04-(7U!#25]"3$%#2TQ)4U1?2 I<
M"B-D969I;F4@;6%C:%]P8VE?:7-?8FQA8VML:7-T960H8G5S+&1E=BQF;BD@
M*" H8G5S/C$I('Q\("AB=7,F)BAD979\?&9N*2D@?'P@*"AB=7,]/3 @)B8@
M9&5V/3TP*2 F)B H*&9N/3TQ*7Q\*&9N/3TR*2DI("D*7 HC96YD:68*"CT]
M(&%R8V@O:3,X-B]P8VDO9&ER96-T+F,@/3T*;6]C:&5L0'-E9V9A=6QT+F]S
M9&PN;W)G?&%R8V@O:3,X-B]K97)N96PO<&-I+V1I<F5C="YC?#(P,#(P-#$V
M,34P.#,P?#0T-S,R?#,X-V,U-V0P.3!A9#0X.#@*9W)E9T!K<F]A:"YC;VU;
M9W)E9UU\87)C:"]I,S@V+W!C:2]D:7)E8W0N8WPR,# S,#(R,#(R,C,S-7PT
M-C,U- I$(#$N,34@,#,O,#8O,#(@,3DZ,3$Z-#4K,#(Z,# @86YD97)S9T P
M>#8S+FYU("LT("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\
M0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X
M-C0*0PIC($%D9&5D(%A"3U@@<W5B87)C: IC($%D9&5D(&$@;6%C:"UH;V]K
M(&9O<B!B;&%C:VQI<W1I;F<@<&-I+61E=FEC97,N(%1H92!X8F]X(&AA;F=S
M('-O;&ED"F,@:68@>6]U('1O=6-H('-O;64@<&-I(&1E=FEC97,N"DL@-30S
M,3(*3R M<G<M<G<M<BTM"E @87)C:"]I,S@V+W!C:2]D:7)E8W0N8PHM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*
M"DDV(#$*(VEN8VQU9&4@(FUA8VA?<&-I7V)L86-K;&ES="YH(@I),C(@,PH)
M:68@*&UA8VA?<&-I7VES7V)L86-K;&ES=&5D*&)U<RQD978L9FXI*0H)"7)E
M='5R;B M14E.5D%,.PH)"@H]/2!A<F-H+VDS.#8O36%K969I;&4@/3T*=&]R
M=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\87)C:"]I,S@V+TUA:V5F:6QE
M?#(P,#(P,C U,3<T,#(P?#$X-S$P?#%B.&%A,68P8S0P83%D8F8*86MP;4!D
M:6=E;RYC;VU;=&]R=F%L9'-=?&%R8V@O:3,X-B]-86ME9FEL97PR,# S,#4P
M.# U,3,Q-7PQ,CDV.0I$(#$N-3(@,#,O,#8O,#(@,3DZ,3$Z-#0K,#(Z,# @
M86YD97)S9T P>#8S+FYU("LT("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS
M;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q
M830Q960P,C0X-C0*0PIC($%D9&5D(%A"3U@@<W5B87)C: I+(#(R-3DT"D\@
M+7)W+7)W+7(M+0I0(&%R8V@O:3,X-B]-86ME9FEL90HM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDU-2 T"B,@
M6&)O>"!S=6)A<F-H('-U<'!O<G0*;69L86=S+20H0T].1DE'7U@X-E]80D]8
M*0DZ/2 M26EN8VQU9&4O87-M+6DS.#8O;6%C:"UX8F]X"FUC;W)E+20H0T].
M1DE'7U@X-E]80D]8*0DZ/2!M86-H+7AB;W@*7 H*/3T@87)C:"]I,S@V+V)O
M;W0O8V]M<')E<W-E9"]-86ME9FEL92 ]/0IT;W)V86QD<T!A=&AL;VXN=')A
M;G-M971A+F-O;7QA<F-H+VDS.#8O8F]O="]C;VUP<F5S<V5D+TUA:V5F:6QE
M?#(P,#(P,C U,3<T,#(P?#$T,C@Y?&5E9#(T,V,S9C0U8F5F-@IS86U ;6%R
M<RYR879N8F]R9RYO<F=\87)C:"]I,S@V+V)O;W0O8V]M<')E<W-E9"]-86ME
M9FEL97PR,# S,#,P.3(Q-#<T,7PU,S0R-PI$(#$N,3<@,#,O,#8O,#(@,3DZ
M,3$Z-#4K,#(Z,# @86YD97)S9T P>#8S+FYU("LS("TP"D(@=&]R=F%L9'- 
M871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V
M?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PIC($%D9&5D(%A"3U@@<W5B87)C
M: IC(%1H97)E(&ES('-O;64@<W1R86YG92!I;G1E<F%C=&EO;B!W:&5N('!A
M9VEN9R!I<R!O9F8L('1H870@;6%K97,@,2XQ('AB;WAE;@IC(&-R87-H('=H
M:6QE(&1E8V]M<')E<W-I;F<@:V5R;F5L+"!U;FQE<W,@9&5C;VUP<F5S<V]R
M(&ES(&-O;7!I;&5D('=I=&AO=70*8R!O<'1I;6EZ871I;VXN"DL@-3<T-CD*
M3R M<G<M<G<M<BTM"E @87)C:"]I,S@V+V)O;W0O8V]M<')E<W-E9"]-86ME
M9FEL90HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2T*"DDW(#,*:69E<2 H)"A#3TY&24=?6#@V7UA"3U@I+'DI"D-&
M3$%'4U]M:7-C+F\@(" Z/2 M3S *96YD:68*"CT](&EN8VQU9&4O87-M+6DS
M.#8O=&EM97@N:" ]/0IT;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7QI
M;F-L=61E+V%S;2UI,S@V+W1I;65X+FA\,C P,C R,#4Q-S,Y-#1\-C,X-C)\
M86$U9F0Q868Y,69E-3!F-PIA;&%N0&QX;W)G=6LN=6MU=2YO<F<N=6M;=&]R
M=F%L9'-=?&EN8VQU9&4O87-M+6DS.#8O=&EM97@N:'PR,# S,#,R,C R,C8R
M-7PU,SDP- I$(#$N-2 P,R\P-B\P,B Q.3HQ,3HT-2LP,CHP,"!A;F1E<G-G
M0#!X-C,N;G4@*SD@+34*0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O
M;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A-#%E9# R
M-#@V- I#"F,@061D960@6$)/6"!S=6)A<F-H"DL@-C$U-C0*3R M<G<M<G<M
M<BTM"E @:6YC;'5D92]A<VTM:3,X-B]T:6UE>"YH"BTM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*1#$U(#4*23$Y
M(#D*(R @:69D968@0T].1DE'7TU%3$%."B,@(" @9&5F:6YE($-,3T-+7U1)
M0TM?4D%412 Q,3@Y,C P("\J($%-1"!%;&%N(&AA<R!D:69F97)E;G0@9G)E
M<75E;F-Y(2 J+PHC("!E;'-E"B,@(" @:69D968@0T].1DE'7U@X-E]80D]8
M"B,@(" @("!D969I;F4@0TQ/0TM?5$E#2U]2051%(#$Q,C0Y.3@@+RH@<V\@
M:&%S('1H92!88F]X("HO"B,@(" @96QS92 *(R @(" @(&1E9FEN92!#3$]#
M2U]424-+7U)!5$4@,3$Y,S$X," O*B!5;F1E<FQY:6YG($A:("HO"B,@(" @
M96YD:68*(R @96YD:68*"CT](&%R8V@O:3,X-B]+8V]N9FEG(#T]"GII<'!E
M;$!L:6YU>"UM-CAK+F]R9UMT;W)V86QD<UU\87)C:"]I,S@V+TMC;VYF:6=\
M,C P,C$P,S P-#,R,3A\,C0V.#A\-C$R,S$X,&%B.3$U-S8P8PIA:W!M0&1I
M9V5O+F-O;5MT;W)V86QD<UU\87)C:"]I,S@V+TMC;VYF:6=\,C P,S U,#@P
M-3$S,35\,C@U-C$*1" Q+C4X(# S+S V+S R(#$Y.C$Q.C0T*S R.C P(&%N
M9&5R<V= ,'@V,RYN=2 K,3D@+3(*0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M
M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A
M-#%E9# R-#@V- I#"F,@061D960@6$)/6"!S=6)A<F-H"DL@,30R,3<*3R M
M<G<M<G<M<BTM"E @87)C:"]I,S@V+TMC;VYF:6<*+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I)-#4@,38*8V]N
M9FEG(%@X-E]80D]8"@EB;V]L(")80F]X($=A;6EN9R!3>7-T96TB"@EH96QP
M"@D@(%1H:7,@;W!T:6]N(&ES(&YE961E9"!T;R!M86ME($QI;G5X(&)O;W0@
M;VX@6$)O>"!'86UI;F<@4WES=&5M<RX*"2 @"@D@(%1H92!80F]X(&-A;B!B
M92!C;VYS:61E<F5D(&%S(&$@<W1A;F1A<F0@4$,@=VET:"!A(%!E;G1I=6T@
M24E)($-E;&5R;VX@-S,S($U(>BP*"2 @241%(&AA<F1D<FEV92P@1%9$+"!%
M=&AE<FYE="P@55-"(&%N9"!G<F%P:&EC<RX@"@D@( H)("!4;R!B;V]T('1H
M92!K97)N96P@>6]U(&YE960@(E]R;VUW96QL(BP@96ET:&5R('5S960@87,@
M82!R97!L86-E;65N="!"24]3("AC<F]M=V5L;"D*"2 @;W(@87,@82!B;V]T
M;&]A9&5R+@H)(" *"2 @1F]R(&UO<F4@:6YF;W)M871I;VX@<V5E(&AT=' Z
M+R]X8F]X+6QI;G5X+G-O=7)C969O<F=E+FYE="\@"@D@( H)("!)9B!Y;W4@
M9&\@;F]T('-P96-I9FEC86QL>2!N965D(&$@:V5R;F5L(&9O<B!80D]8(&UA
M8VAI;F4L"@D@('-A>2!.(&AE<F4@;W1H97)W:7-E('1H92!K97)N96P@>6]U
M(&)U:6QD('=I;&P@;F]T(&)E(&)O;W1A8FQE+@I<"DDS.3<@,0H)9&5P96YD
M<R!O;B A6#@V7UA"3U@*1#$P.3,@,0I),3 Y,R Q"@ED97!E;F1S(&]N("$H
M6#@V7U9)4U=3('Q\(%@X-E]63UE!1T52('Q\(%@X-E]80D]8*0I$,34W-" Q
M"DDQ-3<T(#$*"61E<&5N9',@;VX@(2A8.#9?5DE35U,@?'P@6#@V7U9/64%'
K15(@?'P@6#@V7UA"3U@I"@HC(%!A=&-H(&-H96-K<W5M/64Y8S$V-S(T"@  
 
