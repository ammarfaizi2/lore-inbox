Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbWHJTji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWHJTji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWHJTiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:24300 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932690AbWHJThm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:42 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [140/145] i386: mark cpu_dev structures as __cpuinitdata
Message-Id: <20060810193740.9133413C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:40 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Magnus Damm <magnus@valinux.co.jp>

The different cpu_dev structures are all used from __cpuinit callers what
I can tell. So mark them as __cpuinitdata instead of __initdata. I am a
little bit unsure about arch/i386/common.c:default_cpu, especially when it
comes to the purpose of this_cpu.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/i386/kernel/cpu/amd.c       |    2 +-
 arch/i386/kernel/cpu/centaur.c   |    2 +-
 arch/i386/kernel/cpu/common.c    |    2 +-
 arch/i386/kernel/cpu/cyrix.c     |    4 ++--
 arch/i386/kernel/cpu/nexgen.c    |    2 +-
 arch/i386/kernel/cpu/rise.c      |    2 +-
 arch/i386/kernel/cpu/transmeta.c |    2 +-
 arch/i386/kernel/cpu/umc.c       |    2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

Index: linux/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/amd.c
+++ linux/arch/i386/kernel/cpu/amd.c
@@ -259,7 +259,7 @@ static unsigned int amd_size_cache(struc
 	return size;
 }
 
-static struct cpu_dev amd_cpu_dev __initdata = {
+static struct cpu_dev amd_cpu_dev __cpuinitdata = {
 	.c_vendor	= "AMD",
 	.c_ident 	= { "AuthenticAMD" },
 	.c_models = {
Index: linux/arch/i386/kernel/cpu/centaur.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/centaur.c
+++ linux/arch/i386/kernel/cpu/centaur.c
@@ -457,7 +457,7 @@ static unsigned int centaur_size_cache(s
 	return size;
 }
 
-static struct cpu_dev centaur_cpu_dev __initdata = {
+static struct cpu_dev centaur_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Centaur",
 	.c_ident	= { "CentaurHauls" },
 	.c_init		= init_centaur,
Index: linux/arch/i386/kernel/cpu/common.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/common.c
+++ linux/arch/i386/kernel/cpu/common.c
@@ -49,7 +49,7 @@ static void default_init(struct cpuinfo_
 	}
 }
 
-static struct cpu_dev default_cpu = {
+static struct cpu_dev __cpuinitdata default_cpu = {
 	.c_init	= default_init,
 	.c_vendor = "Unknown",
 };
Index: linux/arch/i386/kernel/cpu/cyrix.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/cyrix.c
+++ linux/arch/i386/kernel/cpu/cyrix.c
@@ -429,7 +429,7 @@ static void __init cyrix_identify(struct
 	}
 }
 
-static struct cpu_dev cyrix_cpu_dev __initdata = {
+static struct cpu_dev cyrix_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Cyrix",
 	.c_ident 	= { "CyrixInstead" },
 	.c_init		= init_cyrix,
@@ -452,7 +452,7 @@ static int __init cyrix_exit_cpu(void)
 
 late_initcall(cyrix_exit_cpu);
 
-static struct cpu_dev nsc_cpu_dev __initdata = {
+static struct cpu_dev nsc_cpu_dev __cpuinitdata = {
 	.c_vendor	= "NSC",
 	.c_ident 	= { "Geode by NSC" },
 	.c_init		= init_nsc,
Index: linux/arch/i386/kernel/cpu/nexgen.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/nexgen.c
+++ linux/arch/i386/kernel/cpu/nexgen.c
@@ -40,7 +40,7 @@ static void __init nexgen_identify(struc
 	}
 }
 
-static struct cpu_dev nexgen_cpu_dev __initdata = {
+static struct cpu_dev nexgen_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Nexgen",
 	.c_ident	= { "NexGenDriven" },
 	.c_models = {
Index: linux/arch/i386/kernel/cpu/rise.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/rise.c
+++ linux/arch/i386/kernel/cpu/rise.c
@@ -28,7 +28,7 @@ static void __init init_rise(struct cpui
 	set_bit(X86_FEATURE_CX8, c->x86_capability);
 }
 
-static struct cpu_dev rise_cpu_dev __initdata = {
+static struct cpu_dev rise_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Rise",
 	.c_ident	= { "RiseRiseRise" },
 	.c_models = {
Index: linux/arch/i386/kernel/cpu/transmeta.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/transmeta.c
+++ linux/arch/i386/kernel/cpu/transmeta.c
@@ -97,7 +97,7 @@ static void __init transmeta_identify(st
 	}
 }
 
-static struct cpu_dev transmeta_cpu_dev __initdata = {
+static struct cpu_dev transmeta_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Transmeta",
 	.c_ident	= { "GenuineTMx86", "TransmetaCPU" },
 	.c_init		= init_transmeta,
Index: linux/arch/i386/kernel/cpu/umc.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/umc.c
+++ linux/arch/i386/kernel/cpu/umc.c
@@ -10,7 +10,7 @@ static void __init init_umc(struct cpuin
 
 }
 
-static struct cpu_dev umc_cpu_dev __initdata = {
+static struct cpu_dev umc_cpu_dev __cpuinitdata = {
 	.c_vendor	= "UMC",
 	.c_ident 	= { "UMC UMC UMC" },
 	.c_models = {
