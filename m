Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129373AbRBGSrd>; Wed, 7 Feb 2001 13:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRBGSrX>; Wed, 7 Feb 2001 13:47:23 -0500
Received: from ns.caldera.de ([212.34.180.1]:20746 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129373AbRBGSrL>;
	Wed, 7 Feb 2001 13:47:11 -0500
Date: Wed, 7 Feb 2001 19:44:39 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207194439.A25947@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Steve Lord <lord@sgi.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	kiobuf-io-devel@lists.sourceforge.net,
	Ingo Molnar <mingo@redhat.com>
In-Reply-To: <20010207192622.A23859@caldera.de> <Pine.LNX.4.10.10102071032390.4623-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10102071032390.4623-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Feb 07, 2001 at 10:36:47AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 10:36:47AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 7 Feb 2001, Christoph Hellwig wrote:
> 
> > On Tue, Feb 06, 2001 at 12:59:02PM -0800, Linus Torvalds wrote:
> > > 
> > > Actually, they really aren't.
> > > 
> > > They kind of _used_ to be, but more and more they've moved away from that
> > > historical use. Check in particular the page cache, and as a really
> > > extreme case the swap cache version of the page cache.
> > 
> > Yes.  And that exactly why I think it's ugly to have the left-over
> > caching stuff in the same data sctruture as the IO buffer.
> 
> I do agree.
> 
> I would not be opposed to factoring out the "pure block IO" part from the
> bh struct. It should not even be very hard. You'd do something like
> 
> 	struct block_io {
> 		.. here is the stuff needed for block IO ..
> 	};
> 
> 	struct buffer_head {
> 		struct block_io io;
> 		.. here is the stuff needed for hashing etc ..
> 	}
> 
> and then you make "generic_make_request()" and everything lower down take
> just the "struct block_io".

Yep. (besides the name block_io sucks :))

> You'd still leave "ll_rw_block()" and "submit_bh()" operating on bh's,
> because they knoa about bh semantics (ie things like scaling the sector
> number to the bh size etc). Which means that pretty much all the code
> outside the block layer wouldn't even _notice_. Which is a sign of good
> layering.

Yep.

> If you want to do this, please do go ahead.

I'll take a look at it.

> But do realize that this is not exactly a 2.4.x thing ;)

Sure.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
