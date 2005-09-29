Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVI2UKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVI2UKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVI2UKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:10:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32665 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932306AbVI2UKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:10:48 -0400
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       gregkh <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
References: <20050926201156.7b9ef031.rdunlap@xenotime.net>
	<20050927044840.GA21108@colo.lackof.org> <4339B8EA.1080303@pobox.com>
	<1127860670.10674.32.camel@localhost.localdomain>
	<20050929033426.GA3892@colo.lackof.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 29 Sep 2005 14:09:15 -0600
In-Reply-To: <20050929033426.GA3892@colo.lackof.org> (Grant Grundler's
 message of "Wed, 28 Sep 2005 21:34:26 -0600")
Message-ID: <m1achvab6c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler <grundler@parisc-linux.org> writes:

> On Tue, Sep 27, 2005 at 11:37:50PM +0100, Alan Cox wrote:
>> On Maw, 2005-09-27 at 17:26 -0400, Jeff Garzik wrote:
>> > Grant Grundler wrote:
>> > > I've no clue why folks thought it was better to ignore
>> > > the IO APIC on UP kernels.
>> > 
>> > Hysterical raisins:  the -majority- of the early uniprocessor systems 
>> > that claimed IOAPIC support were broken.
>> 
>> Not really broken in most cases, but since nobody was using the APIC
>> board makers didn't bother wiring for it.
>
> ok. Any clue how PCI IRQs got routed/handled on those boxes?
> Did UP boards have an 8259 PIC and an IRQ line to the CPU?
> Could an 8529 PIC even co-exist with an IO APIC?

x86 linux can't even boot without using an 8259 PIC.
The 8259 PIC if you don't have an IOAPIC is wired to the 
local apic and the appropriate pin is placed in ExtINT mode.

Most current systems have an 8259 PIC, their primary PIC, and a
PIRQ router all in the same chip.

Eric
