Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261795AbTCGVhD>; Fri, 7 Mar 2003 16:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261794AbTCGVhD>; Fri, 7 Mar 2003 16:37:03 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:27010 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S261795AbTCGVhB>;
	Fri, 7 Mar 2003 16:37:01 -0500
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1047071156.29990.5.camel@tux.rsn.bth.se>
References: <Pine.LNX.4.44.0303072136590.22681-100000@localhost.localdomain>
	 <1047071156.29990.5.camel@tux.rsn.bth.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047073649.29990.45.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 22:47:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 22:05, Martin Josefsson wrote:

> And sawfish still takes 30 second naps when executing a bunch of
> aumix's.

For information: this is 2.5.64 + sched-2.5.64-B2, no preempt or other
patches.

I changed the command that sawfish executes to only append the current
date to a file and then I made it take a nap again.

I got a file containing 57 lines, one for each time the command was
executed by sawfish.

it took 41 seconds to execute the command 57 times and the machine was
very idle during that time.

According to top sawfish's priority is between 15 and 20 the whole time.
And as I said the machine is very idle during the test.

The command was a very small bashscript:

#!/bin/bash

date >> /tmp/result


So no aumix executed in the script, didn't want another error factor in
the test.

I've reproduced the problem three times and this is what I got:

executions   time
----------   ----
    57        41 seconds
    52        39 seconds
    28        25 seconds


results from the third run

Fri Mar  7 22:31:00 CET 2003
Fri Mar  7 22:31:02 CET 2003
Fri Mar  7 22:31:03 CET 2003
Fri Mar  7 22:31:04 CET 2003
Fri Mar  7 22:31:05 CET 2003
Fri Mar  7 22:31:06 CET 2003
Fri Mar  7 22:31:07 CET 2003
Fri Mar  7 22:31:07 CET 2003
Fri Mar  7 22:31:07 CET 2003
Fri Mar  7 22:31:09 CET 2003
Fri Mar  7 22:31:10 CET 2003
Fri Mar  7 22:31:11 CET 2003
Fri Mar  7 22:31:12 CET 2003
Fri Mar  7 22:31:14 CET 2003
Fri Mar  7 22:31:14 CET 2003
Fri Mar  7 22:31:14 CET 2003
Fri Mar  7 22:31:15 CET 2003
Fri Mar  7 22:31:16 CET 2003
Fri Mar  7 22:31:17 CET 2003
Fri Mar  7 22:31:18 CET 2003
Fri Mar  7 22:31:19 CET 2003
Fri Mar  7 22:31:19 CET 2003
Fri Mar  7 22:31:19 CET 2003
Fri Mar  7 22:31:20 CET 2003
Fri Mar  7 22:31:22 CET 2003
Fri Mar  7 22:31:23 CET 2003
Fri Mar  7 22:31:24 CET 2003
Fri Mar  7 22:31:25 CET 2003

Do you have any clues to what might be happening?

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
