Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbWHJTlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWHJTlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWHJTiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:44177 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932691AbWHJTho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:44 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [143/145] i386: mark cpu cache functions as __cpuinit
Message-Id: <20060810193743.BEFC413B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:43 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Magnus Damm <magnus@valinux.co.jp>

Mark i386-specific cpu cache functions as __cpuinit. They are all
only called from arch/i386/common.c:display_cache_info() that already is 
marked as __cpuinit.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/i386/kernel/cpu/amd.c     |    2 +-
 arch/i386/kernel/cpu/centaur.c |    2 +-
 arch/i386/kernel/cpu/intel.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/amd.c
+++ linux/arch/i386/kernel/cpu/amd.c
@@ -246,7 +246,7 @@ static void __cpuinit init_amd(struct cp
 		num_cache_leaves = 3;
 }
 
-static unsigned int amd_size_cache(struct cpuinfo_x86 * c, unsigned int size)
+static unsigned int __cpuinit amd_size_cache(struct cpuinfo_x86 * c, unsigned int size)
 {
 	/* AMD errata T13 (order #21922) */
 	if ((c->x86 == 6)) {
Index: linux/arch/i386/kernel/cpu/centaur.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/centaur.c
+++ linux/arch/i386/kernel/cpu/centaur.c
@@ -442,7 +442,7 @@ static void __cpuinit init_centaur(struc
 	}
 }
 
-static unsigned int centaur_size_cache(struct cpuinfo_x86 * c, unsigned int size)
+static unsigned int __cpuinit centaur_size_cache(struct cpuinfo_x86 * c, unsigned int size)
 {
 	/* VIA C3 CPUs (670-68F) need further shifting. */
 	if ((c->x86 == 6) && ((c->x86_model == 7) || (c->x86_model == 8)))
Index: linux/arch/i386/kernel/cpu/intel.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/intel.c
+++ linux/arch/i386/kernel/cpu/intel.c
@@ -198,7 +198,7 @@ static void __cpuinit init_intel(struct 
 }
 
 
-static unsigned int intel_size_cache(struct cpuinfo_x86 * c, unsigned int size)
+static unsigned int __cpuinit intel_size_cache(struct cpuinfo_x86 * c, unsigned int size)
 {
 	/* Intel PIII Tualatin. This comes in two flavours.
 	 * One has 256kb of cache, the other 512. We have no way
