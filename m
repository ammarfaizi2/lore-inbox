Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWIVUCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWIVUCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWIVUCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:02:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:30384 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964852AbWIVUCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:02:47 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
Date: Fri, 22 Sep 2006 22:02:41 +0200
User-Agent: KMail/1.9.3
Cc: Christoph Lameter <clameter@sgi.com>, Martin Bligh <mbligh@mbligh.org>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <200609222110.25118.ak@suse.de> <1158955850.24572.37.camel@localhost.localdomain>
In-Reply-To: <1158955850.24572.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609222202.41692.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 September 2006 22:10, Alan Cox wrote:
> Ar Gwe, 2006-09-22 am 21:10 +0200, ysgrifennodd Andi Kleen:
> > We already have that scheme. Any existing driver should be already converted
> > away from GFP_DMA towards dma_*/pci_*. dma_* knows all the magic
> > how to get memory for the various ranges. No need to mess up the 
> > main allocator.
> 
> Add an isa_device class and that'll fall into place nicely. isa_alloc_*
> will end up asking for 20bit DMA and it will work nicely.


The old school way is to pass NULL to pci_alloc_coherent()

> > that basically goes through the buddy lists freeing in >O(1) 
> > and does some directed reclaim, but that would likely be a separate
> > path anyways and not need your new structure to impact the O(1)
> > allocator.
> 
> Just search within the candidate 4MB (or whatever it is these days)
> chunks.
> 

What chunks?

> Ok the examples I know about are
> - ESS Maestro series audio - PCI, common on 32bit boxes a few years ago,
> no longer shipped and unlikely to be met on 64bit. Also slow allocations
> is fine.

And is fine with 16MB anyways I think.

> - Some aacraid, mostly only for control structures. Those found on 64bit
> are probably fine with slow alloc.

That is the only case where there are rumours they are not fine with 16MB.

> - Broadcom stuff - not sure if 30 or 31bit, around today and on 64bit

b44 is 30bit. That's true. I even got one here.

But it doesn't count really because we can handle it fine with existing 
16MB GFP_DMA

> - Floppy controller

That one only needs one page or so. In the worst case memory could be preallocated
in .bss for it. 

-Andi
