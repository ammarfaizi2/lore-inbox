Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbRATQ0d>; Sat, 20 Jan 2001 11:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRATQ0W>; Sat, 20 Jan 2001 11:26:22 -0500
Received: from MI5.satimex.tvnet.hu ([195.38.97.43]:24402 "HELO
	mi5.satimex.tvnet.hu") by vger.kernel.org with SMTP
	id <S130067AbRATQ0Q>; Sat, 20 Jan 2001 11:26:16 -0500
Date: Sat, 20 Jan 2001 17:26:10 +0100
From: Janos Farkas <chexum@shadow.banki.hu>
To: Dag Bakke <dagb@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inconsistent cache size reporting.?
Message-ID: <priv$8dd123753$b9afe@lk8rp.mail.xeon.eu.org>
Mail-Followup-To: Dag Bakke <dagb@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A67FA33.25F188E0@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/0.96.2i
In-Reply-To: <3A67FA33.25F188E0@sgi.com>; from Dag Bakke on Fri, Jan 19, 2001 at 09:26:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-01-19 at 09:26:27, Dag Bakke wrote:
> It looks as if /proc/cpuinfo reports the L2 cache size on a PII, while
> it reports the L1 cache size on a K6-2. 

The kernel can only detect (at least via "fetch-info-from-cpu" methods)
the size of internal caches.  If there is more level of them, it reports
the latter one (the one more closer to the memory), as all but the most
recent CPU caching techniques do not add up for multiple levels of
caches, so only the larger is the effective size.

I guess the entry in cpuinfo is just a hint for user programs to help
optimizing the size of data to be worked on.  External caches (mostly
found on Socket7 motherboards nowadays) don't really help tight loops,
just improve the memory access timings a bit, so they don't really
count..

So, on a PII/PIII, you'll see the L2 cache size reported (as it's
internal to the CPU), while on a K6, K6-2, you'll see the L1 cache size
(total), since the external (motherboard) caches are invisible to the
kernel.  (Ie. not easily recoverable).  On a K6-III, however, you'd see
the L2 cache as well; but the external cache is still invisible to the
kernel.

> I also note that performance on this system isn't quite what I would expect
> it to be. compiling glibc 2.1.3 takes longer time on my system than on a
> PII-366.
> A Celeron 300 outperforms the K6 when running 'mpeg2dec -o null'. Is the K6-2
> really this bad? Or is it my memory latency/bandwidth which is hurting me?

I seem to remember, that the K6 architecture is quite cache hungry,
that's why the K6-III is noticeably better than the K6-2.  Also, the FPU
is not quite the same than Intel's one, it's not obviously worse, but
needs different optimizations, or "3DNow!" supporting programs to reach
the same level of performance.  Your experience at compiling sounds a
bit surprising, a K6-III at 400 MHz seemed to perform much better than
anything on comparable frequencies, and the K6-2 was still quite similar
to Celerons, so maybe your motherboard has some quirky issues around
memory and/or cache, maybe your disks/controller is much worse on the K6
system, but what the kernel does report is nothing to worry about...

Janos
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
