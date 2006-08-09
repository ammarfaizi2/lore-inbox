Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWHIBCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWHIBCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWHIBCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:02:32 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:55726 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030385AbWHIBC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:02:26 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>, ak@suse.de
Message-Id: <20060809010400.25458.44983.sendpatchset@cherry.local>
In-Reply-To: <20060809010345.25458.86096.sendpatchset@cherry.local>
References: <20060809010345.25458.86096.sendpatchset@cherry.local>
Subject: [PATCH 04/06] i386: mark cpu cache functions as __cpuinit
Date: Wed,  9 Aug 2006 10:03:12 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: mark cpu cache functions as __cpuinit

Mark i386-specific cpu cache functions as __cpuinit. They are all
only called from arch/i386/common.c:display_cache_info() that already is 
marked as __cpuinit.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 amd.c     |    2 +-
 centaur.c |    2 +-
 intel.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- 0004/arch/i386/kernel/cpu/amd.c
+++ work/arch/i386/kernel/cpu/amd.c	2006-08-09 08:13:59.000000000 +0900
@@ -246,7 +246,7 @@ static void __cpuinit init_amd(struct cp
 		num_cache_leaves = 3;
 }
 
-static unsigned int amd_size_cache(struct cpuinfo_x86 * c, unsigned int size)
+static unsigned int __cpuinit amd_size_cache(struct cpuinfo_x86 * c, unsigned int size)
 {
 	/* AMD errata T13 (order #21922) */
 	if ((c->x86 == 6)) {
--- 0004/arch/i386/kernel/cpu/centaur.c
+++ work/arch/i386/kernel/cpu/centaur.c	2006-08-09 08:14:28.000000000 +0900
@@ -442,7 +442,7 @@ static void __cpuinit init_centaur(struc
 	}
 }
 
-static unsigned int centaur_size_cache(struct cpuinfo_x86 * c, unsigned int size)
+static unsigned int __cpuinit centaur_size_cache(struct cpuinfo_x86 * c, unsigned int size)
 {
 	/* VIA C3 CPUs (670-68F) need further shifting. */
 	if ((c->x86 == 6) && ((c->x86_model == 7) || (c->x86_model == 8)))
--- 0003/arch/i386/kernel/cpu/intel.c
+++ work/arch/i386/kernel/cpu/intel.c	2006-08-09 08:14:47.000000000 +0900
@@ -198,7 +198,7 @@ static void __cpuinit init_intel(struct 
 }
 
 
-static unsigned int intel_size_cache(struct cpuinfo_x86 * c, unsigned int size)
+static unsigned int __cpuinit intel_size_cache(struct cpuinfo_x86 * c, unsigned int size)
 {
 	/* Intel PIII Tualatin. This comes in two flavours.
 	 * One has 256kb of cache, the other 512. We have no way
