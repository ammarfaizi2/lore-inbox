Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTEHOWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 10:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTEHOWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 10:22:41 -0400
Received: from franka.aracnet.com ([216.99.193.44]:9102 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261589AbTEHOWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 10:22:39 -0400
Date: Thu, 08 May 2003 05:20:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 678] New: ACPI only enables 16 ouf ot 24 interrupts in the local APIC killing network access (VIA KT400, VT6102)
Message-ID: <24540000.1052396456@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=678

           Summary: ACPI only enables 16 ouf ot 24 interrupts in the local
                    APIC killing network access (VIA KT400, VT6102)
    Kernel Version: 2.5.63-2.5.69
            Status: NEW
          Severity: blocking
             Owner: andrew.grover@intel.com
         Submitter: thunder7@xs4all.nl
                CC: thunder7@xs4all.nl


Distribution: Debian Unstable
Hardware Environment: Epox 8K9A3+ with most recent BIOS, VIA KT-400 + VT6102
network on-board
Software Environment: Debian Unstable
Problem Description:

This bug also happened with earlier kernels, at least back to 2.5.63. Before
that, no kernels were tested. I'll describe what happens with 2.5.69.

A kernel with acpi and local ioapic compiled in boots, but sees only 16 out of
24 interrupts in the local apic. The onboard network (VIA VT6102) uses one of
the 8 lost interrupts and doesn't work. USB not tested due to missing USB devices.
Booting with 'pci=noacpi' or 'acpi=biosirq' doesn't help.

A kernel with acpi and no local ioapic compiled in doesn't boot, hangs after
probing the second ide-controller at ide15: 'ide1 at 0x170-0x177,0x376 on irq
15' is the last line before the system hangs.

Without ACPI, the local ioapic works perfectly, and the onboard network also.

dmesg with acpi on:

Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
Enabling APIC mode:  Flat.  Using 1 I/O APICs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.

dmesg with acpi off:
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-20 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 24.
number of IO-APIC #2 registers: 24.


Steps to reproduce:
compile kernel-2.5.69 with ACPI and local ioapic
boot on Epox 8K9A3+ system board

Various files (dmesg, /proc/interrupts, dsdt etc) gladly available on request.


