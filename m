Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbRIBSqt>; Sun, 2 Sep 2001 14:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268954AbRIBSqj>; Sun, 2 Sep 2001 14:46:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21639 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S268702AbRIBSqY>;
	Sun, 2 Sep 2001 14:46:24 -0400
Date: Sun, 2 Sep 2001 14:46:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFC] lazy allocation of struct block_device
In-Reply-To: <200109021725.RAA20376@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0109021419320.21487-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Sep 2001 Andries.Brouwer@cwi.nl wrote:

> Since several people react, let us fork the discussion
> and talk about dev_t for a while.
> 
> Your reaction ("not in any tree I'd ever run") is too strong,
> more emotion than thought. (Or maybe you only want to please Linus.)

Not really, especially since if Linus will go that way I'll simply fork
the tree.
 
> How long must filenames (maximally) be? Well, long enough.
> And I used systems with namelength 4, 6, 8, 11, 12, 14, 31, 255, maybe more.
> And 255 is long enough. Is it ridiculous to allow 255? Isn't 100 enough?
> Yes, 100 is also enough, as tar shows. But going to 255 has essentially
> zero cost, so has only advantages.
> People do not have to use such long names, but they can, if they want.
> The longest filename on this machine here has length 97.
> 
> How many bits should a dev_t have? Well, enough.

Enough for what? To cover all currently supported devices? Or to allocate
a major for each driver that will ever be written? I can see the value of
the former, but not the latter.

> Now you malign glibc ("this piece of shit"), but in reality this
> has very little to do with glibc. The only important use (important
> efficiency-wise) of dev_t is in the stat() system call.
> Now the present Linux stat64 call uses 96-bit dev_t, 16 bits info
> and 80 bits padding. Even if you use some tiny libc, you get
> 96 bits - in other words, the inefficiency is in the kernel.
> Thus, I do not quite understand why you say that you prefer
> to have only the disadvantages, and that you never in your life
> want the advantages of a large dev_t.

Mostly for the same reasons why I don't like the idea of perpetuating
*FAT and friends.  dev_t as a way to specify device was tolerable on
v7.  It doesn't scale and the fact that you need to expand it indicates
exactly that.  IOW, if we ever need that many device types - numbers
are not going to work.

