Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbWJ3Kgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbWJ3Kgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbWJ3Kgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:36:32 -0500
Received: from tornado.reub.net ([203.222.131.131]:49892 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S1161221AbWJ3Kgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:36:31 -0500
Message-ID: <4545D5AF.1090800@reub.net>
Date: Mon, 30 Oct 2006 21:36:31 +1100
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 2.0b1pre (Windows/20061027)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19-rc3-mm1
References: <20061029160002.29bb2ea1.akpm@osdl.org>
In-Reply-To: <20061029160002.29bb2ea1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2006 11:00 AM, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc3/2.6.19-rc3-mm1/
> 
> - ia64 doesn't compile due to improvements in acpi.  I already fixed a huge
>   string of build errors due to this and it's someone else's turn.
> 
> - For some reason Greg has resurrected the patches which detect whether
>   you're using old versions of udev and if so, punish you for it.
> 
>   If weird stuff happens, try upgrading udev.

udev-095 here.

Some slightly odd messages in dmesg.  Overall this -mm boots and runs and seems 
to be reasonably good (the last -mm didn't boot for me).

1. NMI message - I too, am dazed and confused about this one:

Linux version 2.6.19-rc3-mm1 (root@tornado.reub.net) (gcc version 4.1.1 20061025 
(Red Hat 4.1.1-31)) #1 SMP Mon Oct 30 11:15:58
  EST 2006
Command line: ro root=/dev/md0 panic=60 console=ttyS0,57600

...

CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20061011
Using local APIC timer interrupts.
result 12500379
Detected 12.500 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.02 BogoMIPS (lpj=12000044)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
               Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Brought up 2 CPUs
testing NMI watchdog ... CPU#0: NMI appears to be stuck (58->63)!
OK.
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
Uhhuh. NMI received for unknown reason 3c.
Do you have a strange power saving mode enabled?
Dazed and confused, but trying to continue
time.c: Detected 3000.114 MHz processor.
migration_cost=21

It's a desktop PC/server, no strange power saving mode going on here.  Unsure 
who looks after this or why it would occur.


2. Think this is ok, but still - timeouts, frozen - all words that suggest 
suboptimal things have gone on:

ata_piix 0000:00:1f.1: version 2.00ac7
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x20B0 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x20B8 irq 15
scsi0 : ata_piix
ata1.00: ATAPI, max UDMA/66
ata1.00: configured for UDMA/66
scsi1 : ata_piix
ata2: port disabled. ignoring.
ATA: abnormal status 0xFF on port 0x177
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x24)
ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/66
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x24)
ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/66
ata1: EH complete
scsi 0:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-111D 1.23 PQ: 0 ANSI: 5
scsi 0:0:0:0: Attached scsi generic sg0 type 5
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0x20C8 ctl 0x20EE bmdma 0x20A0 irq 19
ata4: SATA max UDMA/133 cmd 0x20C0 ctl 0x20EA bmdma 0x20A8 irq 19
scsi2 : ata_piix

The device on ata1 is the DVD-RW Atapi.

All devices seem to be detected and work, so it may be just cosmetic.  Alan?

Reuben




