Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbQLaRVF>; Sun, 31 Dec 2000 12:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbQLaRUz>; Sun, 31 Dec 2000 12:20:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23058 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129911AbQLaRUs>; Sun, 31 Dec 2000 12:20:48 -0500
Date: Sun, 31 Dec 2000 17:50:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@fh-brandenburg.de>,
        "Eric W. Biederman" <ebiederman@uswest.net>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
Message-ID: <20001231175004.A8027@athlon.random>
In-Reply-To: <20001231153849.B17728@athlon.random> <Pine.LNX.4.10.10012310812500.3084-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10012310812500.3084-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 31, 2000 at 08:33:01AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 08:33:01AM -0800, Linus Torvalds wrote:
> By doing a better job of caching stuff.

Caching can happen after we are been slow and we waited for I/O synchronously
the first time (bread).

How can we optimize the first time (when the indirect blocks are out of buffer
cache) without changing the on-disk format? We can't as far I can see.

It's of course fine to optimize the address_space->physical_block resolver
algorithm, because it has to run anyways if we want to write such data to disk
eventually (despite it's asynchronous with allocate on flush, or synchronous
like now).  Probably it's a more sensible optimization than the allocate
on flush thing. But still being able to run the resolver in an asynchronous
manner, in parallel, only at the time we need to flush the page to disk, looks
nicer behaviour to me.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
