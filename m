Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTKGWOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTKGWNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:13:52 -0500
Received: from mail-6.tiscali.it ([195.130.225.152]:50026 "EHLO
	mail-6.tiscali.it") by vger.kernel.org with ESMTP id S264605AbTKGTet convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 14:34:49 -0500
Date: Fri, 7 Nov 2003 20:34:48 +0100
Message-ID: <3FAA85C400002BAB@mail-6.tiscali.it>
From: daz@tiscali.it
Subject: Exception on host-PCI-bridge master-abort
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Items: custom PCI card, master-abort on host-PCI bridge, i386 PC, kernel
2.4.18

Hi,
I'm developing i386 linux drivers for a custom PCI card basically built
on
a programmable FPGA.

Every time I re-program the FPGA (without re-booting the PC), the PCI
configuration regs of the card are resetted, which makes memory and I/O
aperture of the card disappearing from the PCI bus.

By calling pci_restore_state() I restore the proper configuration, but
unfortunately sometimes I'm not fast enough, and the PC issues a read or
write requests when the card is still wrong configured.
In such bad situation the PC freezes!

   From the PCI spec, if a card does not respond, after a small timeout
a
master-abort situation will accour.

It will be desiderable having, e.g. a CPU exception when the host-PCI
bridge fails with a master-abort.
By putting a pci_restore_state() call in the exception handler I could solve
the problem.

Digging in the kernel code I didn't found a way for doing that.
No PCI bridge for PC seems having such a feature. Isn't it?

Using a ARM Integrator platform instead of a PC, the solution seems easy.
The V3 PCI controller is programmed to rise an exception when a master-abort
accurs (v3_fault() in arch/arm/mach-integrator/pci_v3.c).

Please could you suggest me a way for getting this exception on PC?

Currently I'm using a PC with SIS620 chipset, but if you know solutions
related with different chipsets, I'm ready to change MB.

Regards
Antonio Borneo
antonio.borneo@stNOS.PAMcom


__________________________________________________________________
Tiscali ADSL SENZA CANONE, paghi solo quello che consumi!
Navighi a 1,5 euro all'ora e il modem e' gratis! Abbonati subito.
http://point.tiscali.it/Adsl/prodotti/senzacanone/



