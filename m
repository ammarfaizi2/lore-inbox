Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbRBGS3X>; Wed, 7 Feb 2001 13:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129877AbRBGS3N>; Wed, 7 Feb 2001 13:29:13 -0500
Received: from ns.caldera.de ([212.34.180.1]:8714 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129831AbRBGS3D>;
	Wed, 7 Feb 2001 13:29:03 -0500
Date: Wed, 7 Feb 2001 19:26:22 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207192622.A23859@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Steve Lord <lord@sgi.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	kiobuf-io-devel@lists.sourceforge.net,
	Ingo Molnar <mingo@redhat.com>
In-Reply-To: <20010206212503.A5426@caldera.de> <Pine.LNX.4.10.10102061235590.1474-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10102061235590.1474-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 12:59:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 12:59:02PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 6 Feb 2001, Christoph Hellwig wrote:
> > 
> > The second is that bh's are two things:
> > 
> >  - a cacheing object
> >  - an io buffer
> 
> Actually, they really aren't.
> 
> They kind of _used_ to be, but more and more they've moved away from that
> historical use. Check in particular the page cache, and as a really
> extreme case the swap cache version of the page cache.

Yes.  And that exactly why I think it's ugly to have the left-over
caching stuff in the same data sctruture as the IO buffer.

> It certainly _used_ to be true that "bh"s were actually first-class memory
> management citizens, and actually had a data buffer and a cache associated
> with them. And because of that historical baggage, that's how many people
> still think of them.

I do even know that the pagecache is our primary cache now :)
Anyway having that caching cruft still in is ugly.

> > This is not really an clean appropeach, and I would really like to
> > get away from it.
> 
> Trust me, you really _can_ get away from it. It's not designed into the
> bh's at all. You can already just allocate a single (or multiple) "struct
> buffer_head" and just use them as IO objects, and give them your _own_
> pointers to the IO buffer etc.

So true.  Exactly because of that the data structures should become
seperated also.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
