Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBON6p>; Thu, 15 Feb 2001 08:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129275AbRBON6f>; Thu, 15 Feb 2001 08:58:35 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:56872 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129072AbRBON6V>; Thu, 15 Feb 2001 08:58:21 -0500
Date: Thu, 15 Feb 2001 07:58:19 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Allocating lots of DMA RAM?
Message-ID: <Pine.LNX.3.96.1010215075702.31904A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.  Is the following loop (from drivers/sound/i810_audio.c among
others) still the best way to allocate a large amount of DMA RAM for
audio?  ie. for audio devices that do not support scatter-gather.

Thanks,

	Jeff



	/* alloc as big a chunk as we can, FIXME: is this necessary ?? */
	for (order = DMABUF_DEFAULTORDER; order >= DMABUF_MINORDER; order--)
		if ((rawbuf = pci_alloc_consistent(state->card->pci_dev,
						   PAGE_SIZE << order,
						   &dmabuf->dma_handle)))
			break;
	if (!rawbuf)
		return -ENOMEM;


