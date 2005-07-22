Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVGVQSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVGVQSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 12:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVGVQSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 12:18:51 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:14335 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262109AbVGVQSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 12:18:50 -0400
Date: Fri, 22 Jul 2005 11:18:41 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix typo in setup of 2nd PCI bus on 85xx
Message-ID: <Pine.LNX.4.61.0507221118070.25550@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo bug that was using PCI1 defines instead of PCI2 when setting up the
second PCI bus controller on 85xx based systems.  This hasn't been a real
issue since currently the PCI2 sizes are the same as the PCI1 sizes for
currently supported boards.

Thanks to Andrew Klossner @ Xerox for point this out.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 9ec8020999ffebb9524ca88e86c15923bf744b55
tree 4f7ac5a96c639ea33a2cec481357a76cfbbeffb3
parent d2a144648ecfe8652d19dd9019141e88a3a2a974
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 22 Jul 2005 09:58:23 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 22 Jul 2005 09:58:23 -0500

 arch/ppc/syslib/ppc85xx_setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/ppc85xx_setup.c b/arch/ppc/syslib/ppc85xx_setup.c
--- a/arch/ppc/syslib/ppc85xx_setup.c
+++ b/arch/ppc/syslib/ppc85xx_setup.c
@@ -233,14 +233,14 @@ mpc85xx_setup_pci2(struct pci_controller
 	pci->powbar1 = (MPC85XX_PCI2_LOWER_MEM >> 12) & 0x000fffff;
 	/* Enable, Mem R/W */
 	pci->powar1 = 0x80044000 |
-	   (__ilog2(MPC85XX_PCI1_UPPER_MEM - MPC85XX_PCI1_LOWER_MEM + 1) - 1);
+	   (__ilog2(MPC85XX_PCI2_UPPER_MEM - MPC85XX_PCI2_LOWER_MEM + 1) - 1);
 
 	/* Setup outboud IO windows @ MPC85XX_PCI2_IO_BASE */
 	pci->potar2 = 0x00000000;
 	pci->potear2 = 0x00000000;
 	pci->powbar2 = (MPC85XX_PCI2_IO_BASE >> 12) & 0x000fffff;
 	/* Enable, IO R/W */
-	pci->powar2 = 0x80088000 | (__ilog2(MPC85XX_PCI1_IO_SIZE) - 1);
+	pci->powar2 = 0x80088000 | (__ilog2(MPC85XX_PCI2_IO_SIZE) - 1);
 
 	/* Setup 2G inbound Memory Window @ 0 */
 	pci->pitar1 = 0x00000000;
