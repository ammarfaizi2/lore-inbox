Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWHHIQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWHHIQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWHHIQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:16:17 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:28054 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932554AbWHHIQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:16:16 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20060808081756.334.46571.sendpatchset@cherry.local>
Subject: [PATCH] i386: mark two more functions as __init
Date: Tue,  8 Aug 2006 17:17:00 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: mark two more functions as __init

cyrix_identify() should be __init because transmeta_identify() is.
tsc_init() is only called from setup_arch() which is marked as __init.

These two section mismatches have been detected using running modpost on
a vmlinux image compiled with CONFIG_RELOCATABLE=y.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 cpu/cyrix.c |    2 +-
 tsc.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/i386/kernel/cpu/cyrix.c
+++ work/arch/i386/kernel/cpu/cyrix.c	2006-08-07 17:02:58.000000000 +0900
@@ -394,7 +394,7 @@ static inline int test_cyrix_52div(void)
 	return (unsigned char) (test >> 8) == 0x02;
 }
 
-static void cyrix_identify(struct cpuinfo_x86 * c)
+static void __init cyrix_identify(struct cpuinfo_x86 * c)
 {
 	/* Detect Cyrix with disabled CPUID */
 	if ( c->x86 == 4 && test_cyrix_52div() ) {
--- 0001/arch/i386/kernel/tsc.c
+++ work/arch/i386/kernel/tsc.c	2006-08-07 17:02:58.000000000 +0900
@@ -192,7 +192,7 @@ int recalibrate_cpu_khz(void)
 
 EXPORT_SYMBOL(recalibrate_cpu_khz);
 
-void tsc_init(void)
+void __init tsc_init(void)
 {
 	if (!cpu_has_tsc || tsc_disable)
 		return;
