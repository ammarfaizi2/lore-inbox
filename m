Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbUK1VG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUK1VG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 16:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbUK1VG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 16:06:58 -0500
Received: from mail.dif.dk ([193.138.115.101]:56749 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261586AbUK1VG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 16:06:56 -0500
Date: Sun, 28 Nov 2004 22:16:39 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gadi Oxman <gadio@netvision.net.il>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2/2] ide-tape: small cleanups - handle copy_to|from_user()
 failures
In-Reply-To: <Pine.LNX.4.61.0411282028200.3389@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0411282212340.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost>
 <1101663266.16761.43.camel@localhost.localdomain>
 <Pine.LNX.4.61.0411282028200.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Nov 2004, Jesper Juhl wrote:

> On Sun, 28 Nov 2004, Alan Cox wrote:
> 
> > On Sul, 2004-11-28 at 16:32, Jesper Juhl wrote:
> > >  #endif /* IDETAPE_DEBUG_BUGS */
> > >  		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
> > > -		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
> > > +		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count))
> > > +			return -EFAULT;
> > >  		n -= count;
> > >  		atomic_add(count, &bh->b_count);
> > >  		buf += count;
> > 
> > If you do this then you don't fix up tape->bh for further operations.
> 
> True, if copy_from_user fails it just bails out, I didn't see anything 
> really bad that could happen from that, but I'm an idiot, looking at it 
> again I guess it could probably mess up tape->bh pretty bad.
> Guess I need to go back and look at this in greater detail.

Does this really matter though?  if copy_from_user fails here the function 
bails out, and with the other changes I made the caller will bail out as 
well with the effect that the entire IO operation will fail. and once a 
new read or write is submitted we get a brand new tape->bh
Am I completely brain-dead or is it not in fact OK as I wrote it the first 
time?


-- 
Jesper Juhl

