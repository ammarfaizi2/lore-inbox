Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTKCQIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTKCQIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:08:36 -0500
Received: from ale.atd.ucar.edu ([128.117.80.15]:35513 "EHLO ale.atd.ucar.edu")
	by vger.kernel.org with ESMTP id S262066AbTKCQIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:08:34 -0500
From: "Charles Martin" <martinc@ucar.edu>
To: <linux-kernel@vger.kernel.org>
Subject: interrupts across  PCI bridge(s) not handled
Date: Mon, 3 Nov 2003 09:08:27 -0700
Message-ID: <004201c3a224$bad501b0$c3507580@atdsputnik>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a pci backplane extender, with 4 cards 
(named piraq) in it. The cards are detected by 
the PCI system, and irqs 92-95 are assigned, 
as shown in /var/log/messages:

kernel: PCI->APIC IRQ transform: (B6,I4,P0) -> 93 
kernel: PCI->APIC IRQ transform: (B6,I6,P0) -> 95 
kernel: PCI->APIC IRQ transform: (B6,I7,P0) -> 92
kernel: PCI->APIC IRQ transform: (B6,I9,P0) -> 94

My driver loads happily, with succesful registering 
of these interrupts. However, the interrupts don't 
get handled properly, and /proc/interrupts shows that 
they have not been correctly setup:

          CPU0       CPU1
  0:       4946      10162    IO-APIC-edge  timer
  1:         53        131    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:       4816          0    IO-APIC-edge  PS/2 Mouse
 15:        903          1    IO-APIC-edge  ide1
 16:          0          0   IO-APIC-level  usb-uhci
 18:          0          0   IO-APIC-level  usb-uhci
 19:          0          0   IO-APIC-level  usb-uhci
 20:          3          0   IO-APIC-level  ohci1394
 23:          0          0   IO-APIC-level  ehci_hcd
 24:        748          0   IO-APIC-level  eth0
 25:         43          0   IO-APIC-level  ioc0
 26:         43          0   IO-APIC-level  ioc1
 50:       9142       4235   IO-APIC-level  ioc2
 92:          0          0            none  piraq
 93:          0          0            none  piraq
 94:          0          0            none  piraq
 95:          0          0            none  piraq
NMI:          0          0
LOC:      15017      15016
ERR:          0
MIS:          0

If I boot with "noapic", the interrupts do get 
assigned to XT-PIC, and will trigger correctly.

Same results are seen in 2.4.22 and 2.6.0-test9.

Thanks,
Charlie

N.B. System is Dell 650 w/ dual Xeons.
Backplane extender is a Magma. This scheme uses
a PCI interconnect card in both the Dell and 
the Magma, with a connecting cable.

