Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBFUHu>; Tue, 6 Feb 2001 15:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129188AbRBFUHi>; Tue, 6 Feb 2001 15:07:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49681 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129111AbRBFUH1>;
	Tue, 6 Feb 2001 15:07:27 -0500
Date: Tue, 6 Feb 2001 21:07:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206210704.E2975@suse.de>
In-Reply-To: <Pine.LNX.4.30.0102061437250.15204-100000@today.toronto.redhat.com> <Pine.LNX.4.30.0102062052110.8926-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0102062052110.8926-100000@elte.hu>; from mingo@elte.hu on Tue, Feb 06, 2001 at 08:57:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Ingo Molnar wrote:
> > This small correction is the crux of the problem: if it blocks, it
> > takes away from the ability of the process to continue doing useful
> > work.  If it returns -EAGAIN, then that's okay, the io will be
> > resubmitted later when other disk io has completed.  But, it should be
> > possible to continue servicing network requests or user io while disk
> > io is underway.
> 
> typical blocking point is waiting for page completion, not
> __wait_request(). But, this is really not an issue, NR_REQUESTS can be
> increased anytime. If NR_REQUESTS is large enough then think of it as the
> 'absolute upper limit of doing IO', and think of the blocking as 'the
> kernel pulling the brakes'.

Not just __get_request_wait, but also the limit on max locked buffers
in ll_rw_block. Serves the same purpose though, brake effect.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
