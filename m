Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129850AbRBARFv>; Thu, 1 Feb 2001 12:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130422AbRBARFl>; Thu, 1 Feb 2001 12:05:41 -0500
Received: from ns.caldera.de ([212.34.180.1]:28934 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129850AbRBARFd>;
	Thu, 1 Feb 2001 12:05:33 -0500
Date: Thu, 1 Feb 2001 18:05:15 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201180515.B28007@caldera.de>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <CA2569E6.0051970D.00@d73mta03.au.ibm.com> <20010201160953.A17058@caldera.de> <20010201161615.T11607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010201161615.T11607@redhat.com>; from sct@redhat.com on Thu, Feb 01, 2001 at 04:16:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 04:16:15PM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, Feb 01, 2001 at 04:09:53PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 01, 2001 at 08:14:58PM +0530, bsuparna@in.ibm.com wrote:
> > > 
> > > That would require the vfs interfaces themselves (address space
> > > readpage/writepage ops) to take kiobufs as arguments, instead of struct
> > > page *  . That's not the case right now, is it ?
> > 
> > No, and with the current kiobufs it would not make sense, because they
> > are to heavy-weight.
> 
> Really?  In what way?  

We can't allocate a huge kiobuf structure just for requesting one page of
IO.  It might get better with VM-level IO clustering though.

> 
> > With page,length,offsett iobufs this makes sense
> > and is IMHO the way to go.
> 
> What, you mean adding *extra* stuff to the heavyweight kiobuf makes it
> lean enough to do the job??

No.  I was speaking abou the light-weight kiobuf Linux & Me discussed on
lkml some time ago (though I'd much more like to call it kiovec analogous
to BSD iovecs).

And a page,offset,length tuple is pretty cheap compared to a current kiobuf.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
