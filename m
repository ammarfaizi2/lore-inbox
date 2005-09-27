Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVI0EmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVI0EmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 00:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVI0EmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 00:42:12 -0400
Received: from colo.lackof.org ([198.49.126.79]:25805 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S964802AbVI0EmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 00:42:11 -0400
Date: Mon, 26 Sep 2005 22:48:40 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       gregkh <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
Message-ID: <20050927044840.GA21108@colo.lackof.org>
References: <20050926201156.7b9ef031.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926201156.7b9ef031.rdunlap@xenotime.net>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 08:11:56PM -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> MSI requires local APIC + IO APIC support (according to
> drivers/pci/Kconfig),

The purpose of MSI is to bypass the IO APIC.
I'm not aware of any dependency on IO APIC in HW.
I suspect the dependency in the Kconfig is historical
because of how the x86 source code is structured:
config X86_LOCAL_APIC
        bool
        depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER)
        default y

essentially, LOCAL_APIC gets enabled if "UP_APIC or SMP".
I've no clue why folks thought it was better to ignore
the IO APIC on UP kernels.

I'm pretty sure one only needs a local APIC support.
Local APIC responds to 0xfee00000 range of addresses and
directs the interrupt to a CPU.


> but if a kernel is built with all of
> those (APICs + CONFIG_PCI_MSI) and then booted with "nosmp" or
> "max_cpus=0|1" or "noapic" or "nolapic", MSI also should be
> disabled, otherwise the interrupt routing is bad (so that only
> using "irqpoll" helps).

UP vs SMP is orthogonal to MSI support wrt HW.
I suppose this is another historical artifact of
APICs being used with SMP x86 boxes first.

thanks,
grant
