Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280297AbRKEHW1>; Mon, 5 Nov 2001 02:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280296AbRKEHWK>; Mon, 5 Nov 2001 02:22:10 -0500
Received: from 117.ppp1-1.hob.worldonline.dk ([212.54.84.117]:16768 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280291AbRKEHWE>; Mon, 5 Nov 2001 02:22:04 -0500
Date: Mon, 5 Nov 2001 08:21:50 +0100
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: SYM-2 patches against latest kernels available
Message-ID: <20011105082150.H2580@suse.de>
In-Reply-To: <20011104195145.J10022@suse.de> <20011104174948.I2222-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011104174948.I2222-100000@gerard>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04 2001, G?rard Roudier wrote:
> > > Didn't see any. Only the dma_addr_t thing can be 32 bit or 64 bit
> > > depending on some magic. Apart this, the driver is asking for the
> > > appropriate dma mask given the configured dma adressing mode.
> >
> > I've looked over the sym-2 and it is using pci_map_sg so it's 64-bit
> > safe for sg transfers at least. For non-sg requests you are using
> > pci_map_single, but you can't do any better because the mid layer is
> > handing you virtual addresses in request_buffer currently anyways...
> 
> If there is some platform-specific thing that allows to handle map_single
> more right:), I can go with it. Would be fine to get IA64 and Alpha
> actually PCI-64 bit safe even by using some software shoehorn for that. :)

IA64 and Alpha is fine, the problem with the non-sg request is just
32-bit archs with highmem support. For that we need to pass in
page/offset values instead of a virtual address.

> > > PS: There is some pci64* API on some arch., but nobody will want to
> > > ever use it, in my opinion.
> >
> > You are doing it right :-)
> 
> You mean as right as possible? :)

Indeed :-)

-- 
Jens Axboe

