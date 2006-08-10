Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWHJTkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWHJTkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWHJTiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:19 -0400
Received: from mx1.suse.de ([195.135.220.2]:43153 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932695AbWHJThn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:43 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [142/145] i386: mark cpu identify functions as __cpuinit
Message-Id: <20060810193742.AE5D313B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:42 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Magnus Damm <magnus@valinux.co.jp>

Mark i386-specific cpu identification functions as __cpuinit. They are all
only called from arch/i386/common.c:identify_cpu() that already is marked as
__cpuinit.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/i386/kernel/cpu/cyrix.c     |    4 ++--
 arch/i386/kernel/cpu/nexgen.c    |    4 ++--
 arch/i386/kernel/cpu/transmeta.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

Index: linux/arch/i386/kernel/cpu/cyrix.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/cyrix.c
+++ linux/arch/i386/kernel/cpu/cyrix.c
@@ -12,7 +12,7 @@
 /*
  * Read NSC/Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
  */
-static void __init do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
+static void __cpuinit do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
 {
 	unsigned char ccr2, ccr3;
 	unsigned long flags;
@@ -394,7 +394,7 @@ static inline int test_cyrix_52div(void)
 	return (unsigned char) (test >> 8) == 0x02;
 }
 
-static void __init cyrix_identify(struct cpuinfo_x86 * c)
+static void __cpuinit cyrix_identify(struct cpuinfo_x86 * c)
 {
 	/* Detect Cyrix with disabled CPUID */
 	if ( c->x86 == 4 && test_cyrix_52div() ) {
Index: linux/arch/i386/kernel/cpu/nexgen.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/nexgen.c
+++ linux/arch/i386/kernel/cpu/nexgen.c
@@ -10,7 +10,7 @@
  *	to have CPUID. (Thanks to Herbert Oppmann)
  */
  
-static int __init deep_magic_nexgen_probe(void)
+static int __cpuinit deep_magic_nexgen_probe(void)
 {
 	int ret;
 	
@@ -32,7 +32,7 @@ static void __cpuinit init_nexgen(struct
 	c->x86_cache_size = 256; /* A few had 1 MB... */
 }
 
-static void __init nexgen_identify(struct cpuinfo_x86 * c)
+static void __cpuinit nexgen_identify(struct cpuinfo_x86 * c)
 {
 	/* Detect NexGen with old hypercode */
 	if ( deep_magic_nexgen_probe() ) {
Index: linux/arch/i386/kernel/cpu/transmeta.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/transmeta.c
+++ linux/arch/i386/kernel/cpu/transmeta.c
@@ -85,7 +85,7 @@ static void __cpuinit init_transmeta(str
 #endif
 }
 
-static void __init transmeta_identify(struct cpuinfo_x86 * c)
+static void __cpuinit transmeta_identify(struct cpuinfo_x86 * c)
 {
 	u32 xlvl;
 
