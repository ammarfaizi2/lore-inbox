Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBFRPl>; Tue, 6 Feb 2001 12:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRBFRPc>; Tue, 6 Feb 2001 12:15:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30224 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129156AbRBFRPX>;
	Tue, 6 Feb 2001 12:15:23 -0500
Date: Tue, 6 Feb 2001 18:14:49 +0100
From: Jens Axboe <axboe@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206181449.C580@suse.de>
In-Reply-To: <E14Pr8G-0003zV-00@the-village.bc.nu> <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com> <20010205205429.V1167@redhat.com> <20010206000704.F1167@redhat.com> <20010206180058.A15974@caldera.de> <20010206170506.H1167@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010206170506.H1167@redhat.com>; from sct@redhat.com on Tue, Feb 06, 2001 at 05:05:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Stephen C. Tweedie wrote:
> > I don't think os.  If we minimize the state in the IO container object,
> > the lower levels could split them at their guess and the IO completion
> > function just has to handle the case that it might be called for a smaller
> > object.
> 
> The whole point of the post was that it is merging, not splitting,
> which is troublesome.  How are you going to merge requests without
> having chains of scatter-gather entities each with their own
> completion callbacks?

You can't, the stuff I played with turned out to be horrible. At
least with the current kiobuf I/O stuff, merging will have to be
done before its submitted. And IMO we don't want to loose the
ability to cluster buffers and requests in ll_rw_blk.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
