Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130492AbRBARve>; Thu, 1 Feb 2001 12:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130534AbRBARvY>; Thu, 1 Feb 2001 12:51:24 -0500
Received: from ns.caldera.de ([212.34.180.1]:52486 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130492AbRBARus>;
	Thu, 1 Feb 2001 12:50:48 -0500
Date: Thu, 1 Feb 2001 18:49:50 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@caldera.de>, "Stephen C. Tweedie" <sct@redhat.com>,
        Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201184950.A448@caldera.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Stephen C. Tweedie" <sct@redhat.com>, Steve Lord <lord@sgi.com>,
	linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010201180237.A28007@caldera.de> <E14ONdD-0004gz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E14ONdD-0004gz-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 01, 2001 at 05:34:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 05:34:49PM +0000, Alan Cox wrote:
> > > I'm in the middle of some parts of it, and am actively soliciting
> > > feedback on what cleanups are required.  
> > 
> > The real issue is that Linus dislikes the current kiobuf scheme.
> > I do not like everything he proposes, but lots of things makes sense.
> 
> Linus basically designed the original kiobuf scheme of course so I guess
> he's allowed to dislike it. Linus disliking something however doesn't mean
> its wrong. Its not a technically valid basis for argument.

Sure.  But Linus saing that he doesn't want more of that (shit, crap,
I don't rember what he said exactly) in the kernel is a very good reason
for thinking a little more aboyt it.

Espescially if most arguments look right to one after thinking more about
it...

> Linus list of reasons like the amount of state are more interesting

True.  The arument that they are to heaviweight also.
That they should allow scatter gather without an array of structs also.


> > > So, what are the benefits in the disk IO stack of adding length/offset
> > > pairs to each page of the kiobuf?
> > 
> > I don't see any real advantage for disk IO.  The real advantage is that
> > we can have a generic structure that is also usefull in e.g. networking
> > and can lead to a unified IO buffering scheme (a little like IO-Lite).
> 
> Networking wants something lighter rather than heavier.

Right.  That's what the new design was about, besides adding a offset and
length to every page instead of the page array, something also wanted by
the networking in the first place.
Look at the skb_frag struct in the zero-copy patch for what networking
thinks it needs for physical page based buffers.

> Adding tons of base/limit pairs to kiobufs makes it worse not better

>From looking at the networking code and listening to Dave and Ingo it looks
like it makes the thing better for networking, although I can not verify
this due to the lack of familarity with the networking code.

For disk I/O it makes the handling a little easier for the cost of the
additional offset/length fields.

	Christoph

P.S. the tuple things is also what Larry had in his inital slice paper.
-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
