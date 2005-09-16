Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965288AbVIPKqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965288AbVIPKqa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 06:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbVIPKqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 06:46:30 -0400
Received: from mail.portrix.net ([212.202.157.208]:9103 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S965288AbVIPKq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 06:46:29 -0400
Message-ID: <432AA269.3070207@ppp0.net>
Date: Fri, 16 Sep 2005 12:46:01 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.14-rc1 load average calculation broken?
References: <43295E30.7030508@ppp0.net> <20050915195317.GE468@openzaurus.ucw.cz>
In-Reply-To: <20050915195317.GE468@openzaurus.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------010109010805010909040303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010109010805010909040303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Hi!
> 
> 
>>Get a steady 2.00 there. I stopped unnecessary processes etc.
>>load average seems to be invariant
> 
> 
> So you probably have 2 processes in "D" state. Find a kernel bug which leaves
> them there...

Okay, it happened again. Turns out to be the usb-storage kernel threads:

root      3308  0.0  0.0      0     0 ?        D    08:40   0:00 [usb-storage]
root      4671  0.0  0.0      0     0 ?        D    08:40   0:00 [usb-storage]

I've an USB card reader in my monitor which turns off, when the monitor goes
to standby/is shut off. I think I can reproduce it that way, but I'm currently
not physically near the machine to check.

Any debug info that can help? Last known good kernel was 2.6.13-git6.
I don't update that machine that much. ;-)

Current kernel is 2.6.14-rc1-git1.

-- 
Jan

--------------010109010805010909040303
Content-Type: text/plain;
 name="dmesg-2.6.14-rc1-git1-via"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.14-rc1-git1-via"

[4294667.296000] Linux version 2.6.14-rc1-git1-via (jdittmer@ds666) (gcc version 4.0.2 20050821 (prerelease) (Debian 4.0.1-6)) #31 PREEMPT Thu Sep 15 09:47:46 CEST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000d6000 - 00000000000de000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[4294667.296000]  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[4294667.296000] 0MB HIGHMEM available.
[4294667.296000] 511MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 131056
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 126960 pages, LIFO batch:31
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 AMI                                   ) @ 0x000fa8c0
[4294667.296000] ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x1fff0000
[4294667.296000] ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x1fff0030
[4294667.296000] ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x1fff00c0
[4294667.296000] ACPI: DSDT (v001    VIA    K7VT4 0x00001000 INTL 0x02002024) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0x808
[4294667.296000] ACPI: Local APIC address 0xfee00000
[4294667.296000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 6:8 APIC version 16
[4294667.296000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[4294667.296000] IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[4294667.296000] ACPI: IRQ0 used by override.
[4294667.296000] ACPI: IRQ2 used by override.
[4294667.296000] ACPI: IRQ9 used by override.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294667.296000] Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/md7 ro netconsole=@/,514@192.168.2.134/
[4294667.296000] netconsole: local port 6665
[4294667.296000] netconsole: interface eth0
[4294667.296000] netconsole: remote port 514
[4294667.296000] netconsole: remote IP 192.168.2.134
[4294667.296000] netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[4294667.296000] Detected 1832.944 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294670.083000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[4294670.085000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[4294670.100000] Memory: 514744k/524224k available (2749k kernel code, 8928k reserved, 741k data, 204k init, 0k highmem)
[4294670.100000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[4294670.161000] Calibrating delay using timer specific routine.. 3668.54 BogoMIPS (lpj=1834271)
[4294670.161000] Mount-cache hash table entries: 512
[4294670.161000] CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
[4294670.161000] CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
[4294670.161000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[4294670.161000] CPU: L2 Cache: 256K (64 bytes/line)
[4294670.161000] CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00000000 00000000
[4294670.161000] Intel machine check architecture supported.
[4294670.161000] Intel machine check reporting enabled on CPU#0.
[4294670.161000] mtrr: v2.0 (20020519)
[4294670.161000] CPU: AMD Sempron(tm) 2600+ stepping 01
[4294670.161000] Enabling fast FPU save and restore... done.
[4294670.161000] Enabling unmasked SIMD FPU exception support... done.
[4294670.161000] Checking 'hlt' instruction... OK.
[4294670.174000] ENABLING IO-APIC IRQs
[4294670.175000] ..TIMER: vector=0x31 pin1=2 pin2=-1
[4294670.286000] softlockup thread 0 started up.
[4294670.286000] NET: Registered protocol family 16
[4294670.286000] ACPI: bus type pci registered
[4294670.288000] PCI: PCI BIOS revision 2.10 entry at 0xfda71, last bus=1
[4294670.288000] PCI: Using configuration type 1
[4294670.288000] ACPI: Subsystem revision 20050902
[4294670.296000] ACPI: Interpreter enabled
[4294670.296000] ACPI: Using IOAPIC for interrupt routing
[4294670.297000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294670.297000] PCI: Probing PCI hardware (bus 00)
[4294670.300000] Boot video device is 0000:01:00.0
[4294670.300000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[4294670.324000] ACPI: Power Resource [URP1] (off)
[4294670.324000] ACPI: Power Resource [URP2] (off)
[4294670.324000] ACPI: Power Resource [FDDP] (off)
[4294670.325000] ACPI: Power Resource [LPTP] (off)
[4294670.326000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
[4294670.326000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12 14 15)
[4294670.327000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 12 14 15)
[4294670.327000] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 10 11 12 14 15)
[4294670.327000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[4294670.328000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[4294670.328000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[4294670.328000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[4294670.329000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294670.329000] pnp: PnP ACPI init
[4294670.332000] pnp: PnP ACPI: found 11 devices
[4294670.332000] PnPBIOS: Disabled by ACPI PNP
[4294670.333000] SCSI subsystem initialized
[4294670.333000] PCI: Using ACPI for IRQ routing
[4294670.333000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294670.336000] TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
[4294670.336000] PCI: Bridge: 0000:00:01.0
[4294670.336000]   IO window: disabled.
[4294670.336000]   MEM window: dde00000-dfefffff
[4294670.336000]   PREFETCH window: cdc00000-ddcfffff
[4294670.336000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[4294670.336000] Machine check exception polling timer started.
[4294670.337000] Total HugeTLB memory allocated, 0
[4294670.337000] Initializing Cryptographic API
[4294670.337000] PCI: Bypassing VIA 8237 APIC De-Assert Message
[4294670.337000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[4294670.337000] nvidiafb: nVidia device/chipset 10DE0250
[4294670.342000] nvidiafb: CRTC0 not found
[4294670.346000] nvidiafb: CRTC1 not found
[4294670.458000] nvidiafb: EDID found from BUS1
[4294670.474000] nvidiafb: CRTC 1 is currently programmed for DFP
[4294670.474000] nvidiafb: Using DFP on CRTC 1
[4294670.474000] Panel size is 1920 x 1200
[4294670.475000] nvidiafb: MTRR set to ON
[4294670.482000] Console: switching to colour frame buffer device 240x75
[4294670.482000] nvidiafb: PCI nVidia NV25 framebuffer (64MB @ 0xD0000000)
[4294670.482000] isapnp: Scanning for PnP cards...
[4294670.839000] isapnp: No Plug & Play device found
[4294670.852000] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[4294670.852000] PNP: PS/2 controller doesn't have AUX irq; using default 12
[4294670.852000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294670.852000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294670.852000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[4294670.852000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294670.853000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294670.853000] io scheduler noop registered
[4294670.853000] io scheduler anticipatory registered
[4294670.853000] io scheduler deadline registered
[4294670.853000] io scheduler cfq registered
[4294670.853000] Intel(R) PRO/1000 Network Driver - version 6.0.60-k2-NAPI
[4294670.853000] Copyright (c) 1999-2005 Intel Corporation.
[4294670.853000] netconsole: eth0 doesn't exist, aborting.
[4294670.853000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294670.853000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294670.853000] VP_IDE: IDE controller at PCI slot 0000:00:0f.1
[4294670.853000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
[4294670.854000] PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
[4294670.854000] VP_IDE: chipset revision 6
[4294670.854000] VP_IDE: not 100% native mode: will probe irqs later
[4294670.854000] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
[4294670.854000]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[4294670.854000]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
[4294670.854000] Probing IDE interface ide0...
[4294671.648000] hda: SONY CD-RW CRX175E2, ATAPI CD/DVD-ROM drive
[4294671.954000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294671.954000] Probing IDE interface ide1...
[4294672.473000] Probing IDE interface ide1...
[4294672.992000] hda: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
[4294672.992000] Uniform CD-ROM driver Revision: 3.20
[4294672.995000] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 16
[4294673.205000] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[4294673.205000]         <Adaptec 3960D Ultra160 SCSI adapter>
[4294673.205000]         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[4294673.205000] 
[4294678.206000]   Vendor: FUJITSU   Model: MAP3367NP         Rev: 5207
[4294678.206000]   Type:   Direct-Access                      ANSI SCSI revision: 03
[4294678.206000] scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
[4294678.206000]  target0:0:0: Beginning Domain Validation
[4294678.209000]  target0:0:0: wide asynchronous.
[4294678.215000]  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 127)
[4294678.217000]  target0:0:0: Ending Domain Validation
[4294678.475000]   Vendor: FUJITSU   Model: MAP3367NP         Rev: 0108
[4294678.475000]   Type:   Direct-Access                      ANSI SCSI revision: 03
[4294678.476000] scsi0:A:2:0: Tagged Queuing enabled.  Depth 32
[4294678.478000]  target0:0:2: Beginning Domain Validation
[4294678.482000]  target0:0:2: wide asynchronous.
[4294678.489000]  target0:0:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 127)
[4294678.494000]  target0:0:2: Ending Domain Validation
[4294681.572000] ACPI: PCI Interrupt 0000:00:0c.1[B] -> GSI 17 (level, low) -> IRQ 18
[4294681.783000] scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[4294681.783000]         <Adaptec 3960D Ultra160 SCSI adapter>
[4294681.783000]         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
[4294681.783000] 
[4294687.296000]   Vendor: FUJITSU   Model: MAN3367MC         Rev: 5207
[4294687.297000]   Type:   Direct-Access                      ANSI SCSI revision: 03
[4294687.298000] scsi1:A:2:0: Tagged Queuing enabled.  Depth 32
[4294687.300000]  target1:0:2: Beginning Domain Validation
[4294687.302000]  target1:0:2: wide asynchronous.
[4294687.307000]  target1:0:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 127)
[4294687.311000]  target1:0:2: Ending Domain Validation
[4294690.390000] 3ware Storage Controller device driver for Linux v1.26.02.001.
[4294690.393000] SCSI device sda: 71775284 512-byte hdwr sectors (36749 MB)
[4294690.395000] SCSI device sda: drive cache: write back
[4294690.397000] SCSI device sda: 71775284 512-byte hdwr sectors (36749 MB)
[4294690.400000] SCSI device sda: drive cache: write back
[4294690.401000]  sda: sda1 sda2
[4294690.407000] Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
[4294690.410000] SCSI device sdb: 71775284 512-byte hdwr sectors (36749 MB)
[4294690.413000] SCSI device sdb: drive cache: write back
[4294690.415000] SCSI device sdb: 71775284 512-byte hdwr sectors (36749 MB)
[4294690.417000] SCSI device sdb: drive cache: write back
[4294690.419000]  sdb: sdb1 sdb2
[4294690.430000] Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
[4294690.433000] SCSI device sdc: 71771688 512-byte hdwr sectors (36747 MB)
[4294690.436000] SCSI device sdc: drive cache: write back
[4294690.437000] SCSI device sdc: 71771688 512-byte hdwr sectors (36747 MB)
[4294690.440000] SCSI device sdc: drive cache: write back
[4294690.441000]  sdc: unknown partition table
[4294690.449000] Attached scsi disk sdc at scsi1, channel 0, id 2, lun 0
[4294690.450000] mice: PS/2 mouse device common for all mice
[4294690.452000] input: PC Speaker
[4294690.453000] md: raid1 personality registered as nr 3
[4294690.455000] md: raid5 personality registered as nr 4
[4294690.456000] raid5: automatically using best checksumming function: pIII_sse
[4294690.463000]    pIII_sse  :  2528.000 MB/sec
[4294690.464000] raid5: using function: pIII_sse (2528.000 MB/sec)
[4294690.466000] md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
[4294690.467000] md: bitmap version 3.39
[4294690.469000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[4294690.470000] oprofile: using NMI interrupt.
[4294690.471000] NET: Registered protocol family 2
[4294690.483000] IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
[4294690.484000] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[4294690.486000] TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
[4294690.488000] TCP: Hash tables configured (established 32768 bind 32768)
[4294690.489000] TCP reno registered
[4294690.490000] TCP bic registered
[4294690.492000] NET: Registered protocol family 1
[4294690.493000] NET: Registered protocol family 17
[4294690.495000] NET: Registered protocol family 15
[4294690.496000] Using IPI Shortcut mode
[4294690.498000] ACPI wakeup devices: 
[4294690.499000] PCI0 UAR1 USB1 USB2 USB3 USB4 EHCI USBD PS2K  AC9  MC9 ILAN SLPB 
[4294690.500000] ACPI: (supports S0 S1 S4 S5)
[4294690.502000] md: Autodetecting RAID arrays.
[4294690.527000] md: autorun ...
[4294690.529000] md: considering sdb2 ...
[4294690.530000] md:  adding sdb2 ...
[4294690.531000] md:  adding sda2 ...
[4294690.532000] md: created md7
[4294690.534000] md: bind<sda2>
[4294690.535000] md: bind<sdb2>
[4294690.536000] md: running: <sdb2><sda2>
[4294690.538000] raid1: raid set md7 active with 2 out of 2 mirrors
[4294690.539000] md: ... autorun DONE.
[4294690.576000] EXT3-fs: mounted filesystem with ordered data mode.
[4294690.577000] VFS: Mounted root (ext3 filesystem) readonly.
[4294690.579000] Freeing unused kernel memory: 204k freed
[4294690.580000] kjournald starting.  Commit interval 5 seconds
[4294690.876000] input: AT Translated Set 2 keyboard on isa0060/serio0
[4294690.881000] atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
[4294691.109000] input: AT Translated Set 2 keyboard on isa0060/serio0
[4294695.541000] Adding 995988k swap on /dev/sda1.  Priority:-1 extents:1 across:995988k
[4294695.549000] Adding 995988k swap on /dev/sdb1.  Priority:-2 extents:1 across:995988k
[4294695.567000] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[4294695.569000] EXT3 FS on md7, internal journal
[4294696.217000] Real Time Clock Driver v1.12
[4294696.228000] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
[4294696.229000] e100: Copyright(c) 1999-2005 Intel Corporation
[4294696.273000] ACPI: CPU0 (power states: C1[C1])
[4294696.286000] ACPI: Power Button (FF) [PWRF]
[4294696.287000] ACPI: Power Button (CM) [PWRB]
[4294696.288000] ACPI: Sleep Button (CM) [SLPB]
[4294696.304000] usbcore: registered new driver usbfs
[4294696.307000] usbcore: registered new driver hub
[4294696.314000] USB Universal Host Controller Interface driver v2.3
[4294696.316000] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 19
[4294696.318000] PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 3
[4294696.319000] uhci_hcd 0000:00:10.0: UHCI Host Controller
[4294696.322000] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[4294696.323000] uhci_hcd 0000:00:10.0: irq 19, io base 0x0000c000
[4294696.327000] hub 1-0:1.0: USB hub found
[4294696.328000] hub 1-0:1.0: 2 ports detected
[4294696.431000] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 19
[4294696.432000] PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 3
[4294696.433000] uhci_hcd 0000:00:10.1: UHCI Host Controller
[4294696.436000] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[4294696.437000] uhci_hcd 0000:00:10.1: irq 19, io base 0x0000c400
[4294696.441000] hub 2-0:1.0: USB hub found
[4294696.442000] hub 2-0:1.0: 2 ports detected
[4294696.545000] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 19
[4294696.546000] PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 3
[4294696.547000] uhci_hcd 0000:00:10.2: UHCI Host Controller
[4294696.550000] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[4294696.551000] uhci_hcd 0000:00:10.2: irq 19, io base 0x0000c800
[4294696.555000] hub 3-0:1.0: USB hub found
[4294696.556000] hub 3-0:1.0: 2 ports detected
[4294696.660000] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 19
[4294696.661000] PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 3
[4294696.662000] uhci_hcd 0000:00:10.3: UHCI Host Controller
[4294696.665000] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[4294696.666000] uhci_hcd 0000:00:10.3: irq 19, io base 0x0000cc00
[4294696.670000] hub 4-0:1.0: USB hub found
[4294696.672000] hub 4-0:1.0: 2 ports detected
[4294696.797000] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 19
[4294696.799000] PCI: Via IRQ fixup for 0000:00:10.4, from 10 to 3
[4294696.800000] ehci_hcd 0000:00:10.4: EHCI Host Controller
[4294696.803000] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
[4294696.804000] ehci_hcd 0000:00:10.4: irq 19, io mem 0xdfff9e00
[4294696.806000] ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[4294696.809000] hub 5-0:1.0: USB hub found
[4294696.811000] hub 5-0:1.0: 8 ports detected
[4294696.845000] usb 2-1: new low speed USB device using uhci_hcd and address 2
[4294696.936000] Initializing USB Mass Storage driver...
[4294697.013000] usbcore: registered new driver usb-storage
[4294697.014000] USB Mass Storage support registered.
[4294697.690000] i2c /dev entries driver
[4294697.790000] usb 5-4: new high speed USB device using ehci_hcd and address 3
[4294697.914000] hub 5-4:1.0: USB hub found
[4294697.915000] hub 5-4:1.0: 2 ports detected
[4294698.299000] Linux video capture interface: v1.00
[4294698.610000] usb 2-1: new low speed USB device using uhci_hcd and address 3
[4294698.961000] usb 5-4.1: new high speed USB device using ehci_hcd and address 6
[4294699.052000] hub 5-4.1:1.0: USB hub found
[4294699.053000] hub 5-4.1:1.0: 4 ports detected
[4294699.333000] usb 5-4.2: new high speed USB device using ehci_hcd and address 7
[4294699.510000] scsi2 : SCSI emulation for USB Mass Storage devices
[4294699.513000] usb-storage: device found at 7
[4294699.513000] usb-storage: waiting for device to settle before scanning
[4294699.569000] bttv: driver version 0.9.16 loaded
[4294699.570000] bttv: using 8 buffers with 2080k (520 pages) each for capture
[4294699.574000] bttv: Bt8xx card found (0).
[4294699.575000] ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 18
[4294699.577000] bttv0: Bt878 (rev 2) at 0000:00:0d.0, irq: 18, latency: 32, mmio: 0xdddfe000
[4294699.578000] bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
[4294699.579000] bttv0: using: Hauppauge (bt878) [card=10,autodetected]
[4294699.580000] bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
[4294699.583000] bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
[4294699.718000] usb 3-1: new full speed USB device using uhci_hcd and address 2
[4294699.786000] tveeprom 3-0050: Hauppauge model 61324, rev D108, serial# 1274407
[4294699.787000] tveeprom 3-0050: tuner model is Philips FI1216 MK2 (idx 8, type 5)
[4294699.788000] tveeprom 3-0050: TV standards PAL(B/G) (eeprom 0x04)
[4294699.789000] tveeprom 3-0050: audio processor is MSP3415 (idx 6)
[4294699.791000] tveeprom 3-0050: has radio
[4294699.792000] bttv0: using tuner=5
[4294699.793000] bttv0: i2c: checking for MSP34xx @ 0x80... found
[4294699.835000] msp34xx: init: chip=MSP3410D-B4 +nicam +simple mode=simple
[4294699.837000] msp3410: daemon started
[4294699.861000] bttv0: i2c: checking for TDA9875 @ 0xb0... not found
[4294699.864000] bttv0: i2c: checking for TDA7432 @ 0x8a... not found
[4294699.892000] bttv0: i2c: checking for TDA9887 @ 0x86... not found
[4294699.916000] tuner 3-0061: chip found @ 0xc2 (bt878 #0 [sw])
[4294699.920000] tuner 3-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
[4294699.955000] bttv0: registered device video0
[4294699.959000] bttv0: registered device vbi0
[4294699.963000] bttv0: registered device radio0
[4294699.982000] bttv0: PLL: 28636363 => 35468950 .. ok
[4294700.503000] parport: PnPBIOS parport detected.
[4294700.504000] parport0: PC-style at 0x378 (0x778), irq 7, dma 0 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[4294700.894000] lp0: using parport0 (interrupt-driven).
[4294700.895000] lp0: console ready
[4294700.923000] Linux agpgart interface v0.101 (c) Dave Jones
[4294700.954000] agpgart: Detected VIA KT400/KT400A/KT600 chipset
[4294700.962000] agpgart: AGP aperture is 64M @ 0xe0000000
[4294701.072000] loop: loaded (max 8 devices)
[4294701.138000] tun: Universal TUN/TAP device driver, 1.6
[4294701.139000] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[4294701.636000] via82xx: Assuming DXS channels with 48k fixed sample rate.
[4294701.637000]          Please try dxs_support=5 option
[4294701.638000]          and report if it works on your machine.
[4294701.639000]          For more details, read ALSA-Configuration.txt.
[4294701.641000] ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 20
[4294701.642000] PCI: Via IRQ fixup for 0000:00:11.5, from 10 to 4
[4294701.643000] PCI: Setting latency timer of device 0000:00:11.5 to 64
[4294704.516000]   Vendor: SMSC      Model: 223 U HS-CF       Rev: 3.60
[4294704.517000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294704.530000] Attached scsi removable disk sdd at scsi2, channel 0, id 0, lun 0
[4294704.676000]   Vendor: SMSC      Model: 223 U HS-MS       Rev: 3.60
[4294704.677000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294704.691000] Attached scsi removable disk sde at scsi2, channel 0, id 0, lun 1
[4294704.697000]   Vendor: SMSC      Model: 223 U HS-SM       Rev: 3.60
[4294704.698000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294704.712000] Attached scsi removable disk sdf at scsi2, channel 0, id 0, lun 2
[4294704.726000]   Vendor: SMSC      Model: 223 U HS-SD/MMC   Rev: 3.60
[4294704.727000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294704.744000] SCSI device sdg: 2007040 512-byte hdwr sectors (1028 MB)
[4294704.749000] sdg: Write Protect is off
[4294704.750000] sdg: Mode Sense: 23 e5 00 00
[4294704.750000] sdg: assuming drive cache: write through
[4294704.765000] SCSI device sdg: 2007040 512-byte hdwr sectors (1028 MB)
[4294704.770000] sdg: Write Protect is off
[4294704.772000] sdg: Mode Sense: 23 e5 00 00
[4294704.772000] sdg: assuming drive cache: write through
[4294704.773000]  sdg: sdg1
[4294704.780000] Attached scsi removable disk sdg at scsi2, channel 0, id 0, lun 3
[4294704.788000] usb-storage: device scan complete
[4294705.070000] usb 3-2: new full speed USB device using uhci_hcd and address 3
[4294705.243000] usbcore: registered new driver hiddev
[4294705.422000] usb 5-4.1.1: new full speed USB device using ehci_hcd and address 8
[4294705.687000] usb 5-4.1.4: new high speed USB device using ehci_hcd and address 9
[4294705.965000] scsi3 : SCSI emulation for USB Mass Storage devices
[4294705.969000] usb-storage: device found at 9
[4294705.969000] usb-storage: waiting for device to settle before scanning
[4294706.033000] input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-0000:00:10.1-1
[4294706.034000] usbcore: registered new driver usbhid
[4294706.036000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[4294706.914000] usbcore: registered new driver usbserial
[4294706.918000] drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
[4294706.922000] usbcore: registered new driver usbserial_generic
[4294706.924000] drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
[4294706.966000] drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
[4294706.971000] pl2303 5-4.1.1:1.0: PL-2303 converter detected
[4294707.189000] usb 5-4.1.1: PL-2303 converter now attached to ttyUSB0
[4294707.190000] usbcore: registered new driver pl2303
[4294707.192000] drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.12
[4294708.032000] drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 1 proto 2 vid 0x067B pid 0x2305
[4294708.034000] usbcore: registered new driver usblp
[4294708.036000] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[4294710.970000]   Vendor: Generic   Model:               CF  Rev: 1.6E
[4294710.972000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294710.979000] Attached scsi removable disk sdh at scsi3, channel 0, id 0, lun 0
[4294710.984000]   Vendor: Generic   Model:               MS  Rev: 1.6E
[4294710.985000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294710.993000] Attached scsi removable disk sdi at scsi3, channel 0, id 0, lun 1
[4294710.998000]   Vendor: Generic   Model:           MMC/SD  Rev: 1.6E
[4294710.999000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294711.006000] Attached scsi removable disk sdj at scsi3, channel 0, id 0, lun 2
[4294711.012000]   Vendor: Generic   Model:               SM  Rev: 1.6E
[4294711.013000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294711.019000] Attached scsi removable disk sdk at scsi3, channel 0, id 0, lun 3
[4294711.026000] usb-storage: device scan complete
[4294712.914000] md: md0 stopped.
[4294712.917000] md: bind<sdc>
[4294712.919000] raid1: raid set md0 active with 1 out of 2 mirrors
[4294713.889000] kjournald starting.  Commit interval 5 seconds
[4294713.895000] EXT3 FS on md0, internal journal
[4294713.897000] EXT3-fs: mounted filesystem with ordered data mode.
[4294716.093000] ACPI: PCI Interrupt 0000:00:0d.1[A] -> GSI 17 (level, low) -> IRQ 18
[4294716.604000] libata version 1.12 loaded.
[4294716.618000] sata_via version 1.1
[4294716.618000] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
[4294716.619000] PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
[4294716.621000] sata_via(0000:00:0f.0): routed to hard irq line 1
[4294716.622000] ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 17
[4294716.624000] ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 17
[4294716.826000] ata1: no device found (phy stat 00000000)
[4294716.827000] scsi4 : sata_via
[4294717.031000] ata2: no device found (phy stat 00000000)
[4294717.032000] scsi5 : sata_via
[4294717.432000] via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
[4294717.438000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 21
[4294717.440000] PCI: Via IRQ fixup for 0000:00:12.0, from 11 to 5
[4294717.445000] eth0: VIA Rhine II at 0xdfff9d00, 00:0b:6a:c3:c0:47, IRQ 21.
[4294717.447000] eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
[4294717.737000] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[4294725.155000] Floppy drive(s): fd0 is 1.44M
[4294725.171000] FDC 0 is a post-1991 82077
[4294727.313000] ttyS1: LSR safety check engaged!
[4294727.315000] ttyS1: LSR safety check engaged!
[4294728.343000] NET: Registered protocol family 10
[4294728.344000] Disabled Privacy Extensions on device c0422cc0(lo)
[4294728.345000] IPv6 over IPv4 tunneling driver
[4294731.307000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[4294731.366000] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[4294731.367000] NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
[4294731.367000] NFSD: starting 90-second grace period
[4294733.057000] process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
[4294733.365000] ttyS1: LSR safety check engaged!
[4294744.948000] Bluetooth: Core ver 2.7
[4294744.950000] NET: Registered protocol family 31
[4294744.951000] Bluetooth: HCI device and connection manager initialized
[4294744.953000] Bluetooth: HCI socket layer initialized
[4294744.968000] Bluetooth: L2CAP ver 2.7
[4294744.970000] Bluetooth: L2CAP socket layer initialized
[4294745.005000] Bluetooth: RFCOMM ver 1.5
[4294745.006000] Bluetooth: RFCOMM socket layer initialized
[4294745.008000] Bluetooth: RFCOMM TTY layer initialized
[4294745.055000] Bluetooth: BNEP (Ethernet Emulation) ver 1.2
[4294745.057000] Bluetooth: BNEP filters: protocol multicast
[4294754.122000] tap0: no IPv6 routers present
[4295112.413000] usb 5-4: USB disconnect, address 3
[4295112.413000] usb 5-4.1: USB disconnect, address 6
[4295112.413000] usb 5-4.1.1: USB disconnect, address 8
[4295112.413000] PL-2303 ttyUSB0: PL-2303 converter now disconnected from ttyUSB0
[4295112.414000] pl2303 5-4.1.1:1.0: device disconnected
[4295112.417000] usb 5-4.1.4: USB disconnect, address 9
[4295112.436000] usb 5-4.2: USB disconnect, address 7

--------------010109010805010909040303--
