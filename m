Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbUJZRZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUJZRZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUJZRZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:25:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3016 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261355AbUJZRZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:25:16 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
In-Reply-To: <1098767513.2926.3.camel@cmn37.stanford.edu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
	 <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com>
	 <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu>
	 <20041025152458.3e62120a@mango.fruits.de> <20041025132605.GA9516@elte.hu>
	 <20041025160330.394e9071@mango.fruits.de> <20041025141008.GA13512@elte.hu>
	 <20041025141628.GA14282@elte.hu>
	 <33313.192.168.1.5.1098733224.squirrel@192.168.1.5>
	 <1098759671.9166.10.camel@krustophenia.net>
	 <1098767513.2926.3.camel@cmn37.stanford.edu>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 13:25:14 -0400
Message-Id: <1098811515.10048.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 22:11 -0700, Fernando Pablo Lopez-Lezcano wrote:
> On Mon, 2004-10-25 at 20:01, Lee Revell wrote: 
> > On Mon, 2004-10-25 at 20:40 +0100, Rui Nuno Capela wrote:
> > > OTOH, jackd -R xruns are awfully back, even thought I (re)prioritize the
> > > relevant IRQ thread handlers to be always higher than jackd's.
> > 
> > Actually they should be lower, except the soundcard.  I was only able to
> > get the xrun free behavior of T3 by setting all IRQ threads except the
> > soundcard to SCHED_OTHER.  Especially important was setting ksoftirqd to
> > SCHED_OTHER, this actually may have been the only one necessary.
> > 
> > The relative priorities of jackd and the soundcard irq do not matter as
> > these two should never contend (aka they are never both runnable at the
> > same time).
> 
> What happens when one is blessed with a laptop where everything is
> sharing an interrupt?
> 
> $ cat /proc/interrupts
>            CPU0
>   0:    2372239          XT-PIC  timer  0/72239
>   1:       5362          XT-PIC  i8042  0/5362
>   2:          0          XT-PIC  cascade  0/0
>   8:          1          XT-PIC  rtc  0/1
>   9:     616176          XT-PIC  acpi, uhci_hcd, uhci_hcd, uhci_hcd,
> eth0, yenta, yenta, Intel 82801CA-ICH3, radeon@PCI:1:0:0  0/16176
> 11:         37          XT-PIC  sonypi  0/35
> 12:      28392          XT-PIC  i8042  0/28392
> 14:      21078          XT-PIC  ide0  0/21078
> 15:        472          XT-PIC  ide1  0/472

Ugh, why would _anyone_ design a laptop like that?  You have 4
perfectly good interrupts that you are not using at all.  Is it really
cheaper to put everything on the same irq?  Does this work better under
Windows or something?

AFAIK there is nothing you can do - any other irq that fires on 9 will
mask out all the others until it completes.

I am increasingly convinced that the vast majority of laptops are
horribly broken and completely unsuitable for low latency audio work.

Lee

