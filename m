Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTKDJBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 04:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTKDJBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 04:01:18 -0500
Received: from mail1.neceur.com ([193.116.254.3]:44167 "EHLO mail1.neceur.com")
	by vger.kernel.org with ESMTP id S264002AbTKDJA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 04:00:57 -0500
To: linux-kernel@vger.kernel.org
Subject: RE: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
MIME-Version: 1.0
X-Mailer: Lotus Notes Build V65_M1_04032003NP April 03, 2003
Message-ID: <OF9591D1E2.26C95CC8-ON80256DD4.0031771C-80256DD4.003181B0@uk.neceur.com>
From: ross.alexander@uk.neceur.com
Date: Tue, 4 Nov 2003 09:00:44 +0000
X-MIMETrack: Serialize by Router on LDN-THOTH/E/NEC(Release 5.0.10 |March 22, 2002) at
 11/04/2003 09:00:41 AM,
	Serialize complete at 11/04/2003 09:00:41 AM,
	Itemize by SMTP Server on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 11/04/2003 09:00:42 AM,
	Serialize by Router on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 11/04/2003 09:00:44 AM,
	Serialize complete at 11/04/2003 09:00:44 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allen,

I'm more than willing to test any patches you want me to.  I really would 
like to get this whole
hardlock problem fixed and even if we can't do that, cleaning up various 
stuff would be
a good thing.

Many thanks,

Ross

---------------------------------------------------------------------------------
Ross Alexander                           "We demand clearly defined
MIS - NEC Europe Limited            boundaries of uncertainty and
Work ph: +44 20 8752 3394         doubt."




Allen Martin <AMartin@nvidia.com>
11/03/2003 06:36 PM
 
        To:     "'ross.alexander@uk.neceur.com'" 
<ross.alexander@uk.neceur.com>
        cc:     Brad House <brad@mcve.com>, linux-kernel@vger.kernel.org
        Subject:        RE: nforce2 stability on 2.6.0-test5 and 
2.6.0-test9


The PIO data setup and hold times look wrong.  Your harddrive shouldn't be
doing data PIO's anyway, but your CD-ROM will use PIO for some commands. 
It
seems unlikely this is the cause of your instability, but if I make up a
test patch to set the regsisters correctly can you test it out?

-Allen

