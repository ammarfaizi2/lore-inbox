Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVAXVuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVAXVuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVAXVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:48:21 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:13965 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261680AbVAXVqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:46:50 -0500
Date: Mon, 24 Jan 2005 15:46:20 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: akpm@osdl.org
cc: linuxppc-embedded@ozlabs.org, rvinson@mvista.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Missing call to ioremap in pci_iomap()
Message-ID: <Pine.LNX.4.61.0501241543530.23252@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PPC version of pci_iomap seems to be missing a call to ioremap. This 
patch corrects that oversight and has been tested on a IBM PPC750FX Eval 
board.

Signed-off-by Randy Vinson <rvinson@mvista.com>
Signed-off-by Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c	2005-01-24 15:43:19 -06:00
+++ b/arch/ppc/kernel/pci.c	2005-01-24 15:43:19 -06:00
@@ -1712,7 +1712,11 @@
 	if (flags & IORESOURCE_IO)
 		return ioport_map(start, len);
 	if (flags & IORESOURCE_MEM)
-		return (void __iomem *) start;
+		/* Not checking IORESOURCE_CACHEABLE because PPC does
+		 * not currently distinguish between ioremap and
+		 * ioremap_nocache.
+		 */
+		return ioremap(start, len);
 	/* What? */
 	return NULL;
 }
