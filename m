Return-Path: <linux-kernel-owner+w=401wt.eu-S1752486AbWLSFQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbWLSFQB (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 00:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbWLSFQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 00:16:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:44706 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbWLSFP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 00:15:59 -0500
Date: Tue, 19 Dec 2006 10:45:55 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Sam Ravnborg <sam@ravnborg.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/5] Convert some functions to __init to avoid MODPOST warnings
Message-ID: <20061219051555.GB26052@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Some functions which should have been in init sections as they are called
  only once. Put them in init sections. Otherwise MODPOST generates warning
  as these functions are placed in .text and they end up accessing something
  in init sections.

WARNING: vmlinux - Section mismatch: reference to .init.text:migration_init
from .text between 'do_pre_smp_initcalls' (at offset 0xc01000d1) and
'run_init_process'

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/acpi/boot.c       |    2 +-
 arch/i386/kernel/acpi/earlyquirk.c |    2 +-
 arch/i386/kernel/setup.c           |    2 +-
 init/main.c                        |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~convert-some-functions-to-init-to-avoid-warnings arch/i386/kernel/acpi/boot.c
--- linux-2.6.19-rc1-reloc/arch/i386/kernel/acpi/boot.c~convert-some-functions-to-init-to-avoid-warnings	2006-12-15 14:08:59.000000000 +0530
+++ linux-2.6.19-rc1-reloc-root/arch/i386/kernel/acpi/boot.c	2006-12-15 14:08:59.000000000 +0530
@@ -333,7 +333,7 @@ acpi_parse_ioapic(acpi_table_entry_heade
 /*
  * Parse Interrupt Source Override for the ACPI SCI
  */
-static void acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
+static void __init acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
 {
 	if (trigger == 0)	/* compatible SCI trigger is level */
 		trigger = 3;
diff -puN arch/i386/kernel/acpi/earlyquirk.c~convert-some-functions-to-init-to-avoid-warnings arch/i386/kernel/acpi/earlyquirk.c
--- linux-2.6.19-rc1-reloc/arch/i386/kernel/acpi/earlyquirk.c~convert-some-functions-to-init-to-avoid-warnings	2006-12-15 14:08:59.000000000 +0530
+++ linux-2.6.19-rc1-reloc-root/arch/i386/kernel/acpi/earlyquirk.c	2006-12-15 14:08:59.000000000 +0530
@@ -50,7 +50,7 @@ static int __init check_bridge(int vendo
 	return 0;
 }
 
-static void check_intel(void)
+static void __init check_intel(void)
 {
 	u16 vendor, device;
 
diff -puN arch/i386/kernel/setup.c~convert-some-functions-to-init-to-avoid-warnings arch/i386/kernel/setup.c
--- linux-2.6.19-rc1-reloc/arch/i386/kernel/setup.c~convert-some-functions-to-init-to-avoid-warnings	2006-12-15 14:08:59.000000000 +0530
+++ linux-2.6.19-rc1-reloc-root/arch/i386/kernel/setup.c	2006-12-15 14:08:59.000000000 +0530
@@ -495,7 +495,7 @@ static void set_mca_bus(int x) { }
 #endif
 
 /* Overridden in paravirt.c if CONFIG_PARAVIRT */
-char * __attribute__((weak)) memory_setup(void)
+char * __init __attribute__((weak)) memory_setup(void)
 {
 	return machine_specific_memory_setup();
 }
diff -puN init/main.c~convert-some-functions-to-init-to-avoid-warnings init/main.c
--- linux-2.6.19-rc1-reloc/init/main.c~convert-some-functions-to-init-to-avoid-warnings	2006-12-15 14:08:59.000000000 +0530
+++ linux-2.6.19-rc1-reloc-root/init/main.c	2006-12-15 14:09:57.000000000 +0530
@@ -698,7 +698,7 @@ static void __init do_basic_setup(void)
 	do_initcalls();
 }
 
-static void do_pre_smp_initcalls(void)
+static void __init do_pre_smp_initcalls(void)
 {
 	extern int spawn_ksoftirqd(void);
 #ifdef CONFIG_SMP
_
