Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUB2QM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 11:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUB2QM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 11:12:28 -0500
Received: from witte.sonytel.be ([80.88.33.193]:11404 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262062AbUB2QM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 11:12:26 -0500
Date: Sun, 29 Feb 2004 17:12:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ben Collins <bcollins@debian.org>
cc: linux1394-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] csr1212 compile fix
Message-ID: <Pine.GSO.4.58.0402291708460.7483@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Ben,

in_interrupt() needs #include <linux/sched.h> on some platforms (e.g. m68k).

BTW, shouldn't most of the IEEE1394 stuff depend on CONFIG_PCI? E.g.
drivers/ieee1394/dma.c uses struct pci_dev and needs pci_alloc_consistent() and
friends.

(All found while trying to enable as many drivers as possible)

--- linux-2.6.4-rc1/drivers/ieee1394/csr1212.h	2004-02-29 09:31:37.000000000 +0100
+++ linux-m68k-2.6.4-rc1/drivers/ieee1394/csr1212.h	2004-02-29 12:37:11.000000000 +0100
@@ -37,6 +37,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/sched.h>

 #define CSR1212_MALLOC(size)		kmalloc((size), in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
 #define CSR1212_FREE(ptr)		kfree(ptr)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
