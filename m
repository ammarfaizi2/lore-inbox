Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVCNNSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVCNNSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVCNNSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:18:07 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:49755 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261482AbVCNNR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:17:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XhvQVP6jRdCPSXRl53XU6C5vk/hf1SyvpzSCnu6iiDybhoWF3pp8GsVBMPuxHV88w0zG0zJpK9NxeGSdtOdt70HepANZD7GKMQ+KiZigTeGIWT4YZngSFg05cADTvWnAhYzFuhVJnypaINbA/WF9RbmCDcpUnI4XTMSZUik9iZ8=
Message-ID: <3de2c80b05031309135460e07@mail.gmail.com>
Date: Sun, 13 Mar 2005 18:13:24 +0100
From: zyphr <infzyphr@gmail.com>
Reply-To: zyphr <infzyphr@gmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Francesco Oppedisano <francesco.oppedisano@gmail.com>
Subject: Re: about interrupt latency
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503120952390.2166@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <875fe4a50503081039328ffede@mail.gmail.com>
	 <Pine.LNX.4.61.0503081156360.30824@montezuma.fsmlabs.com>
	 <875fe4a505030906438a76cb5@mail.gmail.com>
	 <Pine.LNX.4.61.0503120952390.2166@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005 10:01:43 -0700 (MST), Zwane Mwaikambo
<zwane@arm.linux.org.uk> wrote:
> On Wed, 9 Mar 2005, Francesco Oppedisano wrote:
> 
> > On Tue, 8 Mar 2005 12:09:58 -0700 (MST), Zwane Mwaikambo
> > <zwane@arm.linux.org.uk> wrote:
> >
> > > At some cpu frequency point on i386 the main cause of your interrupt
> > > service latency will be in the interrupt controller and how long from irq
> > > assertion to the signal being recognised, resultant vector being
> > > dispatched to the processor and the necessary interrupt controller
> > > acknowledge steps required. This is also helped by the fact that the
> > > Linux/i386 interrupt vector stubs are very small and fast, so there isn't
> > > all that much code to execute to reach the ISR from the vector table. I'm
> > > not sure if you've tested this, but you may notice that timer interrupt
> > > via Local APIC will have lower dispatch latency than timer interrupt via
> > > i8259 only. But that's all at the lower end of the latency graph, you will
> > > most likely run into other sources on a busy system.
> > >
> > >         Zwane
> > >
> > Very interesting zwane....i haven't tested the local APIC....do you
> > think this dispatch time can vary with the system I/O load (many
> > pending interrupts in the PIC)?
> 
> The PIC/i386 setup cannot really pend interrupts so i would say no i don't
> think the dispatch time would be affected.
> 
> > I think the interrupt latency is influenced even by the code inside
> > the kernel: if a lot of code is running with interrupts disabled then
> > the interrupt latency will grow. Am i right?
> 
> Yes that's correct, in fact this will be your major/main cause of
> interrupt latency.
> 
> > So probably we can state that the factors influencing the interrupt latency are:
> > 1)Dispatching time in the PIC
> > 2)Waiting time on the PIC (if there are pending interrupt of lower vector)
> 
> With APIC/i386 this is more possible, if you're really interested you
> should try and calculate the dispatch time using the same system (must
> have an IOAPIC) and testing with the following combinations;
> 
> PIC only (noapic, nolapic)
> PIC + LAPIC (noapic)
> IOAPIC + LAPIC
> 
> You will probably find that the IOAPIC + LAPIC has the lowest dispatch
> time. Also worth noting that the LAPIC can queue upto 2 vectors (on P4),
> this allows for more interrupts to be ready for dispatch.
> 
> > 3)fetching ISR from main memory
> > 4)wait time when CPU is running with disabled interrupt
> >
> > Do U agree?
> 
> A bit more on (4)
> 
> 4a) wait time when CPU is running firmware (e.g. SMI/SMM, VGA BIOSes etc)
> 
> Otherwise, yes i agree, good luck with your research.
> 
>         Zwane
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

I am just a user, not sure if it is related.
But with CONFIG_X86_UP_APIC and/or  CONFIG_X86_UP_IOAPIC set my mouse
behaviour is totally different, when playing games everything feels
more "laggy".
And it gives me what gamers call "negative acceleration".
