Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130260AbQJ2SdF>; Sun, 29 Oct 2000 13:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131315AbQJ2Scp>; Sun, 29 Oct 2000 13:32:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24048 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130260AbQJ2Scc>;
	Sun, 29 Oct 2000 13:32:32 -0500
Date: Sun, 29 Oct 2000 13:32:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Paul Mackerras <paulus@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: page->mapping == 0
In-Reply-To: <Pine.LNX.4.10.10010290957570.18939-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0010291308260.27484-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Oct 2000, Linus Torvalds wrote:

> approach for 2.4.x where we just re-test against the file size in multiple
> places where this can happen - but it would be nicer to handle this more
> cleanly.

One possible way is to access page->mapping _only_ under the page lock
and in cases when we call ->i_mapping->a_ops->foo check the ->mapping
before the method call.

> There are a few details that still elude me, the main one being the big
> question about why this started happening to so many people just recently.
> The bug is not new, and yet it's become obvious only in the last few
> weeks.

And original truncate() problems went undetected since...? Pattern looks
very similar. Petr posted bug reports long time ago - back then they
were ignored since they involved vmware. In both cases we had persistent
problems caught by few people who were using not-too-common combinations
(innd on 2.4 boxen, for example) and at some point the shit had hit the
fan big way. No amount of testing can prove that there is no bugs and all
such...

I would expect problems with truncate, mmap, rename, POSIX locks, fasync,
ptrace and mount go unnoticed for _long_. Ditto for parts of procfs
proper that are not exercised by ps and friends. Sigh...

Maybe something along the lines of BTS might be useful, hell knows.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
