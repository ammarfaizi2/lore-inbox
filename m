Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132821AbRDKSoY>; Wed, 11 Apr 2001 14:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132875AbRDKSoO>; Wed, 11 Apr 2001 14:44:14 -0400
Received: from waste.org ([209.173.204.2]:24376 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S132821AbRDKSoE>;
	Wed, 11 Apr 2001 14:44:04 -0400
Date: Wed, 11 Apr 2001 13:43:31 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        <schwidefsky@de.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer !
In-Reply-To: <E14mkGA-000341-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0104111337170.32245-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2001, Alan Cox wrote:

> > > Its worth doing even on the ancient x86 boards with the PIT.
> >
> > Note that programming the PIT is sloooooooow and doing it on every timer
> > add_timer/del_timer would be a pain.
>
> You only have to do it occasionally.
>
> When you add a timer newer than the current one
> 	(arguably newer by at least 1/2*HZ sec)

That's only if we want to do no better than the current system. We'd want
a new variable called timer_margin or something, which would be dependent
on interrupt source and processor, and could be tuned up or down via
sysctl.

> When you finish running the timers at an interval and the new interval is
> significantly larger than the current one.

Make that larger or smaller. If we come out of a quiescent state (1 hz
interrupts, say) and start getting 10ms timers, we want to respond to them
right away.

> Remember each tick we poke the PIT anyway

We could also have a HZ_max tunable above which we would not try to
reprogram the interval. On older systems, this could be set at
100-200HZ...

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

