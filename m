Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVAYCk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVAYCk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 21:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVAYCi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 21:38:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:21437 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261776AbVAYCgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 21:36:13 -0500
Subject: [PATCH] ppc64: Missing call to ioremap in pci_iomap()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org,
       rvinson@mvista.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501241543530.23252@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0501241543530.23252@blarg.somerset.sps.mot.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 13:35:33 +1100
Message-Id: <1106620533.21888.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 15:46 -0600, Kumar Gala wrote: 
> The PPC version of pci_iomap seems to be missing a call to ioremap. This 
> patch corrects that oversight and has been tested on a IBM PPC750FX Eval 
> board.

Looks like the ppc64 version as well !

This patch adds the missing ioremap call to pci_iomap on ppc64.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/iomap.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/iomap.c	2005-01-24 11:42:36.000000000 +1100
+++ linux-work/arch/ppc64/kernel/iomap.c	2005-01-25 13:33:13.000000000 +1100
@@ -113,7 +113,7 @@
 	if (flags & IORESOURCE_IO)
 		return ioport_map(start, len);
 	if (flags & IORESOURCE_MEM)
-		return (void __iomem *) start;
+		return ioremap(start, len);
 	/* What? */
 	return NULL;
 }




