Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270479AbTG1UDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270483AbTG1UDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:03:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:18884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270479AbTG1UDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:03:44 -0400
Date: Mon, 28 Jul 2003 12:51:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: al.rau@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI patch which fixes all my IRQ problems on nforce2
 -- linux-2.5.75-acpi-irqparams-final4.patch
Message-Id: <20030728125152.4a185090.akpm@osdl.org>
In-Reply-To: <200307281638.24474.adq_dvb@lidskialf.net>
References: <200307272305.12412.adq_dvb@lidskialf.net>
	<3F25419B.2050607@gmx.de>
	<200307281638.24474.adq_dvb@lidskialf.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey <adq_dvb@lidskialf.net> wrote:
>
> > ---------------------------------------------------------------------------
> >-- CC      drivers/acpi/pci_link.o
> > drivers/acpi/pci_link.c: In function `acpi_pci_link_allocate':
> > drivers/acpi/pci_link.c:451: `_dbg' undeclared (first use in this function)
> > drivers/acpi/pci_link.c:451: (Each undeclared identifier is reported
> > only once
> > drivers/acpi/pci_link.c:451: for each function it appears in.)
> > make[2]: *** [drivers/acpi/pci_link.o] Error 1
> > make[1]: *** [drivers/acpi] Error 2
> > make: *** [drivers] Error 2
> > ---------------------------------------------------------------------------
> >--
> >
> > Any ideas how to port your patch to the 2.6 series ?
> 
> Weird! I compiled it on 2.6.0-test2 last night (for a thinkpad T20), and it 
> was fine..... (and the thinkpad works fine too)

I fixed this in test2-mm1: it needs a

	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");

at the start of that function.

I made a bunch of other changes to that patch - mainly whitespace fixups. 
It is at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm1/broken-out/nforce2-acpi-fixes.patch

I'm thinking that perhaps io_apic_irq_read_proc() and print_IO_APIC()
should be consolidated.

