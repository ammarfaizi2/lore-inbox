Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319509AbSIGTmV>; Sat, 7 Sep 2002 15:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319510AbSIGTmV>; Sat, 7 Sep 2002 15:42:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22500 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319509AbSIGTmU>;
	Sat, 7 Sep 2002 15:42:20 -0400
Date: Sat, 7 Sep 2002 15:47:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Daniel Phillips <phillips@arcor.de>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
In-Reply-To: <20020907192736.A22492@kushida.apsleyroad.org>
Message-ID: <Pine.GSO.4.21.0209071544090.23598-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Sep 2002, Jamie Lokier wrote:

> Alexander Viro wrote:
> > If your rules are "it's pinned as long as there are opened files created
> > by foo()" - very well, there are two variants.  The basic idea is the same
> > - have sum of ->mnt_count for all vfsmounts of our type bumped whenever we
> > call foo() and drop whenever final fput() is done on a file created by foo().
> 
> Thanks -- that's what I implemented, except I used a semaphore instead
> of a spinlock.
> 
> I wanted to check that it's safe to call `mntput' from `->release()',
> which seems like quite a dubious thing to depend on.  But if you say it
> is safe, that's cool.

It is neither safe nor needed.  Please, look at the previous posting again -
neither variant calls mntput() in ->release().

Now, __fput() _does_ call mntput() - always.  And yes, if that happens to
be the final reference - it's OK.

