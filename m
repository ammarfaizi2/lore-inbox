Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267591AbUI1GnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUI1GnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 02:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUI1GnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 02:43:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:10131 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267591AbUI1GnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 02:43:18 -0400
Subject: G5 and IO accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1096353661.22555.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 16:41:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've heard in the past that people had trouble getting PCI cards
with IO ports (inX/outX) to work on G5s... looking at the setup code
today, it looks like I had a bogus base address when setting it up,
can somebody with such a card confirm that it works with this patch ? 

===== arch/ppc64/kernel/pmac_pci.c 1.10 vs edited =====
--- 1.10/arch/ppc64/kernel/pmac_pci.c	2004-09-28 11:47:33 +10:00
+++ edited/arch/ppc64/kernel/pmac_pci.c	2004-09-28 16:41:24 +10:00
@@ -419,7 +419,7 @@
 	 * properties or figuring out the U3 address space decoding logic and
 	 * then read it's configuration register (if any).
 	 */
-	hose->io_base_phys = 0xf4000000 + 0x00400000;
+	hose->io_base_phys = 0xf4000000;
 	hose->io_base_virt = ioremap(hose->io_base_phys, 0x00400000);
 	isa_io_base = pci_io_base = (unsigned long) hose->io_base_virt;
 	hose->io_resource.name = np->full_name;


