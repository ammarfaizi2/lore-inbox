Return-Path: <linux-kernel-owner+w=401wt.eu-S932737AbXAJI6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbXAJI6I (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 03:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbXAJI6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 03:58:08 -0500
Received: from cantor2.suse.de ([195.135.220.15]:46748 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932737AbXAJI6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 03:58:07 -0500
Message-ID: <45A4AAA4.4040606@novell.com>
Date: Wed, 10 Jan 2007 09:58:12 +0100
From: Gerd Hoffmann <kraxel@novell.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [patch] Fix bttv and friends on 64bit machines with lots of memory.
Content-Type: multipart/mixed;
 boundary="------------070702000202010903050800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070702000202010903050800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  Hi,

We have a DMA32 zone now, lets use it to make sure the card
can reach the memory we have allocated for the video frame
buffers.

please apply,

  Gerd

--------------070702000202010903050800
Content-Type: text/plain;
 name="v4l-dma32"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-dma32"

Fix bttv and friends on 64bit machines with lots of memory.

We have a DMA32 zone now, lets use it to make sure the card
can reach the memory we have allocated for the video frame
buffers.

Signed-off-by: Gerds Hoffmann <kraxel@suse.de>
---
 drivers/media/video/video-buf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18/drivers/media/video/video-buf.c
===================================================================
--- linux-2.6.18.orig/drivers/media/video/video-buf.c
+++ linux-2.6.18/drivers/media/video/video-buf.c
@@ -1224,7 +1224,7 @@ videobuf_vm_nopage(struct vm_area_struct
 		vaddr,vma->vm_start,vma->vm_end);
 	if (vaddr > vma->vm_end)
 		return NOPAGE_SIGBUS;
-	page = alloc_page(GFP_USER);
+	page = alloc_page(GFP_USER | __GFP_DMA32);
 	if (!page)
 		return NOPAGE_OOM;
 	clear_user_page(page_address(page), vaddr, page);

--------------070702000202010903050800--
