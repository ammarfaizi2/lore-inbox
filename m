Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRBESv2>; Mon, 5 Feb 2001 13:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130020AbRBESvT>; Mon, 5 Feb 2001 13:51:19 -0500
Received: from zeus.kernel.org ([209.10.41.242]:4562 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129792AbRBESvL>;
	Mon, 5 Feb 2001 13:51:11 -0500
Date: Mon, 5 Feb 2001 18:49:11 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205184911.A2116@redhat.com>
In-Reply-To: <20010205172042.O1167@redhat.com> <E14PpSY-0003lL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14PpSY-0003lL-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 05, 2001 at 05:29:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 05, 2001 at 05:29:47PM +0000, Alan Cox wrote:
> > 
> > _All_ drivers would have to do that in the degenerate case, because
> > none of our drivers can deal with a dma boundary in the middle of a
> > sector, and even in those places where the hardware supports it in
> > theory, you are still often limited to word-alignment.
> 
> Thats true for _block_ disk devices but if we want a generic kiovec then
> if I am going from video capture to network I dont need to force anything more
> than 4 byte align

Kiobufs have never, ever required the IO to be aligned on any
particular boundary.  They simply make the assumption that the
underlying buffered object can be described in terms of pages with
some arbitrary (non-aligned) start/offset.  Every video framebuffer
I've ever seen satisfies that, so you can easily map an arbitrary
contiguous region of the framebuffer with a kiobuf already.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
