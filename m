Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130824AbRCJBoj>; Fri, 9 Mar 2001 20:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130825AbRCJBoa>; Fri, 9 Mar 2001 20:44:30 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:6661 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S130824AbRCJBoW>;
	Fri, 9 Mar 2001 20:44:22 -0500
Message-ID: <3AA9868C.A5226735@yahoo.co.uk>
Date: Fri, 09 Mar 2001 20:42:36 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-thinkpad@www.bm-soft.com
Subject: 2.4.2-ac16 PIIX4 ACPI getting wrong IRQ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.4.3-pre1, /proc/pci contained:
>   Bus  0, device   7, function  3:
>     Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 1).

With 2.4.2-ac16, /proc/pci contains:
>  Bus  0, device   7, function  3:
>    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 1).
>      IRQ 9.

So the ACPI function of the PIIX4 is now being given
IRQ 9.  I don't want this.  I was using IRQ 9 for a
PCMCIA device.

So I tried booting the kernel with "acpi=off" and
"pci=irqmask=0x0800", but the result was the same.

Documentation/kernel-parameters.txt says that
"pci=irqmask=0xMMMM ... sets a bit mask of IRQs allowed
to be assigned".  This parameter is being ignored.

[... searches through kernel sources ...]

Well I see that this is the result of a change to
/usr/src/linux-2.4.2-ac16/arch/i386/kernel/pci_pc.c
which looks deliberate:

< static void __init pci_fixup_piix4_acpi(struct pci_dev *d)
< {
< 	/*
< 	 * PIIX4 ACPI device: hardwired IRQ9
< 	 */
< 	d->irq = 9;
< }

What's going on?

Thomas Hood
jdthood_AT_yahoo.co.uk
