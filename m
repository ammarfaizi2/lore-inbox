Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTHUFVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 01:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTHUFVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 01:21:42 -0400
Received: from havoc.gtf.org ([63.247.75.124]:5275 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262440AbTHUFVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 01:21:41 -0400
Date: Thu, 21 Aug 2003 01:21:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] noapic should depend on ioapic config not local
Message-ID: <20030821052140.GA19039@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zwane's comment was correct, it needs to be CONFIG_X86_IO_APIC.

IMO this stuff really wants to be moved to __setup(),
to clean up the ifdefs and modularize the code.


===== arch/i386/kernel/setup.c 1.93 vs edited =====
--- 1.93/arch/i386/kernel/setup.c	Wed Aug 20 14:15:34 2003
+++ edited/arch/i386/kernel/setup.c	Wed Aug 20 21:27:05 2003
@@ -543,12 +543,12 @@
 			if (!acpi_force) acpi_disabled = 1;
 		}
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86_IO_APIC
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6)) {
 			skip_ioapic_setup = 1;
 		}
-#endif /* CONFIG_X86_LOCAL_APIC */
+#endif /* CONFIG_X86_IO_APIC */
 #endif /* CONFIG_ACPI_BOOT */
 
 		/*
