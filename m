Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267193AbTAFXZN>; Mon, 6 Jan 2003 18:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbTAFXZN>; Mon, 6 Jan 2003 18:25:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58004 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267193AbTAFXYn>;
	Mon, 6 Jan 2003 18:24:43 -0500
Date: Mon, 6 Jan 2003 15:30:00 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] configurable LOG_BUF_SIZE (updated)
In-Reply-To: <Pine.LNX.4.33L2.0301061257160.15416-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0301061523360.15416-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| | On Mon, 6 Jan 2003, Linus Torvalds wrote:
| |
| | | No, the reason I'm not crazy about it is that I simply _hate_ having too
| | | many user knobs to tweak. I don't like tweaking like that, it's just
| | | disturbing.
| | |---------------------------------------------------------------------------
| | | I'd probably be happier if the current one didn't even _ask_ the user (or|
| | | only asked the user if kernel debugging is enabled), and just silently   |
| | | defaulted to the normal values.                                          |
| | |---------------------------------------------------------------------------

Linus,

Here's a patch to the 2.5.54-bk4 snapshot that moves the Log Buffer size
to Kernel hacking, shows it only if Debugging is enabled, and uses
default values otherwise.

Please apply.

-- 
~Randy


 arch/alpha/Kconfig     |   27 +++++++++++++++++++++++++++
 arch/arm/Kconfig       |   27 +++++++++++++++++++++++++++
 arch/cris/Kconfig      |   27 +++++++++++++++++++++++++++
 arch/i386/Kconfig      |   27 +++++++++++++++++++++++++++
 arch/ia64/Kconfig      |   27 +++++++++++++++++++++++++++
 arch/m68k/Kconfig      |   27 +++++++++++++++++++++++++++
 arch/m68knommu/Kconfig |   27 +++++++++++++++++++++++++++
 arch/mips/Kconfig      |   27 +++++++++++++++++++++++++++
 arch/mips64/Kconfig    |   27 +++++++++++++++++++++++++++
 arch/parisc/Kconfig    |   27 +++++++++++++++++++++++++++
 arch/ppc/Kconfig       |   27 +++++++++++++++++++++++++++
 arch/ppc64/Kconfig     |   27 +++++++++++++++++++++++++++
 arch/s390/Kconfig      |   27 +++++++++++++++++++++++++++
 arch/s390x/Kconfig     |   27 +++++++++++++++++++++++++++
 arch/sh/Kconfig        |   27 +++++++++++++++++++++++++++
 arch/sparc/Kconfig     |   27 +++++++++++++++++++++++++++
 arch/sparc64/Kconfig   |   27 +++++++++++++++++++++++++++
 arch/um/Kconfig        |   27 +++++++++++++++++++++++++++
 arch/v850/Kconfig      |   27 +++++++++++++++++++++++++++
 arch/x86_64/Kconfig    |   27 +++++++++++++++++++++++++++
 init/Kconfig           |   45 ---------------------------------------------
 21 files changed, 540 insertions(+), 45 deletions(-)




--- ./arch/ppc/Kconfig%LGBUF	Wed Jan  1 19:23:15 2003
+++ ./arch/ppc/Kconfig	Mon Jan  6 14:45:33 2003
@@ -1623,6 +1623,33 @@
 config SERIAL_TEXT_DEBUG
 	bool "Support for early boot texts over serial port"
 	depends on 4xx || GT64260 || LOPEC || MCPN765 || PPLUS || PRPMC800 || SANDPOINT || ZX4500
+
+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif

 config OCP
 	bool
--- ./arch/i386/Kconfig%LGBUF	Wed Jan  1 19:21:10 2003
+++ ./arch/i386/Kconfig	Mon Jan  6 14:27:33 2003
@@ -1583,6 +1583,33 @@
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 config X86_EXTRA_IRQS
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
--- ./arch/m68k/Kconfig%LGBUF	Wed Jan  1 19:22:20 2003
+++ ./arch/m68k/Kconfig	Mon Jan  6 14:42:46 2003
@@ -1805,6 +1805,33 @@
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting"
 	depends on DEBUG_KERNEL
+
+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif

 endmenu

--- ./arch/sparc/Kconfig%LGBUF	Wed Jan  1 19:20:49 2003
+++ ./arch/sparc/Kconfig	Mon Jan  6 14:46:41 2003
@@ -1024,6 +1024,33 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/sparc64/Kconfig%LGBUF	Wed Jan  1 19:23:01 2003
+++ ./arch/sparc64/Kconfig	Mon Jan  6 14:47:10 2003
@@ -1661,6 +1661,33 @@
 	depends on STACK_DEBUG
 	default y

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/m68knommu/Kconfig%LGBUF	Wed Jan  1 19:22:32 2003
+++ ./arch/m68knommu/Kconfig	Mon Jan  6 14:43:59 2003
@@ -710,6 +710,33 @@
 	help
 	  Disable the CPU's BDM signals.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/alpha/Kconfig%LGBUF	Wed Jan  1 19:22:44 2003
+++ ./arch/alpha/Kconfig	Mon Jan  6 14:40:52 2003
@@ -982,6 +982,33 @@
 	  verbose debugging messages.  If you suspect a semaphore problem or a
 	  kernel hacker asks for this option then say Y.  Otherwise say N.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/cris/Kconfig%LGBUF	Wed Jan  1 19:23:05 2003
