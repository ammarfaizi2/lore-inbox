Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129955AbRBFSah>; Tue, 6 Feb 2001 13:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130025AbRBFSaS>; Tue, 6 Feb 2001 13:30:18 -0500
Received: from zeus.kernel.org ([209.10.41.242]:35039 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129955AbRBFSaJ>;
	Tue, 6 Feb 2001 13:30:09 -0500
Date: Tue, 6 Feb 2001 18:26:03 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206182603.J1167@redhat.com>
In-Reply-To: <E14Pr8G-0003zV-00@the-village.bc.nu> <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com> <20010205205429.V1167@redhat.com> <20010206000704.F1167@redhat.com> <20010206180058.A15974@caldera.de> <20010206170506.H1167@redhat.com> <20010206182258.A17923@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010206182258.A17923@caldera.de>; from hch@ns.caldera.de on Tue, Feb 06, 2001 at 06:22:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 06:22:58PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 06, 2001 at 05:05:06PM +0000, Stephen C. Tweedie wrote:
> > The whole point of the post was that it is merging, not splitting,
> > which is troublesome.  How are you going to merge requests without
> > having chains of scatter-gather entities each with their own
> > completion callbacks?
> 
> The object passed down to the low-level driver just needs to ne able
> to contain multiple end-io callbacks.  The decision what to call when
> some of the scatter-gather entities fail is of course not so easy to
> handle and needs further discussion.

Umm, and if you want the separate higher-level IOs to be told which
IOs succeeded and which ones failed on error, you need to associate
each of the multiple completion callbacks with its particular
scatter-gather fragment or fragments.  So you end up with the same
sort of kiobuf/kiovec concept where you have chains of sg chunks, each
chunk with its own completion information.

This is *precisely* what I've been trying to get people to address.
Forget whether the individual sg fragments are based on pages or not:
if you want to have IO merging and accurate completion callbacks, you
need not just one sg list but multiple lists each with a separate
callback header.

Abandon the merging of sg-list requests (by moving that functionality
into the higher-level layers) and that problem disappears: flat
sg-lists will then work quite happily at the request layer.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
