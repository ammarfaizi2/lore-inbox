Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWJUWuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWJUWuz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 18:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWJUWuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 18:50:54 -0400
Received: from ns.suse.de ([195.135.220.2]:3028 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422657AbWJUWuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 18:50:54 -0400
From: Andi Kleen <ak@suse.de>
References: <200610221250.493223000@suse.de>
In-Reply-To: <200610221250.493223000@suse.de>
To: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [1/2] x86_64: Fix C3 timer test
Message-Id: <20061021225052.9395013B62@wotan.suse.de>
Date: Sun, 22 Oct 2006 00:50:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There was a typo in the C3 latency test to decide of the TSC
should be used or not. It used the C2 latency threshold, not the
C3 one. Fix that.

This should fix the time on various dual core laptops.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/time.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -948,7 +948,7 @@ __cpuinit int unsynchronized_tsc(void)
  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 #ifdef CONFIG_ACPI
 		/* But TSC doesn't tick in C3 so don't use it there */
-		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 100)
+		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 1000)
 			return 1;
 #endif
  		return 0;
