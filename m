Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbSKOTVy>; Fri, 15 Nov 2002 14:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSKOTVy>; Fri, 15 Nov 2002 14:21:54 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:24071 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S266408AbSKOTVx>; Fri, 15 Nov 2002 14:21:53 -0500
Date: Fri, 15 Nov 2002 19:28:42 +0000
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: "'Zwane Mwaikambo'" <zwane@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
Message-ID: <20021115192842.GC83229@compsoc.man.ac.uk>
References: <3DD47858.3060404@mvista.com> <20021115051207.GA29779@compsoc.man.ac.uk> <3DD5011F.9010409@mvista.com> <20021115174833.GB83229@compsoc.man.ac.uk> <3DD5444E.9070808@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD5444E.9070808@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18Cm8x-000PcJ-00*RN3USPa9qqw* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc trimmed]

On Fri, Nov 15, 2002 at 01:00:30PM -0600, Corey Minyard wrote:

> If the NMI watchdog doesn't handle an interrupt, it will not re-enable 
> the watchdog (in local APIC mode).  If there is no other source of NMIs, 
> then it will never run.  It will get hit when the timer wraps around, I 
> guess, but that could be a LONG time.

oprofile enabled: source of NMIs, check for apic irqs gets triggered,
all is OK

oprofile disabled: oprofile disable restores the perfctr settings, so
NMI watchdog is as before, all is OK

So this patch actually allows the NMI watchdog to work when oprofile is
running, which it didn't before, which is neat.

> I have attached another patch, this one fixes my stupid bug in 
> dummy_watchdog_reset and also adds code to the NMI watchdog to not 

OK great.

> I have also created a kernel module that loops requesting and releasing 
> the NMI, and counting the number of NMIs that actually get hit by the 
> handler that is installed..  This is on a dual 2.8GHZ Pentium 4 machine 
> with hyperthreading (so 4 processors, sort of).  I have six processes 
> doing the request/release and some other processes eating CPU on each 
> processor.  This has been running for almost three hours, about 
> 10,000,000 NMIs have occurred (around 1000/sec).  Around 4700 NMIs have 
> been caught by the handler, meaning that it was a close race between the 
> removal and the NMI occurring.  So it looks good.

Can you send me the test module so I don't have to bother writing one
myself ?

I'll try to test this weekend

regards
john
