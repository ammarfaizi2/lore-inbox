Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVC3LzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVC3LzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVC3LzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:55:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261848AbVC3Lwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:52:35 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Fix kernel configuration
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 30 Mar 2005 12:52:20 +0100
Message-ID: <28590.1112183540@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes the FRV configuration to work with 2.6.12-rc1. It
does this by breaking out the kernel hacking menu into a separate file, in the
same way this is done in other archs.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-kconfig-2612rc1.diff 
 arch/frv/Kconfig       |  146 -------------------------------------------------
 arch/frv/Kconfig.debug |   74 ++++++++++++++++++++++++
 lib/Kconfig.debug      |    4 -
 3 files changed, 77 insertions(+), 147 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.12-rc1/arch/frv/Kconfig linux-2.6.12-rc1-frv-tlbmiss/arch/frv/Kconfig
--- /warthog/kernels/linux-2.6.12-rc1/arch/frv/Kconfig	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.12-rc1-frv-tlbmiss/arch/frv/Kconfig	2005-03-30 12:00:04.000000000 +0100
@@ -348,151 +348,7 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
-menu "Kernel hacking"
-
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config EARLY_PRINTK
-	bool "Early printk"
-	depends on EMBEDDED && DEBUG_KERNEL
-	default n
-	help
-	  Write kernel log output directly into the VGA buffer or to a serial
-	  port.
-
-	  This is useful for kernel debugging when your machine crashes very
-	  early before the console code is initialized. For normal operation
-	  it is not recommended because it looks ugly and doesn't cooperate
-	  with klogd/syslogd or the X server. You should normally N here,
-	  unless you want to debug such a crash.
-
-config DEBUG_STACKOVERFLOW
-	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here, you will have some control over the system even
-	  if the system crashes for example during kernel debugging (e.g., you
-	  will be able to flush the buffer cache to disk, reboot the system
-	  immediately or dump some status information). This is accomplished
-	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
-	  also works on a serial console (on PC hardware at least), if you
-	  send a BREAK and then within 5 seconds a command keypress. The
-	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
-	  unless you really know what this hack does.
-
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and build SMP to catch missing spinlock initialization
-	  and certain other kinds of spinlock errors commonly made.  This is
-	  best used in conjunction with the NMI watchdog so that spinlock
-	  deadlocks are also debuggable.
-
-config DEBUG_SPINLOCK_SLEEP
-	bool "Sleep-inside-spinlock checking"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here, various routines which may sleep will become very
-	  noisy if they are called with a spinlock held.
-
-config DEBUG_PAGEALLOC
-	bool "Page alloc debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Unmap pages from the kernel linear mapping after free_pages().
-	  This results in a large slowdown, but helps to find certain types
-	  of memory corruptions.
-
-config DEBUG_HIGHMEM
-	bool "Highmem debugging"
-	depends on DEBUG_KERNEL && HIGHMEM
-	help
-	  This options enables addition error checking for high memory systems.
-	  Disable for production systems.
-
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-
-config DEBUG_BUGVERBOSE
-	bool "Verbose BUG() reporting"
-	depends on DEBUG_KERNEL
-
-config FRAME_POINTER
-	bool "Compile the kernel with frame pointers"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here the resulting kernel image will be slightly larger
-	  and slower, but it will give very useful debugging information.
-	  If you don't debug the kernel, you can say N, but we may not be able
-	  to solve problems without frame pointers.
-
-config GDBSTUB
-	bool "Remote GDB kernel debugging"
-	depends on DEBUG_KERNEL
-	select DEBUG_INFO
-	select FRAME_POINTER
-	help
-	  If you say Y here, it will be possible to remotely debug the kernel
-	  using gdb. This enlarges your kernel ELF image disk size by several
-	  megabytes and requires a machine with more than 16 MB, better 32 MB
-	  RAM to avoid excessive linking time. This is only useful for kernel
-	  hackers. If unsure, say N.
-
-choice
-	prompt "GDB stub port"
-	default GDBSTUB_UART1
-	depends on GDBSTUB
-	help
-	  Select the on-CPU port used for GDB-stub
-
-config GDBSTUB_UART0
-	bool "/dev/ttyS0"
-
-config GDBSTUB_UART1
-	bool "/dev/ttyS1"
-
-endchoice
-
-config GDBSTUB_IMMEDIATE
-	bool "Break into GDB stub immediately"
-	depends on GDBSTUB
-	help
-	  If you say Y here, GDB stub will break into the program as soon as
-	  possible, leaving the program counter at the beginning of
-	  start_kernel() in init/main.c.
-
-config GDB_CONSOLE
-	bool "Console output to GDB"
-	depends on KGDB
-	help
-	  If you are using GDB for remote debugging over a serial port and
-	  would like kernel messages to be formatted into GDB $O packets so
-	  that GDB prints them as program output, say 'Y'.
-
-endmenu
+source "arch/frv/Kconfig.debug"
 
 source "security/Kconfig"
 
