Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSKRV7N>; Mon, 18 Nov 2002 16:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSKRV6Z>; Mon, 18 Nov 2002 16:58:25 -0500
Received: from picante.ne.client2.attbi.com ([24.91.80.18]:13560 "EHLO
	habanero.picante.com") by vger.kernel.org with ESMTP
	id <S265066AbSKRV6E>; Mon, 18 Nov 2002 16:58:04 -0500
Message-Id: <200211182204.gAIM47mU030748@habanero.picante.com>
From: Grant Taylor <gtaylor+lkml_cjiia111802@picante.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
Date: Mon, 18 Nov 2002 17:04:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper writes:

>> epoll does hook f_op->poll() and hence uses the asm/poll.h bits.

> It does today. We are talking about "you promise that this will be
> the case ever after or we'll cut your head off". 
> [...]
> it is not you who has to deal with the fallout of a change when it

Maybe Davide wouldn't, but *I* do; my project at work runs over epoll,
and interface changes would require rework by me.

Sensible interface changes in the future won't bother me.  I don't
expect anything in the future nearly as earth-shattering as this
current driver/ioctl->syscall transition.

> If epoll is so different from poll (and this is what I've been told
> frmo Davide) then there should be a clear separation of the
> interfaces and all those arguing to unify the data types and
> constants better should rethink there understanding.

The main call returns a subset of the information that poll returns.
What could be more natural than to name that subset the same thing?

Really, sys_epoll does two things:

 1 It sets up epoll itself.  

   This interface is entirely epoll-specific, and has all EP-specific
   constants etc, in <sys/epoll.h>, as well it should.


 2 It returns the set of poll bits that have changed since the last
   epoll.

   This interface is defined largely in terms of poll, and that's OK.
   How many changes do you expect in the poll interface?


In the end, I don't really feel all that strongly about this bits
issue (since truth be told the performance impact will be very small
at most) so it's up to you and Davide.


OTOH, I really hate the "user pointer in struct epollfd" thing...

-- 
Grant Taylor - gtaylor<at>picante.com - http://www.picante.com/~gtaylor/
   Linux Printing Website and HOWTO:  http://www.linuxprinting.org/
