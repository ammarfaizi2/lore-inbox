Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVLBShw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVLBShw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVLBShv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:37:51 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:27215 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1750896AbVLBShu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:37:50 -0500
Date: Fri, 2 Dec 2005 10:37:48 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp intermittent failures in 2.6.15-rc3-mm1
Message-ID: <20051202183748.GA12584@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200512012242.44995.rjw@sisk.pl>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 10:42:44PM +0100, Rafael J. Wysocki wrote:
> On Thursday, 1 of December 2005 18:36, Andy Isaacson wrote:
> > My Thinkpad X40 (1.25 GB, ipw2200) has had fairly reliable swsusp since
> > 2.6.13 or thereabouts, and as recently as 2.6.15-rc1-mm1 I had about 20
> > successful suspend/resume cycles.  But now that I'm running
> > 2.6.15-rc3-mm1 I'm seeing intermittent failures like this:
> 
> Thanks a lot for the report.
> 
> The problem is apparently caused by my recent patch intended to speed up
> suspend.  Could you please apply the appended debug patch, try to reproduce
> the problem and send full dmesg output back to me?

Here you go.  This is two suspends; the first one completed
successfully, then I triggered a failure by starting a bunch of
processes until highmem looked full.  (Just firefox wasn't enough, so I
started a bunch of vim -R sessions on a 50MB file until HighFree went
under 1MB.)

-andy

