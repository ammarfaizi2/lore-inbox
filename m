Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293196AbSDSAhh>; Thu, 18 Apr 2002 20:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311147AbSDSAhg>; Thu, 18 Apr 2002 20:37:36 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:43025 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S293196AbSDSAhg>;
	Thu, 18 Apr 2002 20:37:36 -0400
Date: Fri, 19 Apr 2002 01:37:25 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_alloc.c comments patch v2
In-Reply-To: <1937110000.1019179067@flay>
Message-ID: <Pine.LNX.4.44.0204190127080.8173-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002, Martin J. Bligh wrote:

> Firstly, nice idea to actually comment the code ;-)
>

Thanks

> Re: __alloc_pages
>
> > + * @zonelist: The preferred zone to allocate from
>
> Zonelist is not a zone, it's a list of zones suitable for the given
> zonemask on that pg_data_t in order of preference. Maybe I'm
> just misreading your syntax.
>

Bad choice of words. I've changed it to

@zonelist: A list of zones to allocate from starting with the preferred one

> > +		 * QUERY: If there was more than one zone in ZONE_NORMAL and
> > +		 *        each zone had a pages_low value of 10, wouldn't the
> > +		 *        second zone have a min value of 20, the third of 30
> > +		 *        and so on? Wouldn't this possibly wake kswapd before
> > +		 *        it was really needed? Is this the expected behaviour?
>
> I don't see how there could be "more that one zone in ZONE_NORMAL"?
> There can only be one ZONE_NORMAL per pgdata_t.
>

I got confused when I was examining the code and got mixed up. I see now
the question about more that one ZONE_NORMAL in this pgdata_t is off, but
the query still (sortof) holds. Let me try again.

I am an allocator and I start in HIGHMEM which has a pages_low value of 10
(arbitary number). I find I would hit it if I allocated from there so I
move to NORMAL which also has a pages_low of 10 but now I am making sure I
am at least 20 pages are free in the NORMAL zone, not 10 and possibly
(presuming pages_low in DMA is 10) making sure 30 are free in DMA. Is this
the way things are meant to happen?

I see what the benefit of it would be, it would mean we would be less
likely to use an undesirable zone, but was that what it was intended? If
it was, I'll put in the comments explaining that.

> Look at build_zonelists to see how the fallback lists (zonelist) are built
> up.

I did, I even have a comment posted for it but managed to miss the
full significance of it in a fit of brillance :-). Thanks for your time

		Mel


