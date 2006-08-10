Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWHJTit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWHJTit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWHJTia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:39569 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932689AbWHJThk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:40 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [131/145] i386: mark two more functions as __init
Message-Id: <20060810193731.076D813C1F@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:30 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Magnus Damm <magnus@valinux.co.jp>

cyrix_identify() should be __init because transmeta_identify() is.
tsc_init() is only called from setup_arch() which is marked as __init.

These two section mismatches have been detected using running modpost on
a vmlinux image compiled with CONFIG_RELOCATABLE=y.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/i386/kernel/cpu/cyrix.c |    2 +-
 arch/i386/kernel/tsc.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/cpu/cyrix.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/cyrix.c
+++ linux/arch/i386/kernel/cpu/cyrix.c
@@ -394,7 +394,7 @@ static inline int test_cyrix_52div(void)
 	return (unsigned char) (test >> 8) == 0x02;
 }
 
-static void cyrix_identify(struct cpuinfo_x86 * c)
+static void __init cyrix_identify(struct cpuinfo_x86 * c)
 {
 	/* Detect Cyrix with disabled CPUID */
 	if ( c->x86 == 4 && test_cyrix_52div() ) {
Index: linux/arch/i386/kernel/tsc.c
===================================================================
--- linux.orig/arch/i386/kernel/tsc.c
+++ linux/arch/i386/kernel/tsc.c
@@ -192,7 +192,7 @@ int recalibrate_cpu_khz(void)
 
 EXPORT_SYMBOL(recalibrate_cpu_khz);
 
-void tsc_init(void)
+void __init tsc_init(void)
 {
 	if (!cpu_has_tsc || tsc_disable)
 		return;
