Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268170AbTBNDez>; Thu, 13 Feb 2003 22:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268171AbTBNDez>; Thu, 13 Feb 2003 22:34:55 -0500
Received: from almesberger.net ([63.105.73.239]:52235 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268170AbTBNDey>; Thu, 13 Feb 2003 22:34:54 -0500
Date: Fri, 14 Feb 2003 00:44:36 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030214004436.B2092@almesberger.net>
References: <20030213201619.A2092@almesberger.net> <20030214020901.22E6C2C002@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214020901.22E6C2C002@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Feb 14, 2003 at 12:57:38PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Um, no.  You're special case "optimizing" it.
> 
> When you have an object which may vanish, the linux kernel idiom runs
> something like this:

Yes, that's when you view it as a locking problem, as for data
objects. What I'm saying is that, if you manage the data
structures properly, plus fix a few interfaces that currently
don't have to manage data structures properly, you're already
perfectly synchronized, so no further locking is needed.

> I assume you're referring to the many places where we assume that the
> structure being added was not dynamically allocated, so don't bother
> to protect against its deletion?

Yes.

> And in general, I agree: not including a refcount is asking for
> trouble.  But these reference counts are *not* free. 

Alas, no. But we how long can we afford not to fix them, at least
the "public" interfaces ? Even if they're unsafe, people will use
them, particularly if they're given no other choice.

> object separately from any objects it might create.  The current
> implementation is extremely fast, requires neither module changes nor
> (many) interface changes, and in effect canonicalizes a single
> existing method of locking, which coders seem quite comfortable with.

It's more the changes behind the interfaces I'm worried about.
It may not be bad today, but every function pointer is a
potential problem.

Anyway, without fixing a good number of the "ghost from the
past" interfaces first, my point is moot. So I won't trouble
you again with module locking before there is some progress in
this area :-)

> Given these reasons, you can see why I no longer discuss new
> implementation ideas with people 8(

Nah, don't give up ! :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
