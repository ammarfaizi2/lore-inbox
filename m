Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310548AbSCGVYN>; Thu, 7 Mar 2002 16:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310553AbSCGVYD>; Thu, 7 Mar 2002 16:24:03 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:37134 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310548AbSCGVXu>;
	Thu, 7 Mar 2002 16:23:50 -0500
Date: Thu, 7 Mar 2002 18:23:36 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <yodaiken@fsmlabs.com>,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <3C87D40C.603DE513@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0203071818140.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Andrew Morton wrote:

> > Nope.  Readahead pages are clean and very easy to evict, so
> > it's still trivial to evict all the pages from another readahead
> > window because everybody's readahead window is too large.

> Any clever ideas?

1) keep track of which pages we are reading ahead
   ... the readahead code already does this

2) at read() or fault time, see if the page
   (a) is resident
   (b) is in the current readahead window,
       ie. already read ahead

3) if the page is in the current readahead window
   but NOT resident, the page was read in and
   evicted before we got around to using it, so
   readahead window thrashing is going on
   ... in that case, collapse the size of the
   readahead window TCP-style

4) slowly growing the readahead window when there is
   enough memory available, in order to minimise the
   number of disk seeks

5) the growing in (3) and shrinking in (4) mean that
   the readahead size of all streaming IO in the system
   gets automatically balanced against each other and
   against other memory demand in the system

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

