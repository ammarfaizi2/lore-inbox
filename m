Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTGCMWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTGCMWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:22:14 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:16543 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261180AbTGCMWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:22:10 -0400
Message-Id: <5.1.0.14.2.20030703141244.00b00f18@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 03 Jul 2003 14:37:03 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.5.7x ACPI
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: XpnpAqZDoeCJ9XzvnVhmZBWD9tVR6eJ20hXGXounDKanjXNU7q+jED@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This weird happening occurs with 2.5.73 (+bkx), 2.5.74 and 74-mm1.
Laptop Clevo/Kapok. 8500V

Earlier this week (with 2.5.73 + bk), I had started a kernel compile over a 
SSH connection.
The laptop had the X login screen balnked out by the screensaver.
Everything working OK upto this point.
Then I went out to lunch, came back, and thought I had got a case of the 
hot flushes
from one too many glasses of wine until I realized that the laptop was 
performing as
a black body radiator.
A quick look in /proc/acpi showed this !!  :

state:                    ok
temperature:         97 C
critical (S5):          80 C
active[0]:               55 C: devices=0xcffde500
active[1]:               45 C: devices=0xcffde600

The very action of looking into /proc/acpi kicked in the fan and 5-7 
minutes later
I was back to a reasonable 38C (and amazingly it appears the box suffered 
no ill effects!).
Funny, I thought, and eventually realized that this happens when the 
machine is completely idle.
I can now reproduce this behviour on all the above mentioned kernels.

Snip from the boot log below.
Will see what happens without ACPI in the next few days.

Margit



-- SNIP --
Inspecting /boot/System.map-2.5.74
Loaded 26431 symbols from /boot/System.map-2.5.74.
Symbols match kernel version 2.5.74.
No module symbols loaded - kernel modules not enabled.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.5.74 (root@roglap) (gcc version 3.3 (SuSE Linux)) #3 Thu 
Jul 3 13:45:3
3 CEST 2003
<4>Video mode to be used for restore is f00
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
<4> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000ea800 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
<4> BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
<4> BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
<4> BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
<5>255MB LOWMEM available.
<4>On node 0 totalpages: 65520
<4>  DMA zone: 4096 pages, LIFO batch:1
<4>  Normal zone: 61424 pages, LIFO batch:14
<4>  HighMem zone: 0 pages, LIFO batch:1
<6>ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6da0
<6>ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0fffc510
<6>ACPI: FADT (v001 CLEVO  HOFFA    01540.00000) @ 0x0ffffb8c
<6>ACPI: DSDT (v001  Clevo PTL_ACPI 01540.00000) @ 0x00000000
<5>ACPI: BIOS passes blacklist
<4>ACPI: MADT not present
<4>Building zonelist for node : 0
<4>Kernel command line: splash=silent root=/dev/hda2 vga=normal splash=0
<4>Local APIC disabled by BIOS -- reenabling.
<4>Found and enabled local APIC!
<6>Initializing CPU#0
<4>PID hash table entries: 1024 (order 10: 8192 bytes)
<4>Detected 1000.239 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 1957.88 BogoMIPS
<6>Memory: 255124k/262080k available (2359k kernel code, 6228k reserved, 
887k data, 180k
init, 0k highmem)
<6>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<6>-> /dev
<6>-> /dev/console
<6>-> /root
<6>CPU: L1 I cache: 16K, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<7>CPU:     After generic, caps: 0383fbff 00000000 00000000 00000040
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<4>CPU: Intel Pentium III (Coppermine) stepping 0a
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 999.0555 MHz.
<4>..... host bus clock speed is 133.0273 MHz.
<4>mtrr: v2.0 (20020519)
<4>Initializing RT netlink socket
<6>PCI: PCI BIOS revision 2.10 entry at 0xfd82e, last bus=1
<6>PCI: Using configuration type 1
<4>BIO: pool of 256 setup, 14Kb (56 bytes/bio)
<4>biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
<4>biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
<4>biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
<4>biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
<4>biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
<4>biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
<6>ACPI: Subsystem revision 20030619
<4>    ACPI-1121: *** Error: Method execution failed 
[\_SB_.PCI0.PIB_.SIRA._STA] (Node c1
2e4260), AE_AML_NO_RETURN_VALUE
<4>    ACPI-0098: *** Error: Method execution failed 
[\_SB_.PCI0.PIB_.SIRA._STA] (Node c1
2e4260), AE_AML_NO_RETURN_VALUE
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 11 13 14 15, disabled)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs *5 13 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs *10 13 14 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs *11 13 14 15)
<6>ACPI: Embedded Controller [EC0] (gpe 12)
<6>ACPI: Power Resource [PFNL] (on)
<6>ACPI: Power Resource [PFNH] (on)
<6>Linux Plug and Play Support v0.96 (c) Adam Belay
<6>PnPBIOS: Scanning system for PnP BIOS support...
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00f6dc0
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa159, dseg 0x400
<6>PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
<5>SCSI subsystem initialized
<6>drivers/usb/core/usb.c: registered new driver usbfs
<6>drivers/usb/core/usb.c: registered new driver hub
<4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
<6>PCI: Using ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
<4>pty: 256 Unix98 ptys configured
<6>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
<5>apm: overridden by ACPI.
<4>Enabling SEP on CPU 0
<6>devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
<6>devfs: boot_options: 0x0
<5>udf: registering filesystem
<6>PCI: Disabling Via external APIC routing
<6>ACPI: AC Adapter [ADP0] (on-line)
<6>ACPI: Battery Slot [BAT0] (battery present)
<6>ACPI: Power Button (FF) [PWRF]
<6>ACPI: Sleep Button (CM) [SLPB]
<6>ACPI: Lid Switch [LID]
<6>ACPI: Fan [FANL] (on)
<6>ACPI: Fan [FANH] (on)
<6>ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
<6>ACPI: Thermal Zone [THM0] (49 C)

