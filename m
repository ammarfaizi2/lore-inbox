Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbSL3UmD>; Mon, 30 Dec 2002 15:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbSL3UmD>; Mon, 30 Dec 2002 15:42:03 -0500
Received: from verein.lst.de ([212.34.181.86]:7953 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S265995AbSL3UmA>;
	Mon, 30 Dec 2002 15:42:00 -0500
Date: Mon, 30 Dec 2002 21:50:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com, james.bottomley@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rename CONFIG_VOYAGER to CONFIG_X86_VOYAGER
Message-ID: <20021230215018.A20215@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	james.bottomley@steeleye.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The name is just a bit too generic, and we already use the _X86 prefix
for lots of other stuff in that area.  Dito for the never use CONFIG_PC
and CONFIG_VISWS.


--- 1.22/arch/i386/Kconfig	Sun Dec 29 21:03:34 2002
+++ edited/arch/i386/Kconfig	Mon Dec 30 11:51:41 2002
@@ -42,12 +42,12 @@
 	prompt "Subarchitecture Type"
 	default PC
 
-config PC
+config X86_PC
 	bool "IBM PC (and compatible)"
 	help
 	  Choose this option if your computer is a standard PC or compatible.
 
-config VOYAGER
+config X86_VOYAGER
 	bool "NCR Voyager"
 	help
 	  Voyager is a MCA based 32 way capable SMP architecture proprietary
@@ -407,7 +407,7 @@
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
-	depends on !VOYAGER
+	depends on !X86_VOYAGER
 	---help---
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -737,7 +737,7 @@
 
 
 menu "Power management options (ACPI, APM)"
-	depends on !VOYAGER
+	depends on !X86_VOYAGER
 
 config PM
 	bool "Power Management support"
@@ -1040,18 +1040,18 @@
 
 config X86_VISWS_APIC
 	bool
-	depends on VISWS
+	depends on X86_VISWS
 	default y
 
 config X86_LOCAL_APIC
 	bool
-	depends on ((!VISWS && SMP) || VISWS) && !VOYAGER
+	depends on (X86_VISWS || SMP) && !X86_VOYAGER
 	default y
 
 config PCI
-	bool "PCI support" if !VISWS
-	depends on !VOYAGER
-	default y if VISWS
+	bool "PCI support" if !X86_VISWS
+	depends on !X86_VOYAGER
+	default y if X86_VISWS
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -1065,12 +1065,12 @@
 
 config X86_IO_APIC
 	bool
-	depends on !VISWS && SMP && !VOYAGER
+	depends on SMP && !(X86_VISWS || X86_VOYAGER)
 	default y
 
 choice
 	prompt "PCI access mode"
-	depends on !VISWS && PCI
+	depends on PCI && !X86_VISWS
 	default PCI_GOANY
 
 config PCI_GOBIOS
@@ -1099,17 +1099,17 @@
 
 config PCI_BIOS
 	bool
-	depends on !VISWS && PCI && (PCI_GOBIOS || PCI_GOANY)
+	depends on !X86_VISWS && PCI && (PCI_GOBIOS || PCI_GOANY)
 	default y
 
 config PCI_DIRECT
 	bool
-	depends on !VISWS && PCI && (PCI_GODIRECT || PCI_GOANY)
+	depends on !X86_VISWS && PCI && (PCI_GODIRECT || PCI_GOANY)
 	default y
 
 config SCx200
 	tristate "NatSemi SCx200 support"
-	depends on !VOYAGER
+	depends on !X86_VOYAGER
 	help
 	  This provides basic support for the National Semiconductor SCx200 
 	  processor.  Right now this is just a driver for the GPIO pins.
@@ -1123,7 +1123,7 @@
 
 config ISA
 	bool "ISA support"
-	depends on !VOYAGER
+	depends on !(X86_VOYAGER || X86_VISWS)
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
@@ -1149,7 +1149,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !VISWS && !VOYAGER
+	depends on !(X86_VISWS || X86_VOYAGER)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
@@ -1157,8 +1157,8 @@
 	  there) before attempting to build an MCA bus kernel.
 
 config MCA
-	depends on VOYAGER
-	default y if VOYAGER
+	depends on X86_VOYAGER
+	default y if X86_VOYAGER
 
 source "drivers/mca/Kconfig"
 
@@ -1626,12 +1626,12 @@
 
 config X86_EXTRA_IRQS
 	bool
-	depends on X86_LOCAL_APIC || VOYAGER
+	depends on X86_LOCAL_APIC || X86_VOYAGER
 	default y
 
 config X86_FIND_SMP_CONFIG
 	bool
-	depends on X86_LOCAL_APIC || VOYAGER
+	depends on X86_LOCAL_APIC || X86_VOYAGER
 	default y
 
 config X86_MPPARSE
@@ -1649,17 +1649,17 @@
 
 config X86_SMP
 	bool
