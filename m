Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319293AbSIKTOT>; Wed, 11 Sep 2002 15:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319295AbSIKTOT>; Wed, 11 Sep 2002 15:14:19 -0400
Received: from dsl-213-023-021-043.arcor-ip.net ([213.23.21.43]:1770 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319293AbSIKTOR>;
	Wed, 11 Sep 2002 15:14:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Oliver Neukum <oliver@neukum.name>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Wed, 11 Sep 2002 21:20:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209101201280.8911-100000@serv> <E17pCKQ-0007Sz-00@starship> <200209112053.52426.oliver@neukum.name>
In-Reply-To: <200209112053.52426.oliver@neukum.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pD2j-0007TM-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 20:53, Oliver Neukum wrote:
> > Now there's the question "if this is such a great approach, why not make
> > all modules work this way, not just filesystems?".  Easy: the magic
> > scheduling approach impacts the scheduler, however lightly, and worse,
> > we cannot put an upper bound on the time needed for
> 
> You are in principle describing RCU. These guys seem to have solved the
> problem.

Eh, how about that, and it was obvious to me.  I wonder what that 
means, if anything.  (No, I never knew anything about RCU other
than the name.)  Anyway, in case I sound too snippy here, here's
a hearty thanks to IBM for contributing that IP to Linux without
a fuss.

> > magic_wait_for_quiescence to complete.  So the try_count approach is
> > preferable, where it works.
> 
> But the try_count approach hurts every user of the defined interfaces,
> even if modules are not used.

Well, it works great for filesystems, which is my point.  And I'll
bet beer that somebody out there will find another application
where it works well.  It's all about choice, and the thing about
the proposed interface is, it gives you the flexibility to make
that choice.  The fact that it's also the simplest interface is
just nice.

> Is the impact on the scheduler limited
> to the time magic_wait_for_quiescence is running.
> If so, the approach looks superior.

It definitely is not superior for filesystem modules.  However,
"damm good" would be a nice level of functionality to aim for.
The more we come to rely on virtual filesystem, the more we care
that the load/unload procedure should be reliable and fast.
Don't forget that point about not being able to put an upper
bound on the time required to complete the magic wait.

Are you hinting that we only need, and only ever will need, one
mechanism here, so the module doesn't need to return a result
from cleanup_module?  If so then I should add that we don't just
have varying requirements for cleanup style between modules, but
other problems, such as single modules that support multiple
services, which are common in the pcmcia world.

-- 
Daniel
