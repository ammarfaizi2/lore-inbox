Return-Path: <linux-kernel-owner+w=401wt.eu-S965046AbXABW5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbXABW5b (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbXABW5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:57:30 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:55459 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964998AbXABW50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:57:26 -0500
Message-ID: <459AE34D.8040709@blueyonder.co.uk>
Date: Tue, 02 Jan 2007 22:57:17 +0000
From: Sid Boyce <g3vbv@blueyonder.co.uk>
Reply-To: g3vbv@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Len Brown <lenb@kernel.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.19 and up to 2.6.20-rc2 Ethernet problems x86_64
References: <459A7D46.5000509@blueyonder.co.uk> <200701021159.24945.lenb@kernel.org>
In-Reply-To: <200701021159.24945.lenb@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------040106070705020900050401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040106070705020900050401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Len Brown wrote:
> On Tuesday 02 January 2007 10:41, Sid Boyce wrote:
>   
>> Same problem with 2.6.19-rc3.
>>     
>
> Do you mean 2.6.20-rc3 still does not work?
> What was the last kernel that worked properly with no cmdline parameters?
>
>   
That's correct, same problem with 2.6.20-rc3. Last worked with 
2.6.19-rc6-git12, so it was 2.6.19 where it failed.
>> Apologies for the long spiel, if memory serves me correct, gzip'd 
>> attachments are verboten.
>>     
>
> Bugzilla may be a good place to put more information.
> If the system fails in ACPI mode, but works in non-ACPI mode,
> then please file a bug here:
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
>
>   
Will do.

> and attach the complete dmesg -s64000 for the last working, plus
> failing kernel -- along with /proc/interrupts for both, and a single
> copy of lspci -vv output.
>
>
>   
>> openSUSE 10.2
>> Network does not get configured with "acpi=noirq" or "acpi=off".
>>     
>
> Do you mean it does not work when running in ACPI mode, but it does
> work correctly if you boot with "acpi=noirq" or "acpi=off"?
>
> If so, please include the dmesg -s64000 and /proc/interrupts for
> the acpi=off case also.
>
>   
Attaching both case1 normal, case2 acpi=noirq. With acpi=noirq ethernet 
doesn't get configured, route -n says it's an Unsupported operation, 
ifconfig only shows for localhost, ifconfig eth0 192.168.10.5 also 
complains of a config error.

> Nothing jumps out as incorrect with the ACPI IRQ routing below.
>
> Maybe somebody who knows about the tg3 can suggest what
> the error messages mean and if they are related to interrupt
> problems, or perhaps something else like IO resource issues?
>
> -Len
>
>   
It's just not a tg3 problem, the problem is also on  nVidia Corporation 
MCP51 Ethernet Controller (rev a1) - tg3 for the 64-bit laptop and MCP51 
on the 64x2 box, tg3 and forcedeth drivers respectively.
>> There may be something in dmesg that allows further analysis of the 
>> problem.
>> 00:0a:e4:4e:a1:42 is the laptop MAC address.
>> 00:48:54:d0:22:f0 is the firewall box
>> 00:50:22:40:0F:D2 is a local box
>> Some things in dmesg which look decidedly strange when compared to what 
>> is seen with 2.6.18.2-34, two mac addresses strung together with an 
>> additional :08:00. I'm guessing here, this may be normal but I haven't 
>> seen such before.
>> Linux version 2.6.20-rc1-git7-default (root@Boycie) (gcc version 4.1.2 
>> 20061115 (prerelease) (SUSE Linux)) #4 SMP Wed Dec 20 01:17:23 GMT 2006
>> Command line: root=/dev/hda1 vga=0x317    resume=/dev/hda2 splash=silent 3
>> BIOS-provided physical RAM map:
>>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>>  BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
>>  BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
>>  BIOS-e820: 000000001fef0000 - 000000001fefb000 (ACPI data)
>>  BIOS-e820: 000000001fefb000 - 000000001ff00000 (ACPI NVS)
>>  BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
>>  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
>> Entering add_active_range(0, 0, 159) 0 entries of 3200 used
>> Entering add_active_range(0, 256, 130800) 1 entries of 3200 used
>> end_pfn_map = 1048576
>> DMI 2.3 present.
>> ACPI: RSDP (v000 PTLTD                                 ) @ 
>> 0x00000000000f68c0
>> ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 
>> 0x000000001fef5d48
>> ACPI: FADT (v002 AMDK8  PTLTW    0x06040000 PTL_ 0x000f4240) @ 
>> 0x000000001fefae56
>> ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 
>> 0x000000001fefaeda
>> ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 
>> 0x000000001fefafb0
>> ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000e) @ 
>> 0x0000000000000000
>> Scanning NUMA topology in Northbridge 24
>> Number of nodes 1
>> Node 0 MemBase 0000000000000000 Limit 000000001fef0000
>> Entering add_active_range(0, 0, 159) 0 entries of 3200 used
>> Entering add_active_range(0, 256, 130800) 1 entries of 3200 used
>> NUMA: Using 63 for the hash shift.
>> Using node hash shift of 63
>> Bootmem setup node 0 0000000000000000-000000001fef0000
>> Zone PFN ranges:
>>   DMA             0 ->     4096
>>   DMA32        4096 ->  1048576
>>   Normal    1048576 ->  1048576
>> early_node_map[2] active PFN ranges
>>     0:        0 ->      159
>>     0:      256 ->   130800
>> On node 0 totalpages: 130703
>>   DMA zone: 56 pages used for memmap
>>   DMA zone: 1183 pages reserved
>>   DMA zone: 2760 pages, LIFO batch:0
>>   DMA32 zone: 1732 pages used for memmap
>>   DMA32 zone: 124972 pages, LIFO batch:31
>>   Normal zone: 0 pages used for memmap
>> ACPI: PM-Timer IO Port: 0x4008
>> ACPI: Local APIC address 0xfee00000
>> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>> Processor #0 (Bootup-CPU)
>> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
>> ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
>> IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
>> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
>> ACPI: IRQ0 used by override.
>> ACPI: IRQ2 used by override.
>> ACPI: IRQ9 used by override.
>> Setting APIC routing to physical flat
>> Using ACPI (MADT) for SMP configuration information
>> Nosave address range: 000000000009f000 - 00000000000a0000
>> Nosave address range: 00000000000a0000 - 00000000000d8000
>> Nosave address range: 00000000000d8000 - 0000000000100000
>> Allocating PCI resources starting at 30000000 (gap: 20000000:dffe0000)
>> SMP: Allowing 1 CPUs, 0 hotplug CPUs
>> PERCPU: Allocating 49664 bytes of per cpu data
>> Built 1 zonelists.  Total pages: 127732
>> Kernel command line: root=/dev/hda1 vga=0x317    resume=/dev/hda2 
>> splash=silent 3
>> Initializing CPU#0
>> PID hash table entries: 2048 (order: 11, 16384 bytes)
>> Console: colour dummy device 80x25
>> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
>> Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
>> Checking aperture...
>> CPU 0: aperture @ e0000000 size 256 MB
>> Memory: 507156k/523200k available (1948k kernel code, 15656k reserved, 
>> 950k data, 324k init)
>> Calibrating delay using timer specific routine.. 3591.92 BogoMIPS 
>> (lpj=1795961)
>> Security Framework v1.0.0 initialized
>> Mount-cache hash table entries: 256
>> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
>> CPU: L2 Cache: 1024K (64 bytes/line)
>> CPU 0/0 -> Node 0
>> SMP alternatives: switching to UP code
>> Freeing SMP alternatives: 28k freed
>> ACPI: Core revision 20060707
>> Using local APIC timer interrupts.
>> result 12464666
>> Detected 12.464 MHz APIC timer.
>> Brought up 1 CPUs
>> testing NMI watchdog ... OK.
>> time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
>> time.c: Detected 1794.911 MHz processor.
>> NET: Registered protocol family 16
>> ACPI: bus type pci registered
>> PCI: Using configuration type 1
>> ACPI: Interpreter enabled
>> ACPI: Using IOAPIC for interrupt routing
>> ACPI: PCI Root Bridge [PCI0] (0000:00)
>> PCI: Probing PCI hardware (bus 00)
>> PCI quirk: region 4000-407f claimed by vt8235 PM
>> PCI quirk: region 8100-810f claimed by vt8235 SMB
>> Boot video device is 0000:01:00.0
>> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>> ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *9, 
>> disabled.
>> ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23) *10, 
>> disabled.
>> ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *11, disabled.
>> ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *10, disabled.
>> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 12 14 15)
>> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 12 14 15)
>> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *11 12 14 15)
>> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12 14 15)
>> Linux Plug and Play Support v0.97 (c) Adam Belay
>> pnp: PnP ACPI init
>> pnp: PnP ACPI: found 13 devices
>> PCI: Using ACPI for IRQ routing
>> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
>> report
>> PCI: Cannot allocate resource region 0 of device 0000:00:00.0
>> agpgart: Detected AGP bridge 0
>> agpgart: AGP aperture is 256M @ 0xe0000000
>> pnp: 00:06: ioport range 0x600-0x60f has been reserved
>> pnp: 00:06: ioport range 0x1c0-0x1cf has been reserved
>> pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
>> pnp: 00:06: ioport range 0xfe10-0xfe11 could not be reserved
>> PCI: Bridge: 0000:00:01.0
>>   IO window: 2000-2fff
>>   MEM window: d0100000-d01fffff
>>   PREFETCH window: d8000000-dfffffff
>> PCI: Bus 2, cardbus bridge: 0000:00:0b.0
>>   IO window: 00001c00-00001cff
>>   IO window: 00003000-000030ff
>>   PREFETCH window: 30000000-31ffffff
>>   MEM window: 32000000-33ffffff
>> PCI: Bus 6, cardbus bridge: 0000:00:0b.1
>>   IO window: 00003400-000034ff
>>   IO window: 00003800-000038ff
>>   PREFETCH window: 34000000-35ffffff
>>   MEM window: 36000000-37ffffff
>> PCI: Setting latency timer of device 0000:00:01.0 to 64
>> ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
>> PCI: Setting latency timer of device 0000:00:0b.0 to 64
>> PCI: Enabling device 0000:00:0b.1 (0000 -> 0003)
>> ACPI: PCI Interrupt 0000:00:0b.1[B] -> GSI 18 (level, low) -> IRQ 18
>> PCI: Setting latency timer of device 0000:00:0b.1 to 64
>> NET: Registered protocol family 2
>> IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
>> TCP established hash table entries: 16384 (order: 6, 262144 bytes)
>> TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
>> TCP: Hash tables configured (established 16384 bind 8192)
>> TCP reno registered
>> checking if image is initramfs... it is
>> Freeing initrd memory: 2885k freed
>> audit: initializing netlink socket (disabled)
>> audit(1166585213.510:1): initialized
>> Total HugeTLB memory allocated, 0
>> VFS: Disk quotas dquot_6.5.1
>> Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>> io scheduler noop registered
>> io scheduler anticipatory registered
>> io scheduler deadline registered
>> io scheduler cfq registered (default)
>> vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20000180000, using 
>> 3072k, total 65536k
>> vesafb: mode is 1024x768x16, linelength=2048, pages=41
>> vesafb: scrolling: redraw
>> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
>> Console: switching to colour frame buffer device 128x48
>> fb0: VESA VGA frame buffer device
>> Real Time Clock Driver v1.12ac
>> Non-volatile memory driver v1.2
>> Linux agpgart interface v0.101 (c) Dave Jones
>> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
>> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>> RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
>> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>> i8042.c: Detected active multiplexing controller, rev 1.1.
>> serio: i8042 KBD port at 0x60,0x64 irq 1
>> serio: i8042 AUX0 port at 0x60,0x64 irq 12
>> serio: i8042 AUX1 port at 0x60,0x64 irq 12
>> serio: i8042 AUX2 port at 0x60,0x64 irq 12
>> serio: i8042 AUX3 port at 0x60,0x64 irq 12
>> mice: PS/2 mouse device common for all mice
>> input: AT Translated Set 2 keyboard as /class/input/input0
>> input: PC Speaker as /class/input/input1
>> Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000
>> input: SynPS/2 Synaptics TouchPad as /class/input/input2
>> NET: Registered protocol family 1
>> ACPI: (supports S0 S3 S4 S5)
>> Freeing unused kernel memory: 324k freed
>> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>> ACPI: Thermal Zone [THRS] (53 C)
>> ACPI: Thermal Zone [THRC] (78 C)
>> VP_IDE: IDE controller at PCI slot 0000:00:11.1
>> ACPI: Unable to derive IRQ for device 0000:00:11.1
>> Losing some ticks... checking if CPU frequency changed.
>> ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
>> VP_IDE: chipset revision 6
>> VP_IDE: not 100% native mode: will probe irqs later
>> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>>     ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
>>     ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
>> Probing IDE interface ide0...
>> hda: WDC WD800VE-07HDT0, ATA DISK drive
>> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>> hda: max request size: 128KiB
>> hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, 
>> UDMA(100)
>> hda: cache flushes supported
>>  hda: hda1 hda2
>> Probing IDE interface ide1...
>> hdc: _NEC DVD_RW ND-6750A, ATAPI CD/DVD-ROM drive
>> ide1 at 0x170-0x177,0x376 on irq 15
>> BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
>> Attempting manual resume
>> ReiserFS: hda1: found reiserfs format "3.6" with standard journal
>> ReiserFS: hda1: using ordered data mode
>> ReiserFS: hda1: journal params: device hda1, size 8192, journal first 
>> block 18, max trans len 1024, max batch 900, max commit age 30, max 
>> trans age 30
>> ReiserFS: hda1: checking transaction log (hda1)
>> ReiserFS: hda1: Using r5 hash to sort names
>> NET: Registered protocol family 23
>> usbcore: registered new interface driver usbfs
>> usbcore: registered new interface driver hub
>> usbcore: registered new device driver usb
>> Yenta: CardBus bridge found at 0000:00:0b.0 [1025:0046]
>> USB Universal Host Controller Interface driver v3.0
>> ieee1394: Initialized config rom entry `ip1394'
>> Yenta: ISA IRQ mask 0x00b8, PCI irq 17
>> Socket status: 30000410
>> Yenta: CardBus bridge found at 0000:00:0b.1 [1025:0046]
>> Yenta: ISA IRQ mask 0x00b8, PCI irq 18
>> Socket status: 30000820
>> ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
>> uhci_hcd 0000:00:10.0: UHCI Host Controller
>> uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
>> uhci_hcd 0000:00:10.0: irq 21, io base 0x00001020
>> usb usb1: configuration #1 chosen from 1 choice
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 2 ports detected
>> ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 21
>> uhci_hcd 0000:00:10.1: UHCI Host Controller
>> uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
>> uhci_hcd 0000:00:10.1: irq 21, io base 0x00001040
>> usb usb2: configuration #1 chosen from 1 choice
>> hub 2-0:1.0: USB hub found
>> hub 2-0:1.0: 2 ports detected
>> ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 21
>> uhci_hcd 0000:00:10.2: UHCI Host Controller
>> uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
>> uhci_hcd 0000:00:10.2: irq 21, io base 0x00001060
>> usb usb3: configuration #1 chosen from 1 choice
>> pccard: PCMCIA card inserted into slot 0
>> hub 3-0:1.0: USB hub found
>> hub 3-0:1.0: 2 ports detected
>> usb 1-2: new full speed USB device using uhci_hcd and address 2
>> nsc-ircc, chip->init
>> nsc-ircc, Found chip at base=0x02e
>> nsc-ircc, driver loaded (Dag Brattli)
>> ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 21
>> ehci_hcd 0000:00:10.3: EHCI Host Controller
>> ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
>> ehci_hcd 0000:00:10.3: irq 21, io mem 0xd0000800
>> ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
>> usb usb4: configuration #1 chosen from 1 choice
>> hub 4-0:1.0: USB hub found
>> hub 4-0:1.0: 6 ports detected
>> nsc_ircc_open(), can't get iobase of 0x2f8
>> nsc-ircc, Found chip at base=0x02e
>> nsc-ircc, driver loaded (Dag Brattli)
>> nsc_ircc_open(), can't get iobase of 0x2f8
>> pnp: Device 00:0a disabled.
>> pccard: CardBus card inserted into slot 1
>> ACPI: PCI Interrupt 0000:00:0b.2[C] -> GSI 19 (level, low) -> IRQ 19
>> ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19] 
>> MMIO=[d0000000-d00007ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
>> ---------------------------------------------------------------------
>> tg3.c:v3.71 (December 15, 2006)
>> ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
>> eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 
>> 10/100/1000Base-T Ethernet 00:0a:e4:4e:a1:42
>> ------------------------------------------------------------------------
>> eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] 
>> TSOcap[1]
>> eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
>> ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
>> PCI: Setting latency timer of device 0000:00:11.5 to 64
>> hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
>> Uniform CD-ROM driver Revision: 3.20
>> usb 1-2: device not accepting address 2, error -71
>> parport: PnPBIOS parport detected.
>> parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
>> [PCSPP,TRISTATE,COMPAT,ECP,DMA]
>> wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.6
>> wbsd: Copyright(c) Pierre Ossman
>> mmc0: W83L51xD id 7112 at 0x820 irq 10 FIFO PnP
>> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae404061046b5]
>> cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 
>> 0xd8000-0xdffff 0xe4000-0xfffff
>> cs: memory probe 0x60000000-0x60ffffff: clean.
>> cs: memory probe 0xa0000000-0xa0ffffff: clean.
>> pcmcia: registering new device pcmcia0.0
>> usb 1-2: new full speed USB device using uhci_hcd and address 4
>> pcmcia: request for exclusive IRQ could not be fulfilled.
>> pcmcia: the driver needs updating to supported shared IRQ lines.
>> 0.0: ttyS0 at I/O 0x3f8 (irq = 17) is a 16550A
>> usb 1-2: configuration #1 chosen from 1 choice
>> Bluetooth: Core ver 2.11
>> NET: Registered protocol family 31
>> Bluetooth: HCI device and connection manager initialized
>> Bluetooth: HCI socket layer initialized
>> usb 3-1: new full speed USB device using uhci_hcd and address 2
>> Bluetooth: HCI USB driver ver 2.9
>> usb 3-1: configuration #1 chosen from 1 choice
>> hub 3-1:1.0: USB hub found
>> hub 3-1:1.0: 4 ports detected
>> usb 3-2: new low speed USB device using uhci_hcd and address 3
>> usb 3-2: configuration #1 chosen from 1 choice
>> usbcore: registered new interface driver hci_usb
>> usb 2-1: new full speed USB device using uhci_hcd and address 2
>> usb 2-1: configuration #1 chosen from 1 choice
>> usb 3-1.3: new full speed USB device using uhci_hcd and address 4
>> Bluetooth: L2CAP ver 2.8
>> Bluetooth: L2CAP socket layer initialized
>> usb 3-1.3: not running at top speed; connect to a high speed hub
>> Bluetooth: HIDP (Human Interface Emulation) ver 1.1
>> usb 3-1.3: configuration #1 chosen from 1 choice
>> usbcore: registered new interface driver hiddev
>> input: Acrox USB & PS/2 Mouse as /class/input/input3
>> input: USB HID v1.10 Mouse [Acrox USB & PS/2 Mouse] on usb-0000:00:10.2-2
>> usbcore: registered new interface driver usbhid
>> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
>> usbcore: registered new interface driver usbserial
>> drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
>> usbcore: registered new interface driver usbserial_generic
>> drivers/usb/serial/usb-serial.c: USB Serial Driver core
>> drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
>> pl2303 2-1:1.0: pl2303 converter detected
>> usb 2-1: pl2303 converter now attached to ttyUSB0
>> usbcore: registered new interface driver pl2303
>> drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
>> SCSI subsystem initialized
>> Initializing USB Mass Storage driver...
>> scsi0 : SCSI emulation for USB Mass Storage devices
>> usb-storage: device found at 4
>> usb-storage: waiting for device to settle before scanning
>> usbcore: registered new interface driver usb-storage
>> Bluetooth: RFCOMM socket layer initialized
>> Bluetooth: RFCOMM TTY layer initialized
>> Bluetooth: RFCOMM ver 1.8
>> USB Mass Storage support registered.
>> Bluetooth: BNEP (Ethernet Emulation) ver 1.2
>> Bluetooth: BNEP filters: protocol multicast
>> Adding 3931696k swap on /dev/hda2.  Priority:-1 extents:1 across:3931696k
>> device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: 
>> dm-devel@redhat.com
>> loop: loaded (max 8 devices)
>> scsi 0:0:0:0: Direct-Access     Maxtor 6 Y120L0           YAR4 PQ: 0 
>> ANSI: 0
>> usb-storage: device scan complete
>> SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
>> sda: Write Protect is off
>> sda: Mode Sense: 03 00 00 00
>> sda: assuming drive cache: write through
>> SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
>> sda: Write Protect is off
>> sda: Mode Sense: 03 00 00 00
>> sda: assuming drive cache: write through
>>  sda: sda1 sda2
>> sd 0:0:0:0: Attached scsi disk sda
>> sd 0:0:0:0: Attached scsi generic sg0 type 0
>> Adding 1550264k swap on /dev/sda2.  Priority:-2 extents:1 across:1550264k
>> NET: Registered protocol family 10
>> lo: Disabled Privacy Extensions
>> ip6_tables: (C) 2000-2006 Netfilter Core Team
>> ip_tables: (C) 2000-2006 Netfilter Core Team
>> ACPI: AC Adapter [AC] (on-line)
>> ACPI: Battery Slot [BAT0] (battery present)
>> ACPI: Power Button (FF) [PWRF]
>> ACPI: Lid Switch [LID]
>> ACPI: Sleep Button (CM) [SLPB]
>> powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3000+ processors 
>> (version 2.00.00)
>> powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2
>> powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6
>> powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12
>> ttyS1: LSR safety check engaged!
>> audit(1166585256.326:2): audit_pid=2996 old=0 by auid=4294967295
>> PM: Writing back config space on device 0000:00:0c.0 at offset b (was 
>> 3ed173b, writing 461025)
>> PM: Writing back config space on device 0000:00:0c.0 at offset 3 (was 0, 
>> writing 4010)
>> PM: Writing back config space on device 0000:00:0c.0 at offset 2 (was 
>> 2000000, writing 2000003)
>> PM: Writing back config space on device 0000:00:0c.0 at offset 1 (was 
>> 2b00000, writing 2b00006)
>> PM: Writing back config space on device 0000:00:0c.0 at offset 0 (was 
>> 3ed173b, writing 169c14e4)
>> ADDRCONF(NETDEV_UP): eth0: link is not ready
>> NET: Registered protocol family 17
>> tg3: eth0: Link is up at 100 Mbps, full duplex.
>> tg3: eth0: Flow control is on for TX and on for RX.
>> ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>> SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.251 LEN=107 
>> TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.10.5 DST=224.0.0.251 
>> LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 
>> LEN=87
>> SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.251 LEN=107 
>> TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.10.5 DST=224.0.0.251 
>> LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 
>> LEN=87
>> SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=192.168.10.1 LEN=60 
>> TOS=0x00 PREC=0x00 TTL=64 ID=64687 DF PROTO=TCP SPT=14566 DPT=111 
>> WINDOW=5840 RES=0x00 S
>> YN URGP=0 OPT (020405B40402080AFFFC4A360000000001030302)
>> SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.22 LEN=40 
>> TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2
>> SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.251 LEN=107 
>> TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.10.5 DST=224.0.0.251 
>> LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 
>> LEN=87
>> eth0: no IPv6 routers present
>> SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=192.168.10.1 LEN=60 
>> TOS=0x00 PREC=0x00 TTL=64 ID=64689 DF PROTO=TCP SPT=14566 DPT=111 
>> WINDOW=5840 RES=0x00 S
>> YN URGP=0 OPT (020405B40402080AFFFC90860000000001030302)
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 
>> DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=247 ID=45
>> 161 DF PROTO=UDP SPT=53 DPT=1025 LEN=99
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 
>> DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=247 ID=45
>> 162 DF PROTO=UDP SPT=53 DPT=1027 LEN=99
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=62.31.176.39 
>> DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=251 ID=1270
>> 7 DF PROTO=UDP SPT=53 DPT=1026 LEN=99
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
>> DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47744
>> PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=1
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
>> DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47745
>> PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=2
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=194.117.134.19 
>> DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=248 ID=56
>> 11 DF PROTO=UDP SPT=53 DPT=1028 LEN=99
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
>> DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47746
>> PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=3
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
>> DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47747
>> PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=4
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=62.31.176.39 
>> DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=251 ID=1270
>> 8 DF PROTO=UDP SPT=53 DPT=1029 LEN=99
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
>> DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47748
>> PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=5
>> SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=195.188.53.175 LEN=58 
>> TOS=0x00 PREC=0x00 TTL=64 ID=43443 DF PROTO=UDP SPT=1025 DPT=53 LEN=38
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=194.117.134.19 
>> DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=248 ID=56
>> 13 DF PROTO=UDP SPT=53 DPT=1028 LEN=99
>> SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=194.117.134.19 LEN=63 
>> TOS=0x00 PREC=0x00 TTL=64 ID=13907 DF PROTO=UDP SPT=1034 DPT=53 LEN=43
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=194.117.134.19 
>> DST=192.168.10.5 LEN=138 TOS=0x00 PREC=0x00 TTL=248 ID=56
>> 16 DF PROTO=UDP SPT=53 DPT=1036 LEN=118
>> SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=194.117.134.19 LEN=63 
>> TOS=0x00 PREC=0x00 TTL=64 ID=18909 DF PROTO=UDP SPT=1036 DPT=53 LEN=43
>> SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
>> MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 
>> DST=192.168.10.5 LEN=74 TOS=0x00 PREC=0x00 TTL=247 ID=356
>> 16 DF PROTO=UDP SPT=53 DPT=1039 LEN=54
>> etc.,etc.
>>
>> Regards
>> Sid.
>>
>>     
>
>
>   
Regards
Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks


--------------040106070705020900050401
Content-Type: text/plain;
 name="ETH_ERR_with_ACPI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ETH_ERR_with_ACPI"

00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at <ignored> (32-bit, prefetchable)
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
        Capabilities: [c0] HyperTransport: Slave or Primary Interface
                !!! Possibly incomplete decoding
                Command: BaseUnitID=0 UnitCnt=3 MastHost- DefDir-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config 0: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
                Link Config 1: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
                Revision ID: 1.02
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] HyperTransport: Interrupt Discovery and Configuration

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at 40010000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 30000000-33fff000 (prefetchable)
        Memory window 1: 34000000-37fff000
        I/O window 0: 00001c00-00001cff
        I/O window 1: 00003000-000030ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 18
        Region 0: Memory at 40011000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 38000000-3bfff000 (prefetchable)
        Memory window 1: 3c000000-3ffff000
        I/O window 0: 00003400-000034ff
        I/O window 1: 00003800-000038ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

00:0b.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 02) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin C routed to IRQ 19
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME+

00:0c.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788 Gigabit Ethernet (rev 03)
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at d0010000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at 40000000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: Mask- 64bit+ Queue=0/3 Enable-
                Address: ffff5ff7fbfbfff4  Data: ffdf

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at 1020 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at 1040 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 64 bytes
        Interrupt: pin C routed to IRQ 21
        Region 4: I/O ports at 1060 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 64 bytes
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at d0000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 0
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
        Region 4: I/O ports at 1000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at 1400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 80)
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at 1800 [size=256]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI] Unknown device 0046
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at d0120000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:00.0 Network controller: RaLink RT2500 802.11g Cardbus/mini-PCI (rev 01)
        Subsystem: Belkin F5D7010 Wireless G Notebook Network Card
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 3c000000 (32-bit, non-prefetchable) [disabled] [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Linux version 2.6.20-rc3 (root@Boycie) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #4 SMP Mon Jan 1 11:39:19 GMT 2007
Command line: root=/dev/hda1 vga=0x317    resume=/dev/hda2 splash=silent 3
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fefb000 (ACPI data)
 BIOS-e820: 000000001fefb000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 130800) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f68c0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x000000001fef5d48
ACPI: FADT (v002 AMDK8  PTLTW    0x06040000 PTL_ 0x000f4240) @ 0x000000001fefae56
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x000000001fefaeda
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 0x000000001fefafb0
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000001fef0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 130800) 1 entries of 3200 used
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-000000001fef0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   130800
On node 0 totalpages: 130703
  DMA zone: 56 pages used for memmap
  DMA zone: 1185 pages reserved
  DMA zone: 2758 pages, LIFO batch:0
  DMA32 zone: 1732 pages used for memmap
  DMA32 zone: 124972 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000d8000
Nosave address range: 00000000000d8000 - 0000000000100000
Allocating PCI resources starting at 30000000 (gap: 20000000:dffe0000)
SMP: Allowing 1 CPUs, 0 hotplug CPUs
PERCPU: Allocating 49664 bytes of per cpu data
Built 1 zonelists.  Total pages: 127730
Kernel command line: root=/dev/hda1 vga=0x317    resume=/dev/hda2 splash=silent 3
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Checking aperture...
CPU 0: aperture @ e0000000 size 256 MB
Memory: 507148k/523200k available (1950k kernel code, 15664k reserved, 953k data, 324k init)
Calibrating delay using timer specific routine.. 3591.90 BogoMIPS (lpj=1795950)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
SMP alternatives: switching to UP code
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12465023
Detected 12.465 MHz APIC timer.
Brought up 1 CPUs
testing NMI watchdog ... OK.
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1794.962 MHz processor.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 4000-407f claimed by vt8235 PM
PCI quirk: region 8100-810f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *9, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23) *10, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *11, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *10, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xe0000000
pnp: 00:06: ioport range 0x600-0x60f has been reserved
pnp: 00:06: ioport range 0x1c0-0x1cf has been reserved
pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:06: ioport range 0xfe10-0xfe11 could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: d0100000-d01fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bus 2, cardbus bridge: 0000:00:0b.0
  IO window: 00001c00-00001cff
  IO window: 00003000-000030ff
  PREFETCH window: 30000000-33ffffff
  MEM window: 34000000-37ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0b.1
  IO window: 00003400-000034ff
  IO window: 00003800-000038ff
  PREFETCH window: 38000000-3bffffff
  MEM window: 3c000000-3fffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Enabling device 0000:00:0b.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0b.1[B] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:0b.1 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2885k freed
audit: initializing netlink socket (disabled)
audit(1167771418.916:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20000180000, using 3072k, total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000
input: SynPS/2 Synaptics TouchPad as /class/input/input2
NET: Registered protocol family 1
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 324k freed
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: Thermal Zone [THRS] (46 C)
ACPI: Thermal Zone [THRC] (65 C)
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: Unable to derive IRQ for device 0000:00:11.1
Losing some ticks... checking if CPU frequency changed.
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800VE-07HDT0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-6750A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Attempting manual resume
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Yenta: CardBus bridge found at 0000:00:0b.0 [1025:0046]
USB Universal Host Controller Interface driver v3.0
Yenta: ISA IRQ mask 0x00b8, PCI irq 17
Socket status: 30000410
Yenta: CardBus bridge found at 0000:00:0b.1 [1025:0046]
NET: Registered protocol family 23
ieee1394: Initialized config rom entry `ip1394'
Yenta: ISA IRQ mask 0x00b8, PCI irq 18
Socket status: 30000820
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 21, io base 0x00001020
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 21, io base 0x00001040
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
pccard: PCMCIA card inserted into slot 0
ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 21, io base 0x00001060
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using uhci_hcd and address 2
nsc-ircc, chip->init
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: irq 21, io mem 0xd0000800
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
nsc_ircc_open(), can't get iobase of 0x2f8
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
nsc_ircc_open(), can't get iobase of 0x2f8
pnp: Device 00:0a disabled.
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
pccard: CardBus card inserted into slot 1
ACPI: PCI Interrupt 0000:00:0b.2[C] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[d0000000-d00007ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
tg3.c:v3.71 (December 15, 2006)
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
parport: PnPBIOS parport detected.
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000Base-T Ethernet 00:0a:e4:4e:a1:42
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1]
eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
usb 1-2: device not accepting address 2, error -71
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.6
wbsd: Copyright(c) Pierre Ossman
mmc0: W83L51xD id 7112 at 0x820 irq 10 FIFO PnP
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xd8000-0xdffff 0xe4000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae404061046b5]
pcmcia: registering new device pcmcia0.0
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
usb 1-2: new full speed USB device using uhci_hcd and address 4
0.0: ttyS0 at I/O 0x3f8 (irq = 17) is a 16550A
usb 1-2: configuration #1 chosen from 1 choice
usb 3-1: new full speed USB device using uhci_hcd and address 2
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
Adding 3931696k swap on /dev/hda2.  Priority:-1 extents:1 across:3931696k
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 4 ports detected
usb 3-2: new low speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hci_usb
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 3-1.3: new full speed USB device using uhci_hcd and address 4
usb 3-1.3: not running at top speed; connect to a high speed hub
usb 3-1.3: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: Acrox USB & PS/2 Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Acrox USB & PS/2 Mouse] on usb-0000:00:10.2-2
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
pl2303 2-1:1.0: pl2303 converter detected
usb 2-1: pl2303 converter now attached to ttyUSB0
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
loop: loaded (max 8 devices)
scsi 0:0:0:0: Direct-Access     Maxtor 6 Y120L0           YAR4 PQ: 0 ANSI: 0
usb-storage: device scan complete
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
ttyS1: LSR safety check engaged!
Adding 1550264k swap on /dev/sda2.  Priority:-2 extents:1 across:1550264k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
input: Power Button (FF) as /class/input/input4
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input5
ACPI: Lid Switch [LID]
input: Sleep Button (CM) as /class/input/input6
ACPI: Sleep Button (CM) [SLPB]
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3000+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12
powernow-k8: ph2 null fid transition 0xa
audit(1167771465.822:2): audit_pid=3040 old=0 by auid=4294967295
ttyS1: LSR safety check engaged!
PM: Writing back config space on device 0000:00:0c.0 at offset b (was 3ed173b, writing 461025)
PM: Writing back config space on device 0000:00:0c.0 at offset 3 (was 0, writing 4010)
PM: Writing back config space on device 0000:00:0c.0 at offset 2 (was 2000000, writing 2000003)
PM: Writing back config space on device 0000:00:0c.0 at offset 1 (was 2b00000, writing 2b00006)
PM: Writing back config space on device 0000:00:0c.0 at offset 0 (was 3ed173b, writing 169c14e4)
ADDRCONF(NETDEV_UP): eth0: link is not ready
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
NET: Registered protocol family 17
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.10.5 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=192.168.10.1 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=40618 DF PROTO=TCP SPT=28713 DPT=111 WINDOW=5840 RES=0x00 S
YN URGP=0 OPT (020405B40402080AFFFC59220000000001030302)
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.10.5 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=192.168.10.1 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=40619 DF PROTO=TCP SPT=28713 DPT=111 WINDOW=5840 RES=0x00 S
YN URGP=0 OPT (020405B40402080AFFFC64DA0000000001030302)
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=247 ID=16
819 DF PROTO=UDP SPT=53 DPT=1025 LEN=99
eth0: no IPv6 routers present
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=247 ID=16
820 DF PROTO=UDP SPT=53 DPT=1027 LEN=99
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=62.31.176.39 DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=251 ID=5468
9 DF PROTO=UDP SPT=53 DPT=1026 LEN=99
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=194.117.134.19 DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=248 ID=29
013 DF PROTO=UDP SPT=53 DPT=1028 LEN=99
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=62.31.176.39 DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=251 ID=5469
0 DF PROTO=UDP SPT=53 DPT=1029 LEN=99
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=194.117.134.19 LEN=58 TOS=0x00 PREC=0x00 TTL=64 ID=43073 DF PROTO=UDP SPT=1030 DPT=53 LEN=38
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=194.117.134.19 DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=248 ID=29
015 DF PROTO=UDP SPT=53 DPT=1028 LEN=99
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=62.31.176.39 LEN=58 TOS=0x00 PREC=0x00 TTL=64 ID=63071 DF PROTO=UDP SPT=1032 DPT=53 LEN=38
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=194.117.134.19 DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=248 ID=29
018 DF PROTO=UDP SPT=53 DPT=1036 LEN=99
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=194.117.134.19 LEN=58 TOS=0x00 PREC=0x00 TTL=64 ID=5538 DF PROTO=UDP SPT=1036 DPT=53 LEN=38
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 DST=192.168.10.5 LEN=74 TOS=0x00 PREC=0x00 TTL=247 ID=244
4 DF PROTO=UDP SPT=53 DPT=1039 LEN=54
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=62.31.176.39 LEN=58 TOS=0x00 PREC=0x00 TTL=64 ID=25536 DF PROTO=UDP SPT=1038 DPT=53 LEN=38
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=62.31.176.39 DST=192.168.10.5 LEN=74 TOS=0x00 PREC=0x00 TTL=251 ID=59124
 DF PROTO=UDP SPT=53 DPT=1042 LEN=54
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=62.31.176.39 LEN=58 TOS=0x00 PREC=0x00 TTL=64 ID=58543 DF PROTO=UDP SPT=1048 DPT=53 LEN=38
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 DST=192.168.10.5 LEN=74 TOS=0x00 PREC=0x00 TTL=247 ID=444
34 DF PROTO=UDP SPT=53 DPT=1046 LEN=54
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=195.188.53.175 LEN=58 TOS=0x00 PREC=0x00 TTL=64 ID=16072 DF PROTO=UDP SPT=1049 DPT=53 LEN=38


           CPU0
  0:     445833   IO-APIC-edge      timer
  1:        724   IO-APIC-edge      i8042
  7:          0   IO-APIC-edge      parport0
  8:          0   IO-APIC-edge      rtc
  9:        708   IO-APIC-fasteoi   acpi
 10:          0   IO-APIC-edge      wbsd
 12:        133   IO-APIC-edge      i8042
 14:      49499   IO-APIC-edge      ide0
 15:       3598   IO-APIC-edge      ide1
 17:          4   IO-APIC-fasteoi   yenta
 18:          7   IO-APIC-fasteoi   yenta
 19:          2   IO-APIC-fasteoi   ohci1394
 20:       4294   IO-APIC-fasteoi   eth0
 21:       2366   IO-APIC-fasteoi   uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, ehci_hcd:usb4
 22:          0   IO-APIC-fasteoi   VIA8233
