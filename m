Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129582AbRBFU4N>; Tue, 6 Feb 2001 15:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130429AbRBFU4D>; Tue, 6 Feb 2001 15:56:03 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:35598 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129582AbRBFUzn>; Tue, 6 Feb 2001 15:55:43 -0500
Date: Tue, 6 Feb 2001 17:05:31 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
cc: Christoph Hellwig <hch@ns.caldera.de>,
        Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102062132250.10016-100000@elte.hu>
Message-ID: <Pine.LNX.4.21.0102061657060.23526-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Ingo Molnar wrote:

> 
> On Tue, 6 Feb 2001, Christoph Hellwig wrote:
> 
> > The second is that bh's are two things:
> >
> >  - a cacheing object
> >  - an io buffer
> >
> > This is not really an clean appropeach, and I would really like to get
> > away from it.
> 
> caching bmap() blocks was a recent addition around 2.3.20, and i suggested
> some time ago to cache pagecache blocks via explicit entries in struct
> page. That would be one solution - but it creates overhead.

Think about a given number of pages which are physically contiguous on
disk -- you dont need to cache the block number for each page, you just
need to cache the physical block number of the first page of the
"cluster".

SGI's pagebuf do that, and it would be great if we had something similar
in 2.5. 

It allows us to have fast IO clustering. 

> but there isnt anything wrong with having the bhs around to cache blocks -
> think of it as a 'cached and recycled IO buffer entry, with the block
> information cached'.

Usually we need to cache only block information (for clustering), and not
all the other stuff which buffer_head holds.

> frankly, my quick (and limited) hack to abuse bhs to cache blocks just
> cannot be a reason to replace bhs ...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
