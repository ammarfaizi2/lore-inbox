Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbUJ0T7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbUJ0T7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbUJ0T5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:57:16 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:50356 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262646AbUJ0Tur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:50:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BccGg6mF6XhNl4tWY9Jg6BsFmlbzsdQo02UO9cjN6fjxF/8Zw6RtBqxVOGObRnDkvRcodYD7Sg/1jNeVbOZ+GYk2KFpNABJ5upLrfICMKlUFhdtQHqj40bxFj2CBPT8h0mFBt9BFx/UmKcxanpW+ord8BK44K25TOxiDFHOOLZc=
Message-ID: <70fda320410271250426d6277@mail.gmail.com>
Date: Wed, 27 Oct 2004 14:50:46 -0500
From: micah milano <micaho@gmail.com>
Reply-To: micah milano <micaho@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: VGA rediction stops, was Re: Serial over LAN console stops printing
In-Reply-To: <70fda320410251121f1a1beb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <70fda3204102510383294a24@mail.gmail.com>
	 <70fda320410251121f1a1beb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies, I was referring to what the IPMI card was doing as
serial over lan, however the serial port is not involved at all, but
it is clearly capturing the VGA buffer.

Regardless, I haven't been able to figure out what in the kernel is
making the exclusive VGA buffer snatch that is causing this.




