Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUBSVLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUBSVLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:11:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:46291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267311AbUBSVKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:10:52 -0500
Date: Thu, 19 Feb 2004 13:03:26 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtrr: init section usage
Message-Id: <20040219130326.5f72836e.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch tries to clean up init section usage in
arch/i386/kernel/cpu/mtrr/*.c.

Comments, corrections?

Andrew, will you put this in -mm for some testing?

Thanks,
--
~Randy


applies_to:	linux-263
description:	add/remove some __init section uses in mtrr/
		plus a small bit of source formatting;

diffstat:=
 arch/i386/kernel/cpu/mtrr/generic.c |    6 +++---
 arch/i386/kernel/cpu/mtrr/main.c    |   14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)


diff -Naurp ./arch/i386/kernel/cpu/mtrr/main.c~mtrrinit ./arch/i386/kernel/cpu/mtrr/main.c
--- ./arch/i386/kernel/cpu/mtrr/main.c~mtrrinit	2004-02-17 19:57:14.000000000 -0800
+++ ./arch/i386/kernel/cpu/mtrr/main.c	2004-02-19 11:13:11.000000000 -0800
@@ -111,7 +111,7 @@ void __init set_num_var_ranges(void)
 	num_var_ranges = config & 0xff;
 }
 
-static void init_table(void)
+static void __init init_table(void)
 {
 	int i, max;
 
@@ -541,7 +541,7 @@ static void __init init_ifs(void)
 	centaur_init_mtrr();
 }
 
-static void init_other_cpus(void)
+static void __init init_other_cpus(void)
 {
 	if (use_intel())
 		get_mtrr_state();
@@ -608,7 +608,7 @@ static struct sysdev_driver mtrr_sysdev_
 
 
 /**
- * mtrr_init - initialie mtrrs on the boot CPU
+ * mtrr_init - initialize mtrrs on the boot CPU
  *
  * This needs to be called early; before any of the other CPUs are 
  * initialized (i.e. before smp_init()).
@@ -618,7 +618,7 @@ static int __init mtrr_init(void)
 {
 	init_ifs();
 
-	if ( cpu_has_mtrr ) {
+	if (cpu_has_mtrr) {
 		mtrr_if = &generic_mtrr_ops;
 		size_or_mask = 0xff000000;	/* 36 bits */
 		size_and_mask = 0x00f00000;
@@ -660,7 +660,7 @@ static int __init mtrr_init(void)
 	} else {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
-			if ( cpu_has_k6_mtrr ) {
+			if (cpu_has_k6_mtrr) {
 				/* Pre-Athlon (K6) AMD CPU MTRRs */
 				mtrr_if = mtrr_ops[X86_VENDOR_AMD];
 				size_or_mask = 0xfff00000;	/* 32 bits */
@@ -668,14 +668,14 @@ static int __init mtrr_init(void)
 			}
 			break;
 		case X86_VENDOR_CENTAUR:
-			if ( cpu_has_centaur_mcr ) {
+			if (cpu_has_centaur_mcr) {
 				mtrr_if = mtrr_ops[X86_VENDOR_CENTAUR];
 				size_or_mask = 0xfff00000;	/* 32 bits */
 				size_and_mask = 0;
 			}
 			break;
 		case X86_VENDOR_CYRIX:
-			if ( cpu_has_cyrix_arr ) {
+			if (cpu_has_cyrix_arr) {
 				mtrr_if = mtrr_ops[X86_VENDOR_CYRIX];
 				size_or_mask = 0xfff00000;	/* 32 bits */
 				size_and_mask = 0;
diff -Naurp ./arch/i386/kernel/cpu/mtrr/generic.c~mtrrinit ./arch/i386/kernel/cpu/mtrr/generic.c
--- ./arch/i386/kernel/cpu/mtrr/generic.c~mtrrinit	2004-02-17 19:58:16.000000000 -0800
+++ ./arch/i386/kernel/cpu/mtrr/generic.c	2004-02-19 11:42:32.000000000 -0800
@@ -45,7 +45,7 @@ get_fixed_ranges(mtrr_type * frs)
 }
 
 /*  Grab all of the MTRR state for this CPU into *state  */
-void get_mtrr_state(void)
+void __init get_mtrr_state(void)
 {
 	unsigned int i;
 	struct mtrr_var_range *vrs;
@@ -142,7 +142,7 @@ void generic_get_mtrr(unsigned int reg, 
 	*type = base_lo & 0xff;
 }
 
-static int __init set_fixed_ranges(mtrr_type * frs)
+static int set_fixed_ranges(mtrr_type * frs)
 {
 	unsigned int *p = (unsigned int *) frs;
 	int changed = FALSE;
@@ -177,7 +177,7 @@ static int __init set_fixed_ranges(mtrr_
 
 /*  Set the MSR pair relating to a var range. Returns TRUE if
     changes are made  */
-static int __init set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
+static int set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 {
 	unsigned int lo, hi;
 	int changed = FALSE;
