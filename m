Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUG2S2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUG2S2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUG2S1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:27:31 -0400
Received: from ozlabs.org ([203.10.76.45]:17612 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267513AbUG2SY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 14:24:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16649.16551.462029.768501@cargo.ozlabs.ibm.com>
Date: Thu, 29 Jul 2004 13:23:35 -0500
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, anton@samba.org,
       John Rose <johnrose@austin.ibm.com>
Subject: [PATCH] PPC64: ISA device tree node refcount fix
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below moves a misplaced of_node_put().  In the existing code, the
node in question is used just after its refcount is decremented.  Please apply.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -Nru a/arch/ppc64/kernel/pSeries_pci.c b/arch/ppc64/kernel/pSeries_pci.c
--- a/arch/ppc64/kernel/pSeries_pci.c	Mon Jul 26 17:47:44 2004
+++ b/arch/ppc64/kernel/pSeries_pci.c	Mon Jul 26 17:47:44 2004
@@ -284,10 +284,10 @@
 				isa_dn = of_find_node_by_type(NULL, "isa");
 				if (isa_dn) {
 					isa_io_base = pci_io_base;
-					of_node_put(isa_dn);
 					pci_process_ISA_OF_ranges(isa_dn,
 						hose->io_base_phys,
 						hose->io_base_virt);
+					of_node_put(isa_dn);
                                         /* Allow all IO */
                                         io_page_mask = -1;
 				}
