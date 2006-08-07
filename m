Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWHGVLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWHGVLK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWHGVLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:09 -0400
Received: from xenotime.net ([66.160.160.81]:5851 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932376AbWHGVLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:08 -0400
Date: Mon, 7 Aug 2006 14:00:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>
Subject: [PATCH 4/9] Replace ARCH_HAS_NMI_WATCHDOG with
 CONFIG_ARCH_NMI_WATCHDOG
Message-Id: <20060807140040.84f41ef1.rdunlap@xenotime.net>
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

Replace ARCH_HAS_NMI_WATCHDOG with CONFIG_ARCH_NMI_WATCHDOG.
Move it from header files to Kconfig space.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/Kconfig        |    4 ++++
 arch/x86_64/Kconfig      |    4 ++++
 include/asm-i386/irq.h   |    4 ----
 include/asm-x86_64/irq.h |    4 ----
 include/linux/nmi.h      |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2618-rc4-arch.orig/include/asm-i386/irq.h
+++ linux-2618-rc4-arch/include/asm-i386/irq.h
@@ -20,10 +20,6 @@ static __inline__ int irq_canonicalize(i
 	return ((irq == 2) ? 9 : irq);
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
-# define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
-#endif
-
 #ifdef CONFIG_4KSTACKS
   extern void irq_ctx_init(int cpu);
   extern void irq_ctx_exit(int cpu);
--- linux-2618-rc4-arch.orig/include/asm-x86_64/irq.h
+++ linux-2618-rc4-arch/include/asm-x86_64/irq.h
@@ -44,10 +44,6 @@ static __inline__ int irq_canonicalize(i
 	return ((irq == 2) ? 9 : irq);
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
-#define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
-#endif
-
 #ifdef CONFIG_HOTPLUG_CPU
 #include <linux/cpumask.h>
 extern void fixup_irqs(cpumask_t map);
--- linux-2618-rc4-arch.orig/include/linux/nmi.h
+++ linux-2618-rc4-arch/include/linux/nmi.h
@@ -13,7 +13,7 @@
  * may be used to reset the timeout - for code which intentionally
  * disables interrupts for a long time. This call is stateless.
  */
-#ifdef ARCH_HAS_NMI_WATCHDOG
+#ifdef CONFIG_ARCH_NMI_WATCHDOG
 extern void touch_nmi_watchdog(void);
 #else
 # define touch_nmi_watchdog() do { } while(0)
--- linux-2618-rc4-arch.orig/arch/i386/Kconfig
+++ linux-2618-rc4-arch/arch/i386/Kconfig
@@ -292,6 +292,10 @@ config X86_LOCAL_APIC
 	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER)
 	default y
 
+config ARCH_NMI_WATCHDOG
+	def_bool y
+	depends on X86_LOCAL_APIC
+
 config X86_IO_APIC
 	bool
 	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER))
--- linux-2618-rc4-arch.orig/arch/x86_64/Kconfig
+++ linux-2618-rc4-arch/arch/x86_64/Kconfig
@@ -213,6 +213,10 @@ config X86_LOCAL_APIC
 	bool
 	default y
 
+config ARCH_NMI_WATCHDOG
+	def_bool y
+	depends on X86_LOCAL_APIC
+
 config MTRR
 	bool "MTRR (Memory Type Range Register) support"
 	---help---


---
