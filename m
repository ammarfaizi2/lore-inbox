Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbRGTS6o>; Fri, 20 Jul 2001 14:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267223AbRGTS6e>; Fri, 20 Jul 2001 14:58:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22537 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267221AbRGTS6V>;
	Fri, 20 Jul 2001 14:58:21 -0400
Date: Fri, 20 Jul 2001 20:57:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, linux-scsi@vger.kernel.org,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
Message-ID: <20010720205746.B3692@suse.de>
In-Reply-To: <20010720102614.A13354@suse.de> <Pine.LNX.4.31.0107200937310.1547-100000@p4.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0107200937310.1547-100000@p4.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 20 2001, Linus Torvalds wrote:
> 
> 
> On Fri, 20 Jul 2001, Jens Axboe wrote:
> >
> > > The paging stuff doesn't use any of this. The paging stuff use the page
> > > cache lock bit, and always has.
> >
> > Paging still hits a request, I assumed that's what the (really really)
> > old comment meant to say.
> 
> No. Tha paging stuff (and _all_ regular IO) uses a regular request, with a
> NULL waiter. That's the normal path. That normal path depends on the
> buffer heads associated with the requests and their "bh->b_end_io()"
> function marking other state up-to-date, and then waits on the page being
> locked.

This is perfectly clear. I'm saying 'paging uses a request just like any
other I/O', and you seem to disagree and restate the same thing?! In
fact the lower layers have no way of knowing what is what, paging or
not.

> The req->sem (and now req->completion) thing is a very different thing: it
> is a "we are waiting for this particular request", and is used when it's
> not really IO and doesn't have a bh, but something that has side effects.
> Like an ioctl that causes a special command to the disk to change some
> parameters, or query the size of the disk or something.

Ditto! Are you reading what I write?

> So the comment has just always been wrong, I think. It may be that the
> original swapping code was doing raw requests instead of real IO, so maybe
> the comment was actually correct back in 1992 or something. My memory
> isn't good enough..

Good, so now you agree that the corrected comment (as per pre9) is crap,
and the patch I sent that changes the wording to:

"Ok, this is an expanded form so that we can use the same
request for paging requests."

is so much better than _you_ mixing ->waiting and ->sem into this paging
or non-paging pool?

But in fact the whole comment block should just be removed. It gives no
useful or additional information.

-- 
Jens Axboe

