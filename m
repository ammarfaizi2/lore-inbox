Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUJZRuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUJZRuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUJZRs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:48:57 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:2232 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261360AbUJZRrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:47:07 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <1098811515.10048.5.camel@krustophenia.net>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
	 <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com>
	 <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu>
	 <20041025152458.3e62120a@mango.fruits.de> <20041025132605.GA9516@elte.hu>
	 <20041025160330.394e9071@mango.fruits.de> <20041025141008.GA13512@elte.hu>
	 <20041025141628.GA14282@elte.hu>
	 <33313.192.168.1.5.1098733224.squirrel@192.168.1.5>
	 <1098759671.9166.10.camel@krustophenia.net>
	 <1098767513.2926.3.camel@cmn37.stanford.edu>
	 <1098811515.10048.5.camel@krustophenia.net>
Content-Type: text/plain
Organization: 
Message-Id: <1098812749.5615.15.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Oct 2004 10:45:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 10:25, Lee Revell wrote:
> On Mon, 2004-10-25 at 22:11 -0700, Fernando Pablo Lopez-Lezcano wrote:
> > On Mon, 2004-10-25 at 20:01, Lee Revell wrote: 
> > > On Mon, 2004-10-25 at 20:40 +0100, Rui Nuno Capela wrote:
> > > > OTOH, jackd -R xruns are awfully back, even thought I (re)prioritize the
> > > > relevant IRQ thread handlers to be always higher than jackd's.
> > > 
> > > Actually they should be lower, except the soundcard.  I was only able to
> > > get the xrun free behavior of T3 by setting all IRQ threads except the
> > > soundcard to SCHED_OTHER.  Especially important was setting ksoftirqd to
> > > SCHED_OTHER, this actually may have been the only one necessary.
> > > 
> > > The relative priorities of jackd and the soundcard irq do not matter as
> > > these two should never contend (aka they are never both runnable at the
> > > same time).
> > 
> > What happens when one is blessed with a laptop where everything is
> > sharing an interrupt?
> > 
> > $ cat /proc/interrupts
> >            CPU0
> >   0:    2372239          XT-PIC  timer  0/72239
> >   1:       5362          XT-PIC  i8042  0/5362
> >   2:          0          XT-PIC  cascade  0/0
> >   8:          1          XT-PIC  rtc  0/1
> >   9:     616176          XT-PIC  acpi, uhci_hcd, uhci_hcd, uhci_hcd,
> > eth0, yenta, yenta, Intel 82801CA-ICH3, radeon@PCI:1:0:0  0/16176
> > 11:         37          XT-PIC  sonypi  0/35
> > 12:      28392          XT-PIC  i8042  0/28392
> > 14:      21078          XT-PIC  ide0  0/21078
> > 15:        472          XT-PIC  ide1  0/472
> 
> Ugh, why would _anyone_ design a laptop like that?  You have 4
> perfectly good interrupts that you are not using at all.  Is it really
> cheaper to put everything on the same irq?  Does this work better under
> Windows or something?
> 
> AFAIK there is nothing you can do - any other irq that fires on 9 will
> mask out all the others until it completes.

Yes, except I did not see all these xruns running 2.4.26 + lowlat +
preempt (same machine). Things got better with 2.6.x up to, perhaps, S7,
although I would have to retest to make sure. Now they seem to be worse
than before. 

-- Fernando


