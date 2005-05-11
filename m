Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVEKUFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVEKUFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVEKUFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:05:23 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:19110 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262040AbVEKUFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:05:17 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 11 May 2005 21:59:10 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [patch] v4l: saa7134 byteorder fix
Message-ID: <20050511195910.GA23126@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix byteorder bug in the saa7134 driver.  With that ObviouslyCorrect[tm]
patch applied the driver reportly works on powerpc.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/saa7134/saa7134-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc3/drivers/media/video/saa7134/saa7134-core.c
===================================================================
--- linux-2.6.12-rc3.orig/drivers/media/video/saa7134/saa7134-core.c	2005-04-26 12:18:56.000000000 +0200
+++ linux-2.6.12-rc3/drivers/media/video/saa7134/saa7134-core.c	2005-05-11 21:54:54.000000000 +0200
@@ -340,7 +340,7 @@ int saa7134_pgtable_build(struct pci_dev
 	ptr = pt->cpu + startpage;
 	for (i = 0; i < length; i++, list++)
 		for (p = 0; p * 4096 < list->length; p++, ptr++)
-			*ptr = sg_dma_address(list) - list->offset;
+			*ptr = cpu_to_le32(sg_dma_address(list) - list->offset);
 	return 0;
 }
 

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3
