Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVAWKlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVAWKlA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVAWKjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:39:35 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:2989 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261295AbVAWKhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:37:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [patch 1/13] Qsort
Date: Sun, 23 Jan 2005 11:37:08 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@muc.de>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
References: <20050122203326.402087000@blunzn.suse.de> <20050123044637.GA54433@muc.de> <Pine.LNX.4.61.0501230600070.2748@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0501230600070.2748@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501231137.09715.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 23 of January 2005 06:05, Jesper Juhl wrote:
> On Sun, 23 Jan 2005, Andi Kleen wrote:
> 
> > > How about a shell sort?  if the data is mostly sorted shell sort beats 
> > > qsort lots of times, and since the data sets are often small in-kernel, 
> > > shell sorts O(n^2) behaviour won't harm it too much, shell sort is also 
> > > faster if the data is already completely sorted. Shell sort is certainly 
> > > not the simplest algorithm around, but I think (without having done any 
> > > tests) that it would probably do pretty well for in-kernel use... Then 
> > > again, I've known to be wrong :)
> > 
> > I like shell sort for small data sets too. And I agree it would be 
> > appropiate for the kernel.
> > 
> Even with large data sets that are mostly unsorted shell sorts performance 
> is close to qsort, and there's an optimization that gives it O(n^(3/2)) 
> runtime (IIRC),

Yes, there is.

> and another nice property is that it's iterative so it  
> doesn't eat up stack space (as oposed to qsort which is recursive and eats 
> stack like ****)...

To be precise, one needs ~(log N) of stack space for qsort, and frankly, one
should use something like the shell (or should I say Shell?) sort for sorting
small sets of elements in qsort as well.

> Yeah, I think shell sort would be good for the kernel.

I agree.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
