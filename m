Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130376AbRBARny>; Thu, 1 Feb 2001 12:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130463AbRBARnr>; Thu, 1 Feb 2001 12:43:47 -0500
Received: from zeus.kernel.org ([209.10.41.242]:5330 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130376AbRBARnf>;
	Thu, 1 Feb 2001 12:43:35 -0500
Date: Thu, 1 Feb 2001 17:41:20 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>, bsuparna@in.ibm.com,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201174120.A11607@redhat.com>
In-Reply-To: <CA2569E6.0051970D.00@d73mta03.au.ibm.com> <20010201160953.A17058@caldera.de> <20010201161615.T11607@redhat.com> <20010201180515.B28007@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010201180515.B28007@caldera.de>; from hch@ns.caldera.de on Thu, Feb 01, 2001 at 06:05:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 06:05:15PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 01, 2001 at 04:16:15PM +0000, Stephen C. Tweedie wrote:
> > > 
> > > No, and with the current kiobufs it would not make sense, because they
> > > are to heavy-weight.
> > 
> > Really?  In what way?  
> 
> We can't allocate a huge kiobuf structure just for requesting one page of
> IO.  It might get better with VM-level IO clustering though.

A kiobuf is *much* smaller than, say, a buffer_head, and we currently
allocate a buffer_head per block for all IO.

A kiobuf contains enough embedded page vector space for 16 pages by
default, but I'm happy enough to remove that if people want.  However,
note that that memory is not initialised, so there is no memory access
cost at all for that empty space.  Remove that space and instead of
one memory allocation per kiobuf, you get two, so the cost goes *UP*
for small IOs.

> > > With page,length,offsett iobufs this makes sense
> > > and is IMHO the way to go.
> > 
> > What, you mean adding *extra* stuff to the heavyweight kiobuf makes it
> > lean enough to do the job??
> 
> No.  I was speaking abou the light-weight kiobuf Linux & Me discussed on
> lkml some time ago (though I'd much more like to call it kiovec analogous
> to BSD iovecs).

What is so heavyweight in the current kiobuf (other than the embedded
vector, which I've already noted I'm willing to cut)?

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
