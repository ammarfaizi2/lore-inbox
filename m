Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRBFVAD>; Tue, 6 Feb 2001 16:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129637AbRBFU7y>; Tue, 6 Feb 2001 15:59:54 -0500
Received: from chiara.elte.hu ([157.181.150.200]:49162 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129364AbRBFU7k>;
	Tue, 6 Feb 2001 15:59:40 -0500
Date: Tue, 6 Feb 2001 21:59:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Christoph Hellwig <hch@ns.caldera.de>,
        Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.21.0102061657060.23526-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0102062154400.10582-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Marcelo Tosatti wrote:

> Think about a given number of pages which are physically contiguous on
> disk -- you dont need to cache the block number for each page, you
> just need to cache the physical block number of the first page of the
> "cluster".

ranges are a hell of a lot more trouble to get right than page or
block-sized objects - and typical access patterns are rarely 'ranged'. As
long as the basic unit is not 'too small' (ie. not 512 byte, but something
more sane, like 4096 bytes), i dont think ranging done in higher levels
buys us anything valuable. And we do ranging at the request layer already
... Guess why most CPUs ended up having pages, and not "memory ranges"?
It's simpler, thus faster in the common case and easier to debug.

> Usually we need to cache only block information (for clustering), and
> not all the other stuff which buffer_head holds.

well, the other issue is that buffer_heads hold buffer-cache details as
well. But i think it's too small right now to justify any splitup - and
those issues are related enough to have significant allocation-merging
effects.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
