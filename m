Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130112AbRBFTdg>; Tue, 6 Feb 2001 14:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129840AbRBFTd0>; Tue, 6 Feb 2001 14:33:26 -0500
Received: from chiara.elte.hu ([157.181.150.200]:31498 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130112AbRBFTdP>;
	Tue, 6 Feb 2001 14:33:15 -0500
Date: Tue, 6 Feb 2001 20:32:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061402200.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.30.0102062024040.8157-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Ben LaHaise wrote:

> > > 	- make asynchronous io possible in the block layer.  This is
> > > 	  impossible with the current ll_rw_block scheme and io request
> > > 	  plugging.
> >
> > why is it impossible?
>
> s/impossible/unpleasant/. ll_rw_blk blocks; it should be possible to
> have a non blocking variant that does all of the setup in the caller's
> context. [...]

sorry, but exactly what code are you comparing this to? The aio code you
sent a few days ago does not do this either. (And you did not answer my
questions regarding this issue.) What i saw is some scheme that at a point
relies on keventd (a kernel thread) to do the blocking stuff. [or, unless
i have misread the code, does the ->bmap() synchronously.]

indeed an asynchron ll_rw_block() is possible and desirable (and not hard
at all - all structures are interrupt-safe already, opposed to the kiovec
code), but this is only half of the story. What is the big issue for me is
an async ->bmap(). And we wont access ext2fs data structures from IRQ
handlers anytime soon - so true async IO right now is damn near
impossible. No matter what the IO-submission interface is: kiobufs/kiovecs
or bhs/requests.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
