Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWHIBCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWHIBCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWHIBCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:02:35 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:57262 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030387AbWHIBCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:02:31 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>, ak@suse.de
Message-Id: <20060809010405.25458.11312.sendpatchset@cherry.local>
In-Reply-To: <20060809010345.25458.86096.sendpatchset@cherry.local>
References: <20060809010345.25458.86096.sendpatchset@cherry.local>
Subject: [PATCH 05/06] i386: mark cpu_dev structures as __cpuinitdata
Date: Wed,  9 Aug 2006 10:03:17 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: mark cpu_dev structures as __cpuinitdata

The different cpu_dev structures are all used from __cpuinit callers what
I can tell. So mark them as __cpuinitdata instead of __initdata. I am a
little bit unsure about arch/i386/common.c:default_cpu, especially when it
comes to the purpose of this_cpu.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 amd.c       |    2 +-
 centaur.c   |    2 +-
 common.c    |    2 +-
 cyrix.c     |    4 ++--
 nexgen.c    |    2 +-
 rise.c      |    2 +-
 transmeta.c |    2 +-
 umc.c       |    2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

--- 0005/arch/i386/kernel/cpu/amd.c
+++ work/arch/i386/kernel/cpu/amd.c	2006-08-09 08:33:02.000000000 +0900
@@ -259,7 +259,7 @@ static unsigned int __cpuinit amd_size_c
 	return size;
 }
 
-static struct cpu_dev amd_cpu_dev __initdata = {
+static struct cpu_dev amd_cpu_dev __cpuinitdata = {
 	.c_vendor	= "AMD",
 	.c_ident 	= { "AuthenticAMD" },
 	.c_models = {
--- 0005/arch/i386/kernel/cpu/centaur.c
+++ work/arch/i386/kernel/cpu/centaur.c	2006-08-09 08:33:02.000000000 +0900
@@ -457,7 +457,7 @@ static unsigned int __cpuinit centaur_si
 	return size;
 }
 
-static struct cpu_dev centaur_cpu_dev __initdata = {
+static struct cpu_dev centaur_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Centaur",
 	.c_ident	= { "CentaurHauls" },
 	.c_init		= init_centaur,
--- 0004/arch/i386/kernel/cpu/common.c
+++ work/arch/i386/kernel/cpu/common.c	2006-08-09 08:33:02.000000000 +0900
@@ -49,7 +49,7 @@ static void __cpuinit default_init(struc
 	}
 }
 
-static struct cpu_dev default_cpu = {
+static struct cpu_dev __cpuinitdata default_cpu = {
 	.c_init	= default_init,
 	.c_vendor = "Unknown",
 };
--- 0004/arch/i386/kernel/cpu/cyrix.c
+++ work/arch/i386/kernel/cpu/cyrix.c	2006-08-09 08:33:02.000000000 +0900
@@ -429,7 +429,7 @@ static void __cpuinit cyrix_identify(str
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
--- 0004/arch/i386/kernel/cpu/nexgen.c
+++ work/arch/i386/kernel/cpu/nexgen.c	2006-08-09 08:33:02.000000000 +0900
@@ -40,7 +40,7 @@ static void __cpuinit nexgen_identify(st
 	}
 }
 
-static struct cpu_dev nexgen_cpu_dev __initdata = {
+static struct cpu_dev nexgen_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Nexgen",
 	.c_ident	= { "NexGenDriven" },
 	.c_models = {
--- 0004/arch/i386/kernel/cpu/rise.c
+++ work/arch/i386/kernel/cpu/rise.c	2006-08-09 08:33:02.000000000 +0900
@@ -28,7 +28,7 @@ static void __cpuinit init_rise(struct c
 	set_bit(X86_FEATURE_CX8, c->x86_capability);
 }
 
-static struct cpu_dev rise_cpu_dev __initdata = {
+static struct cpu_dev rise_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Rise",
 	.c_ident	= { "RiseRiseRise" },
 	.c_models = {
--- 0004/arch/i386/kernel/cpu/transmeta.c
+++ work/arch/i386/kernel/cpu/transmeta.c	2006-08-09 08:34:32.000000000 +0900
@@ -97,7 +97,7 @@ static void __cpuinit transmeta_identify
 	}
 }
 
-static struct cpu_dev transmeta_cpu_dev __initdata = {
+static struct cpu_dev transmeta_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Transmeta",
 	.c_ident	= { "GenuineTMx86", "TransmetaCPU" },
 	.c_init		= init_transmeta,
--- 0004/arch/i386/kernel/cpu/umc.c
+++ work/arch/i386/kernel/cpu/umc.c	2006-08-09 08:33:02.000000000 +0900
@@ -5,7 +5,7 @@
 
 /* UMC chips appear to be only either 386 or 486, so no special init takes place.
  */
-static struct cpu_dev umc_cpu_dev __initdata = {
+static struct cpu_dev umc_cpu_dev __cpuinitdata = {
 	.c_vendor	= "UMC",
 	.c_ident 	= { "UMC UMC UMC" },
 	.c_models = {
