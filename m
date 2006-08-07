Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWHGVLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWHGVLL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWHGVLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:11 -0400
Received: from xenotime.net ([66.160.160.81]:5595 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932373AbWHGVLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:08 -0400
Date: Mon, 7 Aug 2006 13:58:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>
Subject: [PATCH 3/9] Replace ARCH_HAS_READ_CURRENT_TIMER with
 CONFIG_ARCH_READ_CURRENT_TIMER
Message-Id: <20060807135840.753d186b.rdunlap@xenotime.net>
In-Reply-To: <20060807120928.c0fe7045.rdunlap@xenotime.net>
References: <20060807120928.c0fe7045.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Replace ARCH_HAS_READ_CURRENT_TIMER with CONFIG_ARCH_READ_CURRENT_TIMER.
Move it from header files to Kconfig space.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/Kconfig           |    3 +++
 arch/sparc64/Kconfig        |    3 +++
 arch/x86_64/Kconfig         |    3 +++
 include/asm-i386/timex.h    |    1 -
 include/asm-sparc64/timex.h |    1 -
 include/asm-x86_64/timex.h  |    1 -
 init/calibrate.c            |    2 +-
 7 files changed, 10 insertions(+), 4 deletions(-)

--- linux-2618-rc4-arch.orig/init/calibrate.c
+++ linux-2618-rc4-arch/init/calibrate.c
@@ -19,7 +19,7 @@ static int __init lpj_setup(char *str)
 
 __setup("lpj=", lpj_setup);
 
-#ifdef ARCH_HAS_READ_CURRENT_TIMER
+#ifdef CONFIG_ARCH_READ_CURRENT_TIMER
 
 /* This routine uses the read_current_timer() routine and gets the
  * loops per jiffy directly, instead of guessing it using delay().
--- linux-2618-rc4-arch.orig/include/asm-i386/timex.h
+++ linux-2618-rc4-arch/include/asm-i386/timex.h
@@ -17,6 +17,5 @@
 
 
 extern int read_current_timer(unsigned long *timer_value);
-#define ARCH_HAS_READ_CURRENT_TIMER	1
 
 #endif
--- linux-2618-rc4-arch.orig/include/asm-sparc64/timex.h
+++ linux-2618-rc4-arch/include/asm-sparc64/timex.h
@@ -14,7 +14,6 @@
 typedef unsigned long cycles_t;
 #define get_cycles()	tick_ops->get_tick()
 
-#define ARCH_HAS_READ_CURRENT_TIMER	1
 #define read_current_timer(timer_val_p) 	\
 ({	*timer_val_p = tick_ops->get_tick();	\
 	0;					\
--- linux-2618-rc4-arch.orig/include/asm-x86_64/timex.h
+++ linux-2618-rc4-arch/include/asm-x86_64/timex.h
@@ -42,7 +42,6 @@ static __always_inline cycles_t get_cycl
 extern unsigned int cpu_khz;
 
 extern int read_current_timer(unsigned long *timer_value);
-#define ARCH_HAS_READ_CURRENT_TIMER	1
 
 extern struct vxtime_data vxtime;
 
--- linux-2618-rc4-arch.orig/arch/i386/Kconfig
+++ linux-2618-rc4-arch/arch/i386/Kconfig
@@ -202,6 +202,9 @@ config X86_CYCLONE_TIMER
 	default y
 	depends on X86_SUMMIT || X86_GENERICARCH
 
+config ARCH_READ_CURRENT_TIMER
+	def_bool y
+
 config ES7000_CLUSTERED_APIC
 	bool
 	default y
--- linux-2618-rc4-arch.orig/arch/sparc64/Kconfig
+++ linux-2618-rc4-arch/arch/sparc64/Kconfig
@@ -34,6 +34,9 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
 
+config ARCH_READ_CURRENT_TIMER
+	def_bool y
+
 choice
 	prompt "Kernel page size"
 	default SPARC64_PAGE_SIZE_8KB
--- linux-2618-rc4-arch.orig/arch/x86_64/Kconfig
+++ linux-2618-rc4-arch/arch/x86_64/Kconfig
@@ -381,6 +381,9 @@ config HOTPLUG_CPU
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
 
+config ARCH_READ_CURRENT_TIMER
+	def_bool y
+
 config HPET_TIMER
 	bool
 	default y


---