[17179569.184000] Linux version 2.6.15-rc3-mm1 (adi@bobble) (gcc version 3.3.4 (Debian 1:3.3.4-9ubuntu5)) #4 Thu Dec 1 18:01:41 PST 2005
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[17179569.184000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000004f6e0000 (usable)
[17179569.184000]  BIOS-e820: 000000004f6e0000 - 000000004f6f7000 (ACPI data)
[17179569.184000]  BIOS-e820: 000000004f6f7000 - 000000004f6f9000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 000000004f700000 - 0000000050000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
[17179569.184000] 374MB HIGHMEM available.
[17179569.184000] 896MB LOWMEM available.
[17179569.184000] On node 0 totalpages: 325344
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:2
[17179569.184000]   DMA32 zone: 0 pages, LIFO batch:2
[17179569.184000]   Normal zone: 225280 pages, LIFO batch:64
[17179569.184000]   HighMem zone: 95968 pages, LIFO batch:64
[17179569.184000] DMI present.
[17179569.184000] ACPI: RSDP (v002 IBM                                   ) @ 0x000f7020
[17179569.184000] ACPI: XSDT (v001 IBM    TP-1U    0x00001550  LTP 0x00000000) @ 0x4f6e9b7e
[17179569.184000] ACPI: FADT (v003 IBM    TP-1U    0x00001550 IBM  0x00000001) @ 0x4f6e9c00
[17179569.184000] ACPI: SSDT (v001 IBM    TP-1U    0x00001550 MSFT 0x0100000e) @ 0x4f6e9db4
[17179569.184000] ACPI: ECDT (v001 IBM    TP-1U    0x00001550 IBM  0x00000001) @ 0x4f6f6da9
[17179569.184000] ACPI: TCPA (v001 IBM    TP-1U    0x00001550 PTL  0x00000001) @ 0x4f6f6dfb
[17179569.184000] ACPI: MADT (v001 IBM    TP-1U    0x00001550 IBM  0x00000001) @ 0x4f6f6e2d
[17179569.184000] ACPI: BOOT (v001 IBM    TP-1U    0x00001550  LTP 0x00000001) @ 0x4f6f6fd8
[17179569.184000] ACPI: DSDT (v001 IBM    TP-1U    0x00001550 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] ACPI: PM-Timer IO Port: 0x1008
[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:13 APIC version 20
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[17179569.184000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: IRQ0 used by override.
[17179569.184000] ACPI: IRQ2 used by override.
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 60000000 (gap: 50000000:aec00000)
[17179569.184000] Built 1 zonelists
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] Enabling fast FPU save and restore... done.
[17179569.184000] Enabling unmasked SIMD FPU exception support... done.
[17179569.184000] Initializing CPU#0
[17179569.184000] Kernel command line: resume=/dev/hda5
[17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[17179569.184000] Detected 598.143 MHz processor.
[17179569.184000] Using pmtmr for high-res timesource
[17179569.184000] Console: colour VGA+ 80x25
[17179570.760000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[17179570.760000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179570.836000] Memory: 1283488k/1301376k available (1821k kernel code, 15828k reserved, 614k data, 168k init, 383872k highmem)
[17179570.836000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[17179570.916000] Calibrating delay using timer specific routine.. 1198.07 BogoMIPS (lpj=2396154)
[17179570.916000] Security Framework v1.0.0 initialized
[17179570.916000] Mount-cache hash table entries: 512
[17179570.916000] CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
[17179570.916000] CPU: After vendor identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
[17179570.916000] CPU: L1 I cache: 32K, L1 D cache: 32K
[17179570.916000] CPU: L2 cache: 2048K
[17179570.916000] CPU: After all inits, caps: afe9fbbf 00000000 00000000 00000040 00000180 00000000 00000000
[17179570.916000] Intel machine check architecture supported.
[17179570.916000] Intel machine check reporting enabled on CPU#0.
[17179570.916000] mtrr: v2.0 (20020519)
[17179570.916000] CPU: Intel(R) Pentium(R) M processor 1.40GHz stepping 06
[17179570.916000] Checking 'hlt' instruction... OK.
[17179571.032000] ENABLING IO-APIC IRQs
[17179571.032000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[17179571.176000] checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
[17179571.176000] Freeing initrd memory: 1684k freed
[17179571.180000] NET: Registered protocol family 16
[17179571.180000] ACPI: bus type pci registered
[17179571.180000] PCI: PCI BIOS revision 2.10 entry at 0xfd8c8, last bus=5
[17179571.180000] PCI: Using configuration type 1
[17179571.180000] ACPI: Subsystem revision 20050916
[17179571.184000] ACPI: Found ECDT
[17179571.336000] ACPI: Interpreter enabled
[17179571.336000] ACPI: Using IOAPIC for interrupt routing
[17179571.340000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.340000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.344000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.344000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.344000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.348000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.348000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[17179571.352000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.352000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[17179571.352000] PCI: Probing PCI hardware (bus 00)
[17179571.364000] Boot video device is 0000:00:02.0
[17179571.364000] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[17179571.364000] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
[17179571.364000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[17179571.364000] PCI: Transparent bridge - 0000:00:1e.0
[17179571.364000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179571.372000] ACPI: Embedded Controller [EC] (gpe 28)
[17179571.372000] ACPI: Power Resource [PUBS] (on)
[17179571.376000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[17179571.384000] PCI: Using ACPI for IRQ routing
[17179571.384000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[17179571.396000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[17179571.396000] PCI: Bus 3, cardbus bridge: 0000:02:00.0
[17179571.396000]   IO window: 00003000-000030ff
[17179571.396000]   IO window: 00003400-000034ff
[17179571.396000]   PREFETCH window: f0000000-f1ffffff
[17179571.396000]   MEM window: d2000000-d3ffffff
[17179571.396000] PCI: Bridge: 0000:00:1e.0
[17179571.396000]   IO window: 3000-7fff
[17179571.396000]   MEM window: d0200000-dfffffff
[17179571.396000]   PREFETCH window: f0000000-f7ffffff
[17179571.396000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179571.396000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179571.396000] Simple Boot Flag at 0x35 set to 0x1
[17179571.396000] highmem bounce pool size: 64 pages
[17179571.396000] VFS: Disk quotas dquot_6.5.1
[17179571.396000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[17179571.396000] Initializing Cryptographic API
[17179571.396000] io scheduler noop registered
[17179571.396000] io scheduler anticipatory registered
[17179571.396000] io scheduler deadline registered
[17179571.396000] io scheduler cfq registered
[17179571.436000] serio: i8042 AUX port at 0x60,0x64 irq 12
[17179571.436000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179571.436000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[17179571.436000] ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 177
[17179571.436000] ACPI: PCI interrupt for device 0000:00:1f.6 disabled
[17179571.436000] mice: PS/2 mouse device common for all mice
[17179571.436000] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[17179571.436000] netconsole: not configured, aborting
[17179571.436000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[17179571.436000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[17179571.436000] ICH4: IDE controller at PCI slot 0000:00:1f.1
[17179571.436000] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[17179571.436000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
[17179571.436000] ICH4: chipset revision 1
[17179571.436000] ICH4: not 100% native mode: will probe irqs later
[17179571.436000]     ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
[17179571.436000]     ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:pio, hdd:pio
[17179571.436000] Probing IDE interface ide0...
[17179571.452000] input: AT Translated Set 2 keyboard as /class/input/input0
[17179571.728000] hda: HTC426040G9AT00, ATA DISK drive
[17179572.400000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[17179572.400000] Probing IDE interface ide1...
[17179572.968000] Probing IDE interface ide1...
[17179573.536000] hda: max request size: 128KiB
[17179573.632000] hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
[17179573.632000] hda: cache flushes supported
[17179573.632000]  hda: hda1 hda2 < hda5 >
[17179573.668000] NET: Registered protocol family 2
[17179573.704000] IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179573.704000] TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
[17179573.704000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[17179573.704000] TCP: Hash tables configured (established 262144 bind 65536)
[17179573.704000] TCP reno registered
[17179573.704000] TCP bic registered
[17179573.704000] Using IPI Shortcut mode
[17179573.712000] ACPI wakeup devices: 
[17179573.712000]  LID SLPB PCI0 PCI1 DOCK USB0 USB1 USB2 AC9M 
[17179573.712000] ACPI: (supports S0 S3 S4 S5)
[17179573.712000] RAMDISK: cramfs filesystem found at block 0
[17179573.712000] RAMDISK: Loading 1684KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/done.
[17179573.724000] VFS: Mounted root (cramfs filesystem) readonly.
[17179573.764000] Freeing unused kernel memory: 168k freed
[17179573.808000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
[17179573.808000] ACPI: Processor [CPU] (supports 8 throttling states)
[17179573.812000] ACPI: Thermal Zone [THM0] (33 C)
[17179573.828000] NET: Registered protocol family 1
[17179573.908000] kjournald starting.  Commit interval 5 seconds
[17179573.908000] EXT3-fs: mounted filesystem with ordered data mode.
[17179622.568000] Adding 500432k swap on /dev/hda5.  Priority:-1 extents:1 across:500432k
[17179622.696000] EXT3 FS on hda1, internal journal
[17179627.952000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[17179628.004000] input: TPPS/2 IBM TrackPoint as /class/input/input1
[17179628.008000] device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
[17179628.280000] ts: Compaq touchscreen protocol output
[17179628.440000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[17179628.440000] md: bitmap version 4.39
[17179630.488000] device-mapper: dm-linear: Device lookup failed
[17179630.488000] device-mapper: error adding target to table
[17179630.496000] device-mapper: dm-linear: Device lookup failed
[17179630.496000] device-mapper: error adding target to table
[17179630.504000] device-mapper: dm-linear: Device lookup failed
[17179630.504000] device-mapper: error adding target to table
[17179630.624000] device-mapper: dm-linear: Device lookup failed
[17179630.624000] device-mapper: error adding target to table
[17179630.672000] device-mapper: dm-linear: Device lookup failed
[17179630.672000] device-mapper: error adding target to table
[17179630.720000] device-mapper: dm-linear: Device lookup failed
[17179630.720000] device-mapper: error adding target to table
[17179630.764000] device-mapper: dm-linear: Device lookup failed
[17179630.764000] device-mapper: error adding target to table
[17179630.808000] device-mapper: dm-linear: Device lookup failed
[17179630.808000] device-mapper: error adding target to table
[17179632.336000] Linux agpgart interface v0.101 (c) Dave Jones
[17179632.384000] agpgart: Detected an Intel 855 Chipset.
[17179632.384000] agpgart: Detected 8060K stolen memory.
[17179632.420000] agpgart: AGP aperture is 128M @ 0xe0000000
[17179633.236000] usbcore: registered new driver usbfs
[17179633.260000] usbcore: registered new driver hub
[17179633.332000] USB Universal Host Controller Interface driver v2.3
[17179633.356000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179633.356000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179633.356000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[17179633.380000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[17179633.380000] uhci_hcd 0000:00:1d.0: irq 169, io base 0x00001820
[17179633.384000] usb usb1: configuration #1 chosen from 1 choice
[17179633.388000] hub 1-0:1.0: USB hub found
[17179633.388000] hub 1-0:1.0: 2 ports detected
[17179633.500000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
[17179633.500000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179633.500000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[17179633.576000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[17179633.576000] uhci_hcd 0000:00:1d.1: irq 193, io base 0x00001840
[17179633.580000] usb usb2: configuration #1 chosen from 1 choice
[17179633.584000] hub 2-0:1.0: USB hub found
[17179633.584000] hub 2-0:1.0: 2 ports detected
[17179633.884000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
[17179633.884000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179633.884000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[17179634.160000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[17179634.160000] uhci_hcd 0000:00:1d.2: irq 185, io base 0x00001860
[17179634.164000] usb usb3: configuration #1 chosen from 1 choice
[17179634.172000] hub 3-0:1.0: USB hub found
[17179634.172000] hub 3-0:1.0: 2 ports detected
[17179636.796000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
[17179636.796000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179636.796000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[17179636.796000] ehci_hcd 0000:00:1d.7: debug port 1
[17179636.796000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[17179636.820000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
[17179636.820000] ehci_hcd 0000:00:1d.7: irq 201, io mem 0xd0100000
[17179636.824000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179636.832000] usb usb4: configuration #1 chosen from 1 choice
[17179636.836000] hub 4-0:1.0: USB hub found
[17179636.836000] hub 4-0:1.0: 6 ports detected
[17179638.112000] hw_random: RNG not detected
[17179639.460000] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 177
[17179639.460000] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[17179640.280000] intel8x0_measure_ac97_clock: measured 55163 usecs
[17179640.280000] intel8x0: clocking to 48000
[17179640.908000] ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 177
[17179640.908000] PCI: Setting latency timer of device 0000:00:1f.6 to 64
[17179641.012000] MC'97 1 converters and GPIO not ready (0xff00)
[17179641.760000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179641.760000] Yenta: CardBus bridge found at 0000:02:00.0 [1014:0555]
[17179641.888000] Yenta: ISA IRQ mask 0x04b8, PCI irq 169
[17179641.888000] Socket status: 30000006
[17179641.888000] pcmcia: parent PCI bridge I/O window: 0x3000 - 0x7fff
[17179641.888000] cs: IO port probe 0x3000-0x7fff: clean.
[17179641.888000] pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xdfffffff
[17179641.888000] pcmcia: parent PCI bridge Memory window: 0xf0000000 - 0xf7ffffff
[17179642.472000] Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
[17179642.472000] Copyright (c) 1999-2005 Intel Corporation.
[17179642.496000] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 20 (level, low) -> IRQ 209
[17179642.964000] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[17179643.376000] ieee80211_crypt: registered algorithm 'NULL'
[17179643.540000] ieee80211: 802.11 data/management/control stack, git-1.1.7
[17179643.540000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[17179643.636000] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
[17179643.636000] ipw2200: Copyright(c) 2003-2005 Intel Corporation
[17179643.660000] ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 21 (level, low) -> IRQ 217
[17179643.660000] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[17179648.804000] ACPI: Battery Slot [BAT0] (battery present)
[17179648.852000] ACPI: AC Adapter [AC] (off-line)
[17179648.904000] ACPI: Power Button (FF) [PWRF]
[17179648.904000] ACPI: Lid Switch [LID]
[17179648.904000] ACPI: Sleep Button (CM) [SLPB]
[17179652.588000] nbd: registered device at major 43
[17179653.688000] pcmcia: Detected deprecated PCMCIA ioctl usage.
[17179653.688000] pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
[17179653.688000] pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
[17179653.688000] cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
[17179653.692000] cs: IO port probe 0x800-0x8ff: clean.
[17179653.692000] cs: IO port probe 0xc00-0xcff: clean.
[17179653.692000] cs: IO port probe 0xa00-0xaff: clean.
[17179656.916000] NET: Registered protocol family 10
[17179656.916000] Disabled Privacy Extensions on device c032cfc0(lo)
[17179656.916000] IPv6 over IPv4 tunneling driver
[17179657.244000] acpi-cpufreq: CPU0 - ACPI performance management activated.
[17179662.276000] [drm] Initialized drm 1.0.1 20051102
[17179662.312000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179662.324000] [drm] Initialized i830 1.3.2 20021108 on minor 0
[17179662.336000] [drm] Initialized i830 1.3.2 20021108 on minor 1
[17179662.336000] mtrr: base(0xe0020000) is not aligned on a size(0x300000) boundary
[17179722.396000] Stopping tasks: ==================================================|
[17179722.396000] Shrinking memory...  Data pages: 14298
[17179722.440000] Data and highmem pages: 31930
[17179722.440000] Total pages: 33048
[17179722.440000] Pages to free: 29798
[17179722.440000] Pages to free: 29798
[17179722.440000] Pages to free: -182028
[17179722.440000] -done (0 pages freed)
[17179722.440000] Suspending device 1-1:unknown codec
[17179722.440000] Suspending device 0-0:AD1981B
[17179722.440000] Suspending device 4-0:1.0
[17179722.440000] Suspending device usb4
[17179722.440000] Suspending device 3-0:1.0
[17179722.440000] Suspending device usb3
[17179722.440000] Suspending device 2-0:1.0
[17179722.440000] Suspending device usb2
[17179722.440000] Suspending device 1-0:1.0
[17179722.440000] Suspending device usb1
[17179722.440000] Suspending device 0.0
[17179722.468000] Suspending device ide0
[17179722.468000] Suspending device serio1
[17179722.468000] Suspending device serio0
[17179722.468000] Suspending device serial8250
[17179722.468000] Suspending device i8042
[17179722.468000] Suspending device 0000:02:02.0
[17179722.468000] eth1: Going into suspend...
[17179722.472000] ACPI: PCI interrupt for device 0000:02:02.0 disabled
[17179722.488000] Suspending device 0000:02:01.0
[17179722.488000] ACPI: PCI interrupt for device 0000:02:01.0 disabled
[17179722.504000] Suspending device 0000:02:00.1
[17179722.504000] Suspending device 0000:02:00.0
[17179722.504000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
[17179722.504000] Suspending device 0000:00:1f.6
[17179722.504000] ACPI: PCI interrupt for device 0000:00:1f.6 disabled
[17179722.504000] Suspending device 0000:00:1f.5
[17179722.504000] ACPI: PCI interrupt for device 0000:00:1f.5 disabled
[17179722.504000] Suspending device 0000:00:1f.3
[17179722.504000] Suspending device 0000:00:1f.1
[17179722.504000] Suspending device 0000:00:1f.0
[17179722.504000] Suspending device 0000:00:1e.0
[17179722.504000] Suspending device 0000:00:1d.7
[17179722.504000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[17179722.520000] Suspending device 0000:00:1d.2
[17179722.520000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[17179722.520000] Suspending device 0000:00:1d.1
[17179722.520000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[17179722.520000] Suspending device 0000:00:1d.0
[17179722.520000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[17179722.520000] Suspending device 0000:00:02.1
[17179722.520000] Suspending device 0000:00:02.0
[17179722.520000] Suspending device 0000:00:00.3
[17179722.520000] Suspending device 0000:00:00.1
[17179722.520000] Suspending device 0000:00:00.0
[17179722.520000] Suspending device pci0000:00
[17179722.520000] Suspending device platform
[17179722.520000] cpufreq: suspend failed to assert current frequency is what timing core thinks it is.
[17179722.520000] ................................................................................................swsusp: Need to copy 31999 pages
[17179722.520000] swsusp: available memory: 197375 pages
[17179722.520000] Intel machine check architecture supported.
[17179722.520000] Intel machine check reporting enabled on CPU#0.
[17179722.520000] swsusp: Restoring Highmem
[17179722.520000] cpufreq: resume failed to assert current frequency is what timing core thinks it is.
[17179772.552000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179772.552000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179772.552000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179772.552000] usb usb1: root hub lost power or was reset
[17179772.552000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
[17179772.552000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179772.552000] usb usb2: root hub lost power or was reset
[17179772.552000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
[17179772.552000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179772.552000] usb usb3: root hub lost power or was reset
[17179772.568000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
[17179772.568000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179772.568000] usb usb4: root hub lost power or was reset
[17179772.572000] ehci_hcd 0000:00:1d.7: debug port 1
[17179772.572000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[17179772.576000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179772.576000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179772.576000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
[17179772.576000] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 177
[17179772.576000] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[17179772.828000] ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 177
[17179772.828000] PCI: Setting latency timer of device 0000:00:1f.6 to 64
[17179773.832000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179773.884000] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 20 (level, low) -> IRQ 209
[17179774.072000] eth1: Coming out of suspend...
[17179774.088000] ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 21 (level, low) -> IRQ 217
[17179774.772000] Restarting tasks... done
[17179784.332000] ipw2200: Firmware error detected.  Restarting.
[17179784.332000] ipw2200: Sysfs 'error' log captured.
[17179784.816000] ipw2200: Firmware error detected.  Restarting.
[17179784.816000] ipw2200: Sysfs 'error' log already exists.
[17179795.072000] ipw2200: Firmware error detected.  Restarting.
[17179795.072000] ipw2200: Sysfs 'error' log already exists.
[17179909.968000] ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
[17179939.412000] ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
[17179946.884000] ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
[17179970.228000] ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
[17179971.660000] Stopping tasks: ============================================================|
[17179972.060000] Shrinking memory...  Data pages: 65794
[17179972.092000] Data and highmem pages: 161459
[17179972.092000] Total pages: 162957
[17179972.092000] Pages to free: 159697
[17179972.092000] Pages to free: 159697
[17179972.092000] Pages to free: -623
[17179972.092000] -done (0 pages freed)
[17179972.092000] Suspending device 1-1:unknown codec
[17179972.092000] Suspending device 0-0:AD1981B
[17179972.092000] Suspending device 4-0:1.0
[17179972.092000] Suspending device usb4
[17179972.092000] Suspending device 3-0:1.0
[17179972.092000] Suspending device usb3
[17179972.092000] Suspending device 2-0:1.0
[17179972.092000] Suspending device usb2
[17179972.092000] Suspending device 1-0:1.0
[17179972.092000] Suspending device usb1
[17179972.092000] Suspending device 0.0
[17179972.172000] Suspending device ide0
[17179972.172000] Suspending device serio1
[17179972.172000] Suspending device serio0
[17179972.172000] Suspending device serial8250
[17179972.172000] Suspending device i8042
[17179972.172000] Suspending device 0000:02:02.0
[17179972.172000] eth1: Going into suspend...
[17179972.176000] ACPI: PCI interrupt for device 0000:02:02.0 disabled
[17179972.192000] Suspending device 0000:02:01.0
[17179972.192000] ACPI: PCI interrupt for device 0000:02:01.0 disabled
[17179972.208000] Suspending device 0000:02:00.1
[17179972.208000] Suspending device 0000:02:00.0
[17179972.208000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
[17179972.208000] Suspending device 0000:00:1f.6
[17179972.208000] ACPI: PCI interrupt for device 0000:00:1f.6 disabled
[17179972.208000] Suspending device 0000:00:1f.5
[17179972.208000] ACPI: PCI interrupt for device 0000:00:1f.5 disabled
[17179972.208000] Suspending device 0000:00:1f.3
[17179972.208000] Suspending device 0000:00:1f.1
[17179972.208000] Suspending device 0000:00:1f.0
[17179972.208000] Suspending device 0000:00:1e.0
[17179972.208000] Suspending device 0000:00:1d.7
[17179972.208000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[17179972.224000] Suspending device 0000:00:1d.2
[17179972.224000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[17179972.224000] Suspending device 0000:00:1d.1
[17179972.224000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[17179972.224000] Suspending device 0000:00:1d.0
[17179972.224000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[17179972.224000] Suspending device 0000:00:02.1
[17179972.224000] Suspending device 0000:00:02.0
[17179972.224000] Suspending device 0000:00:00.3
[17179972.224000] Suspending device 0000:00:00.1
[17179972.224000] Suspending device 0000:00:00.0
[17179972.224000] Suspending device pci0000:00
[17179972.224000] Suspending device platform
[17179972.224000] cpufreq: suspend failed to assert current frequency is what timing core thinks it is.
[17179972.224000] ................................................................................................swsusp: Need to copy 162186 pages
[17179972.224000] swsusp: available memory: 67188 pages
[17179972.224000] swsusp: Not enough free memory
[17179972.224000] Error -12 suspending
[17179972.224000] Intel machine check architecture supported.
[17179972.224000] Intel machine check reporting enabled on CPU#0.
[17179972.224000] swsusp: Restoring Highmem
[17179972.224000] cpufreq: resume failed to assert current frequency is what timing core thinks it is.
[17179975.236000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179975.236000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179975.236000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179975.236000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
[17179975.236000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179975.236000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
[17179975.236000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179975.252000] PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
[17179975.252000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
[17179975.252000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179975.252000] usb usb4: root hub lost power or was reset
[17179975.256000] ehci_hcd 0000:00:1d.7: debug port 1
[17179975.256000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[17179975.260000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179975.260000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179975.260000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
[17179975.260000] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 177
[17179975.260000] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[17179975.512000] ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 177
[17179975.512000] PCI: Setting latency timer of device 0000:00:1f.6 to 64
[17179976.516000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179976.568000] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 20 (level, low) -> IRQ 209
[17179976.768000] eth1: Coming out of suspend...
[17179976.784000] PCI: Enabling device 0000:02:02.0 (0000 -> 0002)
[17179976.784000] ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 21 (level, low) -> IRQ 217
[17179978.052000] Restarting tasks... done
