Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319780AbSIMURC>; Fri, 13 Sep 2002 16:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319781AbSIMURC>; Fri, 13 Sep 2002 16:17:02 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:64763 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S319780AbSIMURB>;
	Fri, 13 Sep 2002 16:17:01 -0400
Date: Fri, 13 Sep 2002 16:21:50 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Streaming DMA mapping question
Message-ID: <20020913202150.GA24340@www.kroptech.com>
References: <20020913193916.GA5004@www.kroptech.com> <20020913.123641.50140065.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913.123641.50140065.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 12:36:41PM -0700, David S. Miller wrote:
>    From: Adam Kropelin <akropel1@rochester.rr.com>
>    Date: Fri, 13 Sep 2002 15:39:16 -0400
>    
>    According to the docs, you should either unmap or sync your DMA buffer before
>    touching it from the host. The i386 implementation of pci_unmap is empty --no
>    problem; there must not be any unmap work to do on this arch. But the 
>    implementation of pci_dma_sync does contain a flush_write_buffers() call. This
>    makes me think that perhaps if I'm going to modify the buffer before I submit it
>    back to the controller I need to do:
> 
> Actually, rather it appears that the i386 pci_unmap_*() routines need
> the write buffer flush as well.

Ah, a bug then. 

> The x86 implementation is a bad example to read if you're trying to
> see what the worst case scenerio is.

I was looking at the x86 implementation to help me narrow down the possible
source of a bug I'm seeing in the driver. I noticed the driver was examining a
DMA buffer without unmapping or syncing. Before I went to the work to fix the
code I wanted to see if those operations were no-ops on the platform I'm testing
on. I'll definitely fix the driver regardless, but I didn't want to blame the
lockup on it if unmapping won't actually change anything on this platform. Thus
my confusion upon seeing pci_unmap_*() and pci_dma_sync_*() differ.

> Just follow the document and your driver will work properly on all
> platforms.  DMA-mapping.txt was meant to be written in a way such
> that you should not ever need to look at an implementation of the
> interfaces to figure out how to use them.

Absolutely. It does that job very well and I am greatly appreciative for the
code groveling time that document has saved me. Kudos to you and others who
spent time writing it.

--Adam

