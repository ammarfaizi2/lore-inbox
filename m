Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbVA2EaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVA2EaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 23:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVA2EaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 23:30:20 -0500
Received: from dialin-164-250.tor.primus.ca ([216.254.164.250]:51074 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262847AbVA2EaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 23:30:10 -0500
Date: Fri, 28 Jan 2005 23:30:05 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Disabling IRQ #xx, because nobody cared!
Message-ID: <20050129043005.GA16861@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm runing 2.6.10 SMP.  I usually use APM, but I decided to try ACPI.
On my machine, USB (integrated) and Audio (PCI card) shares IRQ:

	       CPU0       CPU1       
      0:   19281733   19952671    IO-APIC-edge  timer
      1:      51751      53105    IO-APIC-edge  i8042
      4:    1613559    1503569    IO-APIC-edge  serial
      7:          0          0    IO-APIC-edge  parport0
      8:          2          0    IO-APIC-edge  rtc
      9:          0          0   IO-APIC-level  acpi
     11:     149496     150504   IO-APIC-level  uhci_hcd, uhci_hcd
     12:      54518      50376    IO-APIC-edge  i8042
     14:      63398      63535    IO-APIC-edge  ide0
     15:          1          1    IO-APIC-edge  ide1
    169:      11440      11565   IO-APIC-level  ide2
    177:     456415     456480   IO-APIC-level  eth0
    185:      50307      49693   IO-APIC-level  Ensoniq AudioPCI
    NMI:          0          0 
    LOC:   39235997   39236069 
    ERR:          1
    MIS:          0

After a while, I get

    irq 185: nobody cared!
     [<c01339e2>] __report_bad_irq+0x22/0x90
     [<c0133ad8>] note_interrupt+0x58/0x90
     [<c0133578>] __do_IRQ+0x128/0x130
     [<c0104eba>] do_IRQ+0x1a/0x30
     [<c010370a>] common_interrupt+0x1a/0x20
     [<c0100690>] default_idle+0x0/0x40
     [<c01006ba>] default_idle+0x2a/0x40
     [<c0100760>] cpu_idle+0x40/0x70
    handlers:
    [<e086e000>] (snd_audiopci_interrupt+0x0/0xc0 [snd_ens1371])
    Disabling IRQ #185

Then, after some more time, I get

    irq 11: nobody cared!
     [<c01339e2>] __report_bad_irq+0x22/0x90
     [<c0133ad8>] note_interrupt+0x58/0x90
     [<c0133578>] __do_IRQ+0x128/0x130
     [<c0104eba>] do_IRQ+0x1a/0x30
     [<c010370a>] common_interrupt+0x1a/0x20
     [<c0100690>] default_idle+0x0/0x40
     [<c01006ba>] default_idle+0x2a/0x40
     [<c0100760>] cpu_idle+0x40/0x70
     [<c03728c7>] start_kernel+0x147/0x170
    handlers:
    [<c0227ef0>] (usb_hcd_irq+0x0/0x60)
    [<c0227ef0>] (usb_hcd_irq+0x0/0x60)

At which point, USB is dead.

Do you know if 'acpi' is responsible for this?

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because I can type.
