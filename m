Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310538AbSCGU7C>; Thu, 7 Mar 2002 15:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310535AbSCGU6x>; Thu, 7 Mar 2002 15:58:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49425 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310538AbSCGU6j>;
	Thu, 7 Mar 2002 15:58:39 -0500
Message-ID: <3C87D40C.603DE513@zip.com.au>
Date: Thu, 07 Mar 2002 12:56:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, yodaiken@fsmlabs.com,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <3C87BD22.BBBF4A86@zip.com.au> <Pine.LNX.4.44L.0203071709400.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 7 Mar 2002, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > >
> > > a GFP flag that says 'fail if this looks hard to get'.
> >
> > Something like that would provide a solution to the
> > readahead thrashing problem.
> 
> Nope.  Readahead pages are clean and very easy to evict, so
> it's still trivial to evict all the pages from another readahead
> window because everybody's readahead window is too large.
> 

I was thinking an explicit GFP_READAHEAD and PG_readahead.
Where a GFP_READAHEAD allocation would fail if it can't 
find any non-readahead pages.  And it would fail if it
had to perform I/O.

That's not nice - it'd result in large LRU walks.  But it'd
be better than the 10x slowdown which readahead thrashing
causes.

Any clever ideas?

-
