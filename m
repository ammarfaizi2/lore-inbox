Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVI0Ews@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVI0Ews (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 00:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVI0Ews
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 00:52:48 -0400
Received: from xenotime.net ([66.160.160.81]:10386 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964805AbVI0Ewr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 00:52:47 -0400
Date: Mon, 26 Sep 2005 21:52:45 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
Message-Id: <20050926215245.7a1be7fa.rdunlap@xenotime.net>
In-Reply-To: <20050927044840.GA21108@colo.lackof.org>
References: <20050926201156.7b9ef031.rdunlap@xenotime.net>
	<20050927044840.GA21108@colo.lackof.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005 22:48:40 -0600 Grant Grundler wrote:

> On Mon, Sep 26, 2005 at 08:11:56PM -0700, Randy.Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > MSI requires local APIC + IO APIC support (according to
> > drivers/pci/Kconfig),
> 
> The purpose of MSI is to bypass the IO APIC.
> I'm not aware of any dependency on IO APIC in HW.
> I suspect the dependency in the Kconfig is historical
> because of how the x86 source code is structured:
> config X86_LOCAL_APIC
>         bool
>         depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER)
>         default y
> 
> essentially, LOCAL_APIC gets enabled if "UP_APIC or SMP".
> I've no clue why folks thought it was better to ignore
> the IO APIC on UP kernels.
> 
> I'm pretty sure one only needs a local APIC support.
> Local APIC responds to 0xfee00000 range of addresses and
> directs the interrupt to a CPU.

Thanks.  Can't say I'm surprised at that info.

> > but if a kernel is built with all of
> > those (APICs + CONFIG_PCI_MSI) and then booted with "nosmp" or
> > "max_cpus=0|1" or "noapic" or "nolapic", MSI also should be
> > disabled, otherwise the interrupt routing is bad (so that only
> > using "irqpoll" helps).
> 
> UP vs SMP is orthogonal to MSI support wrt HW.
> I suppose this is another historical artifact of
> APICs being used with SMP x86 boxes first.

"nosmp" (currently) means 1 CPU and no LAPICs/no IOAPICs.
It doesn't have to be that way, but yes, I suspect that it's
mostly historical, plus a method of getting to a lowest common
hardware boot sequence, which is sometimes nice for debugging
or installation.

Nevertheless, there is a problem here.  What do you suggest
to solve it?  Just making PCI_MSI depend on Local APIC support,
or something else?

[Kernel is assigning MSI interrupts, but then they are "lost."
Using "irqpoll" will find them, but that's a performance penalty.]

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
