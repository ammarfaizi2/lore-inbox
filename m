Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWHGVNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWHGVNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWHGVLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:49 -0400
Received: from xenotime.net ([66.160.160.81]:15323 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932383AbWHGVLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:12 -0400
Date: Mon, 7 Aug 2006 14:09:11 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>, len.brown@intel.com
Subject: [PATCH 9/9] Replace ARCH_HAS_POWER_INIT with CONFIG_ACPI_POWER_INIT
Message-Id: <20060807140911.7836619e.rdunlap@xenotime.net>
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

Replace ARCH_HAS_POWER_INIT with CONFIG_ACPI_POWER_INIT.
Move it from header files to Kconfig space.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/Kconfig      |    4 ++++
 include/acpi/processor.h  |    2 +-
 include/asm-i386/acpi.h   |    2 --
 include/asm-x86_64/acpi.h |    2 --
 4 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2618-rc4-arch.orig/include/acpi/processor.h
+++ linux-2618-rc4-arch/include/acpi/processor.h
@@ -203,7 +203,7 @@ extern struct acpi_processor_errata erra
 
 void arch_acpi_processor_init_pdc(struct acpi_processor *pr);
 
-#ifdef ARCH_HAS_POWER_INIT
+#ifdef CONFIG_ACPI_POWER_INIT
 void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 					unsigned int cpu);
 #else
--- linux-2618-rc4-arch.orig/drivers/acpi/Kconfig
+++ linux-2618-rc4-arch/drivers/acpi/Kconfig
@@ -295,6 +295,10 @@ config ACPI_POWER
 	bool
 	default y
 
+config ACPI_POWER_INIT
+	def_bool y
+	depends on X86
+
 config ACPI_SYSTEM
 	bool
 	default y
--- linux-2618-rc4-arch.orig/include/asm-i386/acpi.h
+++ linux-2618-rc4-arch/include/asm-i386/acpi.h
@@ -181,8 +181,6 @@ extern void acpi_reserve_bootmem(void);
 
 extern u8 x86_acpiid_to_apicid[];
 
-#define ARCH_HAS_POWER_INIT	1
-
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/
--- linux-2618-rc4-arch.orig/include/asm-x86_64/acpi.h
+++ linux-2618-rc4-arch/include/asm-x86_64/acpi.h
@@ -162,8 +162,6 @@ extern int acpi_pci_disabled;
 
 extern u8 x86_acpiid_to_apicid[];
 
-#define ARCH_HAS_POWER_INIT 1
-
 extern int acpi_skip_timer_override;
 
 #endif /*__KERNEL__*/


---
