Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUG2Tmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUG2Tmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUG2Tmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:42:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34775 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264542AbUG2Tmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:42:47 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040729180411.GA16323@elte.hu>
References: <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040727162759.GA32548@elte.hu> <1090968457.743.3.camel@mindpipe>
	 <20040728050535.GA14742@elte.hu> <1091051452.791.52.camel@mindpipe>
	 <1091063295.18598.2.camel@mindpipe>  <20040729180411.GA16323@elte.hu>
Content-Type: text/plain
Message-Id: <1091130189.18598.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 15:43:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 14:04, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Here are some more results.  I am up to 56 million interrupts and I
> > have yet to trigger a latency higher than 46 usecs.  It looks like
> > this is a hard upper limit.
> 
> nice - what is the average (and minimum?) latency reported by jackd? 
> I'd say 46 usecs on a 600 MHz box is quite close to what it takes to
> handle an interrupt and schedule to the cache-cold jackd task. It should
> definitely be well below the latency required for jackd to do its job
> reliably.

Yes, I am quite impressed with these results.  The jitter is about 5-10%
of the total available time at the very lowest latency settings.  This
is an order of magnitude better than 2.4 + ll.  It went as high as 50
usecs, but this took about 100 million interrupts.  I have not hacked
jackd yet to keep track of the average and minimum value, but eyeballing
it I would say 7-8 usecs is the minimum and 25-30 the average.  The
distribution seems very normal.

I am going to try making the RTC irq non-redirectable as well, as I got
a few 'rtc: lost some interrupts at 1024 Hz' messages, and the RTC is
important for MIDI timing.

Other than the few outliers I reported earlier, this is very close to
being ready for general pro audio use.  I did notice that the msync()
XRUN can be reliably reproduced by 'apt-get update && apt-get upgrade'.

I think I can speak on behalf of all Linux audio users when I say:
thanks a million, to all kernel developers.

Lee

