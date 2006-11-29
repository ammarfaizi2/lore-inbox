Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758682AbWK2B34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682AbWK2B34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758683AbWK2B34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:29:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:28863 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1758682AbWK2B3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:29:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=sZUTS8HGv/y2I5B2A2ezexszybQNKZlYuHBVuRlhAskXomxgHu3fuNhmu/RukKZuz5LSXOGvDwbrU6jdilOem4f00cclbcwHv2NoQH2rlhaVESWKgmKLMhz7iSjrGjVANNRvBqNG5/oj5oDbuvGyOD1uReI1rajKCYgij0fOdQo=
Message-ID: <456CE28D.4040202@gmail.com>
Date: Tue, 28 Nov 2006 23:29:49 -0200
From: Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pt-BR; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 tsc clocksource + ntp = excessive drift; acpi_pm does
 fine.
References: <456CCA54.6090504@gmail.com> <1164762181.5521.49.camel@localhost.localdomain>
In-Reply-To: <1164762181.5521.49.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------040709000902030108000805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040709000902030108000805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

john stultz escreveu:

>On Tue, 2006-11-28 at 21:46 -0200, Alexandre Pereira Nunes wrote:
>  
>
>>Hi,
>>
>>with default boot I got tsc clocksource selected on an debian's
>>2.6.18-3-k7 SMP build (but UP machine). ntp keeps bothering me with this
>>message:
>>frequency error 512 PPM exceeds tolerance 500 PPM
>>    
>>
>
>Hmmm. Could you send me your dmesg? Also what frequency is your cpu?
>
>  
>
Sure, attached!
You'll notice an "acpi_pm installed" or something at the end, that was 
at the time I typed the echo acpi_pm >/sys/whatever.

My cpu is an athlon xp 2600+, I attached a copy of /proc/cpuinfo for 
convenience.

>Also does booting w/ "noapic" change the behavior?
>  
>
I'll test it and let you know. I also read (but didn't try) about some 
"notsc" option, I assume that's not a good one to try, right?

> [cut]
>
>>If I remove ntp's drift file, then do a: echo acpi_pm
>> >/sys/devices/system/clocksource/clocksource0/available_clocksource ;
>>    
>>
>
>I think you mean "current_clocksource" there...
>
>  
>
Ooops. Let's just pretend no one else saw that! :-)

>[cut]
>Yea, its likely the generic timekeeping changes for i386. Previously
>(pre-2.6.18) it probably defaulted to the acpi pm timer and was fine.
>The new code is a bit more aggressive in trying to use the TSC.
>  
>
Just out of curiousity: what about this acpi_pm stuff ... Reading from 
tsc is probably cheaper than any other "accurate" clock source, but how 
bad (or good) is acpi_pm?

>As a short term workaround, you can put "clocksource=acpi_pm" on your
>grub line and that will force the clocksource at boot.
>  
>

Yeah, I googled around and had put that on grub's config, but didn't 
reboot. I'll swap that with noapic and reboot, by tomorrow I should have 
some news.

- Alexandre


