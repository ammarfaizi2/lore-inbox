Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVDMDLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVDMDLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVDLTel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:34:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:7625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262187AbVDLKcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:13 -0400
Message-Id: <200504121032.j3CAW5YW005502@shell0.pdx.osdl.net>
Subject: [patch 092/198] x86_64-always-use-cpuid-80000008-to-figure-out-mtrr fix
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, suresh.b.siddha@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>

We need to use the size_and_mask in set_mtrr_var_ranges(which is called 
while programming MTRR's for AP's

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/cpu/mtrr/generic.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/cpu/mtrr/generic.c~x86_64-always-use-cpuid-80000008-to-figure-out-mtrr-fix arch/i386/kernel/cpu/mtrr/generic.c
--- 25/arch/i386/kernel/cpu/mtrr/generic.c~x86_64-always-use-cpuid-80000008-to-figure-out-mtrr-fix	2005-04-12 03:21:25.075324872 -0700
+++ 25-akpm/arch/i386/kernel/cpu/mtrr/generic.c	2005-04-12 03:21:25.078324416 -0700
@@ -193,7 +193,8 @@ static int set_mtrr_var_ranges(unsigned 
 
 	rdmsr(MTRRphysBase_MSR(index), lo, hi);
 	if ((vr->base_lo & 0xfffff0ffUL) != (lo & 0xfffff0ffUL)
-	    || (vr->base_hi & 0xfUL) != (hi & 0xfUL)) {
+	    || (vr->base_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=
+		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
 		mtrr_wrmsr(MTRRphysBase_MSR(index), vr->base_lo, vr->base_hi);
 		changed = TRUE;
 	}
@@ -201,7 +202,8 @@ static int set_mtrr_var_ranges(unsigned 
 	rdmsr(MTRRphysMask_MSR(index), lo, hi);
 
 	if ((vr->mask_lo & 0xfffff800UL) != (lo & 0xfffff800UL)
-	    || (vr->mask_hi & 0xfUL) != (hi & 0xfUL)) {
+	    || (vr->mask_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=
+		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
 		mtrr_wrmsr(MTRRphysMask_MSR(index), vr->mask_lo, vr->mask_hi);
 		changed = TRUE;
 	}
_
