Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316849AbSFQIuz>; Mon, 17 Jun 2002 04:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSFQIuy>; Mon, 17 Jun 2002 04:50:54 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:33259 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316849AbSFQIux>; Mon, 17 Jun 2002 04:50:53 -0400
Date: Mon, 17 Jun 2002 10:23:24 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <Pine.LNX.4.44.0206171028040.9220-100000@e2>
Message-ID: <Pine.LNX.4.44.0206171012270.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Ingo Molnar wrote:

> 
> On Mon, 17 Jun 2002, Zwane Mwaikambo wrote:
> 
> > > i have planned to submit the irqbalance patch for 2.4-ac real soon, which
> > > needs this function - current IRQ distribution on P4 SMP boxes is a
> > > showstopper.
> > 
> > Can we add a config time option for irqbalance? I consider it extra
> > overhead for setups which can do the interrupt distribution via hardware
> > properly, [...]
> 
> What x86 hardware do you have in mind?

ye olde generic x86 SMP box, the interrupt handling imbalance came about 
with the P4 and their newer APIC setup did it not? Although i am aware 
that some x86 SMP boxes don't do the distribution properly too, thats why 
i reckon config option would be best.

> My main issue with irqbalance is the lack of testing it has - eg. a
> showstopper SMP-on-UP bug was found just two days ago.

Understandable, i agree not many people run 2.5 and it would help if it 
got into 2.4-ac for testing purposes.

> > [...] also irqbalance breaks NUMAQ horribly seeing as it assumes a
> > number of things like addressing modes.
> 
> exactly what does it assume that breaks NUMAQ?

<Disclaimer>
I am not a NUMAQ expert and do not even have access to one for testing
</Disclaimer>

The addressing mode, irq_balance assumes that the addressing mode is 
logical mode (when programming the IOREDTBL entries), whilst NUMAQ uses a 
completely different addressing architecture. Also another thing is 
consider this situation;

irqbalance programs IOAPIC#0 on node0 to deliver to CPU#6 on node1

Will that interrupt get delivered?

Regards,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		



