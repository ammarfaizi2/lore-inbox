Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVGSTnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVGSTnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 15:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVGSTnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 15:43:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1293 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261481AbVGSTnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 15:43:18 -0400
Date: Tue, 19 Jul 2005 21:42:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ambx1@neo.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/pnp/pnpbios/rsparser.c: fix compile error wit PCI=n
Message-ID: <20050719194250.GC5531@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with CONFIG_PCI=n:

<--  snip  -->

...
  CC      drivers/pnp/pnpbios/rsparser.o
drivers/pnp/pnpbios/rsparser.c: In function 'pnpbios_parse_allocated_irqresource':
drivers/pnp/pnpbios/rsparser.c:67: error: too many arguments to function 'pcibios_penalize_isa_irq'
make[3]: *** [drivers/pnp/pnpbios/rsparser.o] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/pnp/pnpbios/rsparser.c.old	2005-07-19 20:26:45.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/pnp/pnpbios/rsparser.c	2005-07-19 20:36:03.000000000 +0200
@@ -11,7 +11,7 @@
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
 #else
-inline void pcibios_penalize_isa_irq(int irq) {}
+inline void pcibios_penalize_isa_irq(int irq, int active) {}
 #endif /* CONFIG_PCI */
 
 #include "pnpbios.h"

