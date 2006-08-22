Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWHVFtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWHVFtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 01:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWHVFtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 01:49:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:1960 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750785AbWHVFtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 01:49:40 -0400
Subject: struct msix_entry bogosity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 15:49:22 +1000
Message-Id: <1156225762.21752.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any objection to something like that ? (And of course fixing the few
drivers for the name change)

 struct msix_entry {
-        u16     vector; /* kernel uses to write allocated vector */
+        unsigned int     irq; /* kernel uses to write allocated
interrupt */
         u16     entry;  /* driver uses to specify entry, OS writes */
 };

Maybe x86 has a 1:1 hw vector <-> linux irq numbers (does it btw ?) but
other archs certainly don't. pci_enable_msix API should return a linux
IRQ number for the driver to pass to request_irq(), certainly not a hw
vector number, and the normal type for an irq is unsigned int :)

If it's ok, I'll do a patch changing that and fixing all in-tree users.

Ben.




