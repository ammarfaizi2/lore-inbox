Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVLKPUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVLKPUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 10:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVLKPUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 10:20:16 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:38276 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750713AbVLKPUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 10:20:13 -0500
Date: Sun, 11 Dec 2005 16:17:09 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm2
Message-ID: <20051211151709.GA8900@ens-lyon.fr>
References: <20051211041308.7bb19454.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20051211041308.7bb19454.akpm@osdl.org>
X-Sieve: CMU Sieve 2.2
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 12/11/05, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/
>
> - Many new driver updates and architecture updates
>
> - New CPU scheduler policy: SCHED_BATCH.
>
> - New version of the hrtimers code.
>
I have some issues with this kernel (both issue are reproductible on two
different computers):

- i cannot login with xdm, as soon as i login, the X server restarts.
  Login with startx works (.xinitrc is a symlink to .xsession)
  It works fine with 2.6.15-rc5-mm1.
  If you need any log please ask.

- there is a warning when pinging an inexistent ip
  (it works fine with 2.6.15-rc5-mm1 too)

casaverde tonfa # ping 192.168.1.42
PING 192.168.1.42 (192.168.1.42) 56(84) bytes of data.
WARNING: kernel is not very fresh, upgrade is recommended.
>From 192.168.42.1: icmp_seq=2 Destination Host Unreachable

from iputils source code (ping.c):
} else {
        static int once;
        /* Sigh, IP_RECVERR for raw socket
         * was broken until 2.4.9. So, we ignore
         * the first error and warn on the second.
         */
        if (once++ == 1)
                fprintf(stderr, "\rWARNING: kernel is not very fresh, upgrade is recommended.\n");
        if (once == 1)
                return 0;
}

dmesg and config are attached, please ask if you need something else.

regards,

Benoit

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.log"

