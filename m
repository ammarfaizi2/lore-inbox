Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTBHCet>; Fri, 7 Feb 2003 21:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbTBHCet>; Fri, 7 Feb 2003 21:34:49 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54422 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266965AbTBHCes>;
	Fri, 7 Feb 2003 21:34:48 -0500
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20030208022908.GA29776@wotan.suse.de>
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
	 <p73ptq3bxh6.fsf@oldwotan.suse.de>
	 <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com>
	 <20030208001844.GA20849@wotan.suse.de>
	 <1044665441.18670.106.camel@w-jstultz2.beaverton.ibm.com>
	 <20030208015235.GA25432@wotan.suse.de>
	 <1044670483.21642.18.camel@w-jstultz2.beaverton.ibm.com>
	 <20030208022908.GA29776@wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1044672141.21642.30.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Feb 2003 18:42:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 18:29, Andi Kleen wrote:
> On Fri, Feb 07, 2003 at 06:14:43PM -0800, john stultz wrote:
> > I'm not sure I understand your resistance to using an alternate clock
> > for get_cycles(). Could you better explain your problem with it?
> 
> I want to keep get_cycles() as a very fast primitive useful for benchmarking
> etc. and the random device. Accessing the southbridge would make it magnitudes 
> slower.

Ok, fair enough. But maybe a comment needs to be added to the get_cycles
to notify folks of the issues that surround it on systems without a
synced TSC?

> Regarding the watchdog: what it basically wants is a POSIX
> CLOCK_MONOTONIC clock. This isn't currently implemented by Linux, 
> but I expect it will be eventually because it's really useful for a lot
> of applications who just need an increasing time stamp in user space,
> and who do not want to fight ntpd for this. One example for such 
> an application is the X server who needs this for its internal 
> event sequencing.
> 
> Implementing it based on the current time infrastructure is very easy -
> you just do not add xtime and wall jiffies in, but only jiffies.

Actually, we can't do this, because if interrupts are being blocked
jiffies won't change. That is why I'm trying to provide hardware clock
access to hangcheck. It just so happened it was using get_cycles() as an
interface and it seemed appropriate for moving to timer_ops.

> I don't think doing any special hacks and complicating get_cycles()
> for it is the right way. Just implement a new monotonic clock primitive
> (and eventually export it to user space too) 

Ok, so you're telling me to use another interface. I'm down with that
(sometimes I just need it spelled out). Name suggestions? 
read_hw_timer?

thanks
-john



