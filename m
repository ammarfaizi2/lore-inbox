Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277369AbRJENBj>; Fri, 5 Oct 2001 09:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277370AbRJENBa>; Fri, 5 Oct 2001 09:01:30 -0400
Received: from ns.suse.de ([213.95.15.193]:31246 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277369AbRJENBR>;
	Fri, 5 Oct 2001 09:01:17 -0400
Date: Fri, 5 Oct 2001 15:01:44 +0200
From: Andi Kleen <ak@suse.de>
To: Padraig Brady <padraig@antefacto.com>
Cc: Andi Kleen <ak@suse.de>, Alex Larsson <alexl@redhat.com>,
        Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
Message-ID: <20011005150144.A11810@gruyere.muc.suse.de>
In-Reply-To: <m3r8slywp0.fsf@myware.mynet> <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com> <20011003232609.A11804@gruyere.muc.suse.de> <3BBDAB24.7000909@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BBDAB24.7000909@antefacto.com>; from padraig@antefacto.com on Fri, Oct 05, 2001 at 01:44:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 01:44:20PM +0100, Padraig Brady wrote:
> Andi Kleen wrote:
> 
> >On Wed, Oct 03, 2001 at 11:15:04AM -0400, Alex Larsson wrote:
> >
> >>Is a nanoseconds field the right choice though? In reality you might not 
> >>have a nanosecond resolution timer, so you would miss changes that appear
> >>on shorter timescale than the timer resolution. Wouldn't a generation 
> >>counter, increased when ctime was updated, be a better solution?
> >>
> >
> >Near any CPU has a cycle counter builtin now, which gives you ns like
> >resolution. In theory you could still get collisions on MP systems, 
> >but window is small enough that it can be ignored in practice.
> >
> >-Andi
> >
> But the point is you, only ever would want nano second resolution to make
> sure you notice all changes to a file. A more general (and much simpler)
> solution would be to gen_count++ every time a file's modified. What other
> applications would require better than second resolution on files?

The main advantage of using a real timestamp instead of a generation
counter is that we would be compatible to Unixware/Solaris/... Their
API is fine, so I see no advantage in inventing a new incompatible one.

Another advantage of using the real time instead of a counter is that 
you can easily merge the both values into a single 64bit value and do
arithmetic on it in user space. With a generation counter you would need 
to work with number pairs, which is much more complex. 
[or alternatively reset the generation counter every second in the kernel
to get a flat time range again, 
which would be racy and ugly and complicated in the kernel because it 
would need additional timestamps] 

Also a rdtsc/get_timestamp or in the worst case a jiffie read is really
not complex to code in kernel, what makes you think it is? 

-Andi
