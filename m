Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268908AbUHMApq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268908AbUHMApq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268590AbUHMApq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:45:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:27602 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268908AbUHMApa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:45:30 -0400
X-Authenticated: #4399952
Date: Fri, 13 Aug 2004 02:55:46 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-Id: <20040813025546.1372fbc6@mango.fruits.de>
In-Reply-To: <1092356877.1304.58.camel@mindpipe>
References: <20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<1092174959.5061.6.camel@mindpipe>
	<20040811073149.GA4312@elte.hu>
	<20040811074256.GA5298@elte.hu>
	<1092210765.1650.3.camel@mindpipe>
	<20040811090639.GA8354@elte.hu>
	<20040811141649.447f112f@mango.fruits.de>
	<20040811124342.GA17017@elte.hu>
	<1092268536.1090.7.camel@mindpipe>
	<20040812072127.GA20386@elte.hu>
	<1092347654.11134.10.camel@mindpipe>
	<1092355488.1304.52.camel@mindpipe>
	<1092356877.1304.58.camel@mindpipe>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 20:27:57 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2004-08-12 at 20:04, Lee Revell wrote:
> 
> > So, it seems that if a SCHED_FIFO process opens a PCM device using
> > mmap, then mlockall's the memory, then another process mlockall's
> > memory, the result is an xrun 100% of the time.
> > 
> 
> I have found that around 1400 KB is a magic number on my system, this
> triggers the preempt violation/xrun about 50% of the time.  1300 never
> triggers it, 1500 always triggers it.
> 
> Also the amount of memory being mlockall'ed does not affect the length
> of the preemption violation - if we hit it at all, there's a 10ms
> latency, whether we lock 1400KB or 100MB.
> 
> Hopefully O6 will give enough info to track this down.

Hi, 

i think that the mlockall and client/jackd startup xruns often do not
seem to correspond to a critical timing report.. Try the following: turn
off xrun_debug but leave the preempt-timing stuff on. On my system, the
mlockall_test provokes an xrun in jackd's output but i do not get a
preempt-timing report (thresh = 500). 

OTOH when the xrun_debug is on, the xrun_debug report actually seems to
trigger the preempt-timing report.

I think many of the jackd xruns are really jacks business. But maybe i
misinterpret the symptom.

BTW: on my system with 2*64 frames the magic mlockall number seems to be
around 15megs.. mlockall'ing only 10megs is very unlikely to trigger an
xrun in jackd  And even mlockall'ing 100 megs, while always producing an
xrun in jackd, doesn't show a corresponding preempt timing report either
[with preempt_thresh = 500] as long as the xrun_debug is off. 

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

