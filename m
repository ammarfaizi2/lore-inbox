Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTIIUQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTIIUQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:16:16 -0400
Received: from zok.SGI.COM ([204.94.215.101]:30892 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264486AbTIIUNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:13:49 -0400
Date: Tue, 9 Sep 2003 13:13:10 -0700
To: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] deal with lack of acpi prt entries gracefully
Message-ID: <20030909201310.GB6949@sgi.com>
Mail-Followup-To: andrew.grover@intel.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of going into an infinite loop because the list isn't setup yet,
just return NULL if there are no prt entries.

Jesse


diff -Nru a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c	Tue Sep  9 10:24:14 2003
+++ b/drivers/acpi/pci_irq.c	Tue Sep  9 10:24:14 2003
@@ -71,6 +71,9 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_find_prt_entry");
 
+	if (!acpi_prt.count)
+		return_PTR(NULL);
+
 	/*
 	 * Parse through all PRT entries looking for a match on the specified
 	 * PCI device's segment, bus, device, and pin (don't care about func).
