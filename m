Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129992AbRAGVhd>; Sun, 7 Jan 2001 16:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbRAGVhY>; Sun, 7 Jan 2001 16:37:24 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:60661 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129992AbRAGVhP>; Sun, 7 Jan 2001 16:37:15 -0500
Date: Sun, 7 Jan 2001 19:37:06 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Subtle MM bug
In-Reply-To: <87k8879iyu.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.21.0101071919120.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2001, Zlatko Calusic wrote:

> Things go berzerk if you have one big process whose working set
> is around your physical memory size.

"go berzerk" in what way?  Does the system cause lots of extra
swap IO and does it make the system thrash where 2.2 didn't
even touch the disk ?

> Final effect is that physical memory gets extremely flooded with
> the swap cache pages and at the same time the system absorbs
> ridiculous amount of the swap space.

This is mostly because Linux 2.4 keeps dirty pages in the
swap cache. Under Linux 2.2 a page would be deleted from the
swap cache when a program writes to it, but in Linux 2.4 it
can stay in the swap cache.

Oh, and don't forget that pages in the swap cache can also
be resident in the process, so it's not like the swap cache
is "eating into" the process' RSS ;)

> For instance on my 192MB configuration, firing up the hogmem
> program which allocates let's say 170MB of memory and dirties it
> leads to 215MB of swap used.

So that's 170MB of swap space for hogmem and 45MB for
the other things in the system (daemons, X, ...).

Sounds pretty ok, except maybe for the fact that now
Linux allocates (not uses!) a lot more swap space then
before and some people may need to add some swap space
to their system ...


Now if 2.4 has worse _performance_ than 2.2 due to one
reason or another, that I'd like to hear about ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
