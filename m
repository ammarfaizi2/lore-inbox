Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270705AbRH1Kw0>; Tue, 28 Aug 2001 06:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270724AbRH1KwQ>; Tue, 28 Aug 2001 06:52:16 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:26805 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S270705AbRH1KwC>; Tue, 28 Aug 2001 06:52:02 -0400
Date: Tue, 28 Aug 2001 11:53:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: patch-2.4.10-pre1
In-Reply-To: <Pine.LNX.4.21.0108280257030.7746-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0108281150240.1008-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, Marcelo Tosatti wrote:
> On 28 Aug 2001, Andi Kleen wrote:
> > Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> > 
> > > --- linux.orig/fs/buffer.c	Mon Aug 27 20:46:36 2001
> > > +++ linux/fs/buffer.c	Mon Aug 27 21:43:35 2001
> > > @@ -2448,6 +2448,10 @@
> > >  	write_unlock(&hash_table_lock);
> > >  	spin_unlock(&lru_list_lock);
> > >  	if (gfp_mask & __GFP_IO) {
> > > +#ifdef CONFIG_HIGHMEM
> > > +		if (!(gfp_mask & __GFP_HIGHIO) & PageHighMem(page))
> >                                               ^^
> > Should clearly be &&
> > Could be a problem if PageHighMem returns something other than 1 for true.
> 
> Right. 
> 
> Linus, please fix that on your tree. 

It would also look nicer without the #ifdef CONFIG_HIGHMEM and #endif:
remember that mm.h defines PageHighMem(page) as 0 ifndef CONFIG_HIGHMEM,
so (I hope) it would all get optimized away in that case.

Hugh

