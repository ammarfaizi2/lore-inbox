Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUK1XIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUK1XIp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUK1XIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:08:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41745 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261602AbUK1XIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:08:14 -0500
Date: Mon, 29 Nov 2004 00:08:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, discuss@x86-64.org
Subject: [2.6 patch] i386 cpu/common.c: some cleanups
Message-ID: <20041128230811.GL4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following changes:
- make some needlessly global code static
- remove the unused dodgy_tsc function
- remove the stale dodgy_tsc z86_64 prototype


diffstat output:
 arch/i386/kernel/cpu/common.c  |   15 ++-------------
 arch/i386/kernel/cpu/cpu.h     |    1 -
 include/asm-i386/processor.h   |    1 -
 include/asm-x86_64/processor.h |    1 -
 4 files changed, 2 insertions(+), 16 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/cpu.h.old	2004-11-28 21:03:26.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/cpu.h	2004-11-28 21:03:32.000000000 +0100
@@ -25,7 +25,6 @@
 extern void display_cacheinfo(struct cpuinfo_x86 *c);
 
 extern void generic_identify(struct cpuinfo_x86 * c);
-extern int have_cpuid_p(void);
 
 extern void early_intel_workaround(struct cpuinfo_x86 *c);
 
--- linux-2.6.10-rc2-mm3-full/include/asm-i386/processor.h.old	2004-11-28 21:01:43.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/asm-i386/processor.h	2004-11-28 21:01:56.000000000 +0100
@@ -101,7 +101,6 @@
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
-extern void dodgy_tsc(void);
 
 /*
  * EFLAGS bits
--- linux-2.6.10-rc2-mm3-full/include/asm-x86_64/processor.h.old	2004-11-28 21:02:04.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/asm-x86_64/processor.h	2004-11-28 21:02:08.000000000 +0100
@@ -91,7 +91,6 @@
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
-extern void dodgy_tsc(void);
 
 /*
  * EFLAGS bits
--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/common.c.old	2004-11-28 21:02:16.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/common.c	2004-11-28 21:03:13.000000000 +0100
@@ -194,7 +194,7 @@
 
 
 /* Probe for the CPUID instruction */
-int __init have_cpuid_p(void)
+static int __init have_cpuid_p(void)
 {
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
@@ -202,7 +202,7 @@
 /* Do minimum CPU detection early.
    Fields really needed: vendor, cpuid_level, family, model, mask, cache alignment.
    The others are not touched to avoid unwanted side effects. */
-void __init early_cpu_detect(void)
+static void __init early_cpu_detect(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
@@ -421,16 +421,6 @@
 	mcheck_init(c);
 #endif
 }
-/*
- *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time.c
- */
- 
-void __init dodgy_tsc(void)
-{
-	if (( boot_cpu_data.x86_vendor == X86_VENDOR_CYRIX ) ||
-	    ( boot_cpu_data.x86_vendor == X86_VENDOR_NSC   ))
-		cpu_devs[X86_VENDOR_CYRIX]->c_init(&boot_cpu_data);
-}
 
 void __init print_cpu_info(struct cpuinfo_x86 *c)
 {
@@ -474,7 +464,6 @@
 extern int rise_init_cpu(void);
 extern int nexgen_init_cpu(void);
 extern int umc_init_cpu(void);
-void early_cpu_detect(void);
 
 void __init early_cpu_init(void)
 {
