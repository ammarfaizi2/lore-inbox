Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUK2WIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUK2WIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUK2WIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:08:40 -0500
Received: from zaphod.axian.com ([64.122.196.146]:29136 "EHLO zaphod.axian.com")
	by vger.kernel.org with ESMTP id S261822AbUK2WHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:07:47 -0500
Subject: Re: odd behavior with r8169 and pcap
From: Terry Griffin <terryg@axian.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
In-Reply-To: <20041129210213.GA3880@electric-eye.fr.zoreil.com>
References: <1101751909.2291.21.camel@tux.hq.axian.com>
	 <20041129210213.GA3880@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Message-Id: <1101766059.3382.57.camel@tux.hq.axian.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 14:07:39 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 13:02, Francois Romieu wrote:
> Terry Griffin <terryg@axian.com> :
> [...]
> > So the obvious questions are: Is this a known problem? Why the
> > heck does it do this? Is there a fix or workaround to get the
> > high rate all the time other than running a pcap utility 24x7?
> 
> 1 - not really
> 2 - details please:
>     - which kernel versions have been tested ?
>     - when did the bahavior appear first ?
>     - which compiler version ?
>     - can you provide a short description of the hardware ?
>     - lspci -vx, lsmod, dmesg after boot, /proc/interrupts, vmstat 1
>       for a few seconds when ok/nok will be welcome
> 3 - can it be reproduced with latest -bk ?
> 
> Please Cc: netdev@oss.sgi.com.
> 
> --
> Ueimor
> -

I don't know when it first appeared. I just got my hands on this
hardware and the problem has been there from the beginning.

I've tested the pre-built 2.6.5-1 kernel that came with Fedora Core 2
and the 2.6.9 kernel from kernel.org.

The compiler is gcc 3.3.3.

The hardware is a Dell Dimension 3000, 2.8 GHz P4 (not hyperthreading),
with 512MB RAM. There are *two* Realtek RTL-8169 adapters installed.
lspci identifies them as:

01:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)
01:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)


lspci -vx gives:

00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub
Interface (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: bus master, fast devsel, latency 0
        Memory at f0000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [1106]
00: 86 80 70 25 06 01 90 20 02 00 00 06 00 00 00 00
10: 08 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 9d 01
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated
Graphics Device (rev 02) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: fast devsel, IRQ 11
        Memory at e8000000 (32-bit, prefetchable)
        Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at ed98 [size=8]
        Capabilities: [d0] Power Management version 1
00: 86 80 72 25 03 00 90 00 02 00 00 03 00 00 00 00
10: 08 00 00 e8 00 00 b8 fe 99 ed 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 9d 01
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0b 01 00 00

00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at ff80 [size=32]
00: 86 80 d2 24 05 00 80 02 02 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 ff 00 00 00 00 00 00 00 00 00 00 28 10 9d 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at ff60 [size=32]
00: 86 80 d4 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 ff 00 00 00 00 00 00 00 00 00 00 28 10 9d 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at ff20 [size=32]
00: 86 80 de 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 ff 00 00 00 00 00 00 00 00 00 00 28 10 9d 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: bus master, medium devsel, latency 0, IRQ 9
        Memory at ffa80800 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]
00: 86 80 dd 24 06 01 90 02 02 20 03 0c 00 00 00 00
10: 00 08 a8 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 9d 01
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 04 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI
Bridge (rev c2) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe900000-feafffff
00: 86 80 4e 24 07 01 80 00 c2 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 d0 d0 80 22
20: 90 fe a0 fe f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00

00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev
02)
        Flags: bus master, medium devsel, latency 0
00: 86 80 d0 24 0f 01 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ffa0 [size=16]
        Memory at feb7fc00 (32-bit, non-prefetchable) [size=1K]
00: 86 80 db 24 07 00 88 02 02 8a 01 01 00 00 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: a1 ff 00 00 00 fc b7 fe 00 00 00 00 28 10 9d 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 00

00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev
02)
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: medium devsel, IRQ 3
        I/O ports at eda0 [size=32]
00: 86 80 d3 24 01 00 80 02 02 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ed 00 00 00 00 00 00 00 00 00 00 28 10 9d 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 02 00 00

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R)
AC'97 Audio Controller (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: bus master, medium devsel, latency 0, IRQ 3
        I/O ports at ee00
        I/O ports at edc0 [size=64]
        Memory at feb7fa00 (32-bit, non-prefetchable) [size=512]
        Memory at feb7f900 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
