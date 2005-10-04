Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVJDUic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVJDUic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVJDUic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:38:32 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:25462 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964964AbVJDUib convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:38:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oNGZvLp8YL9SmY2oZHHXPuPQqAmO8BJGyRXgjgoqAvxSAWvifzDzaiG8Carhos1yvLoC55Lz8kjgFZYEhNhLvLKod1pxdtGCMLPIRW2HASDGIFjaPdeuQ2xXO0gM5RRbBcU5LVSGH7Gi7eL9ExLjLmCIq80aBx9O2G/Saf5aKNU=
Message-ID: <5bdc1c8b0510041338n61bb5320qc47906d8e9ed7285@mail.gmail.com>
Date: Tue, 4 Oct 2005 13:38:30 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: tglx@linutronix.de
Subject: Re: 2.6.14-rc3-rt2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128450029.13057.60.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 2005-10-04 at 11:11 -0700, Mark Knecht wrote:
>
> > I have now had one burst of xruns. As best I can tell I was
> > downloading some video files for mplayer to look at, or possibly
> > running one of them. I see this in qjackctl:
> >
>
> I guess its related to the priority leak I'm tracking down right now.
> Can you please set following config options and check if you get a bug
> similar to this ?
>
> BUG: init/1: leaked RT prio 98 (116)?
>

Thomas,
   As per the config options I could actually get turned on I see
something different:

Detected 12.564 MHz APIC timer.
Brought up 1 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
BUG: swapper/1: spin-unlock irq flags assymetry?

Call Trace:<ffffffff80400e59>{_spin_unlock_irqrestore+89}
<ffffffff802695f6>{acpi_ev_create_gpe_block+642}
       <ffffffff80263236>{acpi_os_wait_semaphore+135}
<ffffffff802697a2>{acpi_ev_gpe_initialize+109}
       <ffffffff80266dcc>{acpi_ev_initialize_events+151}
<ffffffff802791c2>{acpi_enable_subsystem+69}
       <ffffffff806086de>{acpi_init+86} <ffffffff80604cda>{init_bio+266}
       <ffffffff8010b25a>{init+506} <ffffffff8010ed16>{child_rip+8}
       <ffffffff8010b060>{init+0} <ffffffff8010ed0e>{child_rip+0}

---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

WARNING: swapper/1 changed soft IRQ-flags.

Call Trace:<ffffffff801534ea>{local_irq_enable+26}
<ffffffff80400e65>{_spin_unlock_irqrestore+101}
       <ffffffff802695f6>{acpi_ev_create_gpe_block+642}
<ffffffff80263236>{acpi_os_wait_semaphore+135}
       <ffffffff802697a2>{acpi_ev_gpe_initialize+109}
<ffffffff80266dcc>{acpi_ev_initialize_events+151}
       <ffffffff802791c2>{acpi_enable_subsystem+69}
<ffffffff806086de>{acpi_init+86}
       <ffffffff80604cda>{init_bio+266} <ffffffff8010b25a>{init+506}
       <ffffffff8010ed16>{child_rip+8} <ffffffff8010b060>{init+0}
       <ffffffff8010ed0e>{child_rip+0}
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)

   I'll do a bit more testing and wait to hear about the data above.

Cheers,
Mark
