Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSCOIrU>; Fri, 15 Mar 2002 03:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSCOIrK>; Fri, 15 Mar 2002 03:47:10 -0500
Received: from [202.135.142.196] ([202.135.142.196]:5640 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S286311AbSCOIq4>; Fri, 15 Mar 2002 03:46:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Joel Becker <jlbec@evilplan.org>
Cc: frankeh@watson.ibm.com, matthew@hairy.beasts.org,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Re: futex and timeouts 
In-Reply-To: Your message of "Fri, 15 Mar 2002 06:08:29 -0000."
             <20020315060829.L4836@parcelfarce.linux.theplanet.co.uk> 
Date: Fri, 15 Mar 2002 19:49:04 +1100
Message-Id: <E16lnOa-0005dy-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020315060829.L4836@parcelfarce.linux.theplanet.co.uk> you write:
> On Fri, Mar 15, 2002 at 04:39:50PM +1100, Rusty Russell wrote:
> > Yep, sorry, my mistake.  I suggest make it a relative "struct timespec
> > *" (more futureproof that timeval).  It would make sense to split the
> > interface into futex_down and futex_up syuscalls, since futex_up
> > doesn't need a timeout arg, but I haven't for the moment.
> 
> 	Why waste a syscall?  The user is going to be using a library
> wrapper.  They don't have to know that futex_up() calls sys_futex(futex,
> FUTEX_UP, NULL);

My bad.  There was a mistake in the patch (ie. I didn't actually do
this).

OTOH, shades of fcntl!  Syscalls are not "wasted": one for every
fundamental operation makes *sense*.  If I were doing it with timeouts
from scratch, I'd definitely have done two syscalls.  As it is, the
"op" arg gives us a chance for more overloading in future.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
