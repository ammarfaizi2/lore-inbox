Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129772AbRBFSKh>; Tue, 6 Feb 2001 13:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129841AbRBFSK1>; Tue, 6 Feb 2001 13:10:27 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:59482 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129840AbRBFSKZ>; Tue, 6 Feb 2001 13:10:25 -0500
Date: Tue, 6 Feb 2001 13:09:09 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Jens Axboe <axboe@suse.de>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010206190018.E580@suse.de>
Message-ID: <Pine.LNX.4.30.0102061301310.15204-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Jens Axboe wrote:

> Stephen already covered this point, the merging is not a problem
> to deal with for read-ahead. The underlying system can easily

I just wanted to make sure that was clear =)

> queue that in nice big chunks. Delayed allocation makes it
> easier to to flush big chunks as well. I seem to recall the xfs people
> having problems with the lack of merging causing a performance hit
> on smaller I/O.

That's where readaround buffers come into play.  If we have a fixed number
of readaround buffers that are used when small ios are issued, they should
provide a low overhead means of substantially improving things like find
(which reads many nearby inodes out of order but sequentially).  I need to
implement this can get cache hit rates for various workloads. ;-)

> Of course merging doesn't have to happen in ll_rw_blk.
>
> > As for io completion, can't we just issue seperate requests for the
> > critical data and the readahead?  That way for SCSI disks, the important
> > io should be finished while the readahead can continue.  Thoughts?
>
> Priorities?

Definately.  I'd like to be able to issue readaheads with a "don't bother
executing if this request unless the cost is low" bit set.  It might also
be helpful for heavy multiuser loads (or even a single user with multiple
processes) to ensure progress is made for others.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
