Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUG2B43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUG2B43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267406AbUG2B43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:56:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:22204 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267405AbUG2B41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:56:27 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <1091063295.18598.2.camel@mindpipe>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu>
	 <1090968457.743.3.camel@mindpipe>  <20040728050535.GA14742@elte.hu>
	 <1091051452.791.52.camel@mindpipe>  <1091063295.18598.2.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1091066206.18598.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 21:56:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 21:08, Lee Revell wrote:
> On Wed, 2004-07-28 at 17:50, Lee Revell wrote:
> > On Wed, 2004-07-28 at 01:05, Ingo Molnar wrote:
> > > * Lee Revell <rlrevell@joe-job.com> wrote:
> > > if your soundcard doesnt share the irq line with any other 'heavy' 
> > > interrupt then you can make the irq 'direct' via a simple change to 
> > > arch/i386/kernel/irq.c, change this line from:
> > > 
> > >  #define redirectable_irq(irq) ((irq) != 0)
> > > 
> > > to:
> > > 
> > >  #define redirectable_irq(irq) (((irq) != 0) && ((irq) != 10))
> > > 
> > > (if the soundcard is on IRQ 10).
> > > 
> > > does such a change combined with v=3 fix the latencies you are seeing?
> > 
> > With L2, 1:3, max_sectors_kb=256, and the above change, the performance
> > is truly amazing.  Over 20 million interrupts, on a 600Mhz machine, the
> > worst latency I was able to trigger was 46 usecs.  There does not seem
> > to be any adverse affect on any aspect of the system.
> > 
> 
> Here are some more results.  I am up to 56 million interrupts and I have
> yet to trigger a latency higher than 46 usecs.  It looks like this is a
> hard upper limit.

I have also found that if I stress the VM subsystem severely using
sysbench --threads=128 --test=memory, jackd will not start, eventually
its watchdog thread will kill it before it opens the audio ports.  It
seems likely that under pressure the mlockall() would never return.  I
can add some debugging code to jackd if you need to see which system
call is timing out.

Lee

