Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTIMFBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 01:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIMFBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 01:01:21 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:4620 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S261966AbTIMFAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 01:00:41 -0400
Message-ID: <3F62A18A.4090901@boxho.com>
Date: Sat, 13 Sep 2003 00:48:10 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Problem: IDE data corruption with VIA chipsets
References: <001601c37891$660cc5d0$5d74ad8e@hyperwolf>	 <1063305812.3606.4.camel@dhcp23.swansea.linux.org.uk>	 <20030912101454.A17364@bitwizard.nl> <1063363467.5330.5.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063363467.5330.5.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a case of a trashed md that reiserfsck --rebuild-tree could
not repair, involving VIA chip--good log and console error report--

k-2.6.0-test5 unpatched
memtest86 passed
what was the name of that hard drive burn-in util? I have to
prove it's not a bad drive like reiserfck said.
Shuttle SK41G Xpc, FX41 mobo based on VIA KT266, AMD XP 2100+

Theory: I observe that changing to kernel opt deadline io
scheduling coincided with error start. another reason to
run out of time waiting for dma could have been pci delay
transaction disabled in cmos setup. ST340016A isn't one of
those notorious buggy drives is it?

-Bob D

Sep 12 06:27:22 heinous logger: rundig htdig start incremental
# errors are on md3 which is /var, and htdig was indexing
# /var/www/www.some.com's--hdc: ST340016A, ATA DISK drive
Sep 12 06:31:33 heinous kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Sep 12 06:31:33 heinous kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=67028386, sector=67028382
Sep 12 06:31:33 heinous kernel: end_request: I/O error, dev hdc, sector 67028382
Sep 12 06:31:43 heinous kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Sep 12 06:31:43 heinous kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=67028386, sector=67028382
Sep 12 06:31:43 heinous kernel: end_request: I/O error, dev hdc, sector 67028382
Sep 12 06:31:43 heinous kernel: Buffer I/O error on device md3, logical block 2270467
Sep 12 06:31:53 heinous kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Sep 12 06:31:53 heinous kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=67028386, sector=67028382
Sep 12 06:31:53 heinous kernel: end_request: I/O error, dev hdc, sector 67028382
Sep 12 06:31:53 heinous kernel: Buffer I/O error on device md3, logical block 2270467
Sep 12 06:32:03 heinous kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Sep 12 06:32:03 heinous kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=67028386, sector=67028382
Sep 12 06:32:03 heinous kernel: end_request: I/O error, dev hdc, sector 67028382
Sep 12 06:32:03 heinous kernel: Buffer I/O error on device md3, logical block 2270467
# copied with pen and paper from vc on half-dead system--
hdc: dma_int: error=0x40 {UnrecoverableError}, LBAsect=57970918, sector=57970918
end_request: I/O error, dev hdc, sector 57970918
Buffer I/O error on device md3, logical block 6101
lost page write due to I/O error on md3
journal-601, buffer write failed
---------[cut here]-------
kernel BUG at fs/reiserfs/prints.c:339!
invalid operand: 0000 [#1]
CPU: 0
EIP: 0060: [<c01dc1a8>] Not tainted
EFLAGS: 00010282
eax: 00000024 ebx: f79fa600 ecx: c041873c edx: c039b5f8
esi: f8c3e738 edi: 00000001 ebp: 00000000 esp: e4cd5e44
ds: 007b es: 007b ss: 0068
Process: pdflush (pid 4830, threadinfo=e4cd4000 task=e4cf5940
Stack: c0335eo4 c0429420 f8c3e738 f79fa600 c01e77be f79fa600 c0365580 00000000
00001000 00000005 00000008 00000006 00000000 ce195e74 00000018 00000019
f79fa600 3f61a0bf c01eaf1e f79fa600 f8c3e738 00000001 00000006 c035afc1
Call Trace: [<c01e77be>] [<c01eaf1e>] [<c01d90e2>] [<c015718c>]
            [<c013aea6>] [<c011a950>] [<c01314d2>] [<c013b5d0>]
            [<c013b5df>] [<c013ae70>] [<c0108aa0>] [<c0108aa5>]
Code: 0f ob 53 01 73 ad 35 c0 c7 04 24 00 40 36 c0 c7 44 24 08 20
<4>hdc: dma_timer_expiry: dma status == 0x21
hdc: DMA timeout error
hdc: dma timeout error: status=0xd0{Busy}
hdc: DMA disabled
ide1: reset: success
# --not! really, server functions crashed, switching between
# vc's possible but reading from logfile locked up a vc so
# reboot after writing down Call Trace with pen and paper.
# see what reiserfs says on boot, then /usr/src/linux/.config 

Sep 12 19:08:06 heinous syslogd 1.4.1#10: restart.

RAM map:
Sep 12 19:08:06 heinous kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Sep 12 19:08:06 heinous kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Sep 12 19:08:06 heinous kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Sep 12 19:08:06 heinous kernel:  BIOS-e820: 0000000000100000 - 000000003dff0000 (usable)
Sep 12 19:08:06 heinous kernel:  BIOS-e820: 000000003dff0000 - 000000003dff3000 (ACPI NVS)
Sep 12 19:08:06 heinous kernel:  BIOS-e820: 000000003dff3000 - 000000003e000000 (ACPI data)
Sep 12 19:08:06 heinous kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Sep 12 19:08:06 heinous kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Sep 12 19:08:06 heinous kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Sep 12 19:08:06 heinous kernel: 95MB HIGHMEM available.
Sep 12 19:08:06 heinous kernel: 896MB LOWMEM available.
Sep 12 19:08:06 heinous kernel: On node 0 totalpages: 253936
Sep 12 19:08:06 heinous kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep 12 19:08:06 heinous kernel:   Normal zone: 225280 pages, LIFO batch:16
Sep 12 19:08:06 heinous kernel:   HighMem zone: 24560 pages, LIFO batch:5
Sep 12 19:08:06 heinous kernel: DMI 2.2 present.
Sep 12 19:08:06 heinous kernel: ACPI: RSDP (v000 KM266                                     ) @ 0x000f71a0
Sep 12 19:08:06 heinous kernel: ACPI: RSDT (v001 KM266  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3dff3000
Sep 12 19:08:06 heinous kernel: ACPI: FADT (v001 KM266  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3dff3040
Sep 12 19:08:06 heinous kernel: ACPI: DSDT (v001 KM266  AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Sep 12 19:08:06 heinous kernel: ACPI: MADT not present
Sep 12 19:08:06 heinous kernel: Building zonelist for node : 0
Sep 12 19:08:06 heinous kernel: Kernel command line: auto BOOT_IMAGE=u root=301 rw console=ttyS0,9600n8 console=tty0 ramdisk=0 ide0=autotune ide2=autotune
Sep 12 19:08:06 heinous kernel: ide_setup: ide0=autotune
Sep 12 19:08:06 heinous kernel: ide_setup: ide2=autotune
Sep 12 19:08:06 heinous kernel: Found and enabled local APIC!
Sep 12 19:08:06 heinous kernel: Initializing CPU#0
Sep 12 19:08:06 heinous kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Sep 12 19:08:06 heinous kernel: Detected 1735.367 MHz processor.
Sep 12 19:08:06 heinous kernel: Console: colour VGA+ 80x60
Sep 12 19:08:06 heinous kernel: Memory: 1001296k/1015744k available (2297k kernel code, 13552k reserved, 674k data, 172k init, 98240k highmem)
Sep 12 19:08:06 heinous kernel: Calibrating delay loop... 3416.06 BogoMIPS

Sep 12 19:08:06 heinous kernel: CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
Sep 12 19:08:06 heinous kernel: CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
Sep 12 19:08:06 heinous kernel: CPU: CLK_CTL MSR was 6003d223. Reprogramming to 2003d223
Sep 12 19:08:06 heinous kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Sep 12 19:08:06 heinous kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep 12 19:08:06 heinous kernel: CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Sep 12 19:08:06 heinous kernel: Intel machine check architecture supported.
Sep 12 19:08:06 heinous kernel: Intel machine check reporting enabled on CPU#0.
Sep 12 19:08:06 heinous kernel: CPU: AMD Athlon(tm) XP 2100+ stepping 01
Sep 12 19:08:06 heinous kernel: Enabling fast FPU save and restore... done.
Sep 12 19:08:06 heinous kernel: Enabling unmasked SIMD FPU exception support... done.
Sep 12 19:08:06 heinous kernel: Checking 'hlt' instruction... OK.
Sep 12 19:08:06 heinous kernel: POSIX conformance testing by UNIFIX
Sep 12 19:08:06 heinous kernel: enabled ExtINT on CPU#0
Sep 12 19:08:06 heinous kernel: ESR value before enabling vector: 00000000
Sep 12 19:08:06 heinous kernel: ESR value after enabling vector: 00000000
Sep 12 19:08:06 heinous kernel: Using local APIC timer interrupts.
Sep 12 19:08:06 heinous kernel: calibrating APIC timer ...
Sep 12 19:08:06 heinous kernel: ..... CPU clock speed is 1735.0186 MHz.
Sep 12 19:08:06 heinous kernel: ..... host bus clock speed is 266.0951 MHz.
Sep 12 19:08:06 heinous kernel: NET: Registered protocol family 16
Sep 12 19:08:06 heinous kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
Sep 12 19:08:06 heinous kernel: PCI: Using configuration type 1
Sep 12 19:08:06 heinous kernel: mtrr: v2.0 (20020519)
Sep 12 19:08:06 heinous kernel: ACPI: Subsystem revision 20030813
Sep 12 19:08:06 heinous kernel: spurious 8259A interrupt: IRQ7.
Sep 12 19:08:06 heinous kernel: ACPI: Interpreter enabled
Sep 12 19:08:06 heinous kernel: ACPI: Using PIC for interrupt routing
Sep 12 19:08:06 heinous kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep 12 19:08:06 heinous kernel: PCI: Probing PCI hardware (bus 00)
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *7 10 11 12 14 15)
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)
Sep 12 19:08:06 heinous kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Sep 12 19:08:06 heinous kernel: PnPBIOS: Scanning system for PnP BIOS support...
Sep 12 19:08:06 heinous kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fc080
Sep 12 19:08:06 heinous kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc0b0, dseg 0xf0000
Sep 12 19:08:06 heinous kernel: PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
Sep 12 19:08:06 heinous kernel: SCSI subsystem initialized
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
Sep 12 19:08:06 heinous kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
Sep 12 19:08:06 heinous kernel: PCI: Using ACPI for IRQ routing

Sep 12 19:08:06 heinous kernel: agpgart: Detected VIA PM266/KM266 chipset
Sep 12 19:08:06 heinous kernel: agpgart: Maximum main memory to use for agp memory: 909M
Sep 12 19:08:06 heinous kernel: agpgart: AGP aperture is 128M @ 0xd0000000

Sep 12 19:08:06 heinous kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep 12 19:08:06 heinous kernel: Using deadline io scheduler

Sep 12 19:08:06 heinous kernel: eth0: RealTek RTL8139 at 0xf882d000, 00:30:1b:ab:ef:32, IRQ 10

Sep 12 19:08:06 heinous kernel: eth1: Digital DS21143 Tulip rev 65 at 0xf882f000, 00:C0:F0:4C:88:C4, IRQ 11.

Sep 12 19:08:06 heinous kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Sep 12 19:08:06 heinous kernel: VP_IDE: chipset revision 6
Sep 12 19:08:06 heinous kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep 12 19:08:06 heinous kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Sep 12 19:08:06 heinous kernel:     ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:pio
Sep 12 19:08:06 heinous kernel:     ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:pio
Sep 12 19:08:06 heinous kernel: hda: ST340016A, ATA DISK drive
Sep 12 19:08:06 heinous kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 12 19:08:06 heinous kernel: hdc: ST340016A, ATA DISK drive
Sep 12 19:08:06 heinous kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 12 19:08:06 heinous kernel: hda: max request size: 128KiB
Sep 12 19:08:06 heinous kernel: hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Sep 12 19:08:06 heinous kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 > p4
Sep 12 19:08:06 heinous kernel: hdc: max request size: 128KiB
Sep 12 19:08:06 heinous kernel: hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Sep 12 19:08:06 heinous kernel:  /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 < p5 p6 p7 > p4

Sep 12 19:08:06 heinous kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 12 19:08:06 heinous kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep 12 19:08:06 heinous kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

Sep 12 19:08:06 heinous kernel: md: raid0 personality registered as nr 2
Sep 12 19:08:06 heinous kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27

Sep 12 19:08:06 heinous kernel: md: Autodetecting RAID arrays.
Sep 12 19:08:06 heinous kernel: md: autorun ...
Sep 12 19:08:06 heinous kernel: md: ... autorun DONE.
Sep 12 19:08:06 heinous kernel: found reiserfs format "3.6" with standard journal
Sep 12 19:08:06 heinous kernel: Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep 12 19:08:06 heinous kernel: reiserfs: checking transaction log (hda1) for (hda1)
Sep 12 19:08:06 heinous kernel: reiserfs: replayed 1 transactions in 0 seconds
Sep 12 19:08:06 heinous kernel: Using r5 hash to sort names
Sep 12 19:08:06 heinous kernel: Removing [2029 3551 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 3161 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 3157 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 3152 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 3144 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 3143 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 3124 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 3101 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [2029 2834 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 2772 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 2770 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 2735 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 2720 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [2029 2126 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 2120 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [2029 1933 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 1360 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [3 1274 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 677 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: Removing [1345 70 0x0 SD]..done
Sep 12 19:08:06 heinous kernel: There were 20 uncompleted unlinks/truncates. Completed
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
# CONFIG_STANDALONE is not set
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
# CONFIG_KALLSYMS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
###########NOTE!! deadline sched
##########preceded this problem
CONFIG_IOSCHED_DEADLINE=y
## and cmos setup had pci delay
# transaction set OFF, too

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI_HT=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y

#
# Generic Driver Options
#
CONFIG_FW_LOADER=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=0
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_DM is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_FWMARK is not set
CONFIG_IP_ROUTE_NAT=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
# CONFIG_IP_PIMSM_V1 is not set
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
# CONFIG_IP_NF_MATCH_IPRANGE is not set
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
# CONFIG_IP_NF_MATCH_TOS is not set
CONFIG_IP_NF_MATCH_RECENT=y
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
CONFIG_IP_NF_TARGET_REDIRECT=y
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
# CONFIG_IP_NF_TARGET_TOS is not set
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=y
# CONFIG_IP_NF_TARGET_CLASSIFY is not set
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_ACPI=y
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y

#
# I2C Hardware Sensors Mainboard support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIAPRO=y

#
# I2C Hardware Sensors Chip support
#
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_I2C_SENSOR=y

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y



