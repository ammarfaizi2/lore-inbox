Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131239AbRCHAaV>; Wed, 7 Mar 2001 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131240AbRCHAaL>; Wed, 7 Mar 2001 19:30:11 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:27388 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S131239AbRCHAaI>;
	Wed, 7 Mar 2001 19:30:08 -0500
Message-ID: <3AA6A97A.1EDE6A0B@sun.com>
Date: Wed, 07 Mar 2001 16:34:50 -0500
From: ludovic <ludovic.fernandez@sun.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oswald Buddenhagen <ob6@inf.tu-dresden.de>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <20010307184000.A26594@ugly.wh8.tu-dresden.de> <Pine.LNX.4.33.0103071447340.1409-100000@duckman.distro.conectiva> <20010307202027.B27421@ugly.wh8.tu-dresden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oswald Buddenhagen wrote:
> 
> > The problem with these things it that sometimes such a task may hold
> > a lock, which can prevent higher-priority tasks from running.
> >
> true ... three ideas:
> - a sort of temporary priority elevation (the opposite of SCHED_YIELD)
>   as long as the process holds some lock
> - automatically schedule the task, if some higher-priorized task wants
>   the lock
> - preventing the processes from aquiring locks at all (obviously this
>   is not possible for required locks inside the kernel, but i don't
>   know enough about this)
> 
> > A solution would be to make sure that these tasks get at least one
> > time slice every 3 seconds or so, so they can release any locks
> > they might be holding and the system as a whole won't livelock.
> >
> did "these" apply only to the tasks, that actually hold a lock?
> if not, then i don't like this idea, as it gives the processes
> time for the only reason, that it _might_ hold a lock. this basically
> undermines the idea of static classes. in this case, we could actually
> just make the "nice" scale incredibly large and possibly nonlinear,
> as mark suggested.
> 

Since the linux kernel is not preemptive, the problem is a little
bit more complicated; A low priority kernel thread won't lose the 
CPU while holding a lock except if it wants to. That simplifies the
locking problem you mention but the idea of background low priority 
threads that run when the machine is really idle is also not this
simple.

Ludo.
