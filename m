Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319850AbSINDq3>; Fri, 13 Sep 2002 23:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319851AbSINDq2>; Fri, 13 Sep 2002 23:46:28 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:50677 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S319850AbSINDq1>;
	Fri, 13 Sep 2002 23:46:27 -0400
Date: Fri, 13 Sep 2002 23:51:13 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Streaming DMA mapping question
Message-ID: <20020914035112.GA14647@www.kroptech.com>
References: <20020913193916.GA5004@www.kroptech.com> <20020913.123641.50140065.davem@redhat.com> <20020913202150.GA24340@www.kroptech.com> <20020913.132842.97163812.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913.132842.97163812.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 01:28:42PM -0700, David S. Miller wrote:
>    From: Adam Kropelin <akropel1@rochester.rr.com>
>    Date: Fri, 13 Sep 2002 16:21:50 -0400
> 
>    On Fri, Sep 13, 2002 at 12:36:41PM -0700, David S. Miller wrote:
>    > Actually, rather it appears that the i386 pci_unmap_*() routines need
>    > the write buffer flush as well.
>    
>    Ah, a bug then. 
>    
> On further discussion with Alan Cox, the bug is actually that
> pci_map_*() needs the write buffer flush added.  pci_map_*()
> and pci_dma_sync_*() transfer ownership from CPU to PCI controller
> as abstracted in DMA-mapping.txt   Therefore these are the cases
> where the CPU write buffers need to be flushed.

It seems that pci_dma_sync_*() transfers ownership in either direction. In the
example from DMA-mapping.txt, it is used to transfer ownership from the PCI
device to the host CPU. Additionally, the presence of the host write buffer
flush indicates that it can also be used to transfer ownership from the host CPU
to the PCI device.

Am I missing something?

If I'm right, would you accept a patch to clarify the issue in DMA-mapping.txt?

--Adam