[17179569.184000] Linux version 2.6.15-rc5-mm2-casaverde (tonfa@casaverde) (gcc version 4.0.2 (Gentoo 4.0.2-r1, pie-8.7.8)) #6 Sun Dec 11 16:02:01 CET 2005
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[17179569.184000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000001ffae000 (usable)
[17179569.184000]  BIOS-e820: 000000001ffae000 - 0000000020000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
[17179569.184000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[17179569.184000] 511MB LOWMEM available.
[17179569.184000] On node 0 totalpages: 130990
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   DMA32 zone: 0 pages, LIFO batch:0
[17179569.184000]   Normal zone: 126894 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 0 pages, LIFO batch:0
[17179569.184000] DMI 2.3 present.
[17179569.184000] ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf00
[17179569.184000] ACPI: RSDT (v001 DELL    CPi R   0x27d5011a ASL  0x00000061) @ 0x1fff0000
[17179569.184000] ACPI: FADT (v001 DELL    CPi R   0x27d5011a ASL  0x00000061) @ 0x1fff0400
[17179569.184000] ACPI: ASF! (v016 DELL    CPi R   0x27d5011a ASL  0x00000061) @ 0x1fff0800
[17179569.184000] ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] Allocating PCI resources starting at 30000000 (gap: 20000000:deda0000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[17179569.184000] mapped APIC to ffffd000 (01401000)
[17179569.184000] Enabling fast FPU save and restore... done.
[17179569.184000] Enabling unmasked SIMD FPU exception support... done.
[17179569.184000] Initializing CPU#0
[17179569.184000] Kernel command line: root=/dev/hda5 video=vesa:mtrr vga=0x317 resume=/dev/hda3
[17179569.184000] CPU 0 irqstacks, hard=c03f9000 soft=c03f8000
[17179569.184000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 1598.905 MHz processor.
[    6.713094] Using tsc for high-res timesource
[    6.713130] Console: colour dummy device 80x25
[    6.713822] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    6.714589] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    6.728683] Memory: 515208k/523960k available (2163k kernel code, 8228k reserved, 671k data, 180k init, 0k highmem)
[    6.728696] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    6.805330] Calibrating delay using timer specific routine.. 3201.11 BogoMIPS (lpj=6402220)
[    6.805370] Mount-cache hash table entries: 512
[    6.805468] CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
[    6.805477] CPU: After vendor identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
[    6.805486] CPU: L1 I cache: 32K, L1 D cache: 32K
[    6.805491] CPU: L2 cache: 2048K
[    6.805495] CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
[    6.805501] Intel machine check architecture supported.
[    6.805507] Intel machine check reporting enabled on CPU#0.
[    6.805517] mtrr: v2.0 (20020519)
[    6.805524] CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 06
[    6.805531] Checking 'hlt' instruction... OK.
[    6.834114] ACPI: setting ELCR to 0200 (from 0800)
[    6.836912] NET: Registered protocol family 16
[    6.836936] ACPI: bus type pci registered
[    6.836944] PCI: Using configuration type 1
[    6.837285] ACPI: Subsystem revision 20050916
[    6.853055] ACPI: Interpreter enabled
[    6.853060] ACPI: Using PIC for interrupt routing
[    6.854270] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    6.854398] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[    6.864947] PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
[    6.864954] PCI quirk: region 0880-08bf claimed by ICH4 GPIO
[    6.865000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    6.865111] Boot video device is 0000:01:00.0
[    6.865355] PCI: Transparent bridge - 0000:00:1e.0
[    6.865413] PCI: Bus #03 (-#06) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[    6.865450] PCI: Bus #07 (-#0a) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[    6.865468] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    6.887855] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
[    6.888096] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
[    6.888335] ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
[    6.888573] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
[    6.888804] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    6.889048] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    6.890187] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[    6.890890] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
[    6.891846] Linux Plug and Play Support v0.97 (c) Adam Belay
[    6.891856] pnp: PnP ACPI init
[    6.920566] pnp: PnP ACPI: found 13 devices
[    6.920611] Generic PHY: Registered new driver
[    6.920701] SCSI subsystem initialized
[    6.920731] PCI: Using ACPI for IRQ routing
[    6.920735] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    6.925838] pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
[    6.925844] pnp: 00:02: ioport range 0x800-0x805 could not be reserved
[    6.925849] pnp: 00:02: ioport range 0x808-0x80f could not be reserved
[    6.925855] pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
[    6.925860] pnp: 00:03: ioport range 0x806-0x807 has been reserved
[    6.925864] pnp: 00:03: ioport range 0x810-0x85f could not be reserved
[    6.925869] pnp: 00:03: ioport range 0x860-0x87f has been reserved
[    6.925873] pnp: 00:03: ioport range 0x880-0x8bf has been reserved
[    6.925878] pnp: 00:03: ioport range 0x8c0-0x8df has been reserved
[    6.925885] pnp: 00:08: ioport range 0x900-0x97f has been reserved
[    6.926055] PCI: Bridge: 0000:00:01.0
[    6.926059]   IO window: c000-cfff
[    6.926064]   MEM window: fc000000-fdffffff
[    6.926069]   PREFETCH window: e8000000-efffffff
[    6.926084] PCI: Bus 3, cardbus bridge: 0000:02:01.0
[    6.926088]   IO window: 0000d000-0000d0ff
[    6.926093]   IO window: 0000d400-0000d4ff
[    6.926099]   PREFETCH window: 30000000-31ffffff
[    6.926104]   MEM window: f6000000-f7ffffff
[    6.926110] PCI: Bus 7, cardbus bridge: 0000:02:01.1
[    6.926113]   IO window: 0000d800-0000d8ff
[    6.926118]   IO window: 0000dc00-0000dcff
[    6.926124]   PREFETCH window: 32000000-33ffffff
[    6.926129]   MEM window: f8000000-f9ffffff
[    6.926134] PCI: Bridge: 0000:00:1e.0
[    6.926138]   IO window: d000-efff
[    6.926145]   MEM window: f6000000-fbffffff
[    6.926150]   PREFETCH window: 30000000-33ffffff
[    6.926167] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    6.926179] PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
[    6.926354] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    6.926359] PCI: setting IRQ 11 as level-triggered
[    6.926362] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[    6.926381] PCI: Enabling device 0000:02:01.1 (0000 -> 0003)
[    6.926386] ACPI: PCI Interrupt 0000:02:01.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[    6.926882] Initializing Cryptographic API
[    6.926888] io scheduler noop registered
[    6.926894] io scheduler anticipatory registered
[    6.926900] io scheduler deadline registered
[    6.926910] io scheduler cfq registered
[    6.927194] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[    6.927199] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[    6.927238] radeonfb: Retreived PLL infos from BIOS
[    6.927243] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=220.00 Mhz, System=200.00 MHz
[    6.927249] radeonfb: PLL min 20000 max 35000
[    7.860497] Non-DDC laptop panel detected
[    8.796754] radeonfb: Monitor 1 type LCD found
[    8.796758] radeonfb: Monitor 2 type no found
[    8.796763] radeonfb: panel ID string: 6J5644141XB
[    8.796764]             
[    8.796769] radeonfb: detected LVDS panel size from BIOS: 1024x768
[    8.796772] radeondb: BIOS provided dividers will be used
[    8.915659] radeonfb: Dynamic Clock Power Management enabled
[    8.945498] Console: switching to colour frame buffer device 128x48
[    8.946600] radeonfb (0000:01:00.0): ATI Radeon Lf 
[    8.946793] vesafb: cannot reserve video memory at 0xe8000000
[    8.946871] vesafb: framebuffer at 0xe8000000, mapped to 0xe1900000, using 3072k, total 32704k
[    8.946969] vesafb: mode is 1024x768x16, linelength=2048, pages=20
[    8.947046] vesafb: protected mode interface info at c000:57f3
[    8.947118] vesafb: scrolling: redraw
[    8.947168] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    8.947278] fb1: VESA VGA frame buffer device
[    8.961426] Real Time Clock Driver v1.12
[    8.961501] Linux agpgart interface v0.101 (c) Dave Jones
[    8.961608] agpgart: Detected an Intel 855PM Chipset.
[    8.970229] agpgart: AGP aperture is 128M @ 0xe0000000
[    8.970403] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    8.973898] serio: i8042 AUX port at 0x60,0x64 irq 12
[    8.974274] serio: i8042 KBD port at 0x60,0x64 irq 1
[    8.974414] mice: PS/2 mouse device common for all mice
[    8.984069] input: AT Translated Set 2 keyboard as /class/input/input0
[   11.985230] floppy0: no floppy controllers found
[   11.988931] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   11.992550] loop: loaded (max 8 devices)
[   11.996058] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   11.999501] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   12.003017] ICH4: IDE controller at PCI slot 0000:00:1f.1
[   12.006545] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   12.010126] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   12.013893] ICH4: chipset revision 1
[   12.017694] ICH4: not 100% native mode: will probe irqs later
[   12.021521]     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
[   12.025413]     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
[   12.029192] Probing IDE interface ide0...
[   12.317121] hda: TOSHIBA MK4026GAX, ATA DISK drive
[   12.988502] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   12.992260] Probing IDE interface ide1...
[   13.728003] hdc: SAMSUNG CDRW/DVD SN-324S, ATAPI CD/DVD-ROM drive
[   14.399870] ide1 at 0x170-0x177,0x376 on irq 15
[   14.404008] hda: max request size: 128KiB
[   14.456566] hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
[   14.460475] hda: cache flushes supported
[   14.464332]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   14.501940] i2c /dev entries driver
[   14.505928] NET: Registered protocol family 2
[   14.543243] IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
[   14.547243] TCP established hash table entries: 32768 (order: 5, 131072 bytes)
[   14.551241] TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
[   14.555226] TCP: Hash tables configured (established 32768 bind 32768)
[   14.559059] TCP reno registered
[   14.562957] TCP bic registered
[   14.566700] NET: Registered protocol family 1
[   14.570395] NET: Registered protocol family 17
[   14.574054] Using IPI Shortcut mode
[   14.591704] ACPI wakeup devices: 
[   14.595332]  LID PBTN PCI0 USB0 USB1 USB2 USB3 MODM PCIE 
[   14.599184] ACPI: (supports S0 S1 S3 S4 S5)
[   14.613136] ReiserFS: hda5: found reiserfs format "3.6" with standard journal
[   15.476013] ReiserFS: hda5: using ordered data mode
[   15.493521] ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   15.501949] ReiserFS: hda5: checking transaction log (hda5)
[   15.591446] ReiserFS: hda5: Using r5 hash to sort names
[   15.595520] VFS: Mounted root (reiserfs filesystem) readonly.
[   15.599704] Freeing unused kernel memory: 180k freed
[   15.603736] Write protecting the kernel read-only data: 304k
[   19.433898] Adding 979956k swap on /dev/hda3.  Priority:-1 extents:1 across:979956k
[   20.629124] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   20.629133] Uniform CD-ROM driver Revision: 3.20
[   20.802001] ieee80211_crypt: registered algorithm 'NULL'
[   20.842859] ieee80211: 802.11 data/management/control stack, git-1.1.7
[   20.842864] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   20.908616] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
[   20.908621] ipw2200: Copyright(c) 2003-2005 Intel Corporation
[   20.908939] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
[   20.908943] PCI: setting IRQ 5 as level-triggered
[   20.908946] ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[   20.909760] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[   21.249384] tg3.c:v3.44 (Dec 6, 2005)
[   21.249649] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[   21.249653] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   21.279578] eth0: Tigon3 [partno(BCM95705A50) rev 3001 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0f:1f:ca:d7:a8
[   21.279585] eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[   21.279588] eth0: dma_rwctrl[763f0000]
[   21.421797] input: DualPoint Stick as /class/input/input1
[   21.444635] input: AlpsPS/2 ALPS DualPoint TouchPad as /class/input/input2
[   21.609241] usbcore: registered new driver usbfs
[   21.609266] usbcore: registered new driver hub
[   21.741786] ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
[   21.741792] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
[   21.741807] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   21.741811] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   21.741840] ehci_hcd 0000:00:1d.7: debug port 1
[   21.741850] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   21.742080] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   21.742089] ehci_hcd 0000:00:1d.7: irq 11, io mem 0xf4fffc00
[   21.745966] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   21.746026] usb usb1: configuration #1 chosen from 1 choice
[   21.746049] hub 1-0:1.0: USB hub found
[   21.746055] hub 1-0:1.0: 6 ports detected
[   21.944599] USB Universal Host Controller Interface driver v2.3
[   21.944651] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   21.944664] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   21.944668] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   21.944712] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   21.944722] uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
[   21.944799] usb usb2: configuration #1 chosen from 1 choice
[   21.944824] hub 2-0:1.0: USB hub found
[   21.944831] hub 2-0:1.0: 2 ports detected
[   22.045347] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   22.045361] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   22.045366] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   22.045399] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   22.045408] uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000bf40
[   22.045477] usb usb3: configuration #1 chosen from 1 choice
[   22.045497] hub 3-0:1.0: USB hub found
[   22.045503] hub 3-0:1.0: 2 ports detected
[   22.149260] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   22.149273] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   22.149277] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   22.149314] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   22.149322] uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
[   22.149386] usb usb4: configuration #1 chosen from 1 choice
[   22.149406] hub 4-0:1.0: USB hub found
[   22.149412] hub 4-0:1.0: 2 ports detected
[   22.374690] ACPI: AC Adapter [AC] (on-line)
[   22.964591] ACPI: Battery Slot [BAT0] (battery present)
[   22.964664] ACPI: Battery Slot [BAT1] (battery absent)
[   23.247501] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
[   23.247508] ACPI: Processor [CPU0] (supports 8 throttling states)
[   23.271434] ACPI: Thermal Zone [THM] (43 C)
[   23.284975] ACPI: Lid Switch [LID]
[   23.284984] ACPI: Power Button (CM) [PBTN]
[   23.284992] ACPI: Sleep Button (CM) [SBTN]
[   31.396382] kjournald starting.  Commit interval 5 seconds
[   31.396393] EXT3-fs: mounted filesystem with ordered data mode.
[   31.424636] ReiserFS: hda6: found reiserfs format "3.6" with standard journal
[   34.132210] ReiserFS: hda6: using ordered data mode
[   34.157151] ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   34.157613] ReiserFS: hda6: checking transaction log (hda6)
[   34.200573] ReiserFS: hda6: Using r5 hash to sort names
[   40.644815] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[   40.644841] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   41.411602] intel8x0_measure_ac97_clock: measured 55471 usecs
[   41.411606] intel8x0: clocking to 48000
[   43.298413] Netfilter messages via NETLINK v0.30.
[   43.385586] ip_conntrack version 2.4 (4093 buckets, 32744 max) - 216 bytes per conntrack
[   43.550112] ip_tables: (C) 2000-2002 Netfilter core team
[   44.384419] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   44.384428] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   44.384431] ide: failed opcode was: 0xec
[   44.392275] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   44.392282] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   44.392285] ide: failed opcode was: 0xec
[   44.400036] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   44.400044] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   44.400046] ide: failed opcode was: 0xec
[   52.066446] [drm] Initialized drm 1.0.1 20051102
[   52.094409] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   52.096030] [drm] Initialized radeon 1.19.0 20050911 on minor 0
[   52.096903] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[   52.097333] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[   52.097344] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[   52.097370] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[   52.159038] [drm] Loading R200 Microcode
[   99.194572] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[   99.194736] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[   99.194794] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[   99.195065] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[   99.195080] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[   99.195107] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[   99.199658] [drm] Loading R200 Microcode
[  315.282095] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[  315.282315] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[  315.282428] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[  315.283177] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  315.283201] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  315.283237] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  315.290306] [drm] Loading R200 Microcode

--7JfCtLOvnd9MIVvH
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--7JfCtLOvnd9MIVvH--
