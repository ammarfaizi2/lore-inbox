Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUI2EKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUI2EKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 00:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268180AbUI2EKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 00:10:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:64154 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268177AbUI2EKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 00:10:35 -0400
Subject: [PATCH] ppc/ppc64: Fix g5 access to PCI IO cycles
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Owen Stampflee <ostampflee@terrasoftsolutions.com>
Content-Type: text/plain
Message-Id: <1096430880.17114.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 14:08:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Looks like we never needed them, since that bug has been there forever,
I didn't get the right base for the IO cycles on the G5 host bridge
in the first place (I probably misinterpreted some OF forth code or
something like that).

Here's the fix:

===== arch/ppc/platforms/pmac_pci.c 1.23 vs edited =====
--- 1.23/arch/ppc/platforms/pmac_pci.c	2004-09-21 11:17:40 +10:00
+++ edited/arch/ppc/platforms/pmac_pci.c	2004-09-29 14:05:15 +10:00
@@ -716,7 +716,7 @@
 	 * properties or figuring out the U3 address space decoding logic and
 	 * then read its configuration register (if any).
 	 */
-	hose->io_base_phys = 0xf4000000 + 0x00400000;
+	hose->io_base_phys = 0xf4000000;
 	hose->io_base_virt = ioremap(hose->io_base_phys, 0x00400000);
 	isa_io_base = (unsigned long) hose->io_base_virt;
 	hose->io_resource.name = np->full_name;
===== arch/ppc64/kernel/pmac_pci.c 1.9 vs edited =====
--- 1.9/arch/ppc64/kernel/pmac_pci.c	2004-09-27 19:12:49 +10:00
+++ edited/arch/ppc64/kernel/pmac_pci.c	2004-09-29 14:05:38 +10:00
@@ -419,7 +419,7 @@
 	 * properties or figuring out the U3 address space decoding logic and
 	 * then read it's configuration register (if any).
 	 */
-	hose->io_base_phys = 0xf4000000 + 0x00400000;
+	hose->io_base_phys = 0xf4000000;
 	hose->io_base_virt = ioremap(hose->io_base_phys, 0x00400000);
 	isa_io_base = pci_io_base = (unsigned long) hose->io_base_virt;
 	hose->io_resource.name = np->full_name;


