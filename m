Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVG2V7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVG2V7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVG2V7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:59:38 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:45198 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262920AbVG2V7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:59:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:from;
        b=kicG8dKXH5vaIpkjo8FT/mQqR0rEIRpnQLCXz6jP7whE6SAlu+s5gMO5SCsxEpoTL9nBvS7E3bQG6ul66cEgqGXKneSOOvzIT3esObh4CVSeUfIiSqXwQvcCaJAQCaB5LoFhfELu0fTDjKr31bi3lTRSIyIiQiwxp8E4Dbt3ho8=
Message-ID: <42EAC330.90900@gmail.com>
Date: Sat, 30 Jul 2005 00:00:48 +0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050726)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Thonke <tk-shockwave@web.de>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org>	<42E96A42.7060405@gmail.com>	<20050728164640.062286fe.akpm@osdl.org>	<42EA4FCC.7030600@web.de> <20050729123330.2fcfb751.akpm@osdl.org>
In-Reply-To: <20050729123330.2fcfb751.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000304010806070102050401"
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000304010806070102050401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton schrieb:

>Michael Thonke <tk-shockwave@web.de> wrote:
>  
>
>>Andrew Morton schrieb:
>>    
>>
>>>Michael Thonke <iogl64nx@gmail.com> wrote:
>>>      
>>>
>>>>here again I have two problems. With 2.6.13-rc3-mm3 I have problems 
>>>> using my SATA drives on Intel ICH6.
>>>> The kernel can't route there IRQs or can't discover them. the option 
>>>> irqpoll got them to work now.
>>>> The problem is new because 2.6.13-rc3[-mm1,mm2] work without any problems.
>>>>        
>>>>
>>>OK.  Please generate the full dmesg output for -mm2 and for -mm3 and run
>>>`diff -u dmesg.mm2 dmesg.mm3' and send it?  And keep those files because we
>>>may end up needing to add them to an acpi bugzilla entry ;)
>>>      
>>>
>>Well I did a little mistake..it only worked correctly up to
>>2.6.13-rc3-mm1 but this dmesg output I have.
>>
>>Well as I save mm[2,3] are unable to setup the correct IRQs for the
>>devices..and please note that 2.6.13-rc3-mm3 only booted with irqpoll so
>>its in the dmesg output "dmesg.mm3"
>>Normaly the IRQ routed to something about 1xx now they are 1-21?! Caused
>>by irqpoll?
>>
>>    
>>
>
>Are these problems only present in -mm kernels?  Does 2.6.13-rc4 work OK?
>  
>
I'm sorry to say that, Yes.

I finially compiled a fresh 2.6.13-rc4-git1 kernel with ck-patch and 
Gregh-kh patches.

With this kernel non of the problems I had with mm-kernel are present.
Here is everthing just perfect..now
I attached a dmesg output for review :-)

The Oops on probing snd-hda-intel gone. It works now ... Mozart rocks :-)
I look at the CVS tree of Alsa later.

I finialy converted my reiser4 root to reiser 3.6.

Where I can get acpidumb or what it is called?

>  
>
>>>Odd trace.  Do you have CONFIG_KALLSYMS enabled?  If not, please turn it on.
>>>      
>>>
Okay, i will do so ... what else we need to back that out.

>>Mh I tried but my system freezes on boot then. And screen leaves blank.
>>    
>>
>
>Oh geeze.
>  
>
Like oh my god? ;-)

>@@ -53,10 +23,18 @@
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
>+    ACPI-0287: *** Error: Region SystemMemory(0) has no handler
>+    ACPI-0127: *** Error: acpi_load_tables: Could not load namespace: AE_NOT_EXIST
>+    ACPI-0136: *** Error: acpi_load_tables: Could not load tables: AE_NOT_EXIST
>+ACPI: Unable to load the System Description Tables
> ENABLING IO-APIC IRQs
>-..TIMER: vector=0x31 pin1=2 pin2=0
>+..TIMER: vector=0x31 pin1=2 pin2=-1 
>  
>
The pin2=-1 is wrong I think, right?

> NET: Registered protocol family 16
> PCI: Using configuration type 1
>+ACPI: Subsystem revision 20050708
>+ACPI: Interpreter disabled.
>
>Well it looks like ACPI committed suicide, so there's probably not much
>point looking at the other things until that gets addressed.
>
>Would you have time to raise a kernel bugzilla entry for this?  Raise it
>against the ACPI AML interpreter, version 20050708 and mention the above
>failure.  The output of acpidump (from
>ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-20050727.tar.gz)
>will probably be asked for.
>
>Thanks.
>
>  
>
Sorry for my different mail accounts, gmail have some problems.
Let me say, Thanks again for the help Andrew and all others.

--------------000304010806070102050401
Content-Type: text/plain;
 name="dmesg.2613rc4git1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.2613rc4git1"

 IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
    ACPI-0362: *** Error: Looking up [CHAF] in namespace, AE_NOT_FOUND
search_node b1994240 start_node b1994240 return_node 00000000
    ACPI-0362: *** Error: Looking up [OC06] in namespace, AE_NOT_FOUND
search_node b1994f60 start_node b1994f60 return_node 00000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: d2f00000-d7ffffff
  PREFETCH window: d8000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: c000-cfff
  MEM window: d2e00000-d2efffff
  PREFETCH window: 40000000-400fffff
PCI: Bridge: 0000:00:1e.0
  IO window: b000-bfff
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pnp: 00:06: ioport range 0x290-0x297 has been reserved
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
vesafb: framebuffer at 0xd8000000, mapped to 0xf0880000, using 5120k, total 131072k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:d620
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
fb1: Virtual frame buffer device, using 1024K of video memory
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12
i8xx TCO timer: heartbeat value must be 2<heartbeat<39, using 30
i8xx TCO timer: initialized (0x0860). heartbeat=30 sec (nowayout=0)
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 2 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
ub: sizeof ub_scsi_cmd 68 ub_dev 2388 ub_lun 140
usbcore: registered new driver ub
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
sk98lin: Network Device Driver v8.23.1.3
(C)Copyright 1999-2005 Marvell(R).
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
      PrefPort:A  RlmtMode:Check Link State
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH6: chipset revision 5
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
hdb: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 63X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdb: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
libata version 1.11 loaded.
ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xAC00 ctl 0xA882 bmdma 0xA400 irq 19
ata2: SATA max UDMA/133 cmd 0xA800 ctl 0xA482 bmdma 0xA408 irq 19
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:20ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:20ff
ata2: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: WU10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: WU10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xd2dffc00
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00009880
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00009c00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000a080
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-1: new low speed USB device using uhci_hcd and address 2
usb 2-2: new low speed USB device using uhci_hcd and address 3
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Keyboard [CHESEN USB Keyboard] on usb-0000:00:1d.0-1
input: USB HID v1.10 Device [CHESEN USB Keyboard] on usb-0000:00:1d.0-1
input: USB HID v1.10 Mouse [Genius       NetScroll+Mini Traveler] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
usb 4-1: new full speed USB device using uhci_hcd and address 2
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
pl2303 4-1:1.0: PL-2303 converter detected
usb 4-1: PL-2303 converter now attached to ttyUSB0
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.12
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
P0P1 P0P3 P0P4 P0P5 P0P6 P0P7 USB1 USB2 USB3 USB4 EUSB MC97 
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb7 ...
md:  adding sdb7 ...
md: sdb6 has different UUID to sdb7
md: sdb5 has different UUID to sdb7
md: sda7 has different UUID to sdb7
md:  adding sda6 ...
md: sda5 has different UUID to sdb7
md: created md2
md: bind<sda6>
md: bind<sdb7>
md: running: <sdb7><sda6>
md2: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb7
raid0:   comparing sdb7(20000768) with sdb7(20000768)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda6
raid0:   comparing sda6(20000768) with sdb7(20000768)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 40001536 blocks.
raid0 : conf->hash_spacing is 40001536 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: sda7 has different UUID to sdb6
md:  adding sda5 ...
md: created md0
md: bind<sda5>
md: bind<sdb6>
md: running: <sdb6><sda5>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb6
raid0:   comparing sdb6(20000768) with sdb6(20000768)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda5
raid0:   comparing sda5(20000768) with sdb6(20000768)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 40001536 blocks.
raid0 : conf->hash_spacing is 40001536 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: considering sdb5 ...
md:  adding sdb5 ...
md:  adding sda7 ...
md: created md1
md: bind<sda7>
md: bind<sdb5>
md: running: <sdb5><sda7>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb5
raid0:   comparing sdb5(20000768) with sdb5(20000768)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda7
raid0:   comparing sda7(20000768) with sdb5(20000768)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 40001536 blocks.
raid0 : conf->hash_spacing is 40001536 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: ... autorun DONE.
ReiserFS: md2: found reiserfs format "3.6" with standard journal
ReiserFS: md2: using ordered data mode
ReiserFS: md2: journal params: device md2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md2: checking transaction log (md2)
ReiserFS: md2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 192k freed
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
hda_codec: num_steps = 0 for NID=0x8
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:04:00.0 to 64
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7667  Fri Jun 17 07:01:04 PDT 2005
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9

--------------000304010806070102050401--