00: 86 80 d5 24 07 00 90 02 02 00 01 04 00 00 00 00
10: 01 ee 00 00 c1 ed 00 00 00 fa b7 fe 00 f9 b7 fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 9d 01
30: 00 00 00 00 50 00 00 00 00 00 00 00 03 02 00 00

01:00.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link
Layer Controller (rev 01) (prog-if 10 [OHCI])
        Subsystem: AFAVLAB Technology Inc: Unknown device 702a
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at fe9fa800 (32-bit, non-prefetchable)
        Memory at fe9fc000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
00: 4c 10 25 80 16 01 10 02 01 10 00 0c 10 40 00 00
10: 00 a8 9f fe 00 c0 9f fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 db 14 2a 70
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 02 04

01:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit
Ethernet
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 9
        I/O ports at dd00 [size=fea00000]
        Memory at fe9fa600 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [dc] Power Management version 2
00: ec 10 69 81 17 01 b0 02 10 00 00 02 10 40 00 00
10: 01 dd 00 00 00 a6 9f fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 69 81
30: 00 00 a0 fe dc 00 00 00 00 00 00 00 09 01 20 40

01:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit
Ethernet
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 3
        I/O ports at de00 [size=fea00000]
        Memory at fe9fa700 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [dc] Power Management version 2
00: ec 10 69 81 17 01 b0 02 10 00 00 02 10 40 00 00
10: 01 de 00 00 00 a7 9f fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 69 81
30: 00 00 a0 fe dc 00 00 00 00 00 00 00 03 01 20 40

