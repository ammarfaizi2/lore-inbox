Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266405AbRGBIYZ>; Mon, 2 Jul 2001 04:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266406AbRGBIYP>; Mon, 2 Jul 2001 04:24:15 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:28172 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S266405AbRGBIYD>; Mon, 2 Jul 2001 04:24:03 -0400
Date: Mon, 2 Jul 2001 10:09:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, Jes Sorensen <jes@sunsite.dk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
Message-ID: <20010702100936.C600@suse.de>
In-Reply-To: <15163.43319.82354.562310@pizda.ninka.net> <Pine.LNX.4.33.0106281823000.32276-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106281823000.32276-100000@toomuch.toronto.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28 2001, Ben LaHaise wrote:
> On Thu, 28 Jun 2001, David S. Miller wrote:
> 
> > Please note that this is nonstandard and undocumented behavior.
> >
> > This is not a supported API at all, and the way 64-bit DMA will
> > eventually be done across all platforms is likely to be different.
> 
> Well, what is the standard API to use?  All these 64 bit cards in my
> machine really make that 95% cpu usage in bounce buffer copying rather
> depressing.

The current sg list and single mapping functions are useless on 64-bit
(and highmem) anyway. I've used struct sg_list as a scatterlist
replacement for some time that holds a page/offset/length thing instead,
and also used pci_map_page for single mappings.

Using a virtual address for this stuff seems a bit short-sighted to
me...

-- 
Jens Axboe
