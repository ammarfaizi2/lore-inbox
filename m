Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbWHJTkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbWHJTkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWHJTiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:24812 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932692AbWHJThn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:43 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [141/145] i386: mark cpu init functions as __cpuinit, data as __cpuinitdata
Message-Id: <20060810193741.A0D4513B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:41 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Magnus Damm <magnus@valinux.co.jp>

Mark i386-specific cpu init functions as __cpuinit. They are all
only called from arch/i386/common.c:identify_cpu() that already is marked as
__cpuinit. This patch also removes the empty function init_umc().

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/i386/kernel/cpu/amd.c       |    2 +-
 arch/i386/kernel/cpu/centaur.c   |   20 ++++++++++----------
 arch/i386/kernel/cpu/common.c    |    2 +-
 arch/i386/kernel/cpu/cyrix.c     |   32 ++++++++++++++++----------------
 arch/i386/kernel/cpu/nexgen.c    |    2 +-
 arch/i386/kernel/cpu/rise.c      |    2 +-
 arch/i386/kernel/cpu/transmeta.c |    2 +-
 arch/i386/kernel/cpu/umc.c       |    5 -----
 8 files changed, 31 insertions(+), 36 deletions(-)

Index: linux/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/amd.c
+++ linux/arch/i386/kernel/cpu/amd.c
@@ -22,7 +22,7 @@
 extern void vide(void);
 __asm__(".align 4\nvide: ret");
 
