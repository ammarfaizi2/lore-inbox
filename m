Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVHBJ4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVHBJ4C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVHBJyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:54:08 -0400
Received: from gw.alcove.fr ([81.80.245.157]:47549 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261449AbVHBJxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:53:40 -0400
Subject: [PATCH] meye: use dma-mapping constants
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 11:52:10 +0200
Message-Id: <1122976330.4656.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch comes from the janitors and have been in my tree for quite
some time now. Please apply.

Stelian.

Use the DMA_32BIT_MASK constant from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask()
This patch includes dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Stelian Pop <stelian@popies.net>

Index: linux-2.6.git/drivers/media/video/meye.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/meye.c	2005-07-08 14:08:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/meye.c	2005-08-02 10:22:23.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/vmalloc.h>
+#include <linux/dma-mapping.h>
 
 #include "meye.h"
 #include <linux/meye.h>
@@ -121,7 +122,7 @@
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
 
 	/* give only 32 bit DMA addresses */
-	if (dma_set_mask(&meye.mchip_dev->dev, 0xffffffff))
+	if (dma_set_mask(&meye.mchip_dev->dev, DMA_32BIT_MASK))
 		return -1;
 
 	meye.mchip_ptable_toc = dma_alloc_coherent(&meye.mchip_dev->dev,

-- 
Stelian Pop <stelian@popies.net>

