Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131753AbRBQONg>; Sat, 17 Feb 2001 09:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131743AbRBQON1>; Sat, 17 Feb 2001 09:13:27 -0500
Received: from colorfullife.com ([216.156.138.34]:13585 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131753AbRBQONV>;
	Sat, 17 Feb 2001 09:13:21 -0500
Message-ID: <3A8E8719.DD58EB7C@colorfullife.com>
Date: Sat, 17 Feb 2001 15:13:45 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Thomas Widmann <thomas.widmann@icn.siemens.de>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP: bind process to cpu
In-Reply-To: <200102171327.OAA00342@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> In article <BGEDIODHBENLENEMBEPAEEDFCAAA.thomas.widmann@icn.siemens.de> you wrote:
> > Hi,
> >
> > I run an 3*XEON 550MHz Primergy with 2GB of RAM.
> > On this machine, i have compiled kernel 2.4.0SMP.
> >
> > Is it possible to bind a process to a specific
> > cpu on this SMP machine (process affinity) ?
> 
> Linux 2.4 is mostlu ready for process affinity, but it is not (yet)
> exported to userspace.  I've attached at patch by Nick Pollitt from SGI
> that allows to enable process pinning using prctl().
> 
> > I there something like pset ?
> 
> I've seen patches for SGI-like psets for 2.2.<something>, but not for 2.4.
>
>         Christoph
>
You must also update wake_process_synchroneous(), otherwise you can get
lost wakeups with pipes.

Something like

>         if (!(p->cpus_allowed & (1 << smp_processor_id()))
>                 reschedule_idle(p);

must be added after add_to_runqueue().

Ingo Molnar did some testing with tux2, and under high load wakeups were
lost without such a patch.

--
	Manfred
