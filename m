Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRADQx2>; Thu, 4 Jan 2001 11:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbRADQxT>; Thu, 4 Jan 2001 11:53:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:34162 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129675AbRADQxF>; Thu, 4 Jan 2001 11:53:05 -0500
Date: Thu, 4 Jan 2001 17:52:38 +0100
From: Andrea Arcangeli <andrea@e-mind.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
Message-ID: <20010104175238.F1507@athlon.random>
In-Reply-To: <20010104171807.B1507@athlon.random> <Pine.LNX.4.21.0101041422360.1188-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101041422360.1188-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Jan 04, 2001 at 02:23:53PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 02:23:53PM -0200, Rik van Riel wrote:
> > The dcache aging is mostly useful with _high_ VFS load like
> > updatedb in background. The logic is the same of the VM aging
> > (ask yourself when the VM aging is most useful: when there's
> > high VM load, like a `cp /dev/zero .`
> 
> This is exactly the point where page aging alone isn't good
> enough and you need something like drop-behind...
> 
> (yes, there IS a reason why we have drop_behind() and page
> deactivation in generic_file_write)

This is totally offtopic. We were _not_ talking about other algorithms.  We
were _only_ talking about _when_ the 1 bit of aging I introduced with my
algorithm improves performance at max.  My answer is that the max performance
improvement happens when there's the _highest_ VFS load in background and you
disagreed.  Everything else has nothing to do with this our previous discussion
so your above reply partly still doesn't make sense to me.

Talking about the new topic you introduced above with your offtopic reply, I
think that for a thing like dcache 1 bit of aging is more than enough
(and btw, in my 2.4.x VM tree I put a 1 bit of aging also in the icache).  In
case you didn't realized the frequency the dcache gets recycled completly is
much much much lower than the frequency something like the pagecache can be
recycled completly. So you have relatively plenty of time before the referenced
dentries gets collected.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
