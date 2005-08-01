Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVHAVMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVHAVMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVHAUew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:52 -0400
Received: from fmr18.intel.com ([134.134.136.17]:38057 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261230AbVHAUdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:16 -0400
Message-Id: <20050801203011.514711000@araj-em64t>
References: <20050801202017.043754000@araj-em64t>
Date: Mon, 01 Aug 2005 13:20:23 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [patch 6/8] x86_64:Dont use Lowest Priority when using physical mode.
Content-Disposition: inline; filename=fix-physflat-dmode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delivery mode should be APIC_DM_FIXED when using physical mode.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
----------------------------------------------------
 arch/x86_64/kernel/genapic_flat.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_flat.c
@@ -175,9 +175,9 @@ static unsigned int physflat_cpu_mask_to
 
 struct genapic apic_physflat =  {
 	.name = "physical flat",
-	.int_delivery_mode = dest_LowestPrio,
+	.int_delivery_mode = dest_Fixed,
 	.int_dest_mode = (APIC_DEST_PHYSICAL != 0),
-	.int_delivery_dest = APIC_DEST_PHYSICAL | APIC_DM_LOWEST,
+	.int_delivery_dest = APIC_DEST_PHYSICAL | APIC_DM_FIXED,
 	.target_cpus = physflat_target_cpus,
 	.apic_id_registered = flat_apic_id_registered,
 	.init_apic_ldr = flat_init_apic_ldr,/*not needed, but shouldn't hurt*/

--

