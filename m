Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130741AbRBARDl>; Thu, 1 Feb 2001 12:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130772AbRBARDb>; Thu, 1 Feb 2001 12:03:31 -0500
Received: from ns.caldera.de ([212.34.180.1]:26374 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130741AbRBARDO>;
	Thu, 1 Feb 2001 12:03:14 -0500
Date: Thu, 1 Feb 2001 18:02:37 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201180237.A28007@caldera.de>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <hch@caldera.de> <200102011608.f11G8j007752@jen.americas.sgi.com> <20010201164958.U11607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010201164958.U11607@redhat.com>; from sct@redhat.com on Thu, Feb 01, 2001 at 04:49:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 04:49:58PM +0000, Stephen C. Tweedie wrote:
> > Enquiring minds would like to know if you are working towards this 
> > revamp of the kiobuf structure at the moment, you have been very quiet
> > recently. 
> 
> I'm in the middle of some parts of it, and am actively soliciting
> feedback on what cleanups are required.  

The real issue is that Linus dislikes the current kiobuf scheme.
I do not like everything he proposes, but lots of things makes sense.

> I've been merging all of the 2.2 fixes into a 2.4 kiobuf tree, and
> have started doing some of the cleanups needed --- removing the
> embedded page vector, and adding support for lightweight stacking of
> kiobufs for completion callback chains.

Ok, great.

> However, filesystem IO is almost *always* page aligned: O_DIRECT IO
> comes from VM pages, and internal filesystem IO comes from page cache
> pages.  Buffer cache IOs are the only exception, and kiobufs only fail
> for such IOs once you have multiple buffer_heads being merged into
> single requests.
> 
> So, what are the benefits in the disk IO stack of adding length/offset
> pairs to each page of the kiobuf?

I don't see any real advantage for disk IO.  The real advantage is that
we can have a generic structure that is also usefull in e.g. networking
and can lead to a unified IO buffering scheme (a little like IO-Lite).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
