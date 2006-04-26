Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWDZNwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWDZNwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWDZNwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:52:13 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:43573
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932444AbWDZNwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:52:13 -0400
Message-Id: <444F9755.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 15:52:53 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: apic= command line option should always be
	honored
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using apic= on the kernel command line, this had no effect for machines
matched by either the ACPI MADT or the MPS OEM table scan. However, when such
option is specified, it should also take effect for this set of systems.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/mach-generic/probe.c
2.6.17-rc2-i386-honor-cmdline-apic-mode/arch/i386/mach-generic/probe.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/mach-generic/probe.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.17-rc2-i386-honor-cmdline-apic-mode/arch/i386/mach-generic/probe.c	2006-04-25 11:34:46.000000000 +0200
@@ -93,9 +93,11 @@ int __init mps_oem_check(struct mp_confi
 	int i;
 	for (i = 0; apic_probe[i]; ++i) { 
 		if (apic_probe[i]->mps_oem_check(mpc,oem,productid)) { 
-			genapic = apic_probe[i];
-			printk(KERN_INFO "Switched to APIC driver `%s'.\n", 
-			       genapic->name);
+			if (!cmdline_apic) {
+				genapic = apic_probe[i];
+				printk(KERN_INFO "Switched to APIC driver `%s'.\n",
+				       genapic->name);
+			}
 			return 1;
 		} 
 	} 
@@ -107,9 +109,11 @@ int __init acpi_madt_oem_check(char *oem
 	int i;
 	for (i = 0; apic_probe[i]; ++i) { 
 		if (apic_probe[i]->acpi_madt_oem_check(oem_id, oem_table_id)) { 
-			genapic = apic_probe[i];
-			printk(KERN_INFO "Switched to APIC driver `%s'.\n", 
-			       genapic->name);
+			if (!cmdline_apic) {
+				genapic = apic_probe[i];
+				printk(KERN_INFO "Switched to APIC driver `%s'.\n",
+				       genapic->name);
+			}
 			return 1;
 		} 
 	} 


