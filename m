Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWJWGKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWJWGKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWJWGKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:10:10 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:24080 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751565AbWJWGKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:10:07 -0400
Subject: [PATCH] Kconfig refactoring for better menu nesting
From: Don Mullis <dwm@meer.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rdunlap@xenotime.net, akpm@osdl.org, sam@ravnborg.org, gregkh@suse.de,
       kristen.c.accardi@intel.com
Content-Type: text/plain
Date: Sun, 22 Oct 2006 23:02:48 -0700
Message-Id: <1161583368.31851.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor Kconfig content to maximize nesting of menus by menuconfig
and xconfig.

Tested by simultaneously running `make xconfig` with and without
patch, and comparing displays.

Signed-off-by: Don Mullis <dwm@meer.net>
Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

---
The claim is that this helps the user's understanding of options -- but
since options are reordered, experts on particular subsystems might
disagree in some instances.

Thanks to Randy Dunlap for content contribution, review, and process help.


 drivers/parport/Kconfig     |    6 +--
 drivers/pci/hotplug/Kconfig |    3 +
 drivers/serial/Kconfig      |   53 +++++++++++++--------------
 lib/Kconfig.debug           |   85 ++++++++++++++++++++++----------------------
 4 files changed, 74 insertions(+), 73 deletions(-)

Index: linux-2.6/lib/Kconfig.debug
===================================================================
--- linux-2.6.orig/lib/Kconfig.debug
+++ linux-2.6/lib/Kconfig.debug
@@ -46,6 +46,48 @@ config UNUSED_SYMBOLS
 	  you really need it, and what the merge plan to the mainline kernel for
 	  your module is.
 
+config DEBUG_FS
+	bool "Debug Filesystem"
+	depends on SYSFS
+	help
+	  debugfs is a virtual file system that kernel developers use to put
+	  debugging files into.  Enable this option to be able to read and
+	  write to these files.
+
+	  If unsure, say N.
+
+config UNWIND_INFO
+	bool "Compile the kernel with frame unwind information"
+	depends on !IA64 && !PARISC
+	depends on !MODULES || !(MIPS || PPC || SUPERH || V850)
+	help
+	  If you say Y here the resulting kernel image will be slightly larger
+	  but not slower, and it will give very useful debugging information.
+	  If you don't debug the kernel, you can say N, but we may not be able
+	  to solve problems without frame unwind information or frame pointers.
+
+config STACK_UNWIND
+	bool "Stack unwind support"
+	depends on UNWIND_INFO
+	depends on X86
+	help
+	  This enables more precise stack traces, omitting all unrelated
+	  occurrences of pointers into kernel code from the dump.
+
+config HEADERS_CHECK
+	bool "Run 'make headers_check' when building vmlinux"
+	depends on !UML
+	help
+	  This option will extract the user-visible kernel headers whenever
+	  building the kernel, and will run basic sanity checks on them to
+	  ensure that exported files do not attempt to include files which
+	  were not exported, etc.
+
+	  If you're making modifications to header files which are
+	  relevant for userspace, say 'Y', and check the headers
+	  exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
+	  your build tree), to make sure they're suitable.
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
@@ -301,16 +343,6 @@ config DEBUG_INFO
 
 	  If unsure, say N.
 
-config DEBUG_FS
-	bool "Debug Filesystem"
-	depends on SYSFS
-	help
-	  debugfs is a virtual file system that kernel developers use to put
-	  debugging files into.  Enable this option to be able to read and
-	  write to these files.
-
-	  If unsure, say N.
-
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
@@ -339,24 +371,6 @@ config FRAME_POINTER
 	  some architectures or if you use external debuggers.
 	  If you don't debug the kernel, you can say N.
 
-config UNWIND_INFO
-	bool "Compile the kernel with frame unwind information"
-	depends on !IA64 && !PARISC
-	depends on !MODULES || !(MIPS || PPC || SUPERH || V850)
-	help
-	  If you say Y here the resulting kernel image will be slightly larger
-	  but not slower, and it will give very useful debugging information.
-	  If you don't debug the kernel, you can say N, but we may not be able
-	  to solve problems without frame unwind information or frame pointers.
-
-config STACK_UNWIND
-	bool "Stack unwind support"
-	depends on UNWIND_INFO
-	depends on X86
-	help
-	  This enables more precise stack traces, omitting all unrelated
-	  occurrences of pointers into kernel code from the dump.
-
 config FORCED_INLINING
 	bool "Force gcc to inline functions marked 'inline'"
 	depends on DEBUG_KERNEL
@@ -371,20 +385,6 @@ config FORCED_INLINING
 	  become the default in the future, until then this option is there to
 	  test gcc for this.
 
