Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313613AbSDSAzh>; Thu, 18 Apr 2002 20:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314047AbSDSAzh>; Thu, 18 Apr 2002 20:55:37 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54204 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313613AbSDSAzg>; Thu, 18 Apr 2002 20:55:36 -0400
Date: Thu, 18 Apr 2002 18:54:02 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Mel <mel@csn.ul.ie>
cc: linux-kernel@vger.kernel.org
Subject: Re: page_alloc.c comments patch v2
Message-ID: <1940570000.1019181242@flay>
In-Reply-To: <Pine.LNX.4.44.0204190127080.8173-100000@skynet>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I got confused when I was examining the code and got mixed up. I see now
> the question about more that one ZONE_NORMAL in this pgdata_t is off, but
> the query still (sortof) holds. Let me try again.
> 
> I am an allocator and I start in HIGHMEM which has a pages_low value of 10
> (arbitary number). I find I would hit it if I allocated from there so I
> move to NORMAL which also has a pages_low of 10 but now I am making sure I
> am at least 20 pages are free in the NORMAL zone, not 10 and possibly
> (presuming pages_low in DMA is 10) making sure 30 are free in DMA. Is this
> the way things are meant to happen?

Ah, OK, I see what you were getting at now ;-)

It's hard to really tell what was intended - Andrea might be able to give
you a
better idea. However, from the way I read the code, it might seem to make
more
sense if the "min = 1UL << order;" was inside the loop rather than outside.
That'd simply make sure we always left "zone->pages_low" free inside that
zone .... if course it would make no sense to assign min and then increment
it
with += inside the loop, or even set it any more .... just

if (z->free_pages > z->pages_low + (1UL << order))

But all that's purely speculation, he might have meant it as it is ;-)

M.

