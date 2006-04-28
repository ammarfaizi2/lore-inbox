Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWD1F2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWD1F2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWD1F2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:28:45 -0400
Received: from ns1.suse.de ([195.135.220.2]:64413 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965188AbWD1F2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:28:45 -0400
Date: Fri, 28 Apr 2006 07:28:43 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: [PATCH] [2/4] i386/x86-64: Fix ACPI disabled LAPIC handling 
 mismerge
Message-ID: <4451A80B.mailNXH1OHM2B@suse.de>
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
@@ -215,7 +215,7 @@ static int __init acpi_parse_madt(unsign
 {
 	struct acpi_table_madt *madt = NULL;
 
-	if (!phys_addr || !size || !cpu_has_apic)
+	if (!phys_addr || !size)
 		return -EINVAL;
 
 	madt = (struct acpi_table_madt *)__acpi_map_table(phys_addr, size);
@@ -1151,6 +1151,9 @@ int __init acpi_boot_init(void)
 
 	acpi_table_parse(ACPI_BOOT, acpi_parse_sbf);
 
+	if (!cpu_has_apic)
+		return -ENODEV;
+
 	/*
 	 * set sci_int and PM timer address
 	 */
