Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbTBHDbx>; Fri, 7 Feb 2003 22:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTBHDbx>; Fri, 7 Feb 2003 22:31:53 -0500
Received: from ns.suse.de ([213.95.15.193]:13576 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266967AbTBHDbx>;
	Fri, 7 Feb 2003 22:31:53 -0500
Date: Sat, 8 Feb 2003 04:41:32 +0100
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
Message-ID: <20030208034132.GA4257@wotan.suse.de>
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel> <p73ptq3bxh6.fsf@oldwotan.suse.de> <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com> <20030208001844.GA20849@wotan.suse.de> <1044665441.18670.106.camel@w-jstultz2.beaverton.ibm.com> <20030208015235.GA25432@wotan.suse.de> <1044670483.21642.18.camel@w-jstultz2.beaverton.ibm.com> <20030208022908.GA29776@wotan.suse.de> <1044672141.21642.30.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044672141.21642.30.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 06:42:21PM -0800, john stultz wrote:
> > of applications who just need an increasing time stamp in user space,
> > and who do not want to fight ntpd for this. One example for such 
> > an application is the X server who needs this for its internal 
> > event sequencing.
> > 
> > Implementing it based on the current time infrastructure is very easy -
> > you just do not add xtime and wall jiffies in, but only jiffies.
> 
> Actually, we can't do this, because if interrupts are being blocked
> jiffies won't change. That is why I'm trying to provide hardware clock
> access to hangcheck. It just so happened it was using get_cycles() as an
> interface and it seemed appropriate for moving to timer_ops.

monotonic clock can use the hw clock too. It just shouldn't use anything 
manipulated by settimeofday() et.al.

> 
> > I don't think doing any special hacks and complicating get_cycles()
> > for it is the right way. Just implement a new monotonic clock primitive
> > (and eventually export it to user space too) 
> 
> Ok, so you're telling me to use another interface. I'm down with that
> (sometimes I just need it spelled out). Name suggestions? 
> read_hw_timer?

monotonic_clock() 

-Andi

