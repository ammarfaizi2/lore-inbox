Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVJHKMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVJHKMY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 06:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVJHKMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 06:12:24 -0400
Received: from tentacle.b.gz.ru ([217.67.124.4]:31367 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S1750862AbVJHKMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 06:12:24 -0400
Date: Sat, 8 Oct 2005 14:11:53 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, discuss@x86-64.org
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
Message-ID: <20051008101153.GA1541@tentacle.sectorb.msk.ru>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20051007122624.GA23606@tentacle.sectorb.msk.ru> <200510071431.47245.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200510071431.47245.ak@suse.de>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.11-ac7
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 02:31:46PM +0200, Andi Kleen wrote:
> On Friday 07 October 2005 14:26, Vladimir B. Savkin wrote:
> > On Mon, Sep 19, 2005 at 12:16:43PM -0700, john stultz wrote:
> > > Andrew,
> > > 	This patch should resolve the issue seen in bugme bug #5105, where it
> > > is assumed that dualcore x86_64 systems have synced TSCs. This is not
> > > the case, and alternate timesources should be used instead.
> > >
> > > For more details, see:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=5105
> >
> > I too have a box that shows the symptoms from bugzilla entry above.
> > The system is Asus A8V Deluxe MB with
> > "AMD Athlon(tm) 64 X2 Dual Core Processor 3800+".
> >
> > The patch below did not fix the problem, while "idle=poll" did.
> > Hope this helps, dmesg attached.
> 
> Are you running the latest BIOS?

Just upgraded to the lastest BIOS (revision 1014), nothing changed.
Only with "idle=poll" timers run normally.

> 
> > > Please consider for inclusion in your tree.
> > >
> > > thanks
> > > -john
> > >
> > > diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> > > --- a/arch/x86_64/kernel/time.c
> > > +++ b/arch/x86_64/kernel/time.c
> > > @@ -959,9 +959,6 @@ static __init int unsynchronized_tsc(voi
> > >   	   are handled in the OEM check above. */
> > >   	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> > >   		return 0;
> > > - 	/* All in a single socket - should be synchronized */
> > > - 	if (cpus_weight(cpu_core_map[0]) == num_online_cpus())
> > > - 		return 0;
> > >  #endif
> > >   	/* Assume multi socket systems are not synchronized */
> > >   	return num_online_cpus() > 1;
> >
> > ~
~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

