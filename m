Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262673AbTCIXyy>; Sun, 9 Mar 2003 18:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262674AbTCIXyy>; Sun, 9 Mar 2003 18:54:54 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:22375
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262673AbTCIXyx>; Sun, 9 Mar 2003 18:54:53 -0500
Date: Sun, 9 Mar 2003 19:03:01 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Robert Love <rml@tech9.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] small fixes in brlock.h
In-Reply-To: <1047254400.680.10.camel@phantasy.awol.org>
Message-ID: <Pine.LNX.4.50.0303091901370.1464-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303091843250.1464-100000@montezuma.mastecende.com>
 <1047254400.680.10.camel@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003, Robert Love wrote:

> On Sun, 2003-03-09 at 18:44, Zwane Mwaikambo wrote:
> 
> > --- linux-2.5.64-unwashed/include/linux/brlock.h	5 Mar 2003 05:07:54 -0000	1.1.1.1
> > +++ linux-2.5.64-unwashed/include/linux/brlock.h	9 Mar 2003 23:42:26 -0000
> > @@ -85,8 +85,7 @@
> >  	if (idx >= __BR_END)
> >  		__br_lock_usage_bug();
> >  
> > -	preempt_disable();
> > -	_raw_read_lock(&__brlock_array[smp_processor_id()][idx]);
> > +	read_lock(&__brlock_array[smp_processor_id()][idx]);
> >  }
> 
> This is wrong.

I was waiting for this ;)

> We have to disable preemption prior to reading smp_processor_id(). 
> Otherwise we may lock/unlock the wrong processor's brlock.  The above as
> you changed it is equivalent to:
> 
> 	cpu = smp_processor_id();
> 	/* do not want to preempt here, but we can! */
> 	preempt_disable();
> 	_raw_read_lock(&__brlock_array[cpu][idx]);

How are we able to preempt there? Timer tick?

Thanks,
	Zwane
-- 
function.linuxpower.ca