-	depends on SMP && !VOYAGER
+	depends on SMP && !X86_VOYAGER
 	default y
 
 config X86_HT
 	bool
-	depends on SMP && !VOYAGER
+	depends on SMP && !X86_VOYAGER
 	default y
 
 config X86_BIOS_REBOOT
 	bool
-	depends on !VOYAGER
+	depends on !X86_VOYAGER
 	default y
 
 config X86_TRAMPOLINE
===== arch/i386/Makefile 1.36 vs edited =====
--- 1.36/arch/i386/Makefile	Sat Dec 28 23:04:12 2002
+++ edited/arch/i386/Makefile	Mon Dec 30 11:45:16 2002
@@ -49,24 +49,22 @@
 
 CFLAGS += $(cflags-y)
 
-#default subarch .c files
+# Default subarch .c files
 mcore-y  := mach-default
 
-#Voyager subarch support
-mflags-$(CONFIG_VOYAGER)	:= -Iinclude/asm-i386/mach-voyager
-mcore-$(CONFIG_VOYAGER)		:= mach-voyager
+# Voyager subarch support
+mflags-$(CONFIG_X86_VOYAGER)	:= -Iinclude/asm-i386/mach-voyager
+mcore-$(CONFIG_X86_VOYAGER)	:= mach-voyager
 
-#VISWS subarch support
-mflags-$(CONFIG_VISWS) := -Iinclude/asm-i386/mach-visws
-mcore-$(CONFIG_VISWS)  := mach-visws
+# VISWS subarch support
+mflags-$(CONFIG_X86_VISWS)	:= -Iinclude/asm-i386/mach-visws
+mcore-$(CONFIG_X86_VISWS)	:= mach-visws
 
-#NUMAQ subarch support
-mflags-$(CONFIG_X86_NUMAQ) := -Iinclude/asm-i386/mach-numaq
-mcore-$(CONFIG_X86_NUMAQ)  := mach-default
+# NUMAQ subarch support
+mflags-$(CONFIG_X86_NUMAQ)	:= -Iinclude/asm-i386/mach-numaq
+mcore-$(CONFIG_X86_NUMAQ)	:= mach-default
 
-#add other subarch support here
-
-#default subarch .h files
+# default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
===== arch/i386/boot/setup.S 1.18 vs edited =====
--- 1.18/arch/i386/boot/setup.S	Sat Dec 28 12:18:50 2002
+++ edited/arch/i386/boot/setup.S	Mon Dec 30 11:44:05 2002
@@ -476,7 +476,7 @@
 	movsb
 	popw	%ds
 no_mca:
-#ifdef CONFIG_VOYAGER
+#ifdef CONFIG_X86_VOYAGER
 	movb	$0xff, 0x40	# flag on config found
 	movb	$0xc0, %al
 	mov	$0xff, %ah
@@ -758,7 +758,7 @@
 A20_ENABLE_LOOPS	= 255		# Total loops to try		
 
 
-#ifndef CONFIG_VOYAGER
+#ifndef CONFIG_X86_VOYAGER
 a20_try_loop:
 
 	# First, see if we are on a system with no A20 gate.
@@ -777,11 +777,11 @@
 	jnz	a20_done
 
 	# Try enabling A20 through the keyboard controller
-#endif /* CONFIG_VOYAGER */
+#endif /* CONFIG_X86_VOYAGER */
 a20_kbc:
 	call	empty_8042
 
-#ifndef CONFIG_VOYAGER
+#ifndef CONFIG_X86_VOYAGER
 	call	a20_test			# Just in case the BIOS worked
 	jnz	a20_done			# but had a delayed reaction.
 #endif
@@ -794,7 +794,7 @@
 	outb	%al, $0x60
 	call	empty_8042
 
-#ifndef CONFIG_VOYAGER
+#ifndef CONFIG_X86_VOYAGER
 	# Wait until a20 really *is* enabled; it can take a fair amount of
 	# time on certain systems; Toshiba Tecras are known to have this
 	# problem.
@@ -842,7 +842,7 @@
 	# If we get here, all is good
 a20_done:
 
-#endif /* CONFIG_VOYAGER */
+#endif /* CONFIG_X86_VOYAGER */
 # set up gdt and idt
 	lidt	idt_48				# load idt with 0,0
 	xorl	%eax, %eax			# Compute gdt_base
@@ -1009,7 +1009,7 @@
 	.string	"INT15 refuses to access high mem, giving up."
 
 
-#ifndef CONFIG_VOYAGER
+#ifndef CONFIG_X86_VOYAGER
 # This routine tests whether or not A20 is enabled.  If so, it
 # exits with zf = 0.
 #
@@ -1040,7 +1040,7 @@
 	popw	%cx
 	ret	
 
-#endif /* CONFIG_VOYAGER */
+#endif /* CONFIG_X86_VOYAGER */
 
 # This routine checks that the keyboard command queue is empty
 # (after emptying the output buffers)
