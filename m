Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbTCSC2G>; Tue, 18 Mar 2003 21:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262919AbTCSC2G>; Tue, 18 Mar 2003 21:28:06 -0500
Received: from sark.cc.gatech.edu ([130.207.7.23]:28146 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S262915AbTCSC2B>; Tue, 18 Mar 2003 21:28:01 -0500
Date: Tue, 18 Mar 2003 21:38:55 -0500
From: rm <async@cc.gatech.edu>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] limits on SCHED_FIFO tasks
Message-ID: <20030318213855.E1361@tokyo.cc.gatech.edu>
References: <20030318185135.D1361@tokyo.cc.gatech.edu> <3E77C40D.4090700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E77C40D.4090700@mvista.com>; from george@mvista.com on Tue, Mar 18, 2003 at 05:12:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 05:12:45PM -0800, george anzinger wrote:
> If the issue is regaining control after some RT task goes into a loop, 
> the way this is usually done is to keep a session around with a higher 
> priority.  Using this concept, one might provide tools that, from 
> userland, insure that such a session exists prior to launching the 
> "suspect" code.  I fail to see the need for this sort of code in the 
> kernel.

some of the code out there already uses a watchdog process. there are
a couple of issues with it. 

first, it's difficult to figure out when another process is behaving
badly. and if another process is behaving badly, the only choice you
have is to kill it. secondly, what happens if the watch dog process
dies or the bug is in that process itself? i once accidently killed
the thread serving as the watchdog and then hung the system trying to
bring down the SCHED_FIFO program afterward.

the glib answer is, 'don't do stupid things'. unfortunately, people do
stupid things, and the system shouldn't be vulnerable to them to the
extent possible. it's like saying, 'preemptive multitasking isn't
necessary because cooperative multitasking works fine and offers lower
overhead...just don't run stupid code with bugs in it'.

it seems like this is more easily and more completely solved by
allowing limitations to be placed on what a sched_fifo task can do, in
the same way that the kernel allows you to put limits on users and
programs.

i'm not arguing against other people using SCHED_FIFO to lockup their
boxes, just that there needs to be something in between running as
SCHED_OTHER, and running with absolutely no limits as SCHED_FIFO.

		thanks, 
		 rob

----
Robert Melby
Georgia Institute of Technology, Atlanta Georgia, 30332
uucp:     ...!{decvax,hplabs,ncar,purdue,rutgers}!gatech!prism!gt4255a
Internet: async@cc.gatech.edu

