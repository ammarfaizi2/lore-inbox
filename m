Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131164AbRCGTVG>; Wed, 7 Mar 2001 14:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131165AbRCGTU5>; Wed, 7 Mar 2001 14:20:57 -0500
Received: from mail.inf.tu-dresden.de ([141.76.2.1]:40293 "EHLO
	mail.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S131164AbRCGTUt>; Wed, 7 Mar 2001 14:20:49 -0500
Date: Wed, 7 Mar 2001 20:20:27 +0100
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
Message-ID: <20010307202027.B27421@ugly.wh8.tu-dresden.de>
In-Reply-To: <20010307184000.A26594@ugly.wh8.tu-dresden.de> <Pine.LNX.4.33.0103071447340.1409-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0103071447340.1409-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Mar 07, 2001 at 03:04:00PM -0300
From: Oswald Buddenhagen <ob6@inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem with these things it that sometimes such a task may hold
> a lock, which can prevent higher-priority tasks from running.
> 
true ... three ideas:
- a sort of temporary priority elevation (the opposite of SCHED_YIELD)
  as long as the process holds some lock
- automatically schedule the task, if some higher-priorized task wants
  the lock
- preventing the processes from aquiring locks at all (obviously this
  is not possible for required locks inside the kernel, but i don't
  know enough about this)

> A solution would be to make sure that these tasks get at least one
> time slice every 3 seconds or so, so they can release any locks
> they might be holding and the system as a whole won't livelock.
> 
did "these" apply only to the tasks, that actually hold a lock?
if not, then i don't like this idea, as it gives the processes
time for the only reason, that it _might_ hold a lock. this basically 
undermines the idea of static classes. in this case, we could actually
just make the "nice" scale incredibly large and possibly nonlinear, 
as mark suggested.

best regards

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Nothing is fool-proof to a sufficiently talented fool.
