Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbTA0Tf4>; Mon, 27 Jan 2003 14:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTA0Tf4>; Mon, 27 Jan 2003 14:35:56 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:23839 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267141AbTA0Tfz>; Mon, 27 Jan 2003 14:35:55 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301271945.h0RJj7B26739@devserv.devel.redhat.com>
Subject: Re: 2.4.21-pre3 kernel crash
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 27 Jan 2003 14:45:07 -0500 (EST)
Cc: rossb@google.com (Ross Biro), linux-kernel@vger.kernel.org,
       alan@redhat.com
In-Reply-To: <1043694192.2756.55.camel@zion.wanadoo.fr> from "Benjamin Herrenschmidt" at Jan 27, 2003 08:03:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2003-01-27 at 17:53, Ross Biro wrote:
> > This looks like the same problem I ran into with IDE and highmem not 
> > getting along.  Try compiling your kernel with out highmem enabled and 
> > see what happenes.
> 
> Indeed, looking at the code, it seems ide_build_sglist() doesn't worry
> much about highmem, just picks bh->b_data, assume it's a virtual
> address, and gives that to pci_map_sg(). I beleive, at least for highmem
> pages, it should rather pick bh->b_page and bh_offset(bh)
> 
> I can hack something, maybe tonight, but I can't test HIGHMEM for a while
> here. Interestingly, I had no problem report on PPC from users using IDE
> with highmem though.

I don't see how 2.4 IDE would be getting highmem pages. 2.5 IDE does handle
this and does need to

