Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266518AbRGGSJV>; Sat, 7 Jul 2001 14:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266523AbRGGSJL>; Sat, 7 Jul 2001 14:09:11 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24527 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266518AbRGGSJB>;
	Sat, 7 Jul 2001 14:09:01 -0400
Message-ID: <3B47503A.6BC6A9B6@mandrakesoft.com>
Date: Sat, 07 Jul 2001 14:08:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107071046570.31249-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 7 Jul 2001, Jeff Garzik wrote:
> > Linus Torvalds wrote:
> > >
> > > Now, the fact that the system appears unusable does obviously mean that
> > > something is wrong. But you're barking up the wrong tree.
> >
> > Two more additional data points,
> >
> > 1) partially kernel-unrelated.  MDK's "make" macro didn't support
> > alpha's /proc/cpuinfo output, "make -j$numprocs" became "make -j" and
> > fun ensued.
> 
> Ahh, well..
> 
> The kernel source code is set up to scale quite well, so yes a "make -j"
> will parallellise a bit teoo well for most machines, and you'll certainly
> run out of memory on just about anything (I routinely get load averages of
> 30+, and yes, you need at least half a GB of RAM for it to not be
> unpleasant - and probably more like a full gigabyte on an alpha).

"make -j" is a lot of fun on a dual athlon w/ 512mb :)

> So I definitely think the kernel likely did the right thing. It's not even
> clear that the OOM killer might not have been right - due to the 2.4.x
> swap space allocation, 256MB of swap-space is a bit tight on a 384MB
> machine that actually wants to use a lot of memory.

Sigh.  since I am a VM ignoramus I doubt my opinion matters much at all
here... but it would be nice if oddball configurations like 384MB with
50MB swap could be supported.  I don't ask that it perform optimally at
all, but at least the machine should behave predictably...

This type of swap configuration makes sense for, "my working set is
pretty much always in RAM, including i/dcache, but let's have some swap
just-in-case"


> > 2) I agree that 200MB into swap and 200MB into cache isn't bad per se,
> > but when it triggers the OOM killer it is bad.
> 
> Note that it might easily have been 256MB into swap (ie it had eaten _all_
> of your swap) at some stage - and you just didn't see it in the vmstat
> output because obviously at that point the machine was a bit loaded.

I'm pretty sure swap was 100% full.  I should have sysrq'd and checked
but I forgot.


> But neutering the OOM killer like Alan suggested may be a rather valid
> approach anyway. Delaying the killing sounds valid: if we're truly
> livelocked on the VM, we'll be calling down to the OOM killer so much that
> it's probably quite valid to say "only return 1 after X iterations".

cnt % 5000 may have been a bit extreme but it was fun to see it thrash. 
sysrq was pretty much the only talking point into the system.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
