Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUCPQvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbUCPQt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:49:26 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:35846 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263127AbUCPQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:40:25 -0500
Message-ID: <4057318D.9090901@techsource.com>
Date: Tue, 16 Mar 2004 11:55:41 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: Process priority fed back to parent?
References: <40571A62.8050204@techsource.com> <20040316154611.GA31510@mulix.org> <40572922.10109@techsource.com> <20040316160246.GL28008@mulix.org>
In-Reply-To: <20040316160246.GL28008@mulix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Muli Ben-Yehuda wrote:
> On Tue, Mar 16, 2004 at 11:19:46AM -0500, Timothy Miller wrote:
> 
> 
>>Unfortunately, the OS has to play babysitter to processes, because 
>>they're guaranteed to misbehave.  Preemption exists to ensure fairness 
>>amongst processes.  Thus, while you're right that it would be nice to 
>>have processes report their CPU requirements, if we were to actually DO 
>>that, it would be a disaster.
> 
> 
> I agree we should do the best thing possible without any prior
> knowledge of what a process should do. I don't agree we should add
> pointless complexity to the scheduler for dubious gains (getting rid
> of the very short ramp up time). Of course, if you think it's useful,
> feel free to implement it and let's resume the discussion when we have
> some numbers. 


If shortening ramp-up times is the only benefit, then it's not worth the 
effort.  The objective is continuity and over-all feel of the system.

With Nick's and Con's schedulers, if you have a set of processes that 
are running continuously, then after a brief period, everything has 
settled into its ideal state.  The interactive processes are 
interactive, the CPU-bound ones are penalized, etc.

But real systems aren't like this.  Processes are launched and killed 
constantly.  Consider what a shell script does!  To have program 
behavior from one time affect how the program is run at a later time 
would allow system behavior to be smooth over many launch/kill cycles.


And having parent processes (eg. shell) maintain information on child 
behavior would also help, because then a shell script would behave more 
like a single program than many independent programs.  Compiles would 
affect the system less because 'make' would maintain information on 
compiler behavior, making the impact of compiler launches much less 
negative.

In FACT, that I think I may be on to something here... Hmmm.  So far, 
process schedulers have been trying to BOOST priority of interactive 
processes.  That's great.  But maybe an even BIGGER problem is that 
every time gcc (and cc1) is launched during a kernel compile, it's given 
too high of a priority, and by the time the priority is corrected, the 
compile has finished for that .c file.

This sounds SO familiar... I know this has been discussed before by 
people much smarter about this than I.

