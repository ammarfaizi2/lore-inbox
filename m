Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129142AbRBFRDh>; Tue, 6 Feb 2001 12:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbRBFRD1>; Tue, 6 Feb 2001 12:03:27 -0500
Received: from ns.caldera.de ([212.34.180.1]:49931 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129142AbRBFRDI>;
	Tue, 6 Feb 2001 12:03:08 -0500
Date: Tue, 6 Feb 2001 18:00:58 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206180058.A15974@caldera.de>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net,
	Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@redhat.com>
In-Reply-To: <E14Pr8G-0003zV-00@the-village.bc.nu> <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com> <20010205205429.V1167@redhat.com> <20010206000704.F1167@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010206000704.F1167@redhat.com>; from sct@redhat.com on Tue, Feb 06, 2001 at 12:07:04AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 12:07:04AM +0000, Stephen C. Tweedie wrote:
> This is the current situation.  If the page cache submits a 64K IO to
> the block layer, it does so in pieces, and then expects to be told on
> return exactly which pages succeeded and which failed.
> 
> That's where the mess of having multiple completion objects in a
> single IO request comes from.  Can we just forbid this case?
> 
> That's the short cut that SGI's kiobuf block dev patches do when they
> get kiobufs: they currently deal with either buffer_heads or kiobufs
> in struct requests, but they don't merge kiobuf requests.

IIRC Jens Axboe has done some work on merging kiobuf-based requests.

> (XFS already clusters the IOs for them in that case.)
> 
> Is that a realistic basis for a cleaned-up ll_rw_blk.c?

I don't think os.  If we minimize the state in the IO container object,
the lower levels could split them at their guess and the IO completion
function just has to handle the case that it might be called for a smaller
object.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
