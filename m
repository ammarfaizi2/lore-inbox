Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSHISP1>; Fri, 9 Aug 2002 14:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSHISP1>; Fri, 9 Aug 2002 14:15:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15020 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315278AbSHISP0>; Fri, 9 Aug 2002 14:15:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Analysis for Linux-2.5 fix/improve get_pid(), comparing various approaches
Date: Fri, 9 Aug 2002 14:18:07 -0400
User-Agent: KMail/1.4.1
Cc: Andrew Morton <akpm@zip.com.au>, Andries Brouwer <aebr@win.tue.nl>,
       Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       <andrea@suse.de>, <gh@us.ibm.com>
References: <Pine.LNX.4.44.0208090901090.1547-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208090901090.1547-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208091418.07676.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 12:05 pm, Linus Torvalds wrote:
> On Fri, 9 Aug 2002, Hubertus Franke wrote:
> > I dragged the various algorithms into a userlevel test program to figure
> > out where the cut off points are with PID_MAX=32768. In this testprogram
> > I maintain A tasks, and for 10 rounds (delete D random tasks and
> > reallocate D tasks again) resulting in T=10*D total measured allocations.
>
> Mind re-doing that with PID_MAX=999999 or similar? The whole point of the
> current simple algorithm is that the common case (nay, done right, the
> _only_ case) is where the number of threads << PID_MAX.
>

Don't have time right now...
Simply look at the numbers for the ratio you are expected.
I would be very surprise if the relative curves would change
when moving to 132K tasks and also populate the pid space only by
let's say 25%.

Otherwise, Paul can you run this....

> That certainly used to be true with PID_MAX=32768 (not many people may
> realize it, but in 1991 the maximum number of tasks in the system was
> limited to 63, simply because of how the VM carved out the 4GB address
> space).
>
> Things have changed, but considering that some people think that 32k
> threads are a limitation already, and that the current code should work
> fine (and be pretty much optimal) with a larger PID_MAX, I really think
> it's unfair to not even benchmark that case..
>
> 		Linus

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