> -----Original Message-----
> From: ross.alexander@uk.neceur.com 
> [mailto:ross.alexander@uk.neceur.com] 
> Sent: Thursday, October 30, 2003 1:12 AM
> To: Allen Martin
> Cc: Brad House; linux-kernel@vger.kernel.org
> Subject: RE: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
> 
> 
> Allen,
> 
> Here are the config files you requested.  I have also included
> the boot logs from both kernel versions.
> 
> Many thanks for taking an interest.
> 
> Cheers,
> 
> Ross
> 
> **** /proc/interrupts ****
> 
>            CPU0 
>   0:   77764351          XT-PIC  timer
>   1:      35127    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:     146812    IO-APIC-edge  i8042
>  14:     105553    IO-APIC-edge  ide0
>  15:       1371    IO-APIC-edge  ide1
>  19:    5329271   IO-APIC-level  nvidia
>  21:   12326898   IO-APIC-level  NVidia nForce2, eth0
> NMI:          0 
> LOC:   77761842 
> ERR:          0
> MIS:          4
> 
> **** /proc/ide/amd74xxx ****
> 
> ----------AMD BusMastering IDE Configuration----------------
> Driver Version:                     2.11
> South Bridge:                       0000:00:09.0
> Revision:                           IDE 0xa2
> Highest DMA rate:                   UDMA133
> BM-DMA base:                        0xf000
> PCI clock:                          33.3MHz
> -----------------------Primary IDE-------Secondary IDE------
> Prefetch Buffer:              yes                 yes
> Post Write Buffer:            yes                 yes
> Enabled:                      yes                 yes
> Simplex only:                  no                  no
> Cable Type:                   80w                 40w
> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:       UDMA       DMA      UDMA       DMA
> Address Setup:       30ns      90ns      30ns      90ns
> Cmd Active:          90ns      90ns      90ns      90ns
> Cmd Recovery:        30ns      30ns      30ns      30ns
> Data Active:         90ns     330ns      90ns     330ns
> Data Recovery:       30ns     270ns      30ns     270ns
> Cycle Time:          20ns     600ns      60ns     600ns
> Transfer Rate:   99.9MB/s   3.3MB/s  33.3MB/s   3.3MB/s
> 
> 
> **** /proc/ide/ide*/config ****
> 
> pci bus 00 device 48 vendor 10de device 0065 channel 0
> de 10 65 00 05 00 b0 00 a2 8a 01 01 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 01 f0 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
> 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01
> 43 10 11 0c 01 00 02 00 00 00 00 00 00 09 00 00
> 03 f0 00 00 00 00 00 00 a8 20 a8 20 22 00 20 20
> 00 c0 00 c6 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 80 a9 10 00 00 02 0c 00 00 7f 36
> 00 00 46 04 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> pci bus 00 device 48 vendor 10de device 0065 channel 1
> de 10 65 00 05 00 b0 00 a2 8a 01 01 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 01 f0 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
> 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01
> 43 10 11 0c 01 00 02 00 00 00 00 00 00 09 00 00
> 03 f0 00 00 00 00 00 00 a8 20 a8 20 22 00 20 20
> 00 c0 00 c6 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 80 a9 10 00 00 02 0c 00 00 7f 36
> 00 00 46 04 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> **** hdparm -I /dev/hda ****
> 
> 
> /dev/hda:
> 
> ATA device, with non-removable media
>         Model Number:       ST380021A 
>         Serial Number:      3HV4HP3X 
>         Firmware Revision:  3.19 
> Standards:
>         Supported: 5 4 3 2 
>         Likely used: 6
> Configuration:
>         Logical         max     current
>         cylinders       16383   16383
>         heads           16      16
>         sectors/track   63      63
>         --
>         CHS current addressable sectors:   16514064
>         LBA    user addressable sectors:  156301488
>         device size with M = 1024*1024:       76319 MBytes
>         device size with M = 1000*1000:       80026 MBytes (80 GB)
> Capabilities:
>         LBA, IORDY(can be disabled)
>         bytes avail on r/w long: 4      Queue depth: 1
>         Standby timer values: spec'd by Standard
>         R/W multiple sector transfer: Max = 16  Current = 16
>         Recommended acoustic management value: 128, current value: 128
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4 
>              Cycle time: no flow control=240ns  IORDY flow 
> control=120ns
> Commands/features:
>         Enabled Supported:
>            *    READ BUFFER cmd
>            *    WRITE BUFFER cmd
>            *    Host Protected Area feature set
>            *    Look-ahead
>            *    Write cache
>            *    Power Management feature set
>                 Security Mode feature set
>                 SMART feature set
> 
> 
> **** hdparm -I /dev/hdc ****
> 
> /dev/hdc:
> 
> ATAPI CD-ROM, with removable media
>         Model Number:       _NEC    CD-ROM  CD-3002A 
>         Serial Number: 
>         Firmware Revision:  C000 
> Standards:
>         Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
>         Supported: CD-ROM ATAPI-2 
> Configuration:
>         DRQ response: 50us.
>         Packet size: 12 bytes
> Capabilities:
>         LBA, IORDY(can be disabled)
>         DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4 
>              Cycle time: no flow control=120ns  IORDY flow 
> control=120ns
>                 Device Configuration Overlay feature set 
>            *    Automatic Acoustic Management feature set 
>                 SET MAX security extension
>            *    DOWNLOAD MICROCODE cmd
> Security: 
>         Master password revision code = 65534
>                 supported
>         not     enabled
>         not     locked
>         not     frozen
>         not     expired: security count
>         not     supported: enhanced erase
> HW reset results:
>         CBLID- above Vih
>         Device num = 1
> Checksum: correct
> 
> **** syslog linux-2.6.0-test5 ****
> 
> Linux version 2.6.0-test5 (root@mig27) (gcc version 3.3) #7 
> SMP Thu Oct 9 
> 12:55:40 BST 2003
> Video mode to be used for restore is 305
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000005fff0000 (usable)
>  BIOS-e820: 000000005fff0000 - 000000005fff3000 (ACPI NVS)
>  BIOS-e820: 000000005fff3000 - 0000000060000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
>  user: 0000000000000000 - 000000000009fc00 (usable)
>  user: 000000000009fc00 - 00000000000a0000 (reserved)
>  user: 00000000000f0000 - 0000000000100000 (reserved)
>  user: 0000000000100000 - 000000005fff0000 (usable)
>  user: 000000005fff0000 - 000000005fff3000 (ACPI NVS)
>  user: 000000005fff3000 - 0000000060000000 (ACPI data)
>  user: 00000000fec00000 - 00000000fec01000 (reserved)
>  user: 00000000fee00000 - 00000000fee01000 (reserved)
>  user: 00000000ffff0000 - 0000000100000000 (reserved)
> On node 0 totalpages: 393200
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 163824 pages, LIFO batch:16
> Processor #0 6:8 APIC version 16
> IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Building zonelist for node : 0
> Kernel command line: root=/dev/hda1 vga=773 mem=1572800K
> PID hash table entries: 4096 (order 12: 32768 bytes)
> Detected 2162.690 MHz processor.
> Console: colour dummy device 80x25
> Calibrating delay loop... 4276.22 BogoMIPS
> Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> POSIX conformance testing by UNIFIX
> CPU0: AMD Athlon(tm) XP 2700+ stepping 01
> per-CPU timeslice cutoff: 731.66 usecs.
> task migration cache decay timeout: 1 msecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Error: only one processor found.
> ENABLING IO-APIC IRQs
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 2162.0402 MHz.
> ..... host bus clock speed is 332.0677 MHz.
> Starting migration thread for cpu 0
> CPUS done 8
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 
> 15, disabled)
> ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 11 12 14 
> 15, disabled)
> ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 
> 15, disabled)
> ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 
> 15, disabled)
> ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 11 12 14 
> 15, disabled)
> ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 
> 15, disabled)
> ACPI: PCI Interrupt Link [APC1] (IRQs *16)
> ACPI: PCI Interrupt Link [APC2] (IRQs *17)
> ACPI: PCI Interrupt Link [APC3] (IRQs *18)
> ACPI: PCI Interrupt Link [APC4] (IRQs *19)
> ACPI: PCI Interrupt Link [APC5] (IRQs 16, disabled)
> ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [APCS] (IRQs 23, disabled)
> ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22, disabled)
> ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
> ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
> ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
> ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
> ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
> ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
> ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
> ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
> ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
> ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 21
> ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 20
> ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
> ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
> ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
> ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
> Console: switching to colour frame buffer device 128x48
> pty: 256 Unix98 ptys configured
> highmem bounce pool size: 64 pages
> AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
> hda: ST380021A, ATA DISK drive
> Using anticipatory scheduling io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: _NEC CD-ROM CD-3002A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> Console: switching to colour frame buffer device 128x48
> VFS: Mounted root (ext2 filesystem) readonly.
> hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
> nvidia: module license 'NVIDIA' taints kernel.
> 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module 
> 1.0-4496  Wed 
> Jul 16 19:03:09 PDT 2003
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 
> **** syslog linux-2.6.0-test9 ****
> 
> Linux version 2.6.0-test9 (root@mig27) (gcc version 3.3.2) #1 
> SMP Mon Oct 
> 27 10:16:25 GMT 2003
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000005fff0000 (usable)
>  BIOS-e820: 000000005fff0000 - 000000005fff3000 (ACPI NVS)
>  BIOS-e820: 000000005fff3000 - 0000000060000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
>  user: 0000000000000000 - 000000000009fc00 (usable)
>  user: 000000000009fc00 - 00000000000a0000 (reserved)
>  user: 00000000000f0000 - 0000000000100000 (reserved)
>  user: 0000000000100000 - 000000005fff0000 (usable)
> On node 0 totalpages: 393200
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 163824 pages, LIFO batch:16
> Processor #0 6:8 APIC version 16
> IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Building zonelist for node : 0
> Kernel command line: root=/dev/hda1 vga=773 mem=1572800K
> PID hash table entries: 4096 (order 12: 32768 bytes)
> Detected 2162.834 MHz processor.
> Console: colour dummy device 80x25
> Calibrating delay loop... 4276.22 BogoMIPS
> Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> POSIX conformance testing by UNIFIX
> CPU0: AMD Athlon(tm) XP 2700+ stepping 01
> per-CPU timeslice cutoff: 731.66 usecs.
> task migration cache decay timeout: 1 msecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 2162.0362 MHz.
> ..... host bus clock speed is 332.0671 MHz.
> Starting migration thread for cpu 0
> CPUS done 8
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [APC1] (IRQs *16)
> ACPI: PCI Interrupt Link [APC2] (IRQs *17)
> ACPI: PCI Interrupt Link [APC3] (IRQs *18)
> ACPI: PCI Interrupt Link [APC4] (IRQs *19)
> ACPI: PCI Interrupt Link [APC5] (IRQs 16)
> ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCS] (IRQs 23)
> ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
> ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
> ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
> ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
> ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
> ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
> ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
> ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
> ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
> ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 21
> ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 20
> ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
> ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
> ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
> ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
> highmem bounce pool size: 64 pages
> Console: switching to colour frame buffer device 128x48
> pty: 256 Unix98 ptys configured
> AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
> hda: ST380021A, ATA DISK drive
> hda: IRQ probe failed (0xfffffdfa)
> hdb: IRQ probe failed (0xfffffdfa)
> hdb: IRQ probe failed (0xfffffdfa)
> Using anticipatory io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: _NEC CD-ROM CD-3002A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> Console: switching to colour frame buffer device 128x48
> VFS: Mounted root (ext2 filesystem) readonly.
> hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
> nvidia: module license 'NVIDIA' taints kernel.
> 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module 
> 1.0-4496  Wed 
> Jul 16 19:03:09 PDT 2003
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 
> --------------------------------------------------------------
> -------------------
> Ross Alexander                           "We demand clearly defined
> MIS - NEC Europe Limited            boundaries of uncertainty and
> Work ph: +44 20 8752 3394         doubt."
> 


