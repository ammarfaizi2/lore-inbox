Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269182AbUJQQMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269182AbUJQQMT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269181AbUJQQLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:11:24 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:18052 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S269183AbUJQQJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:09:15 -0400
Subject: [PATCH 1/8] replacing/fixing printk with pr_debug/pr_info in
	arch/i386 - boot.c
From: Daniele Pizzoni <auouo@tin.it>
To: kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1098032557.3023.112.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:10:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom macro Dprintk with pr_debug from kernel.h.
Use  pr_info when appropriate.
Fix consistency of printks.

Signed-off-by: Daniele Pizzoni <auouo@tin.it>

Index: linux-2.6.9-rc4/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/kernel/acpi/boot.c	2004-10-17 16:56:59.908679824 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/acpi/boot.c	2004-10-17 17:01:22.980686800 +0200
@@ -204,7 +204,7 @@ acpi_parse_madt (
 	if (madt->lapic_address) {
 		acpi_lapic_addr = (u64) madt->lapic_address;
 
-		printk(KERN_DEBUG PREFIX "Local APIC address 0x%08x\n",
+		pr_info(PREFIX "Local APIC address 0x%08x\n",
 			madt->lapic_address);
 	}
 
@@ -461,7 +461,7 @@ unsigned int acpi_register_gsi(u32 gsi, 
 
 		if (edge_level == ACPI_LEVEL_SENSITIVE) {
 			if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
-				Dprintk(KERN_DEBUG PREFIX "Setting GSI %u as level-triggered\n", gsi);
+				pr_debug(PREFIX "Setting GSI %u as level-triggered\n", gsi);
 				irq_mask |= (1 << gsi);
 				eisa_set_level_irq(gsi);
 			}
@@ -544,14 +544,14 @@ static int __init acpi_parse_hpet(unsign
         vxtime.hpet_address = hpet_tbl->addr.addrl |
                 ((long) hpet_tbl->addr.addrh << 32);
 
-        printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
+        pr_info(PREFIX "HPET id: %#x base: %#lx\n",
                hpet_tbl->id, vxtime.hpet_address);
 #else	/* X86 */
 	{
 		extern unsigned long hpet_address;
 
 		hpet_address = hpet_tbl->addr.addrl;
-		printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
+		pr_info(PREFIX "HPET id: %#x base: %#lx\n",
 			hpet_tbl->id, hpet_address);
 	}
 #endif	/* X86 */
@@ -594,7 +594,7 @@ static int __init acpi_parse_fadt(unsign
 		pmtmr_ioport = fadt->V1_pm_tmr_blk;
 	}
 	if (pmtmr_ioport)
-		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n", pmtmr_ioport);
+		pr_info(PREFIX "PM-Timer IO Port: %#x\n", pmtmr_ioport);
 #endif
 	return 0;
 }
@@ -692,7 +692,7 @@ acpi_parse_madt_ioapic_entries(void)
  	 * if "noapic" boot option, don't look for IO-APICs
 	 */
 	if (skip_ioapic_setup) {
-		printk(KERN_INFO PREFIX "Skipping IOAPIC probe "
+		pr_info(PREFIX "Skipping IOAPIC probe "
 			"due to 'noapic' option.\n");
 		return -ENODEV;
 	}


