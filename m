Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265837AbVBDSqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbVBDSqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbVBDSqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:46:33 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:41901 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S264804AbVBDSp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:45:58 -0500
Date: Fri, 4 Feb 2005 19:45:23 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [compile fix] 2.6.11-rc3-mm1 (acpi Kconfig)
Message-ID: <20050204184523.GA3492@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I had the following errors while compiling 2.6.11-rc3-mm1:

In file included from include/asm/fixmap.h:27,
                 from arch/i386/kernel/asm-offsets.c:12:
		 include/asm/acpi.h: In function `acpi_noirq_set':
		 include/asm/acpi.h:160: error: `acpi_noirq' undeclared
		 (first use in this function)
		 include/asm/acpi.h:160: error: (Each undeclared
		 identifier is reported only once
		 include/asm/acpi.h:160: error: for each function it
		 appears in.)
		 include/asm/acpi.h: In function `acpi_disable_pci':
		 include/asm/acpi.h:163: error: `acpi_pci_disabled'
		 undeclared (first use in this function)


The following patch fixes it (it looks like bk-kconfig-acpi-fix.patch
was incorrect).

Regards,

Benoit


--- linux-clean/drivers/acpi/Kconfig	2005-02-04 19:36:49.000000000 +0100
+++ linux/drivers/acpi/Kconfig	2005-02-04 19:36:45.000000000 +0100
@@ -42,7 +42,7 @@ config ACPI
 
 config ACPI_BOOT
 	bool
-	depends on X86_HT
+	depends on ACPI || X86_HT
 	default y
 
 if ACPI
