Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135448AbRDXKmj>; Tue, 24 Apr 2001 06:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135528AbRDXKm3>; Tue, 24 Apr 2001 06:42:29 -0400
Received: from granada.iram.es ([150.214.224.100]:63504 "EHLO granada.iram.es")
	by vger.kernel.org with ESMTP id <S135448AbRDXKmW>;
	Tue, 24 Apr 2001 06:42:22 -0400
Date: Tue, 24 Apr 2001 12:42:11 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: george anzinger <george@mvista.com>
cc: "Robert H. de Vries" <rhdv@rhdv.cistron.nl>,
        high-res-timers-discourse@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: high-res-timers start code.
In-Reply-To: <3AE49402.BB093022@mvista.com>
Message-ID: <Pine.HPX.4.10.10104241213530.2724-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Apr 2001, george anzinger wrote:

> "Robert H. de Vries" wrote:
> > 
> > On Monday 23 April 2001 19:45, you wrote:
> > 
> > > By the way, is the user land stuff the same for all "arch"s?
> > 
> > Not if you plan to handle the CPU cycle counter in user space. That is at
> > least what I would propose.
> 
> Just got interesting, lets let the world look in.
> 
> What did you have in mind here?  I suspect that on some archs the cycle
> counter is not available to user code.  I know that on parisc it is
> optionally available (kernel can set a bit to make it available), but by
> it self it is only good for intervals.  You need to peg some value to a
> CLOCK to use it to get timeofday, for instance.

On Intel there is a also bit to disable unprivileged RDTSC, IIRC. On PPC
the timebase is always available (but the old 601 needs spacial casing: it
uses different registers and does not count in binary :-().

> On the other hand, if there is an area of memory that both users and
> system can read but only system can write, one might put the soft clock
> there.  This would allow gettimeofday (with the cycle counter) to work
> without a system call.  To the best of my knowledge the system does not
> have such an area as yet.
> 
> comments?

Well, there may be work in this area, since x86-64 will not enter kernel
mode for gettimeofday() if I understand correctly what Andrea said. Linus
hinted once at exporting (kernel) code to user space.

Some data also will also need to be accessible but as long as you don't
guarantee compatibility on data layout, only AFAIU on interface for these
calls (it was not clear to me if it would be a fixed address forever or
dynamic linking with kernel exported symbols), it's not a problem.

Of course it will SIGSEGV instead of returning -EFAULT but this is a good
thing IMHO, nobody checks for -EFAULT from gettimeofday(). I think
that system calls should rather force SIGSEGV than return -EFAULT anyway,
to make syscalls indistinguishable from pure library calls. 

	Regards,
	Gabriel.

