Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbUKLBNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbUKLBNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 20:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKLBNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 20:13:32 -0500
Received: from fsmlabs.com ([168.103.115.128]:22407 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S262414AbUKLBLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 20:11:22 -0500
Date: Thu, 11 Nov 2004 18:11:12 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How could smp_error_interrupt get activated on x86?
In-Reply-To: <1100220203.6432.46.camel@desktop.cunninghams>
Message-ID: <Pine.LNX.4.61.0411111807350.3407@musoma.fsmlabs.com>
References: <1100220203.6432.46.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, Nigel Cunningham wrote:

> I can't for the life of me figure out how one of my suspend2 users could
> get this on a 2.6.9 kernel:
> 
> > Software Suspend 2.1.4: Initiating a software suspend cycle.
> > ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
> > ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
> > ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
> > ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 23
> > APIC error on CPU0: 00(00)
> > ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 20 (level, low) -> IRQ 177
> > ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 193
> > Please include the following information in bug reports:
> > - SUSPEND core   : 2.1.4
> > [...]
> > 
> > All work fine.
> > Processor and motherboard  Athlon Barton 2500+@3200+, EPoX 8KRAI
> (KT600).
> > 
> > What is APIC error CPU0: 00(00)?
> 
> I know it's really no error (according to the code), but I can't even
> see how the function gets called in the first place:
> 
> find -type f | xargs grep smp_error_interrupt
> ./arch/i386/kernel/apic.c:asmlinkage void smp_error_interrupt(void)
> ./arch/x86_64/kernel/apic.c:asmlinkage void smp_error_interrupt(void)
> ./arch/x86_64/kernel/entry.S:   apicinterrupt ERROR_APIC_VECTOR,smp_error_interrupt

Ahhh y'see it's by BUILD_INTERRUPT magik;

arch/i386/kernel/entry.S defines BUILD_INTERRUPT, then includes;
include/asm-i386/mach-default/entry_arch.h which does;

BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)

Which results in the IDT stub being created for ERROR_APIC_VECTOR

Neat huh? ;)

Regarding your error, has the IOAPIC resumed when you get there?

	Zwane

