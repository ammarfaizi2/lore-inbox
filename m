Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSEXVAK>; Fri, 24 May 2002 17:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSEXVAJ>; Fri, 24 May 2002 17:00:09 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:28552 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S293337AbSEXVAJ>;
	Fri, 24 May 2002 17:00:09 -0400
Date: Fri, 24 May 2002 13:58:42 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible discrepancy regarding streaming DMA mappings in DMA-mapping.txt?
Message-ID: <20020524135842.L7205@ayrnetworks.com>
In-Reply-To: <20020524104345.J7205@ayrnetworks.com> <20020524.104209.31440798.davem@redhat.com> <20020524133711.K7205@ayrnetworks.com> <20020524.132641.104219414.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 01:26:41PM -0700, David S. Miller wrote:
> 
> I know what you're trying to do, but I'm going to tell you upfront
> that this will make the existing case much more inefficient than
> it needs to be.

Sorry, I'm not clear on this one. I was first proposing (for the short
term, at least) to not change anything at all: all the existing
implementations of pci_dma_sync_*(..., PCIDMA_TO_DEVICE) already do what
is required: prepare the buffer to be DMAed from by the controller. Most
drivers won't have to deal with this; most network drivers, for example,
do a pci_map_*() on an skb passed down from the stack and subsequently
pci_unmap_*() those buffers once transmitted, thus having no need for
pci_dma_sync_*()... So I don't see how this makes anything else less
efficient...

> 
> Please, add a new call to handle your case.  Thanks.

Such a call would do what pci_dma_sync_*(..., PCIDMA_TO_DEVICE) already
does (unless that is what you want - to have a new call just for the
sake of clarity...).

Thanks,
William
