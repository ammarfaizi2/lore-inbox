Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSHIQAY>; Fri, 9 Aug 2002 12:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSHIQAY>; Fri, 9 Aug 2002 12:00:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8717 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314149AbSHIQAX>; Fri, 9 Aug 2002 12:00:23 -0400
Date: Fri, 9 Aug 2002 09:05:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Andrew Morton <akpm@zip.com.au>, Andries Brouwer <aebr@win.tue.nl>,
       Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       <andrea@suse.de>, <gh@us.ibm.com>
Subject: Re: Analysis for Linux-2.5 fix/improve get_pid(), comparing various
 approaches
In-Reply-To: <200208090722.08223.frankeh@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0208090901090.1547-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Aug 2002, Hubertus Franke wrote:
> 
> I dragged the various algorithms into a userlevel test program to figure
> out where the cut off points are with PID_MAX=32768. In this testprogram
> I maintain A tasks, and for 10 rounds (delete D random tasks and 
> reallocate D tasks again) resulting in T=10*D total measured allocations.

Mind re-doing that with PID_MAX=999999 or similar? The whole point of the
current simple algorithm is that the common case (nay, done right, the
_only_ case) is where the number of threads << PID_MAX.

That certainly used to be true with PID_MAX=32768 (not many people may
realize it, but in 1991 the maximum number of tasks in the system was
limited to 63, simply because of how the VM carved out the 4GB address
space).

Things have changed, but considering that some people think that 32k
threads are a limitation already, and that the current code should work
fine (and be pretty much optimal) with a larger PID_MAX, I really think 
it's unfair to not even benchmark that case..

		Linus

