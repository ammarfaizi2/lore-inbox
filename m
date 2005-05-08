Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVEHDuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVEHDuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 23:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVEHDuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 23:50:21 -0400
Received: from ozlabs.org ([203.10.76.45]:65003 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262804AbVEHDuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 23:50:13 -0400
Subject: Re: [RFC] (How to) Let idle CPUs sleep
From: Rusty Russell <rusty@rustcorp.com.au>
To: vatsa@in.ibm.com
Cc: schwidefsky@de.ibm.com, jdike@addtoit.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <20050507182728.GA29592@in.ibm.com>
References: <20050507182728.GA29592@in.ibm.com>
Content-Type: text/plain
Date: Sun, 08 May 2005 13:50:10 +1000
Message-Id: <1115524211.17482.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-07 at 23:57 +0530, Srivatsa Vaddagiri wrote:
> Two solutions have been proposed so far:
> 
> 	A. As per Nick's suggestion, impose a max limit (say some 100 ms or
> 	   say a second, Nick?) on how long a idle CPU can avoid taking
> 	   local-timer ticks. As a result, the load imbalance could exist only
> 	   for this max duration, after which the sleeping CPU will wake up
> 	   and balance itself. If there is no imbalance, it can go and sleep
> 	   again for the max duration.
> 
>  	   For ex, lets say a idle CPU found that it doesn't have any near timer
> 	   for the next 1 minute. Instead of letting it sleep for 1 minute in
> 	   a single stretch, we let it sleep in bursts of 100 msec (or whatever
> 	   is the max. duration chosen). This still is better than having
> 	   the idle CPU take HZ ticks a second.
> 
> 	   As a special case, when all the CPUs of an image go idle, we
> 	   could consider completely shutting off local timer ticks
> 	   across all CPUs (till the next non-timer interrupt).
> 
> 
> 	B. Don't impose any max limit on how long a idle CPU can sleep.
> 	   Here we let the idle CPU sleep as long as it wants. It is
> 	   woken up by a "busy" CPU when it detects an imbalance. The
> 	   busy CPU acts as a watchdog here. If there are no such
> 	   busy CPUs, then it means that nobody will acts as watchdogs
> 	   and idle CPUs sleep as long as they want. A possible watchdog
> 	   implementation has been discussed at:
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=111287808905764&w=2

My preference would be the second: fix the scheduler so it doesn't rely
on regular polling.  However, as long as the UP case runs with no timer
interrupts when idle, many people will be happy (eg. most embedded).

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

