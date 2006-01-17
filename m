Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWAQRym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWAQRym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWAQRym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:54:42 -0500
Received: from [81.2.110.250] ([81.2.110.250]:50364 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932265AbWAQRyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:54:41 -0500
Subject: PATCH: Fix warning with b44.c on 64bit boxes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 17:53:56 +0000
Message-Id: <1137520436.14135.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof() return is not an int, so use max_t to get the types right.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/net/b44.c linux-2.6.16-rc1/drivers/net/b44.c
--- linux.vanilla-2.6.16-rc1/drivers/net/b44.c	2006-01-17 15:36:31.000000000 +0000
+++ linux-2.6.16-rc1/drivers/net/b44.c	2006-01-17 17:20:41.000000000 +0000
@@ -2136,7 +2136,7 @@
 
 	/* Setup paramaters for syncing RX/TX DMA descriptors */
 	dma_desc_align_mask = ~(dma_desc_align_size - 1);
-	dma_desc_sync_size = max(dma_desc_align_size, sizeof(struct dma_desc));
+	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));
 
 	return pci_module_init(&b44_driver);
 }