On Mon, 25 Oct 2004 13:21:36 -0500, micah milano <micaho@gmail.com> wrote:
> When booting with apic=off, the console prints a little bit more,
> before it stops:
> 
> ta, 208k init, 130496k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay loop... 5521.40 BogoMIPS
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: L3 cache: 1024K
> CPU: Physical Processor ID: 0
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU0: Thermal monitoring enabled
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 05
> per-CPU timeslice cutoff: 1462.65 usecs.
> task migration cache decay timeout: 2 msecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Booting processor 1/1 eip 2000
> 
> Booting with kernel option "noapic" gives:
> 
> ta, 208k init, 130496k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay loop... 5521.40 BogoMIPS
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: L3 cache: 1024K
> CPU: Physical Processor ID: 0
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU0: Thermal monitoring enabled
> Enabling fast FPU save and restore... done.
> 
> 
> 
> On Mon, 25 Oct 2004 12:38:50 -0500, micah milano <micaho@gmail.com> wrote:
> > I've got an IPMI 1.5 card from SuperMicro (so it has the backported
> > IBM serial over lan capability that is normally in 2.0) in a X5DPR-TP+
> > motherboard with a single P4 HT Xeon CPU. Using kernel 2.4.25 I am
> > able to utilize the serial over lan console of the IPMI card without
> > problems (I can see the bootup all the way to the login). However,
> > with a 2.6.7 kernel, the console ceases to print right after
> > "Initializing CPU#0"...  I've been searching the list and the web all
> > weekend trying to figure out what is going on, but most of the
> > problems people have had that are similar relate to failing to
> > configure VGA_CONSOLE, but as you'll see, that is not the case in my
> > config (config attached to this message):
> >
> > # CONFIG_NETCONSOLE is not set
> > CONFIG_VT_CONSOLE=y
> > CONFIG_HW_CONSOLE=y
> > CONFIG_SERIAL_8250_CONSOLE=y
> > CONFIG_SERIAL_CORE_CONSOLE=y
> > CONFIG_VGA_CONSOLE=y
> > # CONFIG_MDA_CONSOLE is not set
> > CONFIG_DUMMY_CONSOLE=y
> >
> > The machine boots all the way up, but that is not visible on the console.
> >
> > Here is everything I see on the console:
> >
> > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> > Processor #1 15:2 APIC version 20
> > ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> > ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> > ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
> > IOAPIC[0]: Assigned apic_id 2
> > IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> > ACPI: IOAPIC (id[0x03] address[0xfec80000] global_irq_base[0x18])
> > IOAPIC[1]: Assigned apic_id 3
> > IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
> > ACPI: IOAPIC (id[0x04] address[0xfec80400] global_irq_base[0x30])
> > IOAPIC[2]: Assigned apic_id 4
> > IOAPIC[2]: apic_id 4, version 32, address 0xfec80400, GSI 48-71
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> > Enabling APIC mode:  Flat.  Using 3 I/O APICs
> > Using ACPI (MADT) for SMP configuration information
> > Built 1 zonelists
> > Kernel command line: root=/dev/md0 ro
> > Initializing CPU#0
> >
> > Here is what is in my dmseg immediately after boot (note: the first
> > part of ACPI is cut off in the dmesg as well):
> >
> > I: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15) *5
> > ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
> > ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
> > ACPI: PCI Interrupt Link [LNKH] (IRQs 3 10 11 14 15) *0, disabled.
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICH3._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.PH2A._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.PH2B._PRT]
> > SCSI subsystem initialized
> > 00:00:1f[A] -> 2-18 -> IRQ 18 level low
> > 00:00:1f[B] -> 2-17 -> IRQ 17 level low
> > 00:00:1d[A] -> 2-16 -> IRQ 16 level low
> > 00:00:1d[B] -> 2-19 -> IRQ 19 level low
> > 00:03:01[A] -> 3-0 -> IRQ 24 level low
> > 00:03:01[B] -> 3-1 -> IRQ 25 level low
> > 00:03:01[C] -> 3-2 -> IRQ 26 level low
> > 00:03:01[D] -> 3-3 -> IRQ 27 level low
> > 00:02:01[A] -> 4-0 -> IRQ 48 level low
> > 00:02:01[B] -> 4-1 -> IRQ 49 level low
> > 00:02:01[C] -> 4-2 -> IRQ 50 level low
> > 00:02:01[D] -> 4-3 -> IRQ 51 level low
> > 00:02:02[A] -> 4-4 -> IRQ 52 level low
> > 00:02:02[B] -> 4-5 -> IRQ 53 level low
> > 00:02:03[A] -> 4-6 -> IRQ 54 level low
> > 00:02:03[B] -> 4-7 -> IRQ 55 level low
> > number of MP IRQ sources: 15.
> > number of IO-APIC #2 registers: 24.
> > number of IO-APIC #3 registers: 24.
> > number of IO-APIC #4 registers: 24.
> > testing the IO APIC.......................
> > IO APIC #2......
> > .... register #00: 02008000
> > .......    : physical APIC id: 02
> > .......    : Delivery Type: 1
> > .......    : LTS          : 0
> > .... register #01: 00178020
> > .......     : max redirection entries: 0017
> > .......     : PRQ implemented: 1
> > .......     : IO APIC version: 0020
> > .... register #02: 00000000
> > .......     : arbitration: 00
> > .... register #03: 00000001
> > .......     : Boot DT    : 1
> > .... IRQ redirection table:
> >  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
> >  00 000 00  1    0    0   0   0    0    0    00
> >  01 003 03  0    0    0   0   0    1    1    39
> >  02 003 03  0    0    0   0   0    1    1    31
> >  03 003 03  0    0    0   0   0    1    1    41
> >  04 003 03  0    0    0   0   0    1    1    49
> >  05 003 03  0    0    0   0   0    1    1    51
> >  06 003 03  0    0    0   0   0    1    1    59
> >  07 003 03  0    0    0   0   0    1    1    61
> >  08 003 03  0    0    0   0   0    1    1    69
> >  09 003 03  0    1    0   0   0    1    1    71
> >  0a 003 03  0    0    0   0   0    1    1    79
> >  0b 003 03  0    0    0   0   0    1    1    81
> >  0c 003 03  0    0    0   0   0    1    1    89
> >  0d 003 03  0    0    0   0   0    1    1    91
> >  0e 003 03  0    0    0   0   0    1    1    99
> >  0f 003 03  0    0    0   0   0    1    1    A1
> >  10 003 03  1    1    0   1   0    1    1    B9
> >  11 003 03  1    1    0   1   0    1    1    B1
> >  12 003 03  1    1    0   1   0    1    1    A9
> >  13 003 03  1    1    0   1   0    1    1    C1
> >  14 000 00  1    0    0   0   0    0    0    00
> >  15 000 00  1    0    0   0   0    0    0    00
> >  16 000 00  1    0    0   0   0    0    0    00
> >  17 000 00  1    0    0   0   0    0    0    00
> > IO APIC #3......
> > .... register #00: 03000000
> > .......    : physical APIC id: 03
> > .......    : Delivery Type: 0
> > .......    : LTS          : 0
> > .... register #01: 00178020
> > .......     : max redirection entries: 0017
> > .......     : PRQ implemented: 1
> > .......     : IO APIC version: 0020
> > .... register #02: 03000000
> > .......     : arbitration: 03
> > .... register #03: 00000001
> > .......     : Boot DT    : 1
> > .... IRQ redirection table:
> >  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
> >  00 003 03  1    1    0   1   0    1    1    C9
> >  01 003 03  1    1    0   1   0    1    1    D1
> >  02 003 03  1    1    0   1   0    1    1    D9
> >  03 003 03  1    1    0   1   0    1    1    E1
> >  04 000 00  1    0    0   0   0    0    0    00
> >  05 000 00  1    0    0   0   0    0    0    00
> >  06 000 00  1    0    0   0   0    0    0    00
> >  07 000 00  1    0    0   0   0    0    0    00
> >  08 000 00  1    0    0   0   0    0    0    00
> >  09 000 00  1    0    0   0   0    0    0    00
> >  0a 000 00  1    0    0   0   0    0    0    00
> >  0b 000 00  1    0    0   0   0    0    0    00
> >  0c 000 00  1    0    0   0   0    0    0    00
> >  0d 000 00  1    0    0   0   0    0    0    00
> >  0e 000 00  1    0    0   0   0    0    0    00
> >  0f 000 00  1    0    0   0   0    0    0    00
> >  10 000 00  1    0    0   0   0    0    0    00
> >  11 000 00  1    0    0   0   0    0    0    00
> >  12 000 00  1    0    0   0   0    0    0    00
> >  13 000 00  1    0    0   0   0    0    0    00
> >  14 000 00  1    0    0   0   0    0    0    00
> >  15 000 00  1    0    0   0   0    0    0    00
> >  16 000 00  1    0    0   0   0    0    0    00
> >  17 000 00  1    0    0   0   0    0    0    00
> > IO APIC #4......
> > .... register #00: 04000000
> > .......    : physical APIC id: 04
> > .......    : Delivery Type: 0
> > .......    : LTS          : 0
> > .... register #01: 00178020
> > .......     : max redirection entries: 0017
> > .......     : PRQ implemented: 1
> > .......     : IO APIC version: 0020
> > .... register #02: 04000000
> > .......     : arbitration: 04
> > .... register #03: 00000001
> > .......     : Boot DT    : 1
> > .... IRQ redirection table:
> >  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
> >  00 003 03  1    1    0   1   0    1    1    E9
> >  01 003 03  1    1    0   1   0    1    1    32
> >  02 003 03  1    1    0   1   0    1    1    3A
> >  03 003 03  1    1    0   1   0    1    1    42
> >  04 003 03  1    1    0   1   0    1    1    4A
> >  05 003 03  1    1    0   1   0    1    1    52
> >  06 003 03  1    1    0   1   0    1    1    5A
> >  07 003 03  1    1    0   1   0    1    1    62
> >  08 000 00  1    0    0   0   0    0    0    00
> >  09 000 00  1    0    0   0   0    0    0    00
> >  0a 000 00  1    0    0   0   0    0    0    00
> >  0b 000 00  1    0    0   0   0    0    0    00
> >  0c 000 00  1    0    0   0   0    0    0    00
> >  0d 000 00  1    0    0   0   0    0    0    00
> >  0e 000 00  1    0    0   0   0    0    0    00
> >  0f 000 00  1    0    0   0   0    0    0    00
> >  10 000 00  1    0    0   0   0    0    0    00
> >  11 000 00  1    0    0   0   0    0    0    00
> >  12 000 00  1    0    0   0   0    0    0    00
> >  13 000 00  1    0    0   0   0    0    0    00
> >  14 000 00  1    0    0   0   0    0    0    00
> >  15 000 00  1    0    0   0   0    0    0    00
> >  16 000 00  1    0    0   0   0    0    0    00
> >  17 000 00  1    0    0   0   0    0    0    00
> > IRQ to pin mappings:
> > IRQ0 -> 0:2
> > IRQ1 -> 0:1
> > IRQ3 -> 0:3
> > IRQ4 -> 0:4
> > IRQ5 -> 0:5
> > IRQ6 -> 0:6
> > IRQ7 -> 0:7
> > IRQ8 -> 0:8
> > IRQ9 -> 0:9
> > IRQ10 -> 0:10
> > IRQ11 -> 0:11
> > IRQ12 -> 0:12
> > IRQ13 -> 0:13
> > IRQ14 -> 0:14
> > IRQ15 -> 0:15
> > IRQ16 -> 0:16
> > IRQ17 -> 0:17
> > IRQ18 -> 0:18
> > IRQ19 -> 0:19
> > IRQ24 -> 1:0
> > IRQ25 -> 1:1
> > IRQ26 -> 1:2
> > IRQ27 -> 1:3
> > IRQ48 -> 2:0
> > IRQ49 -> 2:1
> > IRQ50 -> 2:2
> > IRQ51 -> 2:3
> > IRQ52 -> 2:4
> > IRQ53 -> 2:5
> > IRQ54 -> 2:6
> > IRQ55 -> 2:7
> > .................................... done.
> > PCI: Using ACPI for IRQ routing
> > Simple Boot Flag at 0x36 set to 0x1
> > Machine check exception polling timer started.
> > IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
> > Starting balanced_irq
> > highmem bounce pool size: 64 pages
> > VFS: Disk quotas dquot_6.5.1
> > Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> > devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> > devfs: boot_options: 0x0
> > udf: registering filesystem
> > Initializing Cryptographic API
> > ACPI: Power Button (FF) [PWRF]
> > ACPI: Processor [CPU0] (supports C1)
> > ACPI: Processor [CPU1] (supports C1)
> > Real Time Clock Driver v1.12
> > Non-volatile memory driver v1.2
> > hw_random hardware driver 1.0.0 loaded
> > Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
> > ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> > ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> > Using anticipatory io scheduler
> > Floppy drive(s): fd0 is 1.44M
> > FDC 0 is a post-1991 82077
> > RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> > loop: loaded (max 8 devices)
> > nbd: registered device at major 43
> > Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
> > Copyright (c) 1999-2004 Intel Corporation.
> > e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> > e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > ICH3: IDE controller at PCI slot 0000:00:1f.1
> > ICH3: chipset revision 2
> > ICH3: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0x2060-0x2067, BIOS settings: hda:pio, hdb:pio
> >     ide1: BM-DMA at 0x2068-0x206f, BIOS settings: hdc:pio, hdd:pio
> > hdc: CD-224E, ATAPI CD/DVD-ROM drive
> > ide1 at 0x170-0x177,0x376 on irq 15
> > SiI3112 Serial ATA: IDE controller at PCI slot 0000:03:02.0
> > SiI3112 Serial ATA: chipset revision 2
> > SiI3112 Serial ATA: 100% native mode on irq 26
> >     ide2: MMIO-DMA , BIOS settings: hde:DMA, hdf:DMA
> >     ide3: MMIO-DMA , BIOS settings: hdg:DMA, hdh:DMA
> > hde: Maxtor 6Y120M0, ATA DISK drive
> > ide2 at 0xf8858080-0xf8858087,0xf885808a on irq 26
> > hdg: Maxtor 6Y120M0, ATA DISK drive
> > ide3 at 0xf88580c0-0xf88580c7,0xf88580ca on irq 26
> > SiI3112 Serial ATA: IDE controller at PCI slot 0000:03:03.0
> > SiI3112 Serial ATA: chipset revision 2
> > SiI3112 Serial ATA: 100% native mode on irq 27
> >     ide4: MMIO-DMA , BIOS settings: hdi:pio, hdj:pio
> >     ide5: MMIO-DMA , BIOS settings: hdk:pio, hdl:pio
> > hdi: no response (status = 0xfe)
> > hdk: no response (status = 0xfe)
> > hdi: no response (status = 0xfe), resetting drive
> > hdi: no response (status = 0xfe)
> > hdk: no response (status = 0xfe), resetting drive
> > hdk: no response (status = 0xfe)
> > hde: max request size: 64KiB
> > hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63
> >  /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 >
> > hdg: max request size: 64KiB
> > hdg: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63
> >  /dev/ide/host2/bus1/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 >
> > hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
> > Uniform CD-ROM driver Revision: 3.20
> > libata version 1.02 loaded.
> > mice: PS/2 mouse device common for all mice
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > i2c /dev entries driver
> > md: linear personality registered as nr 1
> > md: raid0 personality registered as nr 2
> > md: raid1 personality registered as nr 3
> > md: raid5 personality registered as nr 4
> > raid5: measuring checksumming speed
> >    8regs     :  3244.000 MB/sec
> >    8regs_prefetch:  2904.000 MB/sec
> >    32regs    :  2144.000 MB/sec
> >    32regs_prefetch:  1960.000 MB/sec
> >    pIII_sse  :  3648.000 MB/sec
> >    pII_mmx   :  4624.000 MB/sec
> >    p5_mmx    :  4536.000 MB/sec
> > raid5: using function: pIII_sse (3648.000 MB/sec)
> > md: multipath personality registered as nr 7
> > md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> > device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
> > NET: Registered protocol family 2
> > IP: routing cache hash table of 8192 buckets, 64Kbytes
> > TCP: Hash tables configured (established 262144 bind 65536)
> > ip_conntrack version 2.1 (8188 buckets, 65504 max) - 300 bytes per conntrack
> > ip_tables: (C) 2000-2002 Netfilter core team
> > ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/proje
> > cts/ipt_recent/
> > arp_tables: (C) 2002 David S. Miller
> > NET: Registered protocol family 1
> > NET: Registered protocol family 10
> > IPv6 over IPv4 tunneling driver
> > ip6_tables: (C) 2000-2002 Netfilter core team
> > registering ipv6 mark target
> > NET: Registered protocol family 17
> > NET: Registered protocol family 15
> > md: Autodetecting RAID arrays.
> > md: autorun ...
> >
> > [snip]
> >
> >
> >
>
