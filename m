Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTHTWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTHTWR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:17:58 -0400
Received: from havoc.gtf.org ([63.247.75.124]:42381 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262288AbTHTWR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:17:56 -0400
Date: Wed, 20 Aug 2003 18:17:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix ioapic build breakage
Message-ID: <20030820221755.GA20633@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



===== arch/i386/kernel/setup.c 1.92 vs edited =====
--- 1.92/arch/i386/kernel/setup.c	Tue Aug 19 16:01:09 2003
+++ edited/arch/i386/kernel/setup.c	Wed Aug 20 18:15:34 2003
@@ -543,11 +543,13 @@
 			if (!acpi_force) acpi_disabled = 1;
 		}
 
+#ifdef CONFIG_X86_LOCAL_APIC
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6)) {
 			skip_ioapic_setup = 1;
 		}
-#endif
+#endif /* CONFIG_X86_LOCAL_APIC */
+#endif /* CONFIG_ACPI_BOOT */
 
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
