Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265661AbUGTFiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUGTFiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 01:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUGTFiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 01:38:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:49813 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265661AbUGTFiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 01:38:14 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040719104837.GA9459@elte.hu>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe>  <20040719104837.GA9459@elte.hu>
Content-Type: text/plain
Message-Id: <1090301906.22521.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 01:38:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-19 at 06:48, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Just as a reference point, what do you think is the longest delay I
> > *should* be seeing?  I recall hearing that BEOS guaranteed that
> > interrupts are never disabled for more than 50 usecs.  This seems
> > achievable, as the average delay I am seeing is 15 usecs.
> 
> ATA hardirq latency can be as high as 700 usecs under load even on
> modern hw, when big DMA requests are created with long scatter-gather
> lists. We also moved some of the page IO completion code into irq
> context which further increased hardirq latencies. Since these all touch
> cold cachelines it all adds up quite quickly.
> 

Does this scale in a linear fashion with respect to CPU speed?  You
mentioned you were testing on a 2Ghz machine, does 700 usecs on that
translate to 2800 usecs on a 500Mhz box?

On a 2Ghz machine, 700 usecs is about one million CPU cycles.  In other
words, the highest priority process can become runnable, then have to
wait *one million cycles* to get the CPU.

How much I/O do you allow to be in flight at once?  It seems like by
decreasing the maximum size of I/O that you handle in one interrupt you
could improve this quite a bit.  Disk throughput is good enough, anyone
in the real world who would feel a 10% hit would just throw hardware at
the problem.

Lee

