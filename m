Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129840AbRBFTp1>; Tue, 6 Feb 2001 14:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130047AbRBFTpI>; Tue, 6 Feb 2001 14:45:08 -0500
Received: from chiara.elte.hu ([157.181.150.200]:34058 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129840AbRBFTpA>;
	Tue, 6 Feb 2001 14:45:00 -0500
Date: Tue, 6 Feb 2001 20:44:22 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben LaHaise <bcrl@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102061121530.1474-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0102062034570.8481-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Linus Torvalds wrote:

> (Small correction: it doesn't block on anything else than allocating a
> request structure if needed, and quite frankly, you have to block
> SOMETIME. You can't just try to throw stuff at the device faster than
> it can take it. Think of it as a "there can only be this many IO's in
> flight")

yep. The/my goal would be to get some sort of async IO capability that is
able to read the pagecache without holding up the process. And just
because i've already implemented the helper-kernel-thread async IO variant
[in fact what TUX does is that there are per-CPU async IO helper threads,
and we always pick the 'localized' thread, to avoid unnecessery cross-CPU
traffic], i'd like to explore the possibility of getting this done via a
pure, IRQ-driven state-machine - which arguably has the lowest overhead.

but i just cannot find any robust way to do this with ext2fs (or any other
disk-based FS for that matter). The horror scenario: the inode block is
not cached yet, and the block resides in a triple-indirected block which
triggers 3 other block reads, before the actual data block can be read.
And i definitely do not see why kiobufs would help make this any easier.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
