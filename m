Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSI2JN5>; Sun, 29 Sep 2002 05:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbSI2JN5>; Sun, 29 Sep 2002 05:13:57 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:56224 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262425AbSI2JNz>; Sun, 29 Sep 2002 05:13:55 -0400
Date: Sun, 29 Sep 2002 11:16:03 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Gerald Britton <gbritton@alum.mit.edu>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020929111603.F1250@brodo.de>
References: <20020928112503.E1217@brodo.de> <20020928134457.A14784@brodo.de> <20020928134739.A11797@light-brigade.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020928134739.A11797@light-brigade.mit.edu>; from gbritton@alum.mit.edu on Sat, Sep 28, 2002 at 01:47:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 01:47:39PM -0400, Gerald Britton wrote:
> > -		if (!speedstep_low_freq || !speedstep_high_freq || 
> > +		if (!low || !high || 
> >  		    (speedstep_low_freq == speedstep_high_freq))
> >  			return -EIO;
> 
> This is still obviously broken.
> 
> First time through the loop, high and low are 0, one of the two of them gets
> set and the other is still 0.  This !low || !high test is still within the loop
> so it will drop out with -EIO.
Oh, thanks for pointing this out. I'll fix it for the next realease. 

>  I'd been using cpufreq under 2.4 for a while
> and with the recent updates (profile api), speedstep hasn't started up because
> of this, or because it was sending bad data into the notifier chains.  Your
> patch here passes bogus data into the notifier chains, which could be bad imho.
Well, so far the only x86 notifier is the one in arch/i386/kernel/time.c.
But yes, you're right, it's bad; and so I'll add a workaround for this, too. 
 
> If I fix the init by moving the !low || !high test below the loop, and prevent
> bad data from being passed into the notifier chains, I start getting memory
> corruption being detected by slab poisioning.
Any idea why this is happening??? The only dynamically allocated struct is
struct cpfureq_driver driver; and it is only kfree'd in speedstep_exit... 

> /* Disable IRQs */
> local_irq_save(flags);
> local_irq_disable();
>   . . .
> /* Enable IRQs */
> local_irq_enable();
> local_irq_restore(flags);

Thanks. Fixed.
BTW, unfortunately I can't test speedstep.c locally - my notebook has the
old 440?X ISSCL speedstep interface which is undocumented. So I'm really
glad whenever others test speedstep.c. Many thanks,

	Dominik
