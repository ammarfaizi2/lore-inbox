Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287219AbRL2WzH>; Sat, 29 Dec 2001 17:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287218AbRL2WzA>; Sat, 29 Dec 2001 17:55:00 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:4620 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287202AbRL2Wya>; Sat, 29 Dec 2001 17:54:30 -0500
Message-ID: <3C2E4875.9D0F4BC6@zip.com.au>
Date: Sat, 29 Dec 2001 14:49:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
In-Reply-To: <20011229051712Z287139-18284+8656@vger.kernel.org> <Pine.LNX.4.40.0112291424560.1580-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Sat, 29 Dec 2001, Dieter [iso-8859-15] Nützel wrote:
> 
> > Davide worte:
> > > There's a bug fix and the use of the Time Slice Split Scheduler inside the
> > > local CPUs schedulers. Versions from 0.46 to 0.52 are broken by the fixed
> > > bug so testers should use this version :
> > >
> > > http://www.xmailserver.org/linux-patches/mss-2.html#patches
> >
> > Sorry, if someone asks this before but do you think that you get some stuff
> > out of it for 2.4.xx?
> >
> > Your numbers for the 8 SMP system are great.
> > Can't wait to do some tests on my poor single 1 GHz Athlon II and soon dual
> > Athlon MP/XP 1600+ on an MS 6501 (AMD 760MPX).
> >
> > Maybe my MP3/Ogg-Vorbis hiccup during dbench 32+ are solved?
> > Currently running latest 2.4.17+preempt (do think that can be mixed with your
> > new scheduler?).
> 
> The new patch need ver >= 2.5.2-pre3 because Linus merged the Time Slice
> Split Scheduler and making it to apply to 2.4.x could be a pain in the b*tt.
> Yes, as i expected numbers on big SMP are very good but still i don't
> think that this can help you with your problem.

I would expect the audio dropouts to be due to disk read latencies
and insufficiently large buffers in the audio app, and/or failure
of that audio app to mlock itself down.

If it's scheduling latency, which I doubt, I yesterday put out
a 2.4.17 low-latency patch which has a worst-case latency which is
two orders of magnitude less that the preemptive kernel's.  The
lock-break patch will improve the preempt patch's worst case.
http://www.zip.com.au/~akpm/linux/2.4.17-low-latency.patch.gz

> It'd be nice to have inside local_irq_disable()/enable() a cycle counter
> sampler to see what is the worst case path with disabled irqs.
> 

http://www.zip.com.au/~akpm/linux/#intlat

This tool needs a bit of maintenance work, but it can measure and identify
the source of worst-case interrupt latencies quite successfully.

-
