Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWEWSHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWEWSHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWEWSHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:07:34 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:63965 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750832AbWEWSHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:07:33 -0400
Date: Tue, 23 May 2006 20:07:32 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: constify some parts of arch/i386/kernel/cpu/
Message-ID: <20060523180732.GD24461@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

patch run-tested on linux-2.6.17-rc4-mm3.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/cpu/intel_cacheinfo.c linux-2.6.17-rc4-mm3.my/arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-05-23 19:14:13.000000000 +0200
+++ linux-2.6.17-rc4-mm3/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-05-23 17:27:28.000000000 +0200
@@ -159,13 +159,13 @@
 	unsigned val;
 };
 
-static unsigned short assocs[] = {
+static const unsigned short assocs[] = {
 	[1] = 1, [2] = 2, [4] = 4, [6] = 8,
 	[8] = 16,
 	[0xf] = 0xffff // ??
 	};
-static unsigned char levels[] = { 1, 1, 2 };
-static unsigned char types[] = { 1, 2, 3 };
+static const unsigned char levels[] = { 1, 1, 2 };
+static const unsigned char types[] = { 1, 2, 3 };
 
 static void __cpuinit amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 		       union _cpuid4_leaf_ebx *ebx,
diff -urN linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/cpu/proc.c linux-2.6.17-rc4-mm3.my/arch/i386/kernel/cpu/proc.c
--- linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/cpu/proc.c	2006-05-23 19:13:13.000000000 +0200
+++ linux-2.6.17-rc4-mm3/arch/i386/kernel/cpu/proc.c	2006-05-22 17:42:41.000000000 +0200
@@ -18,7 +18,7 @@
 	 * applications want to get the raw CPUID data, they should access
 	 * /dev/cpu/<cpu_nr>/cpuid instead.
 	 */
-	static char *x86_cap_flags[] = {
+	static const char * const x86_cap_flags[] = {
 		/* Intel-defined */
 	        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
 	        "cx8", "apic", NULL, "sep", "mtrr", "pge", "mca", "cmov",
@@ -62,7 +62,7 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 	};
-	static char *x86_power_flags[] = {
+	static const char * const x86_power_flags[] = {
 		"ts",	/* temperature sensor */
 		"fid",  /* frequency id control */
 		"vid",  /* voltage id control */
