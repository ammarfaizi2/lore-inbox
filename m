Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTHUQOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTHUQOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:14:41 -0400
Received: from havoc.gtf.org ([63.247.75.124]:42655 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262785AbTHUQOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:14:37 -0400
Date: Thu, 21 Aug 2003 12:14:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: len.brown@intel.com, andrew.grover@intel.com, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 'noapic' already handled elsewhere
Message-ID: <20030821161436.GA15610@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent a previous patch to s/LOCAL_APIC/IO_APIC/, as Zwane noticed
my first patch needed that.  In that patch, I commented __setup()
would be better.

Well... line 718 of arch/i386/kernel/io_apic.c _already_ handles this
case, using __setup() properly.

Word of warning... patch only compile tested, but seems obvious from
looking at io_apic.c.

BTW, why isn't ACPI using __setup() as well?  I don't see that ACPI
needs to patch arch/i386/kernel/setup.c at all.


===== arch/i386/kernel/setup.c 1.94 vs edited =====
--- 1.94/arch/i386/kernel/setup.c	Thu Aug 21 01:32:04 2003
+++ edited/arch/i386/kernel/setup.c	Thu Aug 21 12:09:13 2003
@@ -544,12 +544,6 @@
 			if (!acpi_force) acpi_disabled = 1;
 		}
 
-#ifdef CONFIG_X86_LOCAL_APIC
-		/* disable IO-APIC */
-		else if (!memcmp(from, "noapic", 6)) {
-			skip_ioapic_setup = 1;
-		}
-#endif /* CONFIG_X86_LOCAL_APIC */
 #endif /* CONFIG_ACPI_BOOT */
 
 		/*
