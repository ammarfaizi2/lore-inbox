Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVEYPg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVEYPg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVEYPg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:36:57 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:31939 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262375AbVEYPgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:36:48 -0400
Date: Wed, 25 May 2005 10:36:24 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, shall@mvista.com
Subject: [PATCH] ppc32: Fix building MPC8555 CDS when CONFIG_PCI is disabled
Message-ID: <Pine.LNX.4.61.0505251035320.13355@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch that introduced support for the VIA chipset broke building if
CONFIG_PCI is disabled.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 84a069e46b6b866b338e44529f505fddd7d31fbb
tree 362fd343e5b2c022b654da36742ce08b6a5ddca9
parent 7289356a6b3c0218f9ad6e85280c4f9cc121e371
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 25 May 2005 10:32:53 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 25 May 2005 10:32:53 -0500

 ppc/platforms/85xx/mpc85xx_cds_common.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- 12a426fa6a66d581ca2c5fca42457b3f3505af09/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
+++ 362fd343e5b2c022b654da36742ce08b6a5ddca9/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
@@ -439,9 +439,6 @@
 
 	printk("mpc85xx_cds_setup_arch\n");
 
-	/* VIA IDE configuration */
-        ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
-
 #ifdef CONFIG_CPM2
 	cpm2_reset();
 #endif
@@ -462,6 +459,9 @@
 	loops_per_jiffy = freq / HZ;
 
 #ifdef CONFIG_PCI
+	/* VIA IDE configuration */
+        ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
+
 	/* setup PCI host bridges */
 	mpc85xx_setup_hose();
 #endif
