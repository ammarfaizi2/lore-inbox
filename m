Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUCXVM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUCXVM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:12:57 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:42453 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261930AbUCXVMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:12:48 -0500
Date: Wed, 24 Mar 2004 22:12:31 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, matthias.andree@gmx.de,
       andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 SMP - BUG at page_alloc.c:105
Message-ID: <20040324211231.GB14579@merlin.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>, andrea@suse.de,
	linux-kernel@vger.kernel.org
References: <20040324205811.GB6572@logos.cnet> <20040324122806.4015d3d6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324122806.4015d3d6.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004, Andrew Morton wrote:

> I'd suspect that's just gunk on the stack and that zap_pte_range() freed an
> anonymous page which had a non-null ->mapping.  It could be a hardware bug.
> Without seeing the actual value of page->mapping it's hard to know.

Any chance to retrieve that when the machine has been rebooted since? I
fear there is none.

I have these log entries from boot-up (after the crash), seems the BIOS
isn't perfect (Tyan S2460 "Tiger MP" w/ BIOS 1.05):

...
128MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
found SMP MP-table at 000f7510
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262144
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32768 pages.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 2
Kernel command line: root=/dev/hda5 vga=791 splash=silent showopts noapic
Initializing CPU#0
Detected 1533.378 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3060.53 BogoMIPS
Memory: 1032772k/1048576k available (1902k kernel code, 15416k reserved, 636k data, 152k init, 131072k highmem)
...
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 1800+ stepping 02
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (6121.06 BogoMIPS).
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1533.3658 MHz.
..... host bus clock speed is 266.6723 MHz.
cpu: 0, clocks: 2666723, slice: 888907
CPU0<T0:2666720,T1:1777808,D:5,S:888907,C:2666723>
cpu: 1, clocks: 2666723, slice: 888907
CPU1<T0:2666720,T1:888896,D:10,S:888907,C:2666723>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
ACPI: Subsystem revision 20040116
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfd7e0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
BIOS failed to enable PCI standards compliance, fixing this error.
I/O APIC: AMD Errata #22 may be present. In the event of instability try
        : booting with the "noapic" option.
...


Don't waste countless efforts debugging this 

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
