Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbRBEPHk>; Mon, 5 Feb 2001 10:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130529AbRBEPHa>; Mon, 5 Feb 2001 10:07:30 -0500
Received: from zeus.kernel.org ([209.10.41.242]:58824 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129775AbRBEPHP>;
	Mon, 5 Feb 2001 10:07:15 -0500
Date: Mon, 5 Feb 2001 15:03:54 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205150354.E1167@redhat.com>
In-Reply-To: <20010201220744.K11607@redhat.com> <Pine.LNX.4.10.10102031224210.8867-100000@penguin.transmeta.com> <20010205110336.A1167@redhat.com> <3A7E95F3.38B26DC@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A7E95F3.38B26DC@colorfullife.com>; from manfred@colorfullife.com on Mon, Feb 05, 2001 at 01:00:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 05, 2001 at 01:00:51PM +0100, Manfred Spraul wrote:
> "Stephen C. Tweedie" wrote:
> > 
> > You simply cannot do physical disk IO on
> > non-sector-aligned memory or in chunks which aren't a multiple of
> > sector size.
> 
> Why not?
> 
> Obviously the disk access itself must be sector aligned and the total
> length must be a multiple of the sector length, but there shouldn't be
> any restrictions on the data buffers.

But there are.  Many controllers just break down and corrupt things
silently if you don't align the data buffers (Jeff Merkey found this
by accident when he started generating unaligned IOs within page
boundaries in his NWFS code).  And a lot of controllers simply cannot
break a sector dma over a page boundary (at least not without some
form of IOMMU remapping).

Yes, it's the sort of thing that you would hope should work, but in
practice it's not reliable.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