-config HEADERS_CHECK
-	bool "Run 'make headers_check' when building vmlinux"
-	depends on !UML
-	help
-	  This option will extract the user-visible kernel headers whenever
-	  building the kernel, and will run basic sanity checks on them to
-	  ensure that exported files do not attempt to include files which
-	  were not exported, etc.
-
-	  If you're making modifications to header files which are
-	  relevant for userspace, say 'Y', and check the headers
-	  exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
-	  your build tree), to make sure they're suitable.
-
 config RCU_TORTURE_TEST
 	tristate "torture tests for RCU"
 	depends on DEBUG_KERNEL
@@ -401,6 +401,7 @@ config RCU_TORTURE_TEST
 
 config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
+	depends on DEBUG_KERNEL
 	depends on KPROBES
 	default n
 	help
Index: linux-2.6/drivers/pci/hotplug/Kconfig
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/Kconfig
+++ linux-2.6/drivers/pci/hotplug/Kconfig
@@ -76,7 +76,8 @@ config HOTPLUG_PCI_IBM
 
 config HOTPLUG_PCI_ACPI
 	tristate "ACPI PCI Hotplug driver"
-	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)
+	depends on HOTPLUG_PCI
+	depends on (!ACPI_DOCK && ACPI) || (ACPI_DOCK)
 	help
 	  Say Y here if you have a system that supports PCI Hotplug using
 	  ACPI.
Index: linux-2.6/drivers/serial/Kconfig
===================================================================
--- linux-2.6.orig/drivers/serial/Kconfig
+++ linux-2.6/drivers/serial/Kconfig
@@ -151,32 +151,6 @@ config SERIAL_8250_MANY_PORTS
 	  say N here to save some memory. You can also say Y if you have an
 	  "intelligent" multiport card such as Cyclades, Digiboards, etc.
 
-config SERIAL_8250_SHARE_IRQ
-	bool "Support for sharing serial interrupts"
-	depends on SERIAL_8250_EXTENDED
-	help
-	  Some serial boards have hardware support which allows multiple dumb
-	  serial ports on the same board to share a single IRQ. To enable
-	  support for this in the serial driver, say Y here.
-
-config SERIAL_8250_DETECT_IRQ
-	bool "Autodetect IRQ on standard ports (unsafe)"
-	depends on SERIAL_8250_EXTENDED
-	help
-	  Say Y here if you want the kernel to try to guess which IRQ
-	  to use for your serial port.
-
-	  This is considered unsafe; it is far better to configure the IRQ in
-	  a boot script using the setserial command.
-
-	  If unsure, say N.
-
-config SERIAL_8250_RSA
-	bool "Support RSA serial ports"
-	depends on SERIAL_8250_EXTENDED
-	help
-	  ::: To be written :::
-
 #
 # Multi-port serial cards
 #
@@ -199,7 +173,6 @@ config SERIAL_8250_ACCENT
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_accent.
 
-
 config SERIAL_8250_BOCA
 	tristate "Support Boca cards"
 	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
@@ -219,6 +192,32 @@ config SERIAL_8250_HUB6
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_hub6.
 
+config SERIAL_8250_SHARE_IRQ
+	bool "Support for sharing serial interrupts"
+	depends on SERIAL_8250_EXTENDED
+	help
+	  Some serial boards have hardware support which allows multiple dumb
+	  serial ports on the same board to share a single IRQ. To enable
+	  support for this in the serial driver, say Y here.
+
+config SERIAL_8250_DETECT_IRQ
+	bool "Autodetect IRQ on standard ports (unsafe)"
+	depends on SERIAL_8250_EXTENDED
+	help
+	  Say Y here if you want the kernel to try to guess which IRQ
+	  to use for your serial port.
+
+	  This is considered unsafe; it is far better to configure the IRQ in
+	  a boot script using the setserial command.
+
+	  If unsure, say N.
+
+config SERIAL_8250_RSA
+	bool "Support RSA serial ports"
+	depends on SERIAL_8250_EXTENDED
+	help
+	  ::: To be written :::
+
 config SERIAL_8250_MCA
 	tristate "Support 8250-type ports on MCA buses"
 	depends on SERIAL_8250 != n && MCA
Index: linux-2.6/drivers/parport/Kconfig
===================================================================
--- linux-2.6.orig/drivers/parport/Kconfig
+++ linux-2.6/drivers/parport/Kconfig
@@ -82,9 +82,6 @@ config PARPORT_PC_PCMCIA
 	  Say Y here if you need PCMCIA support for your PC-style parallel
 	  ports. If unsure, say N.
 
-config PARPORT_NOT_PC
-	bool
-
 config PARPORT_IP32
 	tristate "SGI IP32 builtin port (EXPERIMENTAL)"
 	depends on SGI_IP32 && PARPORT && EXPERIMENTAL
@@ -158,5 +155,8 @@ config PARPORT_1284
 	  transfer modes. Also say Y if you want device ID information to
 	  appear in /proc/sys/dev/parport/*/autoprobe*. It is safe to say N.
 
+config PARPORT_NOT_PC
+	bool
+
 endmenu
 


