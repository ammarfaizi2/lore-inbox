Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267360AbSIRRZI>; Wed, 18 Sep 2002 13:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267508AbSIRRZI>; Wed, 18 Sep 2002 13:25:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9747 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267360AbSIRRZH>; Wed, 18 Sep 2002 13:25:07 -0400
Date: Wed, 18 Sep 2002 10:30:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209181902000.23619-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209181026550.1230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Ingo Molnar wrote:
> 
> it is a problem still. We can create/destroy 2 billion threads:
> 
>    venus:~> ./p3 -s 2000000 -t 10 -r 0 -T --sync-join
>    Runtime: 19.889182138 seconds
> 
> in roughly 5 hours, on bog-standard 2-CPU x86 hardware.

Again, you're talking about entirely theoretical numbers that have no 
relevance for real life. 

Sure, you can do that. But a real life box? Nope.

>						 Or in 1.25 hours
> on an 8-way box. And then we are back to step #1: trying to pass over
> already allocated PIDs by destroying the contents of the L1 and L2 cache
> once for each allocated PID passed.

So? It happens very rarely, and..

>			 Sure, with 2 billion PIDs space that
> averages out, but it's an algorithm with a very nasty worst-case behavior,
> which is not so hard to trigger.

... the worst-case-behaviour is basically impossible to trigger with any 
real load. 

The worst case does not happen for "100k threads" like you've made it 
sound like.

The worst case happens for "100k threads consecutive in the pid space".

Which means that not only do you have to roll over, you have to roll over 
with a humungous number of threads _still_ occupying their old consecutive 
positions when you roll over.

I repeat: you're making up schenarios that simply have no relevance to 
real life.

		Linus

