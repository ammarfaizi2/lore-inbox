Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWI1RcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWI1RcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWI1RcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:32:15 -0400
Received: from smtp-out.google.com ([216.239.45.12]:44363 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030266AbWI1RcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:32:12 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type;
	b=opJWXaFti1MhcaCeI5kSzlbnBsWNJSYggoXxO2clyv4r81Ly7Fg0fJrUZjmSiGuyP
	MHJcSlpZ8hLygkn7P76pw==
Message-ID: <451C070E.8080800@google.com>
Date: Thu, 28 Sep 2006 10:31:58 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Sujoy Gupta <sujoy@google.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix compiler warning in drivers/media/video/video-buf.c
Content-Type: multipart/mixed;
 boundary="------------020000030805030800070309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020000030805030800070309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Using a double cast to avoid compiler warnings when
building for PAE. Compiler doesn't like direct casting
of a 32 bit ptr to 64 bit integer.

From: Sujoy Gupta <sujoy@google.com>
Signed-off-by: Martin J. Bligh <mbligh@google.com>

--------------020000030805030800070309
Content-Type: text/plain;
 name="2.6.18-videobuf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.18-videobuf"

diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/drivers/media/video/video-buf.c 2.6.18-videobuf/drivers/media/video/video-buf.c
--- linux-2.6.18/drivers/media/video/video-buf.c	2006-06-17 18:49:35.000000000 -0700
+++ 2.6.18-videobuf/drivers/media/video/video-buf.c	2006-09-28 10:28:54.000000000 -0700
@@ -365,7 +365,12 @@ videobuf_iolock(struct videobuf_queue* q
 		if (NULL == fbuf)
 			return -EINVAL;
 		/* FIXME: need sanity checks for vb->boff */
-		bus   = (dma_addr_t)fbuf->base + vb->boff;
+		/*
+		 * Using a double cast to avoid compiler warnings when
+		 * building for PAE. Compiler doesn't like direct casting 
+		 * of a 32 bit ptr to 64 bit integer.
+		 */
+		bus   = (dma_addr_t)(size_t)fbuf->base + vb->boff;
 		pages = PAGE_ALIGN(vb->size) >> PAGE_SHIFT;
 		err = videobuf_dma_init_overlay(&vb->dma,PCI_DMA_FROMDEVICE,
 						bus, pages);

--------------020000030805030800070309--
