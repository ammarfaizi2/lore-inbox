Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272036AbRIDRWT>; Tue, 4 Sep 2001 13:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRIDRWJ>; Tue, 4 Sep 2001 13:22:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28941 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272036AbRIDRVz>; Tue, 4 Sep 2001 13:21:55 -0400
Date: Tue, 4 Sep 2001 12:56:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010904131349.B29711@cs.cmu.edu>
Message-ID: <Pine.LNX.4.21.0109041253510.2038-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Jan Harkes wrote:

> On Tue, Sep 04, 2001 at 01:27:50PM -0300, Rik van Riel wrote:
> > I've been working on a CPU and memory efficient reverse
> > mapping patch for Linux, one which will allow us to do
> > a bunch of optimisations for later on (infrastructure)
> > and has as its short-term benefit the potential for
> > better page aging.
> 
> Yes, I can see that using reverse mappings would be a way of correcting
> the aging if you call page_age_up from try_to_swap_out, in which case
> there probably needs to be a page_age_down on virtual mappings as well
> to correctly balance things.
> 
> > It seems the balancing FreeBSD does (up aging +3, down
> > aging -1, inactive list in LRU order as extra stage) is
> 
> One other observation, we should add anonymously allocated memory to the
> active-list as soon as they are allocated in do_nopage. At the moment a
> large part of memory is not aged at all until we start swapping things
> out.

With reverse mappings we can completly remove the "swap_out()" loop logic
and age pte's at refill_inactive_scan(). 

All that with anon memory added to the active-list as soon as allocated,
of course.

Jan, I suggest you to take a look at the reverse mapping code. 