01:08.0 Ethernet controller: Intel Corp. 82562EZ 10/100 Ethernet
Controller (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 019d
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at fe9fb000 (32-bit, non-prefetchable)
        I/O ports at dcc0 [size=64]
        Capabilities: [dc] Power Management version 2
00: 86 80 50 10 17 01 90 02 02 00 00 02 10 40 00 00
10: 00 b0 9f fe c1 dc 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 9d 01
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 08 38


lsmod gives:

Module                  Size  Used by
r8169                  16008  0 
md5                     3968  1 
ipv6                  216448  10 
autofs4                14852  0 
sunrpc                124516  1 
e100                   29568  0 
mii                     3968  1 e100
microcode               5408  0 
dm_mod                 48508  0 
uhci_hcd               27920  0 
ehci_hcd               26884  0 
button                  5008  0 
battery                 7300  0 
ac                      3460  0 
ext3                  102120  2 
jbd                    48664  1 ext3
ata_piix                6404  0 
libata                 36484  1 ata_piix
sd_mod                 14096  0 
scsi_mod              100044  2 libata,sd_mod


dmesg after boot gives:

Linux version 2.6.9tg3 (root@tux.hq.axian.com) (gcc version 3.3.3
20040412 (Red Hat Linux 3.3.3-7)) #5 Tue Nov 23 09:48:48 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fe70000 (usable)
 BIOS-e820: 000000001fe70000 - 000000001fe72000 (ACPI NVS)
 BIOS-e820: 000000001fe72000 - 000000001fe93000 (ACPI data)
 BIOS-e820: 000000001fe93000 - 000000001ff00000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
510MB LOWMEM available.
On node 0 totalpages: 130672
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126576 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000feb90
ACPI: RSDT (v001 DELL    3000    0x00000007 ASL  0x00000061) @
0x000fd28b
ACPI: FADT (v001 DELL    3000    0x00000007 ASL  0x00000061) @
0x000fd2bf
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @
0xfffd1a9a
ACPI: MADT (v001 DELL    3000    0x00000007 ASL  0x00000061) @
0x000fd333
ACPI: BOOT (v001 DELL    3000    0x00000007 ASL  0x00000061) @
0x000fd39f
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @
0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Kernel command line: ro root=LABEL=/
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2794.847 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514128k/522688k available (1949k kernel code, 7900k reserved,
655k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 5537.79 BogoMIPS (lpj=2768896)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 270k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfbbf8, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 3
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:01:02.0[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 5 (level, low) -> IRQ 5
Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Simple Boot Flag at 0x7a set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1101763151.4294967114:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: Detected 892K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized i830 1.3.2 20021108 on minor 0: 
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST340014A, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: GCR-8483B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
VBTN PCI0 USB0 USB1 USB2 USB3 PCI1  KBD 
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
libata version 1.02 loaded.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 160k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
ACPI: Power Button (FF) [PWRF]
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 9 (level, low) -> IRQ 9
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 9, pci mem e082e800
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0000ff80
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 10, io base 0000ff60
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.3: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 11, io base 0000ff20
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
EXT3 FS on hda2, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
cdrom: open failed.
Adding 1044216k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: No suitable data for CPU0
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 5 (level, low) -> IRQ 5
divert: allocating divert_blk for eth0
e100: eth0: e100_probe: addr 0xfe9fb000, irq 5, MAC addr
00:11:11:5C:BF:ED
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 10
Disabled Privacy Extensions on device c034c5c0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
r8169 Gigabit Ethernet driver 1.2 loaded
ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 9 (level, low) -> IRQ 9
divert: allocating divert_blk for eth1
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xe085c600, 00:40:f4:a9:d7:b2, IRQ 9
ACPI: PCI interrupt 0000:01:02.0[A] -> GSI 3 (level, low) -> IRQ 3
divert: allocating divert_blk for eth2
eth2: Identified chip type is 'RTL8169s/8110s'.
eth2: RTL8169 at 0xe0862700, 00:40:f4:a9:d8:84, IRQ 3
r8169: eth1: link up
r8169: eth2: link up
eth1: no IPv6 routers present
eth2: no IPv6 routers present


When slow (no pcap monitoring) /proc/interrupts is:

          CPU0       
  0:    1531617          XT-PIC  timer
  1:         16          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:         56          XT-PIC  eth2
  5:       2918          XT-PIC  eth0
  8:          1          XT-PIC  rtc
  9:       8861          XT-PIC  acpi, ehci_hcd, eth1
 10:          0          XT-PIC  uhci_hcd
 11:          0          XT-PIC  uhci_hcd, uhci_hcd
 12:        290          XT-PIC  i8042
 14:       3391          XT-PIC  ide0
 15:         18          XT-PIC  ide1
NMI:          0 
ERR:          0

And vmstat 1 gives:

procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
 0  0      0 406816   8636  72444    0    0    19    36 1023    34  0  0
99  1
 0  0      0 399968   8652  79164    0    0     0 11680 4477  3563  0 11
67 22
 0  0      0 398944   8652  80184    0    0     0     0 1567   557  0  3
88  9
 0  0      0 395808   8656  83244    0    0     0     0 2671  1787  0  5
95  0
 0  0      0 392992   8656  85944    0    0     0     0 2483  1547  0  4
90  6
 0  0      0 390432   8668  88404    0    0     0    36 2334  1475  0  6
84 10
 0  0      0 384416   8680  94524    0    0     0 14260 4229  3411  0 12
53 35
 0  0      0 383200   8684  95664    0    0     0     0 1633   635  0  1
89 10
 0  0      0 381728   8684  97104    0    0     0     0 1788   841  1  3
96  0


When fast (with pcap monitoring) /proc/interrupts is:

          CPU0       
  0:    1652710          XT-PIC  timer
  1:         16          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:         56          XT-PIC  eth2
  5:       3147          XT-PIC  eth0
  8:          1          XT-PIC  rtc
  9:     232548          XT-PIC  acpi, ehci_hcd, eth1
 10:          0          XT-PIC  uhci_hcd
 11:          0          XT-PIC  uhci_hcd, uhci_hcd
 12:        290          XT-PIC  i8042
 14:       4086          XT-PIC  ide0
 15:         18          XT-PIC  ide1
NMI:          0 
ERR:          0

and vmstat 1 gives:

procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
 0  1      0 183316   2864 304900    0    0    18   572 1207   148  0  1
97  1
 0  1      0 134420   2868 352420    0    0     0 49156 10313  3223  1
83  0 16
 0  0      0  89236   2868 396700    0    0     0 40960 11536  3147  1
79  8 12
 1  0      0  44500   2868 440320    0    0     0 45056 13089  3174  1
80 19  0
 0  3      0   2796   2868 483520    0    0     0 44372 12912  3184  2
81 10  7
 0  2      0   2216    860 487284    0    0     0  6392 12956  3243  0
84  0 16
 1  0      0   2280    844 486720    0    0     0 33296 13276  3207  1
81 11  7
 0  0      0   2152    848 486588    0    0     0 40960 12911  3241  2
81 17  0
 1  0      0   1704    848 486552    0    0     0 45068 12938  3169  1
80 19  0

I will try -bk and follow up.

I will also try yanking one of the two RealTek adapters to see if that
makes any difference for the remaining adapter. (I should have thought
of that before.)

Thanks,
Terry


