Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311203AbSCLOYm>; Tue, 12 Mar 2002 09:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311211AbSCLOYd>; Tue, 12 Mar 2002 09:24:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21314 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311203AbSCLOYV>; Tue, 12 Mar 2002 09:24:21 -0500
Date: Tue, 12 Mar 2002 15:25:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
        wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312152534.U25226@dualathlon.random>
In-Reply-To: <20020312070645.X10413@dualathlon.random> <Pine.LNX.4.44L.0203120746000.2181-100000@imladris.surriel.com> <20020312124728.L25226@dualathlon.random> <E16klHb-0001up-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16klHb-0001up-00@starship>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 01:21:35PM +0100, Daniel Phillips wrote:
> On March 12, 2002 12:47 pm, Andrea Arcangeli wrote:
> > If it's pure random mul will make no difference to
> > the distribution. And the closer we're to pure random like in the
> > wait_table hash, the less mul will help and the more important will be
> > to just get right the two contigous pages in the same cacheline and
> > nothing else.
> 
> You're ignoring the possibility (probability) of corner cases.  I'm not

The corner cases cannot go away with a mul. If what you care about are
corner cases you shouldn't have dropped page->wait.

I changed the hashfn to make it better IMHO, Bill says it is suboptimal,
but I would prefer to see it happening on real load too before returning
to the mul. Counting the number of collisions per second under load
should be good enough measurement, nominal performance would be the
other variable but I doubt there's anything to measure in real time
differences.

If I'm generating visibly more collisions, I will be very glad to return
to the mul hashfn of course.

AFIK my current hashfn is never been tested in precendence on this kind
of random input of the wait_table pages.

Andrea