-static void __init init_amd(struct cpuinfo_x86 *c)
+static void __cpuinit init_amd(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int mbytes = num_physpages >> (20-PAGE_SHIFT);
Index: linux/arch/i386/kernel/cpu/centaur.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/centaur.c
+++ linux/arch/i386/kernel/cpu/centaur.c
@@ -9,7 +9,7 @@
 
 #ifdef CONFIG_X86_OOSTORE
 
-static u32 __init power2(u32 x)
+static u32 __cpuinit power2(u32 x)
 {
 	u32 s=1;
 	while(s<=x)
@@ -22,7 +22,7 @@ static u32 __init power2(u32 x)
  *	Set up an actual MCR
  */
  
-static void __init centaur_mcr_insert(int reg, u32 base, u32 size, int key)
+static void __cpuinit centaur_mcr_insert(int reg, u32 base, u32 size, int key)
 {
 	u32 lo, hi;
 	
@@ -40,7 +40,7 @@ static void __init centaur_mcr_insert(in
  *	Shortcut: We know you can't put 4Gig of RAM on a winchip
  */
 
-static u32 __init ramtop(void)		/* 16388 */
+static u32 __cpuinit ramtop(void)		/* 16388 */
 {
 	int i;
 	u32 top = 0;
@@ -91,7 +91,7 @@ static u32 __init ramtop(void)		/* 16388
  *	Compute a set of MCR's to give maximum coverage
  */
 
-static int __init centaur_mcr_compute(int nr, int key)
+static int __cpuinit centaur_mcr_compute(int nr, int key)
 {
 	u32 mem = ramtop();
 	u32 root = power2(mem);
@@ -166,7 +166,7 @@ static int __init centaur_mcr_compute(in
 	return ct;
 }
 
-static void __init centaur_create_optimal_mcr(void)
+static void __cpuinit centaur_create_optimal_mcr(void)
 {
 	int i;
 	/*
@@ -189,7 +189,7 @@ static void __init centaur_create_optima
 		wrmsr(MSR_IDT_MCR0+i, 0, 0);
 }
 
-static void __init winchip2_create_optimal_mcr(void)
+static void __cpuinit winchip2_create_optimal_mcr(void)
 {
 	u32 lo, hi;
 	int i;
@@ -227,7 +227,7 @@ static void __init winchip2_create_optim
  *	Handle the MCR key on the Winchip 2.
  */
 
-static void __init winchip2_unprotect_mcr(void)
+static void __cpuinit winchip2_unprotect_mcr(void)
 {
 	u32 lo, hi;
 	u32 key;
@@ -239,7 +239,7 @@ static void __init winchip2_unprotect_mc
 	wrmsr(MSR_IDT_MCR_CTRL, lo, hi);
 }
 
-static void __init winchip2_protect_mcr(void)
+static void __cpuinit winchip2_protect_mcr(void)
 {
 	u32 lo, hi;
 	
@@ -257,7 +257,7 @@ static void __init winchip2_protect_mcr(
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 6)	/* MSR_VIA_RNG */
 
-static void __init init_c3(struct cpuinfo_x86 *c)
+static void __cpuinit init_c3(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
 
@@ -303,7 +303,7 @@ static void __init init_c3(struct cpuinf
 	display_cacheinfo(c);
 }
 
-static void __init init_centaur(struct cpuinfo_x86 *c)
+static void __cpuinit init_centaur(struct cpuinfo_x86 *c)
 {
 	enum {
 		ECX8=1<<1,
Index: linux/arch/i386/kernel/cpu/common.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/common.c
+++ linux/arch/i386/kernel/cpu/common.c
@@ -36,7 +36,7 @@ struct cpu_dev * cpu_devs[X86_VENDOR_NUM
 
 extern int disable_pse;
 
-static void default_init(struct cpuinfo_x86 * c)
+static void __cpuinit default_init(struct cpuinfo_x86 * c)
 {
 	/* Not much we can do here... */
 	/* Check if at least it has cpuid */
Index: linux/arch/i386/kernel/cpu/cyrix.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/cyrix.c
+++ linux/arch/i386/kernel/cpu/cyrix.c
@@ -52,25 +52,25 @@ static void __init do_cyrix_devid(unsign
  * Actually since bugs.h doesn't even reference this perhaps someone should
  * fix the documentation ???
  */
-static unsigned char Cx86_dir0_msb __initdata = 0;
+static unsigned char Cx86_dir0_msb __cpuinitdata = 0;
 
-static char Cx86_model[][9] __initdata = {
+static char Cx86_model[][9] __cpuinitdata = {
 	"Cx486", "Cx486", "5x86 ", "6x86", "MediaGX ", "6x86MX ",
 	"M II ", "Unknown"
 };
-static char Cx486_name[][5] __initdata = {
+static char Cx486_name[][5] __cpuinitdata = {
 	"SLC", "DLC", "SLC2", "DLC2", "SRx", "DRx",
 	"SRx2", "DRx2"
 };
-static char Cx486S_name[][4] __initdata = {
+static char Cx486S_name[][4] __cpuinitdata = {
 	"S", "S2", "Se", "S2e"
 };
-static char Cx486D_name[][4] __initdata = {
+static char Cx486D_name[][4] __cpuinitdata = {
 	"DX", "DX2", "?", "?", "?", "DX4"
 };
-static char Cx86_cb[] __initdata = "?.5x Core/Bus Clock";
-static char cyrix_model_mult1[] __initdata = "12??43";
-static char cyrix_model_mult2[] __initdata = "12233445";
+static char Cx86_cb[] __cpuinitdata = "?.5x Core/Bus Clock";
+static char cyrix_model_mult1[] __cpuinitdata = "12??43";
+static char cyrix_model_mult2[] __cpuinitdata = "12233445";
 
 /*
  * Reset the slow-loop (SLOP) bit on the 686(L) which is set by some old
@@ -82,7 +82,7 @@ static char cyrix_model_mult2[] __initda
 
 extern void calibrate_delay(void) __init;
 
-static void __init check_cx686_slop(struct cpuinfo_x86 *c)
+static void __cpuinit check_cx686_slop(struct cpuinfo_x86 *c)
 {
 	unsigned long flags;
 	
@@ -107,7 +107,7 @@ static void __init check_cx686_slop(stru
 }
 
 
-static void __init set_cx86_reorder(void)
+static void __cpuinit set_cx86_reorder(void)
 {
 	u8 ccr3;
 
@@ -122,7 +122,7 @@ static void __init set_cx86_reorder(void
 	setCx86(CX86_CCR3, ccr3);
 }
 
-static void __init set_cx86_memwb(void)
+static void __cpuinit set_cx86_memwb(void)
 {
 	u32 cr0;
 
@@ -137,7 +137,7 @@ static void __init set_cx86_memwb(void)
 	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x14 );
 }
 
-static void __init set_cx86_inc(void)
+static void __cpuinit set_cx86_inc(void)
 {
 	unsigned char ccr3;
 
@@ -158,7 +158,7 @@ static void __init set_cx86_inc(void)
  *	Configure later MediaGX and/or Geode processor.
  */
 
-static void __init geode_configure(void)
+static void __cpuinit geode_configure(void)
 {
 	unsigned long flags;
 	u8 ccr3, ccr4;
@@ -184,14 +184,14 @@ static void __init geode_configure(void)
 
 
 #ifdef CONFIG_PCI
-static struct pci_device_id __initdata cyrix_55x0[] = {
+static struct pci_device_id __cpuinitdata cyrix_55x0[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520) },
 	{ },
 };
 #endif
 
-static void __init init_cyrix(struct cpuinfo_x86 *c)
+static void __cpuinit init_cyrix(struct cpuinfo_x86 *c)
 {
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
 	char *buf = c->x86_model_id;
@@ -346,7 +346,7 @@ static void __init init_cyrix(struct cpu
 /*
  * Handle National Semiconductor branded processors
  */
-static void __init init_nsc(struct cpuinfo_x86 *c)
+static void __cpuinit init_nsc(struct cpuinfo_x86 *c)
 {
 	/* There may be GX1 processors in the wild that are branded
 	 * NSC and not Cyrix.
Index: linux/arch/i386/kernel/cpu/nexgen.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/nexgen.c
+++ linux/arch/i386/kernel/cpu/nexgen.c
@@ -27,7 +27,7 @@ static int __init deep_magic_nexgen_prob
 	return  ret;
 }
 
-static void __init init_nexgen(struct cpuinfo_x86 * c)
+static void __cpuinit init_nexgen(struct cpuinfo_x86 * c)
 {
 	c->x86_cache_size = 256; /* A few had 1 MB... */
 }
Index: linux/arch/i386/kernel/cpu/rise.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/rise.c
+++ linux/arch/i386/kernel/cpu/rise.c
@@ -5,7 +5,7 @@
 
 #include "cpu.h"
 
-static void __init init_rise(struct cpuinfo_x86 *c)
+static void __cpuinit init_rise(struct cpuinfo_x86 *c)
 {
 	printk("CPU: Rise iDragon");
 	if (c->x86_model > 2)
Index: linux/arch/i386/kernel/cpu/transmeta.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/transmeta.c
+++ linux/arch/i386/kernel/cpu/transmeta.c
@@ -5,7 +5,7 @@
 #include <asm/msr.h>
 #include "cpu.h"
 
-static void __init init_transmeta(struct cpuinfo_x86 *c)
+static void __cpuinit init_transmeta(struct cpuinfo_x86 *c)
 {
 	unsigned int cap_mask, uk, max, dummy;
 	unsigned int cms_rev1, cms_rev2;
Index: linux/arch/i386/kernel/cpu/umc.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/umc.c
+++ linux/arch/i386/kernel/cpu/umc.c
@@ -5,10 +5,6 @@
 
 /* UMC chips appear to be only either 386 or 486, so no special init takes place.
  */
-static void __init init_umc(struct cpuinfo_x86 * c)
-{
-
-}
 
 static struct cpu_dev umc_cpu_dev __cpuinitdata = {
 	.c_vendor	= "UMC",
@@ -21,7 +17,6 @@ static struct cpu_dev umc_cpu_dev __cpui
 		  }
 		},
 	},
-	.c_init		= init_umc,
 };
 
 int __init umc_init_cpu(void)
