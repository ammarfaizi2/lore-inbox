Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132316AbRCaGVs>; Sat, 31 Mar 2001 01:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRCaGVh>; Sat, 31 Mar 2001 01:21:37 -0500
Received: from [209.125.249.111] ([209.125.249.111]:52078 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S132316AbRCaGVZ>; Sat, 31 Mar 2001 01:21:25 -0500
Date: Fri, 30 Mar 2001 22:19:38 -0800
Message-Id: <200103310619.f2V6JcK02699@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: kapm-idled using 45% CPU (why not 100%?) 
In-Reply-To: <200103310544.f2V5icO07172@pcug.org.au>
In-Reply-To: <20010331033504.A7022@pcep-jamie.cern.ch>
	<200103310544.f2V5icO07172@pcug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell writes:
> Hi Jamie,
> 
> Jamie Lokier <lk@tantalophile.demon.co.uk> writes:
> > Subject says it all.  On my laptop which is running 2.4.0, while the
> > machine is completely idle "top" reports kapm-idled as usin about 45% of
> > the CPU.  The remaining 55% is reported as idle time.
> 
> This is normal behaviour ... the current implementation of kapm-idled
> means that it is sleeping some of the time, so the real idle process
> actually gets some time.  I did a patch a while ago the got the kapm-idled
> up to about 93-95%, but I didn;t think i was all that important.
> 
> > When the machine gets a little more active, the CPU time attributed to
> > kapm-idled decreases while the 55% idle time increases to 85%!
> 
> Again this is normal (although it may not seem sensible).
> 
> > This is not caused be "top": I get the same 45% from "ps -l 3".
> > 
> > I remember when kapmd was reporting 100%.  Is the new behaviour
> > intentional, and is it saving the maximum power on the laptop?
> 
> I have NEVER seen kapmd getting 100%.  You are probably getting
> about as good power saving as you will get (unfortunately) although
> don't hold me to that - I have heard of some laptops that get better
> power savings when CONFIG_APM_CPU_IDLE was NOT set ...

The Cyrix chips have an extremely low power mode: they stop the clock
on halt. They use microwatts in this mode (you need to frob a register
to enable this). On an idle machine, these chips don't need a heatsink
and still run cool.

If you enable APM on these machines, the CPU runs hot even though it's
idling. That's because the clock is still running. Slower, yes. But
there's a big difference between slowing down the clock a few times,
or stopping it entirely.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
