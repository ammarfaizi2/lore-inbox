Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWHJUg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWHJUg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWHJUOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:30 -0400
Received: from ns.suse.de ([195.135.220.2]:43664 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932615AbWHJTgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:21 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [64/145] x86_64: Fix up some non linuxy style in ACPI functions in mpparse.c
Message-Id: <20060810193619.DB12D13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:19 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

No functional changes.

Cc: len.brown@intel.com
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/mpparse.c |   57 ++++++++++++-------------------------------
 1 files changed, 16 insertions(+), 41 deletions(-)

Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -614,23 +614,17 @@ void __init find_smp_config(void)
 
 #ifdef CONFIG_ACPI
 
-void __init mp_register_lapic_address (
-	u64			address)
+void __init mp_register_lapic_address(u64 address)
 {
 	mp_lapic_addr = (unsigned long) address;
-
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
-
 	if (boot_cpu_id == -1U)
 		boot_cpu_id = GET_APIC_ID(apic_read(APIC_ID));
 
 	Dprintk("Boot CPU = %d\n", boot_cpu_physical_apicid);
 }
 
-
-void __cpuinit mp_register_lapic (
-	u8			id, 
-	u8			enabled)
+void __cpuinit mp_register_lapic (u8 id, u8 enabled)
 {
 	struct mpc_config_processor processor;
 	int			boot_cpu = 0;
@@ -668,11 +662,9 @@ static struct mp_ioapic_routing {
 	u32			pin_programmed[4];
 } mp_ioapic_routing[MAX_IO_APICS];
 
-
-static int mp_find_ioapic (
-	int			gsi)
+static int mp_find_ioapic(int gsi)
 {
-	int			i = 0;
+	int i = 0;
 
 	/* Find the IOAPIC that manages this GSI. */
 	for (i = 0; i < nr_ioapics; i++) {
@@ -682,17 +674,12 @@ static int mp_find_ioapic (
 	}
 
 	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for GSI %d\n", gsi);
-
 	return -1;
 }
-	
 
-void __init mp_register_ioapic (
-	u8			id, 
-	u32			address,
-	u32			gsi_base)
+void __init mp_register_ioapic(u8 id, u32 address, u32 gsi_base)
 {
-	int			idx = 0;
+	int idx = 0;
 
 	if (nr_ioapics >= MAX_IO_APICS) {
 		printk(KERN_ERR "ERROR: Max # of I/O APICs (%d) exceeded "
@@ -729,16 +716,10 @@ void __init mp_register_ioapic (
 		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,
 		mp_ioapic_routing[idx].gsi_start,
 		mp_ioapic_routing[idx].gsi_end);
-
-	return;
 }
 
-
-void __init mp_override_legacy_irq (
-	u8			bus_irq,
-	u8			polarity, 
-	u8			trigger, 
-	u32			gsi)
+void __init
+mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger, u32	gsi)
 {
 	struct mpc_config_intsrc intsrc;
 	int			ioapic = -1;
@@ -776,16 +757,13 @@ void __init mp_override_legacy_irq (
 	mp_irqs[mp_irq_entries] = intsrc;
 	if (++mp_irq_entries == MAX_IRQ_SOURCES)
 		panic("Max # of irq sources exceeded!\n");
-
-	return;
 }
 
-
-void __init mp_config_acpi_legacy_irqs (void)
+void __init mp_config_acpi_legacy_irqs(void)
 {
 	struct mpc_config_intsrc intsrc;
-	int			i = 0;
-	int			ioapic = -1;
+	int i = 0;
+	int ioapic = -1;
 
 	/* 
 	 * Fabricate the legacy ISA bus (bus #31).
@@ -843,24 +821,22 @@ void __init mp_config_acpi_legacy_irqs (
 		if (++mp_irq_entries == MAX_IRQ_SOURCES)
 			panic("Max # of irq sources exceeded!\n");
 	}
-
-	return;
 }
 
 #define MAX_GSI_NUM	4096
 
 int mp_register_gsi(u32 gsi, int triggering, int polarity)
 {
-	int			ioapic = -1;
-	int			ioapic_pin = 0;
-	int			idx, bit = 0;
-	static int		pci_irq = 16;
+	int ioapic = -1;
+	int ioapic_pin = 0;
+	int idx, bit = 0;
+	static int pci_irq = 16;
 	/*
 	 * Mapping between Global System Interrupts, which
 	 * represent all possible interrupts, to the IRQs
 	 * assigned to actual devices.
 	 */
-	static int		gsi_to_irq[MAX_GSI_NUM];
+	static int gsi_to_irq[MAX_GSI_NUM];
 
 	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC)
 		return gsi;
@@ -934,5 +910,4 @@ int mp_register_gsi(u32 gsi, int trigger
 		polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
 	return gsi;
 }
-
 #endif /*CONFIG_ACPI*/