+++ ./arch/cris/Kconfig	Mon Jan  6 14:41:54 2003
@@ -710,6 +710,33 @@
 	depends on PROFILE
 	default "2"

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/mips/Kconfig%LGBUF	Wed Jan  1 19:21:58 2003
+++ ./arch/mips/Kconfig	Mon Jan  6 14:44:17 2003
@@ -1235,6 +1235,33 @@
 	depends on SMP
 	default "32"

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/x86_64/Kconfig%LGBUF	Wed Jan  1 19:22:53 2003
+++ ./arch/x86_64/Kconfig	Mon Jan  6 14:47:53 2003
@@ -701,6 +701,33 @@
          to solve problems without frame pointers.
 	 Note this is normally not needed on x86-64.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/ppc64/Kconfig%LGBUF	Wed Jan  1 19:22:18 2003
+++ ./arch/ppc64/Kconfig	Mon Jan  6 14:45:47 2003
@@ -510,6 +510,33 @@
 	bool "Include PPCDBG realtime debugging"
 	depends on DEBUG_KERNEL

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/um/Kconfig%LGBUF	Wed Jan  1 19:22:00 2003
+++ ./arch/um/Kconfig	Mon Jan  6 14:47:26 2003
@@ -262,5 +262,32 @@
         If you're involved in UML kernel development and want to use gcov,
         say Y.  If you're unsure, say N.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

--- ./arch/arm/Kconfig%LGBUF	Wed Jan  1 19:22:17 2003
+++ ./arch/arm/Kconfig	Mon Jan  6 14:41:45 2003
@@ -1180,6 +1180,33 @@
 	  Say Y here if you want the debug print routines to direct their
 	  output to the second serial port on these devices.  Saying N will
 	  cause the debug messages to appear on the first serial port.
+
+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif

 endmenu

--- ./arch/parisc/Kconfig%LGBUF	Wed Jan  1 19:22:20 2003
+++ ./arch/parisc/Kconfig	Mon Jan  6 14:44:47 2003
@@ -375,6 +375,33 @@
 	  symbolic stack backtraces. This increases the size of the kernel
 	  somewhat, as all symbols have to be loaded into the kernel image.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/ia64/Kconfig%LGBUF	Wed Jan  1 19:23:09 2003
+++ ./arch/ia64/Kconfig	Mon Jan  6 14:42:34 2003
@@ -889,6 +889,33 @@
 	  and restore instructions.  It's useful for tracking down spinlock
 	  problems, but slow!  If you're unsure, select N.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/mips64/Kconfig%LGBUF	Wed Jan  1 19:21:38 2003
+++ ./arch/mips64/Kconfig	Mon Jan  6 14:44:33 2003
@@ -678,6 +678,33 @@
 	depends on SMP
 	default "64"

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/v850/Kconfig%LGBUF	Wed Jan  1 19:21:53 2003
+++ ./arch/v850/Kconfig	Mon Jan  6 14:47:42 2003
@@ -403,6 +403,33 @@
 	help
 	  Disable the CPU's BDM signals.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/s390x/Kconfig%LGBUF	Wed Jan  1 19:22:05 2003
+++ ./arch/s390x/Kconfig	Mon Jan  6 14:46:14 2003
@@ -342,6 +342,33 @@
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
+
+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif

 endmenu

--- ./arch/sh/Kconfig%LGBUF	Wed Jan  1 19:23:15 2003
+++ ./arch/sh/Kconfig	Mon Jan  6 14:46:27 2003
@@ -1226,6 +1226,33 @@
 	  when the kernel may crash or hang before the serial console is
 	  initialised. If unsure, say N.

+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif
+
 endmenu

 source "security/Kconfig"
--- ./arch/s390/Kconfig%LGBUF	Wed Jan  1 19:21:48 2003
+++ ./arch/s390/Kconfig	Mon Jan  6 14:46:03 2003
@@ -328,6 +328,33 @@
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
+
+if DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
+endif
+
+if !DEBUG_KERNEL
+config LOG_BUF_SHIFT
+	int
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+endif

 endmenu

--- ./init/Kconfig%LGBUF	Mon Jan  6 11:52:14 2003
+++ ./init/Kconfig	Mon Jan  6 11:55:00 2003
@@ -82,51 +82,6 @@
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.

-choice
-	prompt "Kernel log buffer size"
-	default LOG_BUF_SHIFT_17 if ARCH_S390
-	default LOG_BUF_SHIFT_16 if X86_NUMAQ || IA64
-	default LOG_BUF_SHIFT_15 if SMP
-	default LOG_BUF_SHIFT_14
-	help
-	  Select kernel log buffer size from this list (power of 2).
-	  Defaults:  17 (=> 128 KB for S/390)
-		     16 (=> 64 KB for x86 NUMAQ or IA-64)
-	             15 (=> 32 KB for SMP)
-	             14 (=> 16 KB for uniprocessor)
-
-config LOG_BUF_SHIFT_17
-	bool "128 KB"
-	default y if ARCH_S390
-
-config LOG_BUF_SHIFT_16
-	bool "64 KB"
-	default y if X86_NUMAQ || IA64
-
-config LOG_BUF_SHIFT_15
-	bool "32 KB"
-	default y if SMP
-
-config LOG_BUF_SHIFT_14
-	bool "16 KB"
-
-config LOG_BUF_SHIFT_13
-	bool "8 KB"
-
-config LOG_BUF_SHIFT_12
-	bool "4 KB"
-
-endchoice
-
-config LOG_BUF_SHIFT
-	int
-	default 17 if LOG_BUF_SHIFT_17=y
-	default 16 if LOG_BUF_SHIFT_16=y
-	default 15 if LOG_BUF_SHIFT_15=y
-	default 14 if LOG_BUF_SHIFT_14=y
-	default 13 if LOG_BUF_SHIFT_13=y
-	default 12 if LOG_BUF_SHIFT_12=y
-
 endmenu



