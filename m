Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTA0TQj>; Mon, 27 Jan 2003 14:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTA0TQj>; Mon, 27 Jan 2003 14:16:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64748 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267070AbTA0TQh>;
	Mon, 27 Jan 2003 14:16:37 -0500
Date: Mon, 27 Jan 2003 20:25:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ross Biro <rossb@google.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030127192528.GF889@suse.de>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz> <3E356403.9010805@google.com> <1043694192.2756.55.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043694192.2756.55.camel@zion.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27 2003, Benjamin Herrenschmidt wrote:
> On Mon, 2003-01-27 at 17:53, Ross Biro wrote:
> > This looks like the same problem I ran into with IDE and highmem not 
> > getting along.  Try compiling your kernel with out highmem enabled and 
> > see what happenes.
> 
> Indeed, looking at the code, it seems ide_build_sglist() doesn't worry
> much about highmem, just picks bh->b_data, assume it's a virtual
> address, and gives that to pci_map_sg(). I beleive, at least for highmem
> pages, it should rather pick bh->b_page and bh_offset(bh)

Exactly, just take a look at 2.4.20.

> I can hack something, maybe tonight, but I can't test HIGHMEM for a while
> here. Interestingly, I had no problem report on PPC from users using IDE
> with highmem though.

Then noone is using highmem on ppc with 2.4.21-pre yet, it will
definitely barf on the very first highmem bh->b_page

-- 
Jens Axboe