diff -uNrp /warthog/kernels/linux-2.6.12-rc1/arch/frv/Kconfig.debug linux-2.6.12-rc1-frv-tlbmiss/arch/frv/Kconfig.debug
--- /warthog/kernels/linux-2.6.12-rc1/arch/frv/Kconfig.debug	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc1-frv-tlbmiss/arch/frv/Kconfig.debug	2005-03-30 12:05:27.000000000 +0100
@@ -0,0 +1,74 @@
+menu "Kernel hacking"
+
+source "lib/Kconfig.debug"
+
+config EARLY_PRINTK
+	bool "Early printk"
+	depends on EMBEDDED && DEBUG_KERNEL
+	default n
+	help
+	  Write kernel log output directly into the VGA buffer or to a serial
+	  port.
+
+	  This is useful for kernel debugging when your machine crashes very
+	  early before the console code is initialized. For normal operation
+	  it is not recommended because it looks ugly and doesn't cooperate
+	  with klogd/syslogd or the X server. You should normally N here,
+	  unless you want to debug such a crash.
+
+config DEBUG_STACKOVERFLOW
+	bool "Check for stack overflows"
+	depends on DEBUG_KERNEL
+
+config DEBUG_PAGEALLOC
+	bool "Page alloc debugging"
+	depends on DEBUG_KERNEL
+	help
+	  Unmap pages from the kernel linear mapping after free_pages().
+	  This results in a large slowdown, but helps to find certain types
+	  of memory corruptions.
+
+config GDBSTUB
+	bool "Remote GDB kernel debugging"
+	depends on DEBUG_KERNEL
+	select DEBUG_INFO
+	select FRAME_POINTER
+	help
+	  If you say Y here, it will be possible to remotely debug the kernel
+	  using gdb. This enlarges your kernel ELF image disk size by several
+	  megabytes and requires a machine with more than 16 MB, better 32 MB
+	  RAM to avoid excessive linking time. This is only useful for kernel
+	  hackers. If unsure, say N.
+
+choice
+	prompt "GDB stub port"
+	default GDBSTUB_UART1
+	depends on GDBSTUB
+	help
+	  Select the on-CPU port used for GDB-stub
+
+config GDBSTUB_UART0
+	bool "/dev/ttyS0"
+
+config GDBSTUB_UART1
+	bool "/dev/ttyS1"
+
+endchoice
+
+config GDBSTUB_IMMEDIATE
+	bool "Break into GDB stub immediately"
+	depends on GDBSTUB
+	help
+	  If you say Y here, GDB stub will break into the program as soon as
+	  possible, leaving the program counter at the beginning of
+	  start_kernel() in init/main.c.
+
+config GDB_CONSOLE
+	bool "Console output to GDB"
+	depends on GDBSTUB
+	help
+	  If you are using GDB for remote debugging over a serial port and
+	  would like kernel messages to be formatted into GDB $O packets so
+	  that GDB prints them as program output, say 'Y'.
+
+endmenu
diff -uNrp /warthog/kernels/linux-2.6.12-rc1/lib/Kconfig.debug linux-2.6.12-rc1-frv-tlbmiss/lib/Kconfig.debug
--- /warthog/kernels/linux-2.6.12-rc1/lib/Kconfig.debug	2005-03-23 17:09:27.000000000 +0000
+++ linux-2.6.12-rc1-frv-tlbmiss/lib/Kconfig.debug	2005-03-30 12:04:02.000000000 +0100
@@ -108,7 +108,7 @@ config DEBUG_HIGHMEM
 
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
-	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || (X86 && !X86_64)
+	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || (X86 && !X86_64) || FRV
 	default !EMBEDDED
 	help
 	  Say Y here to make BUG() panics output the file name and line number
@@ -150,7 +150,7 @@ config DEBUG_FS
 
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU)
+	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU || FRV)
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
 	  and slower, but it will give very useful debugging information.
