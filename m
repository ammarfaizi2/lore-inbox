Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTIMShh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTIMShh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:37:37 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:8719 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261602AbTIMSh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:37:28 -0400
Date: Sat, 13 Sep 2003 19:35:29 +0100
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913183529.GP1191@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
References: <20030913125103.GE27368@fs.tum.de> <20030913161149.GA1750@redhat.com> <20030913164146.GI27368@fs.tum.de> <20030913172130.GO1191@redhat.com> <20030913182212.GK27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913182212.GK27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 08:22:12PM +0200, Adrian Bunk wrote:

 > What does a user think on which machines a kernel will run after he 
 > enabled the following options?
 >   - "Athlon/Duron/K7"
 >   - "Generic x86 support"

Currently, as you can only choose one of them, it should be obvious.
With your 'you can choose n number of options' patch, it becomes
confusing why there is a generic option at all.

 > >  > If you read the description of X86_GENERIC it implicitely says a kernel 
 > >  > for a 386 isn't generic.
 > > Apart from using incorrect cache line alignments on P4, an i386 kernel
 > > is no more, no less generic than one compiled with X86_GENERIC
 > plus X86_INTEL_USERCOPY

Sure, but that still doesn't prevent it being used on any system as
a generic kernel.

 > > Incidentally, looking closer you broke this option.
 > > 
 > > +ifdef CONFIG_CPU_VIAC3_2
 > > +  cpuflags-y  := $(call check_gcc,-march=c3,-march=i686)
 > > +endif
 > > 
 > > Its C3_2 becauase it needs -march=c3-2 to use SSE instead of 3dnow
 > > prefetches.  One thing that just occured to me, it may be possible
 > >...
 > 
 > Which gcc does support -march=c3-2 ? gcc 3.3.1 doesn't support it.

the 3.3.2 and 3.4 branches have it.

 > > And "You can select 486/586/686 too" is not an answer. These kernels
 > > need to be small, and errata workarounds should NEVER be compiled out
 > > for exactly this reason.
 > >...
 > Why is a kernel compiled with support for all CPUs necessarily much
 > bigger than a current M386 kernel?

Adding in stuff like cpu specific memory copy routines for example.
There have been several cases where vendors haven't been able to squeeze a
boot kernel onto a CD by 40 or so bytes in the past, leading to a last
minute scavenge to try and reclaim that space. Every little helps.

 > OTOH, why waste space on a 486 for 3DNow! support?

I'm arguing for errata workarounds, not extended support.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
