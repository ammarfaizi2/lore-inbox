Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277528AbRKDSwZ>; Sun, 4 Nov 2001 13:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRKDSwI>; Sun, 4 Nov 2001 13:52:08 -0500
Received: from 49.ppp1-2.ski.worldonline.dk ([212.54.89.177]:49025 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S273796AbRKDSwB>; Sun, 4 Nov 2001 13:52:01 -0500
Date: Sun, 4 Nov 2001 19:51:45 +0100
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: SYM-2 patches against latest kernels available
Message-ID: <20011104195145.J10022@suse.de>
In-Reply-To: <3BE564A4.D88D1951@mandrakesoft.com> <20011104160540.X1663-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011104160540.X1663-100000@gerard>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04 2001, G?rard Roudier wrote:
> 
> 
> On Sun, 4 Nov 2001, Jeff Garzik wrote:
> 
> > Gérard Roudier wrote:
> > > The patch against linux-2.4.13 has been sent to Alan Cox for inclusion in
> > > newer stable kernels. Alan wants to test it on his machines which is a
> > > good thing. Anyway, those patches just add the new driver version to
> > > kernel tree and leave stock sym53c8xx and ncr53c8xx in place.
> >
> > Are the older sym/ncr drivers going away in 2.5?
> >
> >
> > > Any report, especially on large memory machines using 64 bit DMA (2.4
> > > kernels + PCI DAC capable controllers only), is welcome. I can't test 64
> > > bit DMA, since my fatest machine has only 512 MB of memory.
> > >
> > > To configure the driver, you must select "SYM53C8XX version 2 driver" from
> > > kernel config. For large memory machines, a new "DMA addressing mode"
> > > option is to be configured as follows (help texts have been added to
> > > Configure.help):
> > >
> > > Value 0: 32 bit DMA addressing
> > > Value 1: 40 bit DMA addressing (upper 24 bytes set to zero)
> > > Value 2: 64 bit DMA addressing limited to 16 segments of 4 GB (64 GB) max.
> >
> > Are you using the new pci64 API under 2.4.x?
> 
> Didn't see any. Only the dma_addr_t thing can be 32 bit or 64 bit
> depending on some magic. Apart this, the driver is asking for the
> appropriate dma mask given the configured dma adressing mode.

I've looked over the sym-2 and it is using pci_map_sg so it's 64-bit
safe for sg transfers at least. For non-sg requests you are using
pci_map_single, but you can't do any better because the mid layer is
handing you virtual addresses in request_buffer currently anyways...

> PS: There is some pci64* API on some arch., but nobody will want to
> ever use it, in my opinion.

You are doing it right :-)

-- 
Jens Axboe

