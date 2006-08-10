Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWHJTgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWHJTgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWHJTgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50411 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932623AbWHJTg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:28 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [71/145] x86_64: remove int_delivery_dest
Message-Id: <20060810193627.52C5513C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:27 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: "Jan Beulich" <jbeulich@novell.com>
The genapic field and the accessor macro weren't used anywhere.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/genapic_cluster.c |    1 -
 arch/x86_64/kernel/genapic_flat.c    |    2 --
 include/asm-x86_64/genapic.h         |    1 -
 include/asm-x86_64/mach_apic.h       |    1 -
 4 files changed, 5 deletions(-)

Index: linux/arch/x86_64/kernel/genapic_cluster.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic_cluster.c
+++ linux/arch/x86_64/kernel/genapic_cluster.c
@@ -118,7 +118,6 @@ struct genapic apic_cluster = {
 	.name = "clustered",
 	.int_delivery_mode = dest_Fixed,
 	.int_dest_mode = (APIC_DEST_PHYSICAL != 0),
-	.int_delivery_dest = APIC_DEST_PHYSICAL | APIC_DM_FIXED,
 	.target_cpus = cluster_target_cpus,
 	.apic_id_registered = cluster_apic_id_registered,
 	.init_apic_ldr = cluster_init_apic_ldr,
Index: linux/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux/arch/x86_64/kernel/genapic_flat.c
@@ -121,7 +121,6 @@ struct genapic apic_flat =  {
 	.name = "flat",
 	.int_delivery_mode = dest_LowestPrio,
 	.int_dest_mode = (APIC_DEST_LOGICAL != 0),
-	.int_delivery_dest = APIC_DEST_LOGICAL | APIC_DM_LOWEST,
 	.target_cpus = flat_target_cpus,
 	.apic_id_registered = flat_apic_id_registered,
 	.init_apic_ldr = flat_init_apic_ldr,
@@ -180,7 +179,6 @@ struct genapic apic_physflat =  {
 	.name = "physical flat",
 	.int_delivery_mode = dest_Fixed,
 	.int_dest_mode = (APIC_DEST_PHYSICAL != 0),
-	.int_delivery_dest = APIC_DEST_PHYSICAL | APIC_DM_FIXED,
 	.target_cpus = physflat_target_cpus,
 	.apic_id_registered = flat_apic_id_registered,
 	.init_apic_ldr = flat_init_apic_ldr,/*not needed, but shouldn't hurt*/
Index: linux/include/asm-x86_64/genapic.h
===================================================================
--- linux.orig/include/asm-x86_64/genapic.h
+++ linux/include/asm-x86_64/genapic.h
@@ -16,7 +16,6 @@ struct genapic {
 	char *name;
 	u32 int_delivery_mode;
 	u32 int_dest_mode;
-	u32 int_delivery_dest;	/* for quick IPIs */
 	int (*apic_id_registered)(void);
 	cpumask_t (*target_cpus)(void);
 	void (*init_apic_ldr)(void);
Index: linux/include/asm-x86_64/mach_apic.h
===================================================================
--- linux.orig/include/asm-x86_64/mach_apic.h
+++ linux/include/asm-x86_64/mach_apic.h
@@ -16,7 +16,6 @@
 
 #define INT_DELIVERY_MODE (genapic->int_delivery_mode)
 #define INT_DEST_MODE (genapic->int_dest_mode)
-#define INT_DELIVERY_DEST (genapic->int_delivery_dest)
 #define TARGET_CPUS	  (genapic->target_cpus())
 #define apic_id_registered (genapic->apic_id_registered)
 #define init_apic_ldr (genapic->init_apic_ldr)
