Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbTIMVwr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 17:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTIMVwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 17:52:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50173 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262220AbTIMVwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 17:52:45 -0400
Date: Sat, 13 Sep 2003 23:52:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913215236.GL27368@fs.tum.de>
References: <20030913125103.GE27368@fs.tum.de> <20030913161149.GA1750@redhat.com> <20030913164146.GI27368@fs.tum.de> <20030913172130.GO1191@redhat.com> <20030913182212.GK27368@fs.tum.de> <20030913183529.GP1191@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913183529.GP1191@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 07:35:29PM +0100, Dave Jones wrote:
> On Sat, Sep 13, 2003 at 08:22:12PM +0200, Adrian Bunk wrote:
> 
>  > What does a user think on which machines a kernel will run after he 
>  > enabled the following options?
>  >   - "Athlon/Duron/K7"
>  >   - "Generic x86 support"
> 
> Currently, as you can only choose one of them, it should be obvious.
> With your 'you can choose n number of options' patch, it becomes
> confusing why there is a generic option at all.

No, currently you first choose the CPU. This CPU selection selects most 
settings like the CPU features (e.g. enables X86_F00F_BUG) and the gcc 
optimization flags.

The "Generic x86 support" question is asked later.

My patch removes the generic option since it's no longer needed.

>...
>  > > Incidentally, looking closer you broke this option.
>  > > 
>  > > +ifdef CONFIG_CPU_VIAC3_2
>  > > +  cpuflags-y  := $(call check_gcc,-march=c3,-march=i686)
>  > > +endif
>  > > 
>  > > Its C3_2 becauase it needs -march=c3-2 to use SSE instead of 3dnow
>  > > prefetches.  One thing that just occured to me, it may be possible
>  > >...
>  > 
>  > Which gcc does support -march=c3-2 ? gcc 3.3.1 doesn't support it.
> 
> the 3.3.2 and 3.4 branches have it.

Ah I didn't know that. The 20030831 snapshot of the 3.3 branch in Debian 
unstable was the latest gcc I checked.

>  > > And "You can select 486/586/686 too" is not an answer. These kernels
>  > > need to be small, and errata workarounds should NEVER be compiled out
>  > > for exactly this reason.
>  > >...
>  > Why is a kernel compiled with support for all CPUs necessarily much
>  > bigger than a current M386 kernel?
> 
> Adding in stuff like cpu specific memory copy routines for example.
> There have been several cases where vendors haven't been able to squeeze a
> boot kernel onto a CD by 40 or so bytes in the past, leading to a last
> minute scavenge to try and reclaim that space. Every little helps.
> 
>  > OTOH, why waste space on a 486 for 3DNow! support?
> 
> I'm arguing for errata workarounds, not extended support.

I'll send the cpu selection patch with the arch/i386/kernel/cpu/ and 
arch/i386/kernel/cpu/mtrr/ stuff as separate patches.

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