--------------040709000902030108000805
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.18-3-k7 (Debian 2.6.18-6) (waldi@debian.org) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)) #1 SMP Thu Nov 23 21:37:22 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d6000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126960 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa8a0
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x1fff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x1fff0030
ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x1fff00c0
ACPI: DSDT (v001    VIA   KT266A 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 2133.046 MHz processor.
Built 1 zonelists.  Total pages: 131056
Kernel command line: root=/dev/hda2 ro 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515356k/524224k available (1556k kernel code, 8332k reserved, 582k data, 196k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4270.91 BogoMIPS (lpj=8541825)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 16k freed
ACPI: Core revision 20060707
CPU0: AMD Athlon(tm) XP 2600+ stepping 01
Total of 1 processors activated (4270.91 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
migration_cost=0
checking if image is initramfs... it is
Freeing initrd memory: 1134k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdae1, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by vt8235 PM
PCI quirk: region 0400-040f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: dde00000-dfefffff
  PREFETCH window: bdd00000-ddcfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1164713211.520:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI No-Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 196k freed
Time: tsc clocksource has been installed.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: Unable to derive IRQ for device 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 15
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
hda: ST340014A, ATA DISK drive
hdb: ST340824A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST RW/DVD GCC-4120B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdb: max request size: 128KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
usbcore: registered new driver usbfs
usbcore: registered new driver hub
input: PC Speaker as /class/input/input1
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 169
PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 9
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 169, io base 0x0000e000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Real Time Clock Driver v1.12ac
ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 169
PCI: VIA IRQ fixup for 0000:00:10.1, from 3 to 9
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 169, io base 0x0000e400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Linux agpgart interface v0.101 (c) Dave Jones
ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 169
PCI: VIA IRQ fixup for 0000:00:10.2, from 5 to 9
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 169, io base 0x0000e800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hdc: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 169
PCI: VIA IRQ fixup for 0000:00:10.3, from 10 to 9
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: irq 169, io mem 0xdffffe00
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 2
via-rhine.c:v1.10-LK1.4.1 July-24-2006 Written by Donald Becker
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
irda_init()
NET: Registered protocol family 23
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 177
eth0: VIA Rhine II at 0x1d800, 00:0c:6e:00:20:f3, IRQ 177.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
8139cp 0000:00:0c.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
8139cp 0000:00:0c.0: Try the "8139too" driver instead.
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
hdd: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 0 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 185
eth1: RealTek RTL8139 at 0xec00, 00:50:bf:5b:d8:32, IRQ 185
eth1:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:11.5 to 64
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 5 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
hub 2-2:1.0: over-current change on port 1
SCSI subsystem initialized
Initializing USB Mass Storage driver...
usb 2-2.2: new low speed USB device using uhci_hcd and address 4
usb 2-2.2: configuration #1 chosen from 1 choice
hub 2-2:1.0: over-current change on port 3
hub 2-2:1.0: over-current change on port 1
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
input: HID 062a:0000 as /class/input/input2
input: USB HID v1.10 Mouse [HID 062a:0000] on usb-0000:00:10.1-2.2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ts: Compaq touchscreen protocol output
Adding 257000k swap on /dev/hda1.  Priority:1 extents:1 across:257000k
  Vendor: IC        Model: USB Storage-CFC   Rev: 301b
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: IC        Model: USB Storage-SMC   Rev: 301b
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: IC        Model: USB Storage-MMC   Rev: 301b
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: IC        Model: USB Storage-MSC   Rev: 301b
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb-storage: device scan complete
sd 0:0:0:0: Attached scsi removable disk sda
sd 0:0:0:1: Attached scsi removable disk sdb
sd 0:0:0:2: Attached scsi removable disk sdc
sd 0:0:0:3: Attached scsi removable disk sdd
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 185
NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-9629  Wed Nov  1 19:30:07 PST 2006
i2c /dev entries driver
ppdev: user-space parallel port driver
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 224 bytes per conntrack
Bridge firewalling registered
device eth0 entered promiscuous mode
audit(1164720447.797:2): dev=eth0 prom=256 old_prom=0 auid=4294967295
eth0: Promiscuous mode enabled.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
br0: port 1(eth0) entering learning state
br0: topology change detected, propagating
br0: port 1(eth0) entering forwarding state
br0: port 1(eth0) entering disabled state
br0: port 1(eth0) entering learning state
br0: topology change detected, propagating
br0: port 1(eth0) entering forwarding state
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
br0: no IPv6 routers present
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
lp0: using parport0 (interrupt-driven).
/dev/vmmon[3102]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[3102]: Module vmmon: initialized
/dev/vmnet: open called by PID 3128 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-br0: enabling the bridge
bridge-br0: up
bridge-br0: already up
bridge-br0: attached
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
hub 2-2:1.0: port 2 disabled by hub (EMI?), re-enabling...
usb 2-2.2: USB disconnect, address 4
usb 2-2.2: new low speed USB device using uhci_hcd and address 5
usb 2-2.2: configuration #1 chosen from 1 choice
input: HID 062a:0000 as /class/input/input3
input: USB HID v1.10 Mouse [HID 062a:0000] on usb-0000:00:10.1-2.2
usb 2-1: new full speed USB device using uhci_hcd and address 6
usb 2-1: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 6 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1411
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/class/usblp.c: usblp0: removed
Time: acpi_pm clocksource has been installed.

--------------040709000902030108000805
Content-Type: text/plain;
 name="cpuinfo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo.txt"

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(tm) XP 2600+
stepping	: 1
cpu MHz		: 2133.046
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow up ts
bogomips	: 4270.91


--------------040709000902030108000805--
