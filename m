Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWHJUOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWHJUOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWHJUNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:13:15 -0400
Received: from mx1.suse.de ([195.135.220.2]:44432 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932252AbWHJTgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:22 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [65/145] i386: Clean up code style in mpparse.c ACPI code
Message-Id: <20060810193620.EBC8913B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:20 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Remove some unlinuxy ways to write function parameter definitions.
Remove some stray "return;"s

No functional change.

Cc: len.brown@intel.com
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/mpparse.c |   52 ++++++++++++++-------------------------------
 1 files changed, 17 insertions(+), 35 deletions(-)

Index: linux/arch/i386/kernel/mpparse.c
===================================================================
--- linux.orig/arch/i386/kernel/mpparse.c
+++ linux/arch/i386/kernel/mpparse.c
@@ -810,8 +810,7 @@ int es7000_plat;
 
 #ifdef CONFIG_ACPI
 
-void __init mp_register_lapic_address (
-	u64			address)
+void __init mp_register_lapic_address(u64 address)
 {
 	mp_lapic_addr = (unsigned long) address;
 
@@ -823,13 +822,10 @@ void __init mp_register_lapic_address (
 	Dprintk("Boot CPU = %d\n", boot_cpu_physical_apicid);
 }
 
-
-void __devinit mp_register_lapic (
-	u8			id, 
-	u8			enabled)
+void __devinit mp_register_lapic (u8 id, u8 enabled)
 {
 	struct mpc_config_processor processor;
-	int			boot_cpu = 0;
+	int boot_cpu = 0;
 	
 	if (MAX_APICS - id <= 0) {
 		printk(KERN_WARNING "Processor #%d invalid (max %d)\n",
@@ -866,11 +862,9 @@ static struct mp_ioapic_routing {
 	u32			pin_programmed[4];
 } mp_ioapic_routing[MAX_IO_APICS];
 
-
-static int mp_find_ioapic (
-	int			gsi)
+static int mp_find_ioapic (int gsi)
 {
-	int			i = 0;
+	int i = 0;
 
 	/* Find the IOAPIC that manages this GSI. */
 	for (i = 0; i < nr_ioapics; i++) {
@@ -883,15 +877,11 @@ static int mp_find_ioapic (
 
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
-	int			tmpid;
+	int idx = 0;
+	int tmpid;
 
 	if (nr_ioapics >= MAX_IO_APICS) {
 		printk(KERN_ERR "ERROR: Max # of I/O APICs (%d) exceeded "
@@ -937,16 +927,10 @@ void __init mp_register_ioapic (
 		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,
 		mp_ioapic_routing[idx].gsi_base,
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
+mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger, u32 gsi)
 {
 	struct mpc_config_intsrc intsrc;
 	int			ioapic = -1;
@@ -984,15 +968,13 @@ void __init mp_override_legacy_irq (
 	mp_irqs[mp_irq_entries] = intsrc;
 	if (++mp_irq_entries == MAX_IRQ_SOURCES)
 		panic("Max # of irq sources exceeded!\n");
-
-	return;
 }
 
 void __init mp_config_acpi_legacy_irqs (void)
 {
 	struct mpc_config_intsrc intsrc;
-	int			i = 0;
-	int			ioapic = -1;
+	int i = 0;
+	int ioapic = -1;
 
 	/* 
 	 * Fabricate the legacy ISA bus (bus #31).
@@ -1061,12 +1043,12 @@ void __init mp_config_acpi_legacy_irqs (
 
 #define MAX_GSI_NUM	4096
 
-int mp_register_gsi (u32 gsi, int triggering, int polarity)
+int mp_register_gsi(u32 gsi, int triggering, int polarity)
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
 	 * Mapping between Global System Interrups, which
 	 * represent all possible interrupts, and IRQs
