Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbREUB6g>; Sun, 20 May 2001 21:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbREUB6Q>; Sun, 20 May 2001 21:58:16 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:64987 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262324AbREUB6N>; Sun, 20 May 2001 21:58:13 -0400
Message-ID: <3B087525.3C498E9A@uow.edu.au>
Date: Mon, 21 May 2001 11:53:41 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: jacob@chaos2.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 del_timer_sync oops in schedule_timeout
In-Reply-To: <Pine.LNX.4.21.0105191417490.2956-100000@inbetween.blorf.net> <Pine.LNX.4.33.0105201945370.31113-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Sat, 19 May 2001, Jacob Luna Lundberg wrote:
> 
> > This is 2.4.4 with the aic7xxx driver version 6.1.13 dropped in.
> 
> > Unable to handle kernel paging request at virtual address 78626970
> 
> this appears to be some sort of DMA-corruption or other memory scribble
> problem. hexa 78626970 is ASCII "pibx", which shows in the direction of
> some sort of disk-related DMA corruption.

It could be timer-list corruption.  Someone released some memory
which had a live timer in it.  The memory got recycled and then
the timer list traversal fell over it.

There was a convincing report of this a few weeks back on a
system which didn't have any unusual drivers in it.  It was
inconclusive.  That system was SMP, so it could have been a
timer deletion race.

This bug is so damn hard to track down that it may be worth
putting some special walk-the-timer-lists code inside
kfree()+SLAB_POISON.

-
