Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271397AbTGRJX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271421AbTGRJX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:23:59 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:9798 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S271397AbTGRJX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:23:57 -0400
Date: Fri, 18 Jul 2003 11:38:51 +0200
From: Jasper Spaans <jasper@vs19.net>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: rephrase acpi init messages for i386/x86_64
Message-ID: <20030718093851.GA1434@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Below is a simple patch which changes the wording of 'BIOS passes blacklist'
into something which is more clear - not being a native speaker of English I
was wondering whether 'BIOS passes blacklist' meant that my machine was
listed or not.

Furthermore, nothing is displayed in the case a BIOS /is/ listed - adding a
warning in that case seems useful to me.


Index: arch/i386/kernel/acpi/boot.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/acpi/boot.c,v
retrieving revision 1.5
diff -u -r1.5 boot.c
--- CVS/arch/i386/kernel/acpi/boot.c	2 Apr 2003 05:01:48 -0000	1.5
+++ linux-2.5/arch/i386/kernel/acpi/boot.c	18 Jul 2003 08:05:29 -0000
@@ -310,11 +310,12 @@
 
 	result = acpi_blacklisted();
 	if (result) {
+		printk(KERN_WARNING PREFIX "BIOS listed in blacklist, disabling ACPI support\n");
 		acpi_disabled = 1;
 		return result;
 	}
 	else
-		printk(KERN_NOTICE PREFIX "BIOS passes blacklist\n");
+		printk(KERN_NOTICE PREFIX "BIOS not listed in blacklist\n");
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
Index: arch/x86_64/kernel/acpi/boot.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/x86_64/kernel/acpi/boot.c,v
retrieving revision 1.4
diff -u -r1.4 boot.c
--- CVS/arch/x86_64/kernel/acpi/boot.c	26 Jun 2003 16:25:45 -0000	1.4
+++ linux-2.5/arch/x86_64/kernel/acpi/boot.c	18 Jul 2003 08:05:35 -0000
@@ -313,10 +313,11 @@
 
 	result = acpi_blacklisted();
 	if (result) {
+		printk(KERN_WARNING PREFIX "BIOS listed in blacklist, disabling ACPI support\n");
 		acpi_disabled = 1;
 		return result;
 	} else
-               printk(KERN_NOTICE PREFIX "BIOS passes blacklist\n");
+               printk(KERN_NOTICE PREFIX "BIOS not listed in blacklist\n");
 
 
 	extern int disable_apic;

VrGr,
-- 
Jasper Spaans                 http://jsp.vs19.net/contact/
