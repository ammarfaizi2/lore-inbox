Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBHOAv>; Thu, 8 Feb 2001 09:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130380AbRBHOAl>; Thu, 8 Feb 2001 09:00:41 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:53991 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129098AbRBHOAd>; Thu, 8 Feb 2001 09:00:33 -0500
Date: Thu, 8 Feb 2001 08:57:33 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: select() returning busy for regular files [was Re: [Kiobuf-io-devel]
 RFC: Kernel mechanism: Compound event wait]
In-Reply-To: <20010208001735.C189@bug.ucw.cz>
Message-ID: <Pine.LNX.4.30.0102080851410.23469-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Pavel Machek wrote:

> Hi!
>
> > > Its arguing against making a smart application block on the disk while its
> > > able to use the CPU for other work.
> >
> > There are currently no other alternatives in user space. You'd have to
> > create whole new interfaces for aio_read/write, and ways for the kernel to
> > inform user space that "now you can re-try submitting your IO".
>
> Why is current select() interface not good enough?

Think of random disk io scattered across the disk.  Think about aio_write
providing a means to perform zero copy io without needing to resort to
playing mm tricks write protecting pages in the user's page tables.  It's
also a means for dealing efficiently with thousands of outstanding
requests for network io.  Using a select based interface is going to be an
ugly kludge that still has all the overhead of select/poll.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
