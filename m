Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbTA0TkR>; Mon, 27 Jan 2003 14:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTA0TkR>; Mon, 27 Jan 2003 14:40:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51584 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267209AbTA0TkQ>;
	Mon, 27 Jan 2003 14:40:16 -0500
Date: Mon, 27 Jan 2003 20:49:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ross Biro <rossb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030127194912.GI889@suse.de>
References: <1043694192.2756.55.camel@zion.wanadoo.fr> <200301271945.h0RJj7B26739@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301271945.h0RJj7B26739@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27 2003, Alan Cox wrote:
> > On Mon, 2003-01-27 at 17:53, Ross Biro wrote:
> > > This looks like the same problem I ran into with IDE and highmem not 
> > > getting along.  Try compiling your kernel with out highmem enabled and 
> > > see what happenes.
> > 
> > Indeed, looking at the code, it seems ide_build_sglist() doesn't worry
> > much about highmem, just picks bh->b_data, assume it's a virtual
> > address, and gives that to pci_map_sg(). I beleive, at least for highmem
> > pages, it should rather pick bh->b_page and bh_offset(bh)
> > 
> > I can hack something, maybe tonight, but I can't test HIGHMEM for a while
> > here. Interestingly, I had no problem report on PPC from users using IDE
> > with highmem though.
> 
> I don't see how 2.4 IDE would be getting highmem pages. 2.5 IDE does handle
> this and does need to

?

The block-highmem patch is in the 2.4 kernels since 2.4.20-pre2/3 (I
forget which). __ide_dma_on() calls ide_toggle_bounce() which turns on
full 32-bit dma for that drive, if it's a disk. So IDE will be getting
highmem pages for io if you have them.

-- 
Jens Axboe

