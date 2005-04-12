Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVDMA0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVDMA0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVDLUUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:20:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:22472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262132AbVDLKb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:28 -0400
Message-Id: <200504121031.j3CAVHpM005280@shell0.pdx.osdl.net>
Subject: [patch 039/198] ppc32: Make the Powerstack II Pro4000 boot again
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, leigh@solinno.co.uk
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Leigh Brown" <leigh@solinno.co.uk>

This patch restores the original behaviour of prep_pcibios_fixup() to only
call prep_pib_init() on machines with an openpic.  This allows the
Powerstack II Pro4000 to boot again.

Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/platforms/prep_pci.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -puN arch/ppc/platforms/prep_pci.c~ppc32-make-the-powerstack-ii-pro4000-boot-again arch/ppc/platforms/prep_pci.c
--- 25/arch/ppc/platforms/prep_pci.c~ppc32-make-the-powerstack-ii-pro4000-boot-again	2005-04-12 03:21:12.719203288 -0700
+++ 25-akpm/arch/ppc/platforms/prep_pci.c	2005-04-12 03:21:12.722202832 -0700
@@ -1245,8 +1245,13 @@ prep_pcibios_fixup(void)
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}
 
-	/* Setup the Winbond or Via PIB */
-	prep_pib_init();
+	/* Setup the Winbond or Via PIB - prep_pib_init() is coded for
+	 * the non-openpic case, but it breaks (at least) the Utah
+	 * (Powerstack II Pro4000), so only call it if we have an
+	 * openpic.
+	 */
+	if (have_openpic)
+		prep_pib_init();
 }
 
 static void __init
_
