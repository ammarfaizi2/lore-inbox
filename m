Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbSKST1v>; Tue, 19 Nov 2002 14:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbSKST1v>; Tue, 19 Nov 2002 14:27:51 -0500
Received: from picante.ne.client2.attbi.com ([24.91.80.18]:46063 "EHLO
	habanero.picante.com") by vger.kernel.org with ESMTP
	id <S267089AbSKST1t>; Tue, 19 Nov 2002 14:27:49 -0500
Message-Id: <200211191933.gAJJXumU025156@habanero.picante.com>
From: Grant Taylor <gtaylor+lkml_cfaea111902@picante.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
Date: Tue, 19 Nov 2002 14:33:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel writes:

>> For example, sometimes TCP reads return EAGAIN when in fact they
> eek!  Thanks for noticing that!

We aim to please.

In fact, it took me a long time to track this sucker down, so it's
good that I remembered before someone else got baffled.

This wouldn't be an issue if nonblocking reads or writes were
guaranteed to be uninterruptible even if on a "slow" device.  But
that's a deeper change than just a bit of caution wrt EAGAIN, and this
is an area to monkey around in only very carefully.

Unfortunately, I never looked elsewhere for this style of error; in
the old epoll you could only epoll TCP sockets (maybe pipes too?).  It
might even be present in TCP sendmsg; I don't recall...


Davide writes:

> I will not enable epoll fds to be stored inside another epoll
> fd. With limited numbers of fds poll scales good, and if you need to
> create a priority hierarchy, you can use a small poll set of epoll
> fds. This is a very corner case and I'm not willing to screw up the
> to to handle something that made 0.1% of users are going to do. It
> _can_ be done in other ways.

I'd vote for the "three levels, tops" approach, myself, but I suspect
that for now you are right and it will be simpler to just be
restrictive until we find a need and/or a good way to let epoll epoll
epoll.  So to speak ;)

If we're bound to poll small sets of epoll fds perhaps a bit of
improvement in poll would be worthwhile.  I should go look at my
profiles again; I've got a program which works this way because some
library code requires poll semantics and it's no good rewriting the
world...

-- 
Grant Taylor - gtaylor<at>picante.com - http://www.picante.com/~gtaylor/
  Linux Printing Website and HOWTO:  http://www.linuxprinting.org/
