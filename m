Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSEOXLm>; Wed, 15 May 2002 19:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316520AbSEOXLl>; Wed, 15 May 2002 19:11:41 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:32273 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316519AbSEOXLl>; Wed, 15 May 2002 19:11:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH] Hotplug CPU prep V: x86 non-linear CPU numbers 
In-Reply-To: Your message of "Wed, 15 May 2002 12:13:14 +0200."
             <20020515101314.GA1152@elf.ucw.cz> 
Date: Thu, 16 May 2002 09:14:47 +1000
Message-Id: <E1787yp-0000RO-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020515101314.GA1152@elf.ucw.cz> you write:
> > @@ -1585,7 +1581,7 @@
> >  
> >  	p = buf;
> >  
> > -	if ((smp_num_cpus == 1) &&
> > +	if ((num_online_cpus() == 1) &&
> >  	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
> >  		ac_line_status = (bx >> 8) & 0xff;
> >  		battery_status = bx & 0xff;
> 
> Are you sure? What if you add another CPU just after the test?

APM is special: what it *really* wants to know is if only CPU 0 is
online (this test will almost certainly fail miserably if the single
online CPU is CPU 1, which previously wasn't possible).

I'll check with the APM maintainer what guarantees he needs: we may
actually need to grab to cpu control lock here.  Anyway apparently I
broke something else in APM.

(BTW, in general, we use magic to avoid locks around num_online_cpus()
et al: we make changes then wait for everyone to voluntarily schedule
before exposing it).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
