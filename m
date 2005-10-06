Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVJFHyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVJFHyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 03:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVJFHyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 03:54:41 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:61063 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750717AbVJFHyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 03:54:40 -0400
Date: Thu, 6 Oct 2005 03:54:27 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Mark Knecht <markknecht@gmail.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0510060351340.28535@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> 
 <20051004130009.GB31466@elte.hu>  <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
  <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> 
 <1128450029.13057.60.camel@tglx.tec.linutronix.de> 
 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com> 
 <1128458707.13057.68.camel@tglx.tec.linutronix.de> 
 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com> 
 <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Oct 2005, Mark Knecht wrote:

> Hi Ingo,
>    By the time I go there it was already -rt9. Unfortunately I still
> get the same message. Possibly the continued discussion is addressing
> this? I haven't tried to read it all yet.
>
> >From dmesg:
>
> PCI: Using configuration type 1
> PCI: Using MMCONFIG at e0000000
> ACPI: Subsystem revision 20050902
> BUG: swapper/1: spin-unlock irq flags assymetry?
>
> Call Trace:<ffffffff80400d19>{_spin_unlock_irqrestore+89}
> <ffffffff802694d6>{acpi_ev_create_gpe_block+642}
>        <ffffffff80263116>{acpi_os_wait_semaphore+135}
> <ffffffff80269682>{acpi_ev_gpe_initialize+109}
>        <ffffffff80266cac>{acpi_ev_initialize_events+151}
> <ffffffff802790a2>{acpi_enable_subsystem+69}
>        <ffffffff806086de>{acpi_init+86} <ffffffff80604cda>{init_bio+266}
>        <ffffffff8010b25a>{init+506} <ffffffff8010ed16>{child_rip+8}
>        <ffffffff8010b060>{init+0} <ffffffff8010ed0e>{child_rip+0}
>
> ---------------------------
> | preempt count: 00000000 ]
> | 0-level deep critical section nesting:
> ----------------------------------------
>

The acpi code is filled with macro hell (and craziness like using a void
pointer for a spinlock).  Do you have the following turned on?

CONFIG_USE_FRAME_POINTER=y
CONFIG_FRAME_POINTER=y


The back trace looks a little suspicious.  But I'm looking into the acpi
code to see if I can locate the bad flags.

-- Steve

