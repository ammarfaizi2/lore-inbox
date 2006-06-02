Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWFBTro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWFBTro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWFBTrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:47:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:24272 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932546AbWFBTqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 21:45:05 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 01/18] video1394: be quiet
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>, Daniel Drake <dsd@gentoo.org>
In-Reply-To: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
Message-ID: <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.26) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <dsd@gentoo.org>

When working with multiple cameras and intensive applications, our logs 
get flooded with video1394 information which isn't of much interest.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
---
Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/video1394.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/video1394.c	2006-06-01 20:55:05.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/video1394.c	2006-06-01 20:55:38.000000000 +0200
@@ -331,7 +331,7 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 
         spin_lock_init(&d->lock);
 
-	PRINT(KERN_INFO, ohci->host->id, "Iso %s DMA: %d buffers "
+	DBGMSG(ohci->host->id, "Iso %s DMA: %d buffers "
 	      "of size %d allocated for a frame size %d, each with %d prgs",
 	      (type == OHCI_ISO_RECEIVE) ? "receive" : "transmit",
 	      d->num_desc - 1, d->buf_size, d->frame_size, d->nb_cmd);
@@ -759,7 +759,7 @@ static int __video1394_ioctl(struct file
 		} else {
 			mask = (u64)0x1<<v.channel;
 		}
-		PRINT(KERN_INFO, ohci->host->id, "mask: %08X%08X usage: %08X%08X\n",
+		DBGMSG(ohci->host->id, "mask: %08X%08X usage: %08X%08X\n",
 			(u32)(mask>>32),(u32)(mask&0xffffffff),
 			(u32)(ohci->ISO_channel_usage>>32),
 			(u32)(ohci->ISO_channel_usage&0xffffffff));
@@ -805,7 +805,7 @@ static int __video1394_ioctl(struct file
 			v.buf_size = d->buf_size;
 			list_add_tail(&d->link, &ctx->context_list);
 
-			PRINT(KERN_INFO, ohci->host->id,
+			DBGMSG(ohci->host->id,
 			      "iso context %d listen on channel %d",
 			      d->ctx, v.channel);
 		}
@@ -828,7 +828,7 @@ static int __video1394_ioctl(struct file
 
 			list_add_tail(&d->link, &ctx->context_list);
 
-			PRINT(KERN_INFO, ohci->host->id,
+			DBGMSG(ohci->host->id,
 			      "Iso context %d talk on channel %d", d->ctx,
 			      v.channel);
 		}
@@ -873,7 +873,7 @@ static int __video1394_ioctl(struct file
 			d = find_ctx(&ctx->context_list, OHCI_ISO_TRANSMIT, channel);
 
 		if (d == NULL) return -ESRCH;
-		PRINT(KERN_INFO, ohci->host->id, "Iso context %d "
+		DBGMSG(ohci->host->id, "Iso context %d "
 		      "stop talking on channel %d", d->ctx, channel);
 		free_dma_iso_ctx(d);
 
@@ -935,7 +935,7 @@ static int __video1394_ioctl(struct file
 		else {
 			/* Wake up dma context if necessary */
 			if (!(reg_read(ohci, d->ctrlSet) & 0x400)) {
-				PRINT(KERN_INFO, ohci->host->id,
+				DBGMSG(ohci->host->id,
 				      "Waking up iso dma ctx=%d", d->ctx);
 				reg_write(ohci, d->ctrlSet, 0x1000);
 			}
@@ -1106,7 +1106,7 @@ static int __video1394_ioctl(struct file
 		else {
 			/* Wake up dma context if necessary */
 			if (!(reg_read(ohci, d->ctrlSet) & 0x400)) {
-				PRINT(KERN_INFO, ohci->host->id,
+				DBGMSG(ohci->host->id,
 				      "Waking up iso transmit dma ctx=%d",
 				      d->ctx);
 				put_timestamp(ohci, d, d->last_buffer);
@@ -1232,7 +1232,7 @@ static int video1394_release(struct inod
 			      "is not being used", d->channel);
 		else
 			ohci->ISO_channel_usage &= ~mask;
-		PRINT(KERN_INFO, ohci->host->id, "On release: Iso %s context "
+		DBGMSG(ohci->host->id, "On release: Iso %s context "
 		      "%d stop listening on channel %d",
 		      d->type == OHCI_ISO_RECEIVE ? "receive" : "transmit",
 		      d->ctx, d->channel);


