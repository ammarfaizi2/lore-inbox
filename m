Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTLDUCY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLDUCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:02:24 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:63104 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262817AbTLDUCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:02:17 -0500
Date: Thu, 4 Dec 2003 21:02:08 +0100
From: cheuche+lkml@free.fr
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11) - IRQ flood related ?
Message-ID: <20031204200208.GA4167@localnet>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FCF25F2.6060008@netzentry.com> <1070551149.4063.8.camel@athlonxp.bradney.info> <20031204163243.GA10471@forming> <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org> <20031204175548.GB10471@forming>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204175548.GB10471@forming>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Along with the lockups already described here, I've noticed an
unidentified source of interrupts on IRQ7. Several people posted their
/proc/interrupts but it only shows interrupts a driver registered and is
using. I noticed a non-constant stream of interrupts on IRQ7 using sar
and I am also able to see it under /proc/interrupts when loading
parport_pc with options to get the driver using the interrupt. However
it is not related to the parallel port because putting it on IRQ5 or
disabling it in the BIOS does not affect the stream of interrupts on
IRQ7. I wonder if people experiencing lockup problems also have these
noise interrupts, and I don't know if this has something to do with the
lockups or if it is an independant problem.

Of course, booting with noapic nolapic, the system is rock-solid, and
the interrupt counter on IRQ7 stays solidly at 1 (should it be 0 ?),
until I use something on the parallel port of course.

Motherboard : abit nfs7-s v2.0, nforce2 chipset
Kernels : 2.6.0-test9, 2.6.0-test10, 2.6.0-test10-mm1, 2.6.0-test11

/proc/interrupts with apic+lapic, shortly after boot, already 408
interrupts on IRQ7 :
           CPU0
  0:     121148          XT-PIC  timer
  1:        279    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  7:        408    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       2591    IO-APIC-edge  ide0
 15:       2916    IO-APIC-edge  ide1
 16:         47   IO-APIC-level  eth0
 18:          0   IO-APIC-level  EMU10K1
 19:       4373   IO-APIC-level  mga@PCI:2:0:0
 20:         31   IO-APIC-level  ohci-hcd
 21:          0   IO-APIC-level  ehci_hcd, NVidia nForce2
 22:          0   IO-APIC-level  ohci-hcd
NMI:          0
LOC:     120982
ERR:          0
MIS:          0

/proc/interrupts with noapic and nolapic, with IRQ7 showing only 1
interrupt since boot : 
           CPU0
  0:     803521          XT-PIC  timer
  1:       1446          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:      54875          XT-PIC  mga@PCI:2:0:0
  7:          1          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:      16027          XT-PIC  ohci_hcd,eth0, NVidia nForce2
 11:    1903732          XT-PIC  bttv0, ehci_hcd, EMU10K1
 12:       9416          XT-PIC  ohci_hcd
 14:       8513          XT-PIC  ide0
 15:       3910          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0



Mathieu
