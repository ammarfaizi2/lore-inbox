Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbUDMJTD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 05:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbUDMJTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 05:19:02 -0400
Received: from ozlabs.org ([203.10.76.45]:59281 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263370AbUDMJS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 05:18:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16507.45195.148525.945019@cargo.ozlabs.ibm.com>
Date: Tue, 13 Apr 2004 19:19:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: boutcher@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix ibmveth.c compilation
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes PCI_DMA_TODEVICE to DMA_TO_DEVICE in a couple of
places in drivers/net/ibmveth.c, since it doesn't compile without this
change and it does compile with it.  It also reformats a couple of
over-long lines in the vicinity of the other changes.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/net/ibmveth.c test25/drivers/net/ibmveth.c
--- linux-2.5/drivers/net/ibmveth.c	2004-04-13 09:25:10.027576720 +1000
+++ test25/drivers/net/ibmveth.c	2004-04-13 18:37:04.966522224 +1000
@@ -641,7 +641,8 @@
 
 	/* map the initial fragment */
 	desc[0].fields.length  = nfrags ? skb->len - skb->data_len : skb->len;
-	desc[0].fields.address = vio_map_single(adapter->vdev, skb->data, desc[0].fields.length, PCI_DMA_TODEVICE);
+	desc[0].fields.address = vio_map_single(adapter->vdev, skb->data,
+					desc[0].fields.length, DMA_TO_DEVICE);
 	desc[0].fields.valid   = 1;
 
 	if(dma_mapping_error(desc[0].fields.address)) {
@@ -657,9 +658,10 @@
 	/* map fragments past the initial portion if there are any */
 	while(curfrag--) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[curfrag];
-		desc[curfrag+1].fields.address = vio_map_single(adapter->vdev,
-								page_address(frag->page) + frag->page_offset,
-								frag->size, PCI_DMA_TODEVICE);
+		desc[curfrag+1].fields.address
+			= vio_map_single(adapter->vdev,
+				page_address(frag->page) + frag->page_offset,
+				frag->size, DMA_TO_DEVICE);
 		desc[curfrag+1].fields.length = frag->size;
 		desc[curfrag+1].fields.valid  = 1;
 
