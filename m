Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTLHVqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 16:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLHVqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 16:46:43 -0500
Received: from fmr06.intel.com ([134.134.136.7]:980 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261775AbTLHVql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 16:46:41 -0500
Subject: Re: balance interrupts
From: Len Brown <len.brown@intel.com>
To: Julien Oster <lkml-2315@mc.frodoid.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <frodoid.frodo.8765grkrkb.fsf@usenet.frodoid.org>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
	 <1070911748.2408.39.camel@dhcppc4>
	 <frodoid.frodo.8765grkrkb.fsf@usenet.frodoid.org>
Content-Type: text/plain
Organization: 
Message-Id: <1070919984.2551.116.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Dec 2003 16:46:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a tight squeeze.  The system has 13 PCI interrupt inputs, but
the chip-set has only a single IO-APIC with 8-pins to handle them.

You don't see all the interrupts in /proc/interrupts because there are
not device drivers attached to all of them -- but if you edit them in
from lspci output you'd get this:

  0:   40022145    IO-APIC-edge  timer
  1:      62950    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:     681626    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:         55    IO-APIC-edge  i8042
 14:     968274    IO-APIC-edge  ide0
 15:    1789182    IO-APIC-edge  ide1

 16:     404489   IO-APIC-level  EMU10K1, eth2
 17:                             eth3
 18:     445160   IO-APIC-level  ide2, ide3, eth0
 19:    1596427   IO-APIC-level  eth1, matrox
 20:          0   IO-APIC-level  ohci_hcd
 21:          0   IO-APIC-level  NVidia nForce2 audio, usb
 22:      36730   IO-APIC-level  ohci_hcd, audio
 23:                             smbus

No, the siimage appears to be a single pci device, so you'll not get to
split ide2 and ide3.

The ethernets appears to be a quad DEC ethernet card with a PCI bridge. 
You're using eth0 and eth1.  But if you used eth3 instead of eth0, you'd
have an ethernet I/F with an interrupt all to itself.

cheers,
-Len

ps. yes, the AML shows these interrupt links are programmable, but it is
unclear if the BIOS/hardware is capable of programming any of the PCI
interrupts to unused destinations < 16 when in APIC mode.
I'd be interested to see the dmesg -s40000 for this box.

pps low hanging fruit = easy to pick
ppps high rent district = expensive place to live


