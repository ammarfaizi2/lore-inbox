Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317793AbSGKJRw>; Thu, 11 Jul 2002 05:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317798AbSGKJRv>; Thu, 11 Jul 2002 05:17:51 -0400
Received: from [195.223.140.120] ([195.223.140.120]:30832 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317793AbSGKJRv>; Thu, 11 Jul 2002 05:17:51 -0400
Date: Thu, 11 Jul 2002 11:21:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: jamagallon@able.es, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: pipe and af/unix latency differences between aa and jam on smp
Message-ID: <20020711092145.GH1342@dualathlon.random>
References: <20020711090214.GA16423@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020711090214.GA16423@rushmore>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 05:02:14AM -0400, rwhron@earthlink.net wrote:
> > both pipe and afunix should not generate any irq load (other than
> > the IPI with the reschedule_task wakeups at least, but they're only
> > dependent on the scheduler
> 
> there are some scheduler bits in irqbalance for cpu affinity.
> irqbalance is in the two jam patchsets with low latency, and not
> in the patchsets with higher latency.  

I don't see those scheduler bits, it only exports the idle task info so
we know if a cpu is idle from irq.

anyways 2.4.19-pre10-jam2 is composed by plain 2.4.19pre10aa2 + a number
of patches (including irqbalance,irqrate,smptimers, btw smptimers
reintroduces a deadlock crahsing bug exploitable from userspace that I
pushed into 2.4 mainline recently). So the difference has to be in the
patches into pre10jam2 because pre10aa2 is slow and jam2 is fast.
Only looking at the patches it's not clear what can make the difference.

BTW, in your new set of benchmarks rc1aa1 still seems to be compiled in
the unfair why that explains the slower I/O results, right? I don't mind
of course, just to be sure.

I don't have time to do benchmarks on this myself right now, but if
somebody could try to apply the patches in jam2 with a binary search
(I'd first suggest to backout irqrate, smptimers and irqbalance and see
if it's still fast as I expect), that would be really interesting.

Thanks,

Andrea
