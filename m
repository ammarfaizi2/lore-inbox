Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129569AbRBFVXV>; Tue, 6 Feb 2001 16:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRBFVXL>; Tue, 6 Feb 2001 16:23:11 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:20807 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129569AbRBFVWz>;
	Tue, 6 Feb 2001 16:22:55 -0500
Message-Id: <200102062120.f16LKsP03554@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: mingo@elte.hu
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Christoph Hellwig <hch@ns.caldera.de>,
        Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait 
In-Reply-To: Message from Ingo Molnar <mingo@elte.hu> 
   of "Tue, 06 Feb 2001 21:59:01 +0100." <Pine.LNX.4.30.0102062154400.10582-100000@elte.hu> 
Date: Tue, 06 Feb 2001 15:20:54 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 6 Feb 2001, Marcelo Tosatti wrote:
> 
> > Think about a given number of pages which are physically contiguous on
> > disk -- you dont need to cache the block number for each page, you
> > just need to cache the physical block number of the first page of the
> > "cluster".
> 
> ranges are a hell of a lot more trouble to get right than page or
> block-sized objects - and typical access patterns are rarely 'ranged'. As
> long as the basic unit is not 'too small' (ie. not 512 byte, but something
> more sane, like 4096 bytes), i dont think ranging done in higher levels
> buys us anything valuable. And we do ranging at the request layer already
> ... Guess why most CPUs ended up having pages, and not "memory ranges"?
> It's simpler, thus faster in the common case and easier to debug.
> 
> > Usually we need to cache only block information (for clustering), and
> > not all the other stuff which buffer_head holds.
> 
> well, the other issue is that buffer_heads hold buffer-cache details as
> well. But i think it's too small right now to justify any splitup - and
> those issues are related enough to have significant allocation-merging
> effects.
> 
> 	Ingo

Think about it from the point of view of being able to reduce the number of
times you need to talk to the allocator in a filesystem. You can talk to
the allocator about all of your readahead pages in one go, or you can do
things like allocate on flush rather than allocating page at a time (that is
a bit more complex, but not too much).

Having to talk to the allocator on a page by page basis is my pet peeve about
the current mechanisms.

Steve



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
