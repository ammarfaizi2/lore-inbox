Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVDLTwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVDLTwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVDLTvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:51:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:48840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262166AbVDLKbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:51 -0400
Message-Id: <200504121031.j3CAVkkR005403@shell0.pdx.osdl.net>
Subject: [patch 069/198] x86_64: disable interrupts during SMP bogomips checking
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andi Kleen <ak@suse.de>

Port over a i386 kludge from rusty to x86-64

I don't think it is a full solution, but the upcomming smp bootup rewrite
will solve it.

This fixes BUGs at bootup on bigger x86-64 systems.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/smpboot.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN arch/x86_64/kernel/smpboot.c~x86_64-disable-interrupts-during-smp-bogomips-checking arch/x86_64/kernel/smpboot.c
--- 25/arch/x86_64/kernel/smpboot.c~x86_64-disable-interrupts-during-smp-bogomips-checking	2005-04-12 03:21:19.996097032 -0700
+++ 25-akpm/arch/x86_64/kernel/smpboot.c	2005-04-12 03:21:19.999096576 -0700
@@ -304,8 +304,6 @@ static void __init smp_callin(void)
 	Dprintk("CALLIN, before setup_local_APIC().\n");
 	setup_local_APIC();
 
-	local_irq_enable();
-
 	/*
 	 * Get our bogomips.
 	 */
@@ -319,8 +317,6 @@ static void __init smp_callin(void)
 	 */
  	smp_store_cpu_info(cpuid);
 
-	local_irq_disable();
-
 	/*
 	 * Allow the master to continue.
 	 */
_
