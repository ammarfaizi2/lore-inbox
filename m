Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272191AbRH3MfM>; Thu, 30 Aug 2001 08:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272192AbRH3MfD>; Thu, 30 Aug 2001 08:35:03 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:40208 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S272191AbRH3Mer>;
	Thu, 30 Aug 2001 08:34:47 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [UPDATE] 2.4.10-pre2 PCI64, API changes README
Date: 30 Aug 2001 12:34:11 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9oscm3.4o6.kraxel@bytesex.org>
In-Reply-To: <20010829.181852.98555095.davem@redhat.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 999174851 4935 127.0.0.1 (30 Aug 2001 12:34:11 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>  
>  Ok, new patch up on kernel.org against 2.4.10-pre2:
>  
>  ftp.kernel.org:/pub/linux/kernel/davem/PCI64/pci64-2.4.10p2-1.patch.gz
>  
>  The major change in this release is that the API has been redone.

A maybe related issue:

My current bttv does zerocopy capture if you ask it for a video frame
using read():  locks memory with kiobufs, builds a scatterlist for the
locked pages, asks for bus addresses using pci_map_sg, then kick DMA.

These days I tried what happens if I start a PCI->PCI transfer this way:
Open the framebuffer device, mmap the framebuffer memory, then ask bttv
to blit one video frame to the framebuffer by passing the pointer of the
fb mapping to bttv's read() function.

Didn't work, looks like map_user_buf can deal with main memory only, but
not with I/O memory.  It gave me NULL pointers in the iobuf page list.

Is there any way (portable) way to deal with this situation?  I'd expect
I can get the physical address for the I/O memory by walking the page
tables, but then I'd have to translate that to a bus address somehow.
How PCI->PCI transfers are handled on architectures with a iommu?  Do I
need a iommu entry for them?

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
