Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSAUJym>; Mon, 21 Jan 2002 04:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289091AbSAUJyd>; Mon, 21 Jan 2002 04:54:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62223
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289089AbSAUJyQ>; Mon, 21 Jan 2002 04:54:16 -0500
Date: Mon, 21 Jan 2002 01:48:10 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121100707.Q27835@suse.de>
Message-ID: <Pine.LNX.4.10.10201210130150.13727-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Jens Axboe wrote:

> On Mon, Jan 21 2002, Andre Hedrick wrote:
> > > This really sucks, it means we cannot safely use multi mode for a
> > > variety of request sizes. I agree with your earlier comment. Here's what
> > > I think we should be doing: when requesting multi mode, limit to 8
> > > sectors like in your patch. This is by far the most commen multiple,
> > > that's why. When starting a request, use WIN_MULT* only for cases where
> > > (rq->nr_sectors % drive->mult_count) == 0. If that doesn't hold, simply
> > > use WIN_READ or WIN_WRITE.
> > > 
> > > Applied the 2.5.3-pre2 sched SMP fix, booting -pre2 and then hacking up
> > > a patch.
> > 
> > Why I have already done it, just take and apply.
> 
> Cool, where is it?

Attached, and please do not pick and choose.

I moved and added things for a reason as not to loose hard work, because
of writing the ISR's to the purity of the spec, and then we modify ISR's 
to fit the kernel and not the other way around.  I do have a just  reason
to request a MEMPOOL, which would be exclusively used for PIO operations.
Then we get out of the mess we are in and get in to serious compliance to
how the hardware works.

Thus in the offline comments about the creation of an ata_request_struct,
a mempool allocation for PIO is justified.  Since the correct solution of
DMA timeouts is to void the request and assume no data down is valid.
Thus PIO is next.

If we look at the overhead in the generation of a new request for each and
every time we do a PIO transfer it is scary.  Think about this issue for
more than the time it takes to hit the delete key.

Respectfully,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

