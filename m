Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbUK1T3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbUK1T3x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 14:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUK1T3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 14:29:53 -0500
Received: from mail.dif.dk ([193.138.115.101]:10406 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261574AbUK1T3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 14:29:49 -0500
Date: Sun, 28 Nov 2004 20:39:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gadi Oxman <gadio@netvision.net.il>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2/2] ide-tape: small cleanups - handle copy_to|from_user()
 failures
In-Reply-To: <1101663266.16761.43.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0411282028200.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost>
 <1101663266.16761.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Nov 2004, Alan Cox wrote:

> On Sul, 2004-11-28 at 16:32, Jesper Juhl wrote:
> >  #endif /* IDETAPE_DEBUG_BUGS */
> >  		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
> > -		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
> > +		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count))
> > +			return -EFAULT;
> >  		n -= count;
> >  		atomic_add(count, &bh->b_count);
> >  		buf += count;
> 
> If you do this then you don't fix up tape->bh for further operations.

True, if copy_from_user fails it just bails out, I didn't see anything 
really bad that could happen from that, but I'm an idiot, looking at it 
again I guess it could probably mess up tape->bh pretty bad.
Guess I need to go back and look at this in greater detail.
Thank you for looking at it.

> Have you tested these changes including the I/O errors ?
> 
As I noted in the [0/2] mail I don't have hardware to test these patches, 
so they need to be reviewed.


--
Jesper Juhl


