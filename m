Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWHIBCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWHIBCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWHIBCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:02:12 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:51886 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030382AbWHIBCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:02:11 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>, ak@suse.de
Message-Id: <20060809010345.25458.86096.sendpatchset@cherry.local>
Subject: [PATCH 01/06] i386: mark cpu identify functions as __cpuinit
Date: Wed,  9 Aug 2006 10:02:57 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: mark cpu identify functions as __cpuinit

Mark i386-specific cpu identification functions as __cpuinit. They are all
only called from arch/i386/common.c:identify_cpu() that already is marked as
__cpuinit.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 cyrix.c     |    4 ++--
 nexgen.c    |    4 ++--
 transmeta.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--- 0001/arch/i386/kernel/cpu/cyrix.c
+++ work/arch/i386/kernel/cpu/cyrix.c	2006-08-09 08:38:00.000000000 +0900
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
 
-static void cyrix_identify(struct cpuinfo_x86 * c)
+static void __cpuinit cyrix_identify(struct cpuinfo_x86 * c)
 {
 	/* Detect Cyrix with disabled CPUID */
 	if ( c->x86 == 4 && test_cyrix_52div() ) {
--- 0001/arch/i386/kernel/cpu/nexgen.c
+++ work/arch/i386/kernel/cpu/nexgen.c	2006-08-09 08:37:02.000000000 +0900
@@ -10,7 +10,7 @@
  *	to have CPUID. (Thanks to Herbert Oppmann)
  */
  
-static int __init deep_magic_nexgen_probe(void)
+static int __cpuinit deep_magic_nexgen_probe(void)
 {
 	int ret;
 	
@@ -32,7 +32,7 @@ static void __init init_nexgen(struct cp
 	c->x86_cache_size = 256; /* A few had 1 MB... */
 }
 
-static void __init nexgen_identify(struct cpuinfo_x86 * c)
+static void __cpuinit nexgen_identify(struct cpuinfo_x86 * c)
 {
 	/* Detect NexGen with old hypercode */
 	if ( deep_magic_nexgen_probe() ) {
--- 0001/arch/i386/kernel/cpu/transmeta.c
+++ work/arch/i386/kernel/cpu/transmeta.c	2006-08-09 08:09:05.000000000 +0900
@@ -85,7 +85,7 @@ static void __init init_transmeta(struct
 #endif
 }
 
-static void __init transmeta_identify(struct cpuinfo_x86 * c)
+static void __cpuinit transmeta_identify(struct cpuinfo_x86 * c)
 {
 	u32 xlvl;
 	generic_identify(c);
