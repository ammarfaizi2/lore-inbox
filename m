Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVEIU1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVEIU1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 16:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVEIU1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 16:27:19 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:43919 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261510AbVEIU1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 16:27:13 -0400
Date: Mon, 9 May 2005 16:26:37 -0400
To: Chris Friesen <cfriesen@nortel.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       Jim Nance <jlnance@sdf.lonestar.org>, Dave Jones <davej@redhat.com>,
       Willy Tarreau <willy@w.ods.org>, Andrew Morton <akpm@osdl.org>,
       Ricky Beam <jfbeam@bluetronic.net>, nico-kernel@schottelius.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050509202637.GF2297@csclub.uwaterloo.ca>
References: <20050508012521.GA24268@SDF.LONESTAR.ORG> <427FA876.7000401@tmr.com> <427FC366.1000506@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427FC366.1000506@nortel.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 02:09:10PM -0600, Chris Friesen wrote:
> Bill Davidsen wrote:
> 
> >Might I suggest that if you like the "we know best just trust us" 
> >approach, there is another OS to use. Making information available to 
> >good applications will improve system performance, or at least allow 
> >better limitation of requests for resources
> 
> What will you do with the information?  The kernel is doing all the 
> resource allocation and scheduling.
> 
> From a higher-level, the application wants the best performance. 
> Doesn't it make more sense to have an API that lets you query things 
> like: how many cores do I have, how many separate memory interfaces do I 
> have, how many cores handle interrupts, etc.
> 
> Based on that information you tell the system: "I've got 4 processes, 
> please put them all on cores with separate memory connectivity since 
> they're all memory-intensive. Now please put these other two threads on 
> the same cpu since they share memory but serialize each other by design."
> 
> The app shouldn't care about the details of architecture, but it should 
> be able to work with the system to give the best performance.

What if the process is able to split itself into say 4 or 8 or 16
threads, but if you only have the hardware to run 2 threads you migth
get less context switch overhead running less threads at a time, while
if you have 16 cpus available, running 4 threads will not be the fastest
way to get the job done.  Being able to "optimally" configure the
program on the fly might be handy (although a config setting of the
optimal config on the particular machine would do the same thing).

Now on the other hand if the process could tell that there were 8 cpu
cores and decided to run 8 threads, but the admin was running another
program already that was using 4 cores, then auto detecting the core
count and starting 8 threads might still be inefficient, and 4 would
have been optimal.

I think make has the right idea.  Let the user and/or admin decide how
to allocate the resources.  If they don't know what they are doing, well
who does.  As long as the user can tell what their machine is they
should be able to decide how many threads to start in a given program.
/proc/cpuinfo as it is currently, is not too bad for that task. 

Adding an option or config setting to the program where the user can
tell it how many threads to run seems like the right solution, while if
the program is simpler to write as 2 threads running at the same time
with no obvious overhead from doing it that way, then run it as 2 threads
even if you only have 1 cpu core to run it.  Context switches are hardly
that expensive on a modern machine.

Len Sorensen
