Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAIRdo>; Tue, 9 Jan 2001 12:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAIRde>; Tue, 9 Jan 2001 12:33:34 -0500
Received: from kanga.kvack.org ([216.129.200.3]:55562 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129534AbRAIRdS>;
	Tue, 9 Jan 2001 12:33:18 -0500
Date: Tue, 9 Jan 2001 12:30:39 -0500 (EST)
From: "Benjamin C.R. LaHaise" <blah@kvack.org>
To: Ingo Molnar <mingo@elte.hu>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101091720030.4491-100000@e2>
Message-ID: <Pine.LNX.3.96.1010109114407.5051E-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Ingo Molnar wrote:

> this is why i ment that *right now* kiobufs are not suited for networking,
> at least the way we do it. Maybe if kiobufs had the same kind of internal
> structure as sk_frag (ie. array of (page,offset,size) triples, not array
> of pages), that would work out better.

That I can agree with, and it would make my life easier since I really
only care about the completion of an entire io, not the individual
fragments of it.

> Please take a look at next release of TUX. Probably the last missing piece
> was that i added O_NONBLOCK to generic_file_read() && sendfile(), so not
> fully cached requests can be offloaded to IO threads.
> 
> Otherwise the current lowlevel filesystem infrastructure is not suited for
> implementing "process-less async IO "- and kiovecs wont be able to help
> that either. Unless we implement async, IRQ-driven bmap(), we'll always
> need some sort of process context to set up IO.

I've already got fully async read and write working via a helper thread
for doing the bmaps when the page is not uptodate in the page cache.  The
primatives for async locking of pages and waiting on events such that
converting ext2 to performing full async bmap should be trivial.  Note
that O_NONBLOCK is not good enough because you can't implement an
asynchronous O_SYNC write with it.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
