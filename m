Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbUKLA4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbUKLA4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbUKLAwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:52:11 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:13965 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262305AbUKLAtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:49:15 -0500
Subject: How could smp_error_interrupt get activated on x86?
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1100220203.6432.46.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 12 Nov 2004 11:43:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I can't for the life of me figure out how one of my suspend2 users could
get this on a 2.6.9 kernel:

> Software Suspend 2.1.4: Initiating a software suspend cycle.
> ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
> ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
> ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
> ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 23
> APIC error on CPU0: 00(00)
> ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 20 (level, low) -> IRQ 177
> ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 193
> Please include the following information in bug reports:
> - SUSPEND core   : 2.1.4
> [...]
> 
> All work fine.
> Processor and motherboard  Athlon Barton 2500+@3200+, EPoX 8KRAI
(KT600).
> 
> What is APIC error CPU0: 00(00)?

I know it's really no error (according to the code), but I can't even
see how the function gets called in the first place:

find -type f | xargs grep smp_error_interrupt
./arch/i386/kernel/apic.c:asmlinkage void smp_error_interrupt(void)
./arch/x86_64/kernel/apic.c:asmlinkage void smp_error_interrupt(void)
./arch/x86_64/kernel/entry.S:   apicinterrupt ERROR_APIC_VECTOR,smp_error_interrupt

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

