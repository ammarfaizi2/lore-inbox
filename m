Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWHIBCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWHIBCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWHIBCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:02:33 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:54446 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030384AbWHIBCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:02:21 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>, ak@suse.de
Message-Id: <20060809010355.25458.34804.sendpatchset@cherry.local>
In-Reply-To: <20060809010345.25458.86096.sendpatchset@cherry.local>
References: <20060809010345.25458.86096.sendpatchset@cherry.local>
Subject: [PATCH 03/06] i386: mark cpu init functions as __cpuinit, data as __cpuinitdata
Date: Wed,  9 Aug 2006 10:03:07 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: mark cpu init functions as __cpuinit, data as __cpuinitdata

Mark i386-specific cpu init functions as __cpuinit. They are all
only called from arch/i386/common.c:identify_cpu() that already is marked as
__cpuinit. This patch also removes the empty function init_umc().

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 amd.c       |    2 +-
 centaur.c   |   20 ++++++++++----------
 common.c    |    2 +-
 cyrix.c     |   32 ++++++++++++++++----------------
 nexgen.c    |    2 +-
 rise.c      |    2 +-
 transmeta.c |    2 +-
 umc.c       |    6 ------
 8 files changed, 31 insertions(+), 37 deletions(-)

--- 0003/arch/i386/kernel/cpu/amd.c
+++ work/arch/i386/kernel/cpu/amd.c	2006-08-09 08:53:37.000000000 +0900
@@ -22,7 +22,7 @@
 extern void vide(void);
 __asm__(".align 4\nvide: ret");
 
-static void __init init_amd(struct cpuinfo_x86 *c)
+static void __cpuinit init_amd(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int mbytes = num_physpages >> (20-PAGE_SHIFT);
--- 0001/arch/i386/kernel/cpu/centaur.c
+++ work/arch/i386/kernel/cpu/centaur.c	2006-08-09 08:53:37.000000000 +0900
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
--- 0003/arch/i386/kernel/cpu/common.c
+++ work/arch/i386/kernel/cpu/common.c	2006-08-09 08:53:37.000000000 +0900
@@ -36,7 +36,7 @@ struct cpu_dev * cpu_devs[X86_VENDOR_NUM
 
 extern int disable_pse;
 
-static void default_init(struct cpuinfo_x86 * c)
+static void __cpuinit default_init(struct cpuinfo_x86 * c)
 {
 	/* Not much we can do here... */
 	/* Check if at least it has cpuid */
--- 0003/arch/i386/kernel/cpu/cyrix.c
+++ work/arch/i386/kernel/cpu/cyrix.c	2006-08-09 08:55:57.000000000 +0900
@@ -52,25 +52,25 @@ static void __cpuinit do_cyrix_devid(uns
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
--- 0003/arch/i386/kernel/cpu/nexgen.c
+++ work/arch/i386/kernel/cpu/nexgen.c	2006-08-09 08:53:37.000000000 +0900
@@ -27,7 +27,7 @@ static int __cpuinit deep_magic_nexgen_p
 	return  ret;
 }
 
-static void __init init_nexgen(struct cpuinfo_x86 * c)
+static void __cpuinit init_nexgen(struct cpuinfo_x86 * c)
 {
 	c->x86_cache_size = 256; /* A few had 1 MB... */
 }
--- 0001/arch/i386/kernel/cpu/rise.c
+++ work/arch/i386/kernel/cpu/rise.c	2006-08-09 08:53:37.000000000 +0900
@@ -5,7 +5,7 @@
 
 #include "cpu.h"
 
-static void __init init_rise(struct cpuinfo_x86 *c)
+static void __cpuinit init_rise(struct cpuinfo_x86 *c)
 {
 	printk("CPU: Rise iDragon");
 	if (c->x86_model > 2)
--- 0003/arch/i386/kernel/cpu/transmeta.c
+++ work/arch/i386/kernel/cpu/transmeta.c	2006-08-09 08:53:37.000000000 +0900
@@ -5,7 +5,7 @@
 #include <asm/msr.h>
 #include "cpu.h"
 
-static void __init init_transmeta(struct cpuinfo_x86 *c)
+static void __cpuinit init_transmeta(struct cpuinfo_x86 *c)
 {
 	unsigned int cap_mask, uk, max, dummy;
 	unsigned int cms_rev1, cms_rev2;
--- 0001/arch/i386/kernel/cpu/umc.c
+++ work/arch/i386/kernel/cpu/umc.c	2006-08-09 08:53:37.000000000 +0900
@@ -5,11 +5,6 @@
 
 /* UMC chips appear to be only either 386 or 486, so no special init takes place.
  */
-static void __init init_umc(struct cpuinfo_x86 * c)
-{
-
-}
-
 static struct cpu_dev umc_cpu_dev __initdata = {
 	.c_vendor	= "UMC",
 	.c_ident 	= { "UMC UMC UMC" },
@@ -21,7 +16,6 @@ static struct cpu_dev umc_cpu_dev __init
 		  }
 		},
 	},
-	.c_init		= init_umc,
 };
 
 int __init umc_init_cpu(void)
