Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVIVE7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVIVE7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVIVE7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:59:07 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:36516 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1030214AbVIVE7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:59:05 -0400
Date: Wed, 21 Sep 2005 23:54:58 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, andrew@cesa.opbu.xerox.com
Subject: [PATCH] ppc32: Fix configuration of PCI IO space on MPC85xx platform
Message-ID: <Pine.LNX.4.61.0509212353540.28494@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For platforms that don't have PCI IO at 0 the outbound window
registers were not being properly configured.

Signed-off-by: Andrew Klossner <andrew@cesa.opbu.xerox.com>
Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit 7b992aef26bd7dc2ed3eea0554d3e901d17aa999
tree a39f664767dbb49df981ed2037b7921f982a7854
parent db1488b812a7a96d50d51b018fbeb20586cc8e84
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 21 Sep 2005 23:53:25 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 21 Sep 2005 23:53:25 -0500

 arch/ppc/syslib/ppc85xx_setup.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/syslib/ppc85xx_setup.c b/arch/ppc/syslib/ppc85xx_setup.c
--- a/arch/ppc/syslib/ppc85xx_setup.c
+++ b/arch/ppc/syslib/ppc85xx_setup.c
@@ -184,8 +184,8 @@ mpc85xx_setup_pci1(struct pci_controller
 	pci->powar1 = 0x80044000 |
 	   (__ilog2(MPC85XX_PCI1_UPPER_MEM - MPC85XX_PCI1_LOWER_MEM + 1) - 1);
 
-	/* Setup outboud IO windows @ MPC85XX_PCI1_IO_BASE */
-	pci->potar2 = 0x00000000;
+	/* Setup outbound IO windows @ MPC85XX_PCI1_IO_BASE */
+	pci->potar2 = (MPC85XX_PCI1_LOWER_IO >> 12) & 0x000fffff;
 	pci->potear2 = 0x00000000;
 	pci->powbar2 = (MPC85XX_PCI1_IO_BASE >> 12) & 0x000fffff;
 	/* Enable, IO R/W */
@@ -235,8 +235,8 @@ mpc85xx_setup_pci2(struct pci_controller
 	pci->powar1 = 0x80044000 |
 	   (__ilog2(MPC85XX_PCI2_UPPER_MEM - MPC85XX_PCI2_LOWER_MEM + 1) - 1);
 
-	/* Setup outboud IO windows @ MPC85XX_PCI2_IO_BASE */
-	pci->potar2 = 0x00000000;
+	/* Setup outbound IO windows @ MPC85XX_PCI2_IO_BASE */
+	pci->potar2 = (MPC85XX_PCI2_LOWER_IO >> 12) & 0x000fffff;;
 	pci->potear2 = 0x00000000;
 	pci->powbar2 = (MPC85XX_PCI2_IO_BASE >> 12) & 0x000fffff;
 	/* Enable, IO R/W */
