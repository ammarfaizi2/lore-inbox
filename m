Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271649AbRIBR0V>; Sun, 2 Sep 2001 13:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271651AbRIBR0L>; Sun, 2 Sep 2001 13:26:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:30607 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271649AbRIBRZ4>;
	Sun, 2 Sep 2001 13:25:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 2 Sep 2001 17:25:40 GMT
Message-Id: <200109021725.RAA20376@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [RFC] lazy allocation of struct block_device
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From viro@math.psu.edu Sun Sep  2 13:39:05 2001

    On Sun, 2 Sep 2001 Andries.Brouwer@cwi.nl wrote:

    > That majors allocation is frozen is not my problem.
    > I make life simple with a 64-bit dev_t. Everybody else already has the
    > disadvantages of a 64-bit dev_t, since glibc moves 64 bits around,
    > but not the advantage of a large namespace.

    Not an option for any tree I'd ever run on my box and IIRC Linus was not
    likely to inflict that on his.  As for the glibc...
        a) not everything uses this piece of shit
        b) it would be really nice to get rid of it completely someday

    > But that is a separate discussion.

    <nod>

Since several people react, let us fork the discussion
and talk about dev_t for a while.

Your reaction ("not in any tree I'd ever run") is too strong,
more emotion than thought. (Or maybe you only want to please Linus.)

How long must filenames (maximally) be? Well, long enough.
And I used systems with namelength 4, 6, 8, 11, 12, 14, 31, 255, maybe more.
And 255 is long enough. Is it ridiculous to allow 255? Isn't 100 enough?
Yes, 100 is also enough, as tar shows. But going to 255 has essentially
zero cost, so has only advantages.
People do not have to use such long names, but they can, if they want.
The longest filename on this machine here has length 97.

How many bits should a dev_t have? Well, enough.
And 16 is not enough, and people go through painful contortions.
And 64 is enough. Is it ridiculous to allow 64? Isn't 32 enough?
Maybe, in most cases, yes, although there are some slight problems
with NFS and interoperability - certainly 64 makes life easier.
Moreover, going to 64 has essentially zero cost, so has only advantages.

Now you malign glibc ("this piece of shit"), but in reality this
has very little to do with glibc. The only important use (important
efficiency-wise) of dev_t is in the stat() system call.
Now the present Linux stat64 call uses 96-bit dev_t, 16 bits info
and 80 bits padding. Even if you use some tiny libc, you get
96 bits - in other words, the inefficiency is in the kernel.

Thus, I do not quite understand why you say that you prefer
to have only the disadvantages, and that you never in your life
want the advantages of a large dev_t.

Andries
