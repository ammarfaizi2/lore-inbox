Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUGYTxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUGYTxO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 15:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUGYTxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 15:53:03 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:33542 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264388AbUGYTw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 15:52:28 -0400
Message-ID: <410415E7.3090001@techsource.com>
Date: Sun, 25 Jul 2004 16:19:51 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another dumb question about  Voluntary Kernel Preemption Patch
References: <20040712163141.31ef1ad6.akpm@osdl.org>	 <1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>	 <200407202011.20558.musical_snake@gmx.de>	 <1090353405.28175.21.camel@mindpipe>  <40FDAF86.10104@gardena.net>	 <1090369957.841.14.camel@mindpipe> <40FDC625.9080804@techsource.com>	 <40FEE26D.7060904@techsource.com> <1090628706.1471.12.camel@mindpipe>
In-Reply-To: <1090628706.1471.12.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lee Revell wrote:
> On Wed, 2004-07-21 at 17:38, Timothy Miller wrote:
> 
>>Lee Revell wrote:
> 
> 
>>>My
>>>understanding is that the kernel is already preemptible anytime that a
>>>spin lock (including the BKL) is not held, and that the voluntary kernel
>>>preemption patch adds some scheduling points in places where it is safe
>>>to sleep, but preemption is disabled because we are holding the BKL, and
>>>that the number of these should approach zero as the kernel is improved
>>>anyway.
>>
>>That's confusing to me.  It was my understanding that the BKL is used to
>>completely lock down the kernel so that no other CPU can have a process
>>get into the kernel... something like how SMP was done under 2.0.
> 
> 
> Yes, I was incorrect.  The vountary kernel preemption patch takes
> sections that are non-preemptible (aka holding a spinlock) and that
> would otherwise run for an unbounded time and adds logic to break out of
> those loops, releasing any locks, in order to allow a higher priority
> process to run.  It is voluntary because even though you are in a
> non-preemptible section you voluntarily release any locks and yield to a
> higher priority process.  It has nothing to do with the BKL as such.
> 

I'm guessing, then, that if you get preempted, then the function call to 
voluntarily preempt returns a value which tells you whether or not you 
got preempted, so that you know whether or not to clean up the results 
of having your locks broken?  (ie. re-lock)

And how does the voluntary-preempt code know which locks to break?  All 
of them?

Thanks.

