Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933179AbWFXBQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933179AbWFXBQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 21:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933182AbWFXBQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 21:16:29 -0400
Received: from mail29.syd.optusnet.com.au ([211.29.132.171]:6607 "EHLO
	mail29.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S933179AbWFXBQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 21:16:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick =?iso-8859-1?q?and=09dynamic_HZ?= -V4
Date: Sat, 24 Jun 2006 11:15:31 +1000
User-Agent: KMail/1.9.3
Cc: Robert Hancock <hancockr@shaw.ca>, tglx@timesys.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
References: <fa.lKfxxA+pCJb5tSZbL1XnnrPzaeQ@ifi.uio.no> <449C8C7E.1040500@shaw.ca> <200606241109.56414.kernel@kolivas.org>
In-Reply-To: <200606241109.56414.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606241115.32042.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 June 2006 11:09, Con Kolivas wrote:
> On Saturday 24 June 2006 10:51, Robert Hancock wrote:
> > Thomas Gleixner wrote:
> > > On Thu, 2006-06-22 at 21:31 -0600, Robert Hancock wrote:
> > >> Thomas Gleixner wrote:
> > >>> An updated patchset is available from:
> > >>>
> > >>> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick4
> > >>>.p atch
> > >>
> > >> On my Compaq Presario X1050 laptop running Fedora Core 5 I get:
> > >>
> > >> Disabling NO_HZ and high resolution timers due to timer broadcasting
> > >>
> > >> Not sure exactly what this is indicating or what's triggered this, but
> > >> I'm assuming the patch isn't doing much on this machine?
> > >
> > > The system is configured for SMP, but this is an UP machine and the
> > > APIC is disabled in the BIOS. Linux uses then the PIT and an IPI
> > > mechanism to broadcast timer events. We need to do the event
> > > reprogramming per CPU, so we switch off in that situation.
> > >
> > > Solution: Either use an UP kernel, or enable Local APIC in the BIOS (is
> > > not possible in most BIOSes), or add "lapic" to the kernel command
> > > line.
> > >
> > > Also for an UP kernel adding "lapic" to the commandline is good, as the
> > > APIC is faster accessible than the PIT.
> >
> > Tried that, still no dice:
> >
> > Kernel command line: ro root=/dev/VolGroup00/LogVol00 lapic
> > Local APIC disabled by BIOS -- reenabling.
> > Found and enabled local APIC!
> >
> > ...
> >
> > Disabling NO_HZ and high resolution timers due to timer broadcasting
> >
> > This isn't a viable solution for all machines anyway - some laptops
> > disable the local APIC and the BIOS expects it to remain that way, and
> > blows up if it gets turned on.
>
> One thing I did discover with my dynticks was that APIC on UP i386 was nigh
> on broken for the most part. Virtually all BIOSs disable it and even if you
> force enable it you may have to play with enable_timer_pin to get it to
> work (sometimes 1, sometimes 0) and there was no pattern to when it would
> be required since the BIOS manufacturer cared not. This is why for UP I
> disabled APIC when dynticks was enabled, and would test for one online cpu
> on SMP and do the same. This obviously isn't a solution when cpu hotplug is
> enabled and only one cpu is online.

That was enable_timer_pin_1 and disable_timer_pin_1 sorry.

-- 
-ck
