Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129587AbRBFSBS>; Tue, 6 Feb 2001 13:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129715AbRBFSBH>; Tue, 6 Feb 2001 13:01:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49680 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129587AbRBFSBC>;
	Tue, 6 Feb 2001 13:01:02 -0500
Date: Tue, 6 Feb 2001 19:00:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206190018.E580@suse.de>
In-Reply-To: <20010206170506.H1167@redhat.com> <Pine.LNX.4.30.0102061225330.15204-100000@today.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0102061225330.15204-100000@today.toronto.redhat.com>; from bcrl@redhat.com on Tue, Feb 06, 2001 at 12:37:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Ben LaHaise wrote:
> > The whole point of the post was that it is merging, not splitting,
> > which is troublesome.  How are you going to merge requests without
> > having chains of scatter-gather entities each with their own
> > completion callbacks?
> 
> Let me just emphasize what Stephen is pointing out: if requests are
> properly merged at higher layers, then merging is neither required nor
> desired.  Traditionally, ext2 has not done merging because the underlying
> system doesn't support it.  This leads to rather convoluted code for
> readahead which doesn't result in appropriately merged requests on
> indirect block boundries, and in fact leads to suboptimal performance.
> The only case I see where merging of requests can improve things is when
> dealing with lots of small files.  But we already know that small files
> need to be treated differently (fe tail merging).  Besides, most of the
> benefit of merging can be had by doing readaround for these small files.

Stephen already covered this point, the merging is not a problem
to deal with for read-ahead. The underlying system can easily
queue that in nice big chunks. Delayed allocation makes it
easier to to flush big chunks as well. I seem to recall the xfs people
having problems with the lack of merging causing a performance hit
on smaller I/O.

Of course merging doesn't have to happen in ll_rw_blk.

> As for io completion, can't we just issue seperate requests for the
> critical data and the readahead?  That way for SCSI disks, the important
> io should be finished while the readahead can continue.  Thoughts?

Priorities?

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
