Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWDRKfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWDRKfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 06:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWDRKfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 06:35:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:6063 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932071AbWDRKfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 06:35:11 -0400
Date: Tue, 18 Apr 2006 12:35:10 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: [PATCH] [2/6] i386/x86-64: Fix ACPI disabled LAPIC handling 
 mismerge
Message-ID: <4444C0DE.mailKGB1ZDB5C@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The patch I submitted earlier to fix disabled LAPIC handling in ACPI
was mismerged for some reason I still don't quite understand. Parts
of it was applied to the wrong function.

This patch fixes it up.

Cc: len.brown@intel.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/acpi/boot.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -168,7 +168,7 @@ int __init acpi_parse_mcfg(unsigned long
 	unsigned long i;
 	int config_size;
 
-	if (!phys_addr || !size || !cpu_has_apic)
+	if (!phys_addr || !size)
 		return -EINVAL;
 
 	mcfg = (struct acpi_table_mcfg *)__acpi_map_table(phys_addr, size);
@@ -1102,6 +1102,9 @@ int __init acpi_boot_table_init(void)
 	dmi_check_system(acpi_dmi_table);
 #endif
 
+	if (!cpu_has_apic)
+		return -ENODEV;
+
 	/*
 	 * If acpi_disabled, bail out
 	 * One exception: acpi=ht continues far enough to enumerate LAPICs
