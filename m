Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268316AbTBMXGn>; Thu, 13 Feb 2003 18:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268317AbTBMXGn>; Thu, 13 Feb 2003 18:06:43 -0500
Received: from almesberger.net ([63.105.73.239]:10763 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268316AbTBMXGl>; Thu, 13 Feb 2003 18:06:41 -0500
Date: Thu, 13 Feb 2003 20:16:19 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030213201619.A2092@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117022833.229992C365@lists.samba.org>; from rusty@rustcorp.co
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m.au on Fri, Jan 17, 2003 at 01:27:56PM +1100

Sorry for the long pause ...

Rusty Russell wrote:
> They gave us SMP.  What do we gain for your change?

Mainly a simpler interface - one that doesn't treat module unloading
as such a special case, but just as yet another fairly regular
synchronization problem.

This should also have a performance impact: the current approach
puts "code locking" outside of the module, and "data locking" inside
of it. Unifying this eliminates one layer of locking mechanisms.

Independent of this, we should fix the interfaces that give us
unstoppable callbacks. These are just disasters waiting to happen,
modules or no.

Of course, since this may imply interface changes (not necessarily
in terms of changing an existing interface, but perhaps in terms of
adding a properly synchronized version, and discovering bugs in
modules using the not-synchronized one), it would be good if the
module cleanup simplification could be done in parallel.

I think, once we know exactly what semantics to aim for, the change
could be relatively straightforward. (And, I wholeheartedly agree,
there must be no "flag day".)

> But apologies for the tone of my previous mail: it seems I'm
> oversensitive to criticism of the module stuff now 8(

No problem. I actually admire your thick skin, given all the
unjustified and nasty stuff you get thrown at you :-)

> To go someway towards an explanation, at least, I humbly submit a
> fairly complete description of the approach used (assuming the module
> init race fix patch gets merged).

Thanks ! That part looks fine. But, of course, it's not how you
do it that I don't like, but what you're doing :-)

Anyway, my plan is to first get my simulation infrastructure
working, and then make a few test cases that show callbacks
after deregistration causing trouble. After that, hopefully
other people can pick up the cleanup work.

Do you see any obvious technical problems with the approach of
using return from module initialization/cleanup as "ready to
unload" indicator ?

- Werner

--
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
