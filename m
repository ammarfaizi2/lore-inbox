Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTKXX5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTKXX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:57:31 -0500
Received: from palrel12.hp.com ([156.153.255.237]:44977 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261784AbTKXX53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:57:29 -0500
Date: Mon, 24 Nov 2003 15:57:27 -0800
To: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: David Hinds <dahinds@users.sourceforge.net>, Pavel Roskin <proski@gnu.org>
Subject: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031124235727.GA2467@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I have a new Ricoh PCI-Carbus bridge and the kernel
2.6.0-test9 doesn't seem to configure it properly (see below).
	With the old Pcmcia package, the i82365 module had a bunch of
module options to change various irq stuff (see Pcmcia Howto 5.2). A
quick look in yenta_socket failed to show any module options, which
seems odd.
	What is the correct way to workaround this stuff ?

	Thanks in advance...

	Jean

--------------------------------------------------
Nov 24 11:33:54 lagaffe kernel: Linux Kernel Card Services
Nov 24 11:33:54 lagaffe kernel:   options:  [pci] [cardbus] [pm]
Nov 24 11:33:54 lagaffe kernel: Intel PCIC probe: not found.
Nov 24 11:33:54 lagaffe kernel: PCI: Enabling device 0000:00:13.0 (0000 -> 0002)
Nov 24 11:33:54 lagaffe kernel: PCI: No IRQ known for interrupt pin A of device 0000:00:13.0. Probably buggy MP table.
Nov 24 11:33:54 lagaffe kernel: Yenta: CardBus bridge found at 0000:00:13.0 [0000:0000]
Nov 24 11:33:54 lagaffe kernel: Yenta: ISA IRQ list 0000, PCI irq0
Nov 24 11:33:54 lagaffe kernel: Socket status: 30000006
Nov 24 11:33:54 lagaffe kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Nov 24 11:33:54 lagaffe kernel: cs: IO port probe 0x0800-0x08ff: clean.
Nov 24 11:33:54 lagaffe kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x1f0-0x1f7 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x39f 0x3c0-0x3df 0x3f0-0x3ff 0x4d0-0x4d7
Nov 24 11:33:54 lagaffe kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Nov 24 11:39:43 lagaffe kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Nov 24 11:39:43 lagaffe kernel: airo:  Probing for PCI adapters
Nov 24 11:39:43 lagaffe kernel: airo:  Finished probing for PCI adapters
Nov 24 11:39:43 lagaffe kernel: airo_cs: RequestIRQ: Resource in use
--------------------------------------------------
# cat /proc/interrupts 
           CPU0       CPU1       
  0:     394423         11    IO-APIC-edge  timer
  1:          8          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          2          1    IO-APIC-edge  rtc
 12:         91          1    IO-APIC-edge  i8042
 16:       5315          1   IO-APIC-level  aic7xxx, HP J2585B
NMI:          0          0 
LOC:     394311     394310 
ERR:          0
MIS:          0
--------------------------------------------------
