Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbUK1XGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbUK1XGG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUK1XGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:06:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29713 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261594AbUK1XFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:05:38 -0500
Date: Mon, 29 Nov 2004 00:05:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rgooch@atnf.csiro.au
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mtrr: some cleanups
Message-ID: <20041128230537.GK4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following changes:
- make some needlessly global code static
- remove the unused mtrr_if_name


diffstat output:
 arch/i386/kernel/cpu/mtrr/cyrix.c   |    4 ++--
 arch/i386/kernel/cpu/mtrr/generic.c |    8 ++++----
 arch/i386/kernel/cpu/mtrr/main.c    |    6 +-----
 arch/i386/kernel/cpu/mtrr/mtrr.h    |    2 --
 4 files changed, 7 insertions(+), 13 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/mtrr/mtrr.h.old	2004-11-28 20:54:40.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/mtrr/mtrr.h	2004-11-28 20:55:53.000000000 +0100
@@ -57,7 +57,6 @@
 
 extern struct mtrr_ops generic_mtrr_ops;
 
-extern int generic_have_wrcomb(void);
 extern int positive_have_wrcomb(void);
 
 /* library functions for processor-specific routines */
@@ -96,4 +95,3 @@
 void mtrr_state_warn(void);
 char *mtrr_attrib_to_str(int x);
 
-extern char * mtrr_if_name[];
--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/mtrr/cyrix.c.old	2004-11-28 20:53:32.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/mtrr/cyrix.c	2004-11-28 20:53:48.000000000 +0100
@@ -218,12 +218,12 @@
 	mtrr_type type;
 } arr_state_t;
 
-arr_state_t arr_state[8] __initdata = {
+static arr_state_t arr_state[8] __initdata = {
 	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL},
 	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}
 };
 
-unsigned char ccr_state[7] __initdata = { 0, 0, 0, 0, 0, 0, 0 };
+static unsigned char ccr_state[7] __initdata = { 0, 0, 0, 0, 0, 0, 0 };
 
 static void cyrix_set_all(void)
 {
--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/mtrr/generic.c.old	2004-11-28 20:54:02.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/mtrr/generic.c	2004-11-28 20:55:32.000000000 +0100
@@ -19,7 +19,7 @@
 };
 
 static unsigned long smp_changes_mask;
-struct mtrr_state mtrr_state = {};
+static struct mtrr_state mtrr_state = {};
 
 
 /*  Get the MSR pair relating to a var range  */
@@ -115,8 +115,8 @@
 	return -ENOSPC;
 }
 
-void generic_get_mtrr(unsigned int reg, unsigned long *base,
-		      unsigned int *size, mtrr_type * type)
+static void generic_get_mtrr(unsigned int reg, unsigned long *base,
+			     unsigned int *size, mtrr_type * type)
 {
 	unsigned int mask_lo, mask_hi, base_lo, base_hi;
 
@@ -372,7 +372,7 @@
 }
 
 
-int generic_have_wrcomb(void)
+static int generic_have_wrcomb(void)
 {
 	unsigned long config, dummy;
 	rdmsr(MTRRcap_MSR, config, dummy);
--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/mtrr/main.c.old	2004-11-28 20:56:00.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/mtrr/main.c	2004-11-28 20:56:26.000000000 +0100
@@ -57,10 +57,6 @@
 
 struct mtrr_ops * mtrr_if = NULL;
 
-__initdata char *mtrr_if_name[] = {
-    "none", "Intel", "AMD K6", "Cyrix ARR", "Centaur MCR"
-};
-
 static void set_mtrr(unsigned int reg, unsigned long base,
 		     unsigned long size, mtrr_type type);
 
@@ -100,7 +96,7 @@
 }
 
 /*  This function returns the number of variable MTRRs  */
-void __init set_num_var_ranges(void)
+static void __init set_num_var_ranges(void)
 {
 	unsigned long config = 0, dummy;
 

