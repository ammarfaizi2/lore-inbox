Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272020AbRIDROJ>; Tue, 4 Sep 2001 13:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272021AbRIDRN7>; Tue, 4 Sep 2001 13:13:59 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:56465 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S272020AbRIDRNm>; Tue, 4 Sep 2001 13:13:42 -0400
Date: Tue, 4 Sep 2001 13:13:50 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010904131349.B29711@cs.cmu.edu>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20010904112629.A27988@cs.cmu.edu> <Pine.LNX.4.33L.0109041320271.7626-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109041320271.7626-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 01:27:50PM -0300, Rik van Riel wrote:
> I've been working on a CPU and memory efficient reverse
> mapping patch for Linux, one which will allow us to do
> a bunch of optimisations for later on (infrastructure)
> and has as its short-term benefit the potential for
> better page aging.

Yes, I can see that using reverse mappings would be a way of correcting
the aging if you call page_age_up from try_to_swap_out, in which case
there probably needs to be a page_age_down on virtual mappings as well
to correctly balance things.

> It seems the balancing FreeBSD does (up aging +3, down
> aging -1, inactive list in LRU order as extra stage) is

One other observation, we should add anonymously allocated memory to the
active-list as soon as they are allocated in do_nopage. At the moment a
large part of memory is not aged at all until we start swapping things
out.

Jan

