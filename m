Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275230AbRIZOtl>; Wed, 26 Sep 2001 10:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275243AbRIZOtc>; Wed, 26 Sep 2001 10:49:32 -0400
Received: from [195.223.140.107] ([195.223.140.107]:44797 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275230AbRIZOtR>;
	Wed, 26 Sep 2001 10:49:17 -0400
Date: Wed, 26 Sep 2001 16:49:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
Subject: Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)
Message-ID: <20010926164935.J27945@athlon.random>
In-Reply-To: <20010926160347.F27945@athlon.random> <Pine.LNX.4.33L.0109261123070.19147-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109261123070.19147-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Wed, Sep 26, 2001 at 11:23:44AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 11:23:44AM -0300, Rik van Riel wrote:
> On Wed, 26 Sep 2001, Andrea Arcangeli wrote:
> > On Wed, Sep 26, 2001 at 06:38:48AM -0700, Craig Kulesa wrote:
> > > in memory, and is swapping out harder to compensate.  The ac14/ac15 tree
> >
> > 2.4.10 is swapping out more also because I don't keep track of which
> > pages are just uptodate on the swap space. This will be fixed as soon
> > as I teach get_swap_page to collect away from the swapcache mapped
> > exclusive swap pages.
> 
> Wouldn't that be easier to do from try_to_swap_out() ?

Of course that's a possibility but then we'd have to duplicate it in all
other get_swap_page callers, see?

And I think it much better fits hided in get_swap_page: the semantics of
get_swap_page() are "give to the caller a newly allocated swap entry".
So IMHO it is its own business to discard our "optimizations" to
generate a free swap entry in case all swap was just allocated.

Andrea
