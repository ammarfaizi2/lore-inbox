Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVEJTR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVEJTR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVEJTR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:17:26 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:15007 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261749AbVEJTQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:16:56 -0400
Message-ID: <4280E27F.8040808@tmr.com>
Date: Tue, 10 May 2005 12:34:07 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Nance <jlnance@sdf.lonestar.org>
CC: Dave Jones <davej@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <20050508012521.GA24268@SDF.LONESTAR.ORG> <427FA876.7000401@tmr.com> <20050510022301.GA13763@SDF.LONESTAR.ORG>
In-Reply-To: <20050510022301.GA13763@SDF.LONESTAR.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Nance wrote:
> Good Afternoon Bill,
> 
> Thanks for the input.  Let me make a couple of comments.
> 
> On Mon, May 09, 2005 at 02:14:14PM -0400, Bill Davidsen wrote:
> 
> 
>>Might I suggest that if you like the "we know best just trust us" 
>>approach, there is another OS to use. Making information available to 
>>good applications will improve system performance, or at least allow 
>>better limitation of requests for resources, and bad applications will 
>>be bad regardless of what you hide. You don't hide the CPU hardware any 
>>more than the memory size.
> 
> 
> You could use a similar argument for cooperative rather than
> preemptive multitasking.  It might even be a valid argument,
> assuming you controlled all the processes running on the system.
> But it didn't work very well in practice.
> 
> I see two problems with encouraging applications to get involved
> with processor selection.
> 
> The first is they don't have enough information to get it right.

The application doesn't have to get it "right" however you define that, 
but unless you expect to extend the API to add a 
signal(STARTMORETHREADS) it makes sense for the application to have some 
idea what the hardware config is, because the kernel doesn't know what 
the application is going to do (future) vs. what it already did (past).

Running a number of threads somewhat close to the number of CPUs, or 
sockets, or something else the application can know is far better than 
starting 64 threads in case this is a big NUMA machine, or running 
single thread while seven of eight CPUs do nothing.

By looking at Ncpu and ldavg a smart application can avoid being really 
wrong, which gives the kernel a better chance of improving throughput.

> There are going to be other processes running on the machine.
> The optimal set of processors to run on is going to depend on
> what else is running and what it is doing at that instant.  This
> isn't information a usermode process has good access to.  Say I
> have an application that wants to bind its 2 threads to the two
> processors on a single SMT chip.  Now say I run two of these
> applications on a machine with 2 SMT chips on it.  What keeps
> both of them from binding themselves to the same chip?  Should
> it be the applications responsibility to look through the process
> table and see what other applicatioins are bound to what processors?
> What prevents races if they do?

If the application can choose a sane number of threads, that makes the 
problem of memory management and CPU scheduling easier. Just because the 
application can't do a perfect job doesn't mean that it should do 
without information needed to do something reasonable.

Perfect is the enemy of better.

