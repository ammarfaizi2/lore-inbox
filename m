Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSLIJOx>; Mon, 9 Dec 2002 04:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbSLIJOx>; Mon, 9 Dec 2002 04:14:53 -0500
Received: from h-64-105-35-2.SNVACAID.covad.net ([64.105.35.2]:36053 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264715AbSLIJOw>; Mon, 9 Dec 2002 04:14:52 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 9 Dec 2002 01:15:24 -0800
Message-Id: <200212090915.BAA10952@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/pci deprecation?
Cc: rth@twiddle.net, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> - we should _never_ update the PCI_INTERRUPT_LINE register, because it
>   destroys boot loader information (the same way we need to not overwrite
>   BIOS extended areas and ACPI areas etc in order to be able to reboot
>   cleanly)

	I don't think the kernel presently does this, but if it
were to actually do the chipset-specific programming change the IRQ
routing of a device, it should update PCI_INTERRUPT_LINE precisely
so that the information will be passed on across a soft reboot.

	This comes up for me because I have daone motherobard with a
BIOS that never programs the USB controller's interrupt line, so I
have to do the chipset-specific bit twiddling (which, in this case
happens to be simply writing the desired irq into the device's
PCI_INTERRUPT_LINE register anyhow).  By the way, I also had to change
arch/i386/kernel/pci.c to get it to reread PCI_INTERRUPT_LINE if it
thought the interrupt was not routed, although all that I would really
need is some way for a user level program to persuade the kernel to
believe that a particular PCI device's interrupt line A has changed to
irq n.

	This exception is probably not relevant to what Linus and
Richard are discussing, but I thought should mention it, lest that
"_never_" be interpreted too absolutely.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
