Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271090AbRHOIcq>; Wed, 15 Aug 2001 04:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271091AbRHOIch>; Wed, 15 Aug 2001 04:32:37 -0400
Received: from leeor.math.technion.ac.il ([132.68.115.2]:8176 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S271090AbRHOIcV>; Wed, 15 Aug 2001 04:32:21 -0400
Date: Wed, 15 Aug 2001 11:31:51 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, mag@fbab.net,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 Resource leaks + limits
Message-ID: <20010815113151.A28444@leeor.math.technion.ac.il>
In-Reply-To: <200108150532.f7F5WGq01653@penguin.transmeta.com> <m3snetq3po.fsf@otr.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <m3snetq3po.fsf@otr.mynet>; from drepper@redhat.com on Tue, Aug 14, 2001 at 10:42:11PM -0700
Hebrew-Date: 26 Av 5761
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001, Ulrich Drepper wrote about "Re: 2.4.8 Resource leaks + limits":
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > However, part of the problem is that because the limits haven't
> > historically existed, there is also no accepted and nice way of
> > setting the limits.
> 
> This should be the least of the problems.  Simply add new RLIMIT_*
> values[1] (and possibly [gs]etrlimit64 syscalls).  The shell's ulimit
> command can easily pick those up.  Non-standard, but every other
> solution will be, too.

I don't see how this would work without confusing users. ulimit currently
fits the model where limits are enforced per process, because each process
can have its own different limits.
If add per-user limits, what do you do if the user has several processes with
different per-user limits? You'll need to have "ulimit" and the likes set a
per-user limit shared by all processes of this user, and the last one
set by any process "wins" and takes effect. But this will not be expected by
the users who expect ulimits to effect only children processes (e.g., now it's
common to lower a limit and fork/exec a program which you want to limit).

So it's doable this way, but the manuals will have to be very clear as to
which limits are inherited how.

-- 
Nadav Har'El                        |       Wednesday, Aug 15 2001, 26 Av 5761
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |I used to work in a pickle factory, until
http://nadav.harel.org.il           |I got canned.