NMI:        117
LOC:     445737
ERR:          0


--------------040106070705020900050401
Content-Type: text/plain;
 name="ETH_ERR_noacpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ETH_ERR_noacpi"

Linux version 2.6.20-rc3 (root@Boycie) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #4 SMP Mon Jan 1 11:39:19 GMT 2007
Command line: root=/dev/hda1 vga=0x317    resume=/dev/hda2 splash=silent 3 acpi=noirq
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fefb000 (ACPI data)
 BIOS-e820: 000000001fefb000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 130800) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f68c0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x000000001fef5d48
ACPI: FADT (v002 AMDK8  PTLTW    0x06040000 PTL_ 0x000f4240) @ 0x000000001fefae56
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x000000001fefaeda
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x000000001fefafb0
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000001fef0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 130800) 1 entries of 3200 used
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-000000001fef0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   130800
On node 0 totalpages: 130703
  DMA zone: 56 pages used for memmap
  DMA zone: 1185 pages reserved
  DMA zone: 2758 pages, LIFO batch:0
  DMA32 zone: 1732 pages used for memmap
  DMA32 zone: 124972 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
MPTABLE: OEM ID:          MPTABLE: Product ID:              MPTABLE: APIC at: 0xFEE00000
I/O APIC #1 at 0xFEC00000.
Setting APIC routing to physical flat
Processors: 1
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000d8000
Nosave address range: 00000000000d8000 - 0000000000100000
Allocating PCI resources starting at 30000000 (gap: 20000000:dffe0000)
SMP: Allowing 1 CPUs, 0 hotplug CPUs
PERCPU: Allocating 49664 bytes of per cpu data
Built 1 zonelists.  Total pages: 127730
Kernel command line: root=/dev/hda1 vga=0x317    resume=/dev/hda2 splash=silent 3 acpi=noirq
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Checking aperture...
CPU 0: aperture @ e0000000 size 256 MB
Memory: 507148k/523200k available (1950k kernel code, 15664k reserved, 953k data, 324k init)
Calibrating delay using timer specific routine.. 3591.85 BogoMIPS (lpj=1795926)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
SMP alternatives: switching to UP code
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12465030
Detected 12.465 MHz APIC timer.
Brought up 1 CPUs
testing NMI watchdog ... OK.
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1794.963 MHz processor.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 4000-407f claimed by vt8235 PM
PCI quirk: region 8100-810f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Probing PCI hardware
pci 0000:00:01.0: Error creating sysfs bridge symlink, continuing...
pci 0000:00:0b.0: Error creating sysfs bridge symlink, continuing...
pci 0000:00:0b.1: Error creating sysfs bridge symlink, continuing...
PCI: Using IRQ router VIA [1106/3177] at 0000:00:11.0
PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 232
PCI->APIC IRQ transform: 0000:00:0b.1[B] -> IRQ 232
PCI->APIC IRQ transform: 0000:00:0b.2[C] -> IRQ 232
PCI->APIC IRQ transform: 0000:00:0c.0[A] -> IRQ 203
PCI->APIC IRQ transform: 0000:00:10.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:10.1[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:10.2[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:10.3[D] -> IRQ 232
PCI->APIC IRQ transform: 0000:00:11.1[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:11.5[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:11.6[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xe0000000
pnp: 00:06: ioport range 0x600-0x60f has been reserved
pnp: 00:06: ioport range 0x1c0-0x1cf has been reserved
pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:06: ioport range 0xfe10-0xfe11 could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: d0100000-d01fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bus 2, cardbus bridge: 0000:00:0b.0
  IO window: 00001c00-00001cff
  IO window: 00003000-000030ff
  PREFETCH window: 30000000-33ffffff
  MEM window: 34000000-37ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0b.1
  IO window: 00003400-000034ff
  IO window: 00003800-000038ff
  PREFETCH window: 38000000-3bffffff
  MEM window: 3c000000-3fffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Enabling device 0000:00:0b.1 (0000 -> 0003)
PCI: Setting latency timer of device 0000:00:0b.1 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2885k freed
audit: initializing netlink socket (disabled)
audit(1167774315.391:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20000180000, using 3072k, total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
NET: Registered protocol family 1
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 324k freed
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: Thermal Zone [THRS] (55 C)
ACPI: Thermal Zone [THRC] (77 C)
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
input: SynPS/2 Synaptics TouchPad as /class/input/input1
Losing some ticks... checking if CPU frequency changed.
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input2
hda: WDC WD800VE-07HDT0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-6750A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Attempting manual resume
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 16, io base 0x00001020
ieee1394: Initialized config rom entry `ip1394'
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Yenta: CardBus bridge found at 0000:00:0b.0 [1025:0046]
Yenta: no PCI IRQ, CardBus support disabled for this socket.
Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
NET: Registered protocol family 23
Yenta: ISA IRQ mask 0x00b8, PCI irq 0
Socket status: 30000410
Yenta: CardBus bridge found at 0000:00:0b.1 [1025:0046]
Yenta: no PCI IRQ, CardBus support disabled for this socket.
Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
Yenta: ISA IRQ mask 0x00b8, PCI irq 0
Socket status: 30000820
usb 1-2: new full speed USB device using uhci_hcd and address 2
ohci1394: Failed to allocate shared interrupt 232
ohci1394: probe of 0000:00:0b.2 failed with error -12
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 17, io base 0x00001040
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 18, io base 0x00001060
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
cs: pcmcia_socket1: cardbus cards are not supported.
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
pccard: PCMCIA card inserted into slot 0
ehci_hcd 0000:00:10.3: request interrupt 232 failed
ehci_hcd 0000:00:10.3: USB bus 4 deregistered
ehci_hcd 0000:00:10.3: init 0000:00:10.3 fail, -38
ehci_hcd: probe of 0000:00:10.3 failed with error -38
tg3.c:v3.71 (December 15, 2006)
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000Base-T Ethernet 00:0a:e4:4e:a1:42
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
PCI: Setting latency timer of device 0000:00:11.5 to 64
hdc: ATAPI 23X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.6
wbsd: Copyright(c) Pierre Ossman
mmc0: W83L51xD id 7112 at 0x820 irq 10 FIFO PnP
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
nsc-ircc, chip->init
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
nsc_ircc_open(), can't get iobase of 0x2f8
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
nsc_ircc_open(), can't get iobase of 0x2f8
pnp: Device 00:0a disabled.
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xd8000-0xdffff 0xe4000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
0.0: RequestIRQ: Resource in use
0.0: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
Adding 3931696k swap on /dev/hda2.  Priority:-1 extents:1 across:3931696k
usb 1-2: configuration #1 chosen from 1 choice
usb 2-1: new full speed USB device using uhci_hcd and address 2
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
usb 2-1: configuration #1 chosen from 1 choice
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 4 ports detected
usb 3-2: new low speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
usb 3-1.3: new full speed USB device using uhci_hcd and address 4
usb 3-1.3: configuration #1 chosen from 1 choice
SCSI subsystem initialized
Initializing USB Mass Storage driver...
usbcore: registered new interface driver hci_usb
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
usbcore: registered new interface driver hiddev
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
pl2303 2-1:1.0: pl2303 converter detected
usb 2-1: pl2303 converter now attached to ttyUSB0
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
input: Acrox USB & PS/2 Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Acrox USB & PS/2 Mouse] on usb-0000:00:10.2-2
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
loop: loaded (max 8 devices)
ttyS1: LSR safety check engaged!
scsi 0:0:0:0: Direct-Access     Maxtor 6 Y120L0           YAR4 PQ: 0 ANSI: 0
usb-storage: device scan complete
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 sda: sda1 sda2
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
input: Power Button (FF) as /class/input/input4
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input5
ACPI: Lid Switch [LID]
input: Sleep Button (CM) as /class/input/input6
ACPI: Sleep Button (CM) [SLPB]
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3000+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12
uhci_hcd 0000:00:10.2: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.
audit(1167774391.363:2): audit_pid=2961 old=0 by auid=4294967295
ttyS1: LSR safety check engaged!
hdc: DMA timeout retry
hdc: timeout waiting for DMA
00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at <ignored> (32-bit, prefetchable)
	Capabilities: [80] AGP version 3.5
		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
	Capabilities: [c0] HyperTransport: Slave or Primary Interface
		!!! Possibly incomplete decoding
		Command: BaseUnitID=0 UnitCnt=3 MastHost- DefDir-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config 0: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
		Link Config 1: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
		Revision ID: 1.02
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] HyperTransport: Interrupt Discovery and Configuration

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 232
	Region 0: Memory at 40010000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 30000000-33fff000 (prefetchable)
	Memory window 1: 34000000-37fff000
	I/O window 0: 00001c00-00001cff
	I/O window 1: 00003000-000030ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 232
	Region 0: Memory at 40011000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 38000000-3bfff000 (prefetchable)
	Memory window 1: 3c000000-3ffff000
	I/O window 0: 00003400-000034ff
	I/O window 1: 00003800-000038ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0b.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 02) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin C routed to IRQ 232
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0c.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788 Gigabit Ethernet (rev 03)
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 203
	Region 0: Memory at d0010000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at 40000000 [disabled] [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: Mask- 64bit+ Queue=0/3 Enable-
		Address: ffff5ff7fbfbfff4  Data: ffdf

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at 1020 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 1040 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 1060 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 232
	Region 0: Memory at d0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 18
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at 1000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at 1400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 80)
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at 1800 [size=256]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI] Unknown device 0046
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at d0120000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

           CPU0       
  0:     619067   IO-APIC-edge      timer
  1:       1402   IO-APIC-edge      i8042
  2:          0    XT-PIC-XT        cascade
  7:          0   IO-APIC-edge      parport0
  8:          0   IO-APIC-edge      rtc
  9:          0    XT-PIC-XT        acpi
 10:          0    XT-PIC-XT        wbsd
 12:        645   IO-APIC-edge      i8042
 14:      35061   IO-APIC-edge      ide0
 15:         70   IO-APIC-edge      ide1
 16:          0   IO-APIC-fasteoi   uhci_hcd:usb1
 17:          3   IO-APIC-fasteoi   uhci_hcd:usb2
 18:        224   IO-APIC-fasteoi   uhci_hcd:usb3, VIA8233
NMI:        135 
LOC:     618946 
ERR:          0

--------------040106070705020900050401--

