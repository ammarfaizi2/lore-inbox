Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbUELXr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUELXr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUELXr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:47:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15060 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263366AbUELXr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:47:27 -0400
Date: Thu, 13 May 2004 01:47:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix cyclades compile with !PCI
Message-ID: <20040512234724.GD21408@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.6-mm1 (but not specific to -mm) 
with CONFIG_PCI=n:

<--  snip  -->

...
  CC      drivers/char/cyclades.o
drivers/char/cyclades.c: In function `cy_cleanup_module':
drivers/char/cyclades.c:5638: warning: implicit declaration of function `pci_release_regions'
...
  LD      .tmp_vmlinux1
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

The patch below fixes this issue.

Please apply
Adrian

--- linux-2.6.6-mm1-full/drivers/char/cyclades.c.old	2004-05-13 01:18:09.000000000 +0200
+++ linux-2.6.6-mm1-full/drivers/char/cyclades.c	2004-05-13 01:18:34.000000000 +0200
@@ -5634,8 +5634,10 @@
 #endif /* CONFIG_CYZ_INTR */
 	    )
 		free_irq(cy_card[i].irq, &cy_card[i]);
+#ifdef CONFIG_PCI
 		if (cy_card[i].pdev)
 			pci_release_regions(cy_card[i].pdev);
+#endif
         }
     }
     if (tmp_buf) {
