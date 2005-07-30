Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVG3P4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVG3P4X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbVG3P4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:56:23 -0400
Received: from pop-cowbird.atl.sa.earthlink.net ([207.69.195.68]:24830 "EHLO
	pop-cowbird.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S262986AbVG3P4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:56:21 -0400
Message-ID: <42EBA31F.9080703@earthlink.net>
Date: Sat, 30 Jul 2005 11:56:15 -0400
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sclark46@earthlink.net
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 sound problem
References: <42E6C8DB.4090608@earthlink.net>	<s5hr7dklko4.wl%tiwai@suse.de>	<42E7A8D8.1030809@earthlink.net> <20050729014150.6e97dfd2.akpm@osdl.org> <42EAF070.5050001@earthlink.net>
In-Reply-To: <42EAF070.5050001@earthlink.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark wrote:

>Andrew Morton wrote:
>
>  
>
>>(Please do reply-to-all when dealing with kernel stuff)
>>
>>Stephen Clark <stephen.clark@earthlink.net> wrote:
>> 
>>
>>    
>>
>>>Takashi Iwai wrote:
>>>
>>>   
>>>
>>>      
>>>
>>>>At Tue, 26 Jul 2005 19:35:55 -0400,
>>>>Stephen Clark wrote:
>>>>
>>>>
>>>>     
>>>>
>>>>        
>>>>
>>>>>Hello List,
>>>>>
>>>>>
>>>>>I recently upgraded my laptop, HP Pavilion N5430, from a 2.4.21 kernel
>>>>>to 2.6.12. As a result of
>>>>>doing this my sound no longer works correctly. It plays the same thing
>>>>>repeatedly some number
>>>>>of times - if it plays at all.
>>>>>
>>>>>Any ideas on how to debug this would be appreciated.
>>>>>
>>>>>Additional info I don't see any interrupts in /proc/interrupts for the
>>>>>Allegro which is on int 5.
>>>>>I just tried the same laptop with knoppix and a 2.4.27 kernel and sound
>>>>>works great and I do
>>>>>see interrupts for Allegro on int 5.
>>>>>  
>>>>>
>>>>>       
>>>>>
>>>>>          
>>>>>
>>>>The irq problem is likely related with ACPI.
>>>>Try to boot once with pci=noacpi.
>>>>
>>>>
>>>>Takashi
>>>>-
>>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>>the body of a message to majordomo@vger.kernel.org
>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>>
>>>>
>>>>
>>>>     
>>>>
>>>>        
>>>>
>>>Hi Takashi,
>>>
>>>I have boot the 2.6.12 kernel with acpi=off pci=noacpi,usepirqmask or I
>>>get a panic or a hang.
>>>   
>>>
>>>      
>>>
>>It's just really awful that 2.4 simply worked and 2.6 requires a sprinkle
>>of obscure kernel parameters.  I shudder to think how long it took you to
>>work them out.
>>
>> 
>>
>>    
>>
>>>I don't have to do this with 2.4.27, anybody know why?
>>>
>>>   
>>>
>>>      
>>>
>>Perhaps you could send the `dmesg -s 1000000' output?
>>
>> 
>>
>>    
>>
>Hi Andrew,
>
>Thanks for the response.
>
>I found a better solution to my problem with my HP N5430 laptop over on 
>the alsa-devel list, my sound had quit working also. The new
>solution, which was pointed out to me by Henry Yuan was to boot with 
>lapic. I had noticed in the dmesg output that a lapic existed but was 
>turned off by the bios, and a pseudo local apic was being used, this 
>caused problems with APCI and my sound.
>
>If you would still like the dmesg I would be glad to send it.
>
>Steve
>-
>
>  
>
Hello Andrew

My joy was short lived - but I do have more info.

1) If I cold boot with only 'lacpi' to run level 3 - shortly after I get 
the login prompt the laptop freezes.

2) If I cold boot with 'lacpi  acpi=off  pci=noacpi,usepirqmask'  the 
system boots and does not freeze but  when I try to play sound I get no 
interrupts from my sound card.

3) If I now warm boot from step  2 with only 'lacpi' my  laptop seems to 
be stable  and I have sound.

I did this several times to try and really verify the above scenarios.

Diff between dmesg output from step 1 and step 3
$ diff dmesg104550 dmesg105029
43,45c43,44
< CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
< CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
< Enabling disabled K7/SSE Support.
---
 > CPU: After generic identify, caps: 0383f9ff c1c7f9ff 00000000 
00000000 00000000 00000000 00000000
 > CPU: After vendor identify, caps: 0383f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
55c54
< ACPI: setting ELCR to 0200 (from 0800)
---
 > ACPI: setting ELCR to 0200 (from 0820)
92c91
< audit(1122734733.300:1): initialized
---
 > audit(1122735011.179:1): initialized
161c160
< Detected 849.810 MHz processor.
---
 > Detected 850.192 MHz processor.
163c162
< powernow: Minimum speed 299 MHz. Maximum speed 849 MHz.
---
 > powernow: Minimum speed 300 MHz. Maximum speed 850 MHz.



I also captured dmesg output from the 3 steps, which are listed below



from step 1.
Linux version 2.6.12-1.1398_FC4 (bhcompile@tweety.build.redhat.com) (gcc 
version 4.0.0 20050519 (Red Hat 4.0.0-8)) #1 Fri Jul 15 00:52:32 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7c20
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0fffcc46
ACPI: FADT (v001 ALI    M1533    0x06040000 PTL  0x000f4240) @ 0x0fffef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0fffefd8
ACPI: DSDT (v001 COMPAL      736 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 10000000 (gap: 10000000:eff80000)
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 lapic rhgb quiet
Initializing CPU#0
CPU 0 irqstacks, hard=c0454000 soft=c0453000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 849.759 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 253496k/262080k available (2508k kernel code, 7896k reserved, 
684k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1687.55 BogoMIPS (lpj=843776)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps: 0383f1ff c1c7f9ff 00000000 00000020 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0800)
checking if image is initramfs... it is
Freeing initrd memory: 1670k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKU] (IRQs *9)
ACPI: Embedded Controller [EC0] (gpe 25)
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
pnp: 00:06: ioport range 0x3810-0x381f has been reserved
pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:06: ioport range 0x8000-0x805f could not be reserved
pnp: 00:06: ioport range 0x4d6-0x4d6 has been reserved
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1122734733.300:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 57652F2F3358E32D
- User ID: Red Hat, Inc. (Kernel Module GPG key)
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (63 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1647 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ACPI: PCI Interrupt 0000:00:0f.0[A]: no GSI
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HITACHI_DK23CA-20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 6, 458752 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Detected 849.810 MHz processor.
powernow: SGTC: 10000
powernow: Minimum speed 299 MHz. Maximum speed 849 MHz.
ACPI wakeup devices:
SBTN  LAN COM1
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 184k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
input: PS/2 Generic Mouse on isa0060/serio1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:10.0 (0010 -> 0013)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKB] -> GSI 11 (level, 
low) -> IRQ 11
tulip0:  MII transceiver #1 config 1000 status 786d advertising 01e1.
eth0: ADMtek Comet rev 17 at d0834000, 00:D0:59:5C:E0:EB, IRQ 11.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKC] -> GSI 5 (level, low) 
-> IRQ 5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKU] -> GSI 9 (level, low) 
-> IRQ 9
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 9, io mem 0xfff70000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:04.0 [103c:0018]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.0, mfunc 0x009c1b22, devctl 0x66
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:04.1[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:04.1 [103c:0018]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.1, mfunc 0x009c1b22, devctl 0x66
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000006
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 524280k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1

from step 2.
Linux version 2.6.12-1.1398_FC4 (bhcompile@tweety.build.redhat.com) (gcc 
version 4.0.0 20050519 (Red Hat 4.0.0-8)) #1 Fri Jul 15 00:52:32 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Allocating PCI resources starting at 10000000 (gap: 10000000:eff80000)
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 single acpi=off 
pci=noacpi,usepirqmask lapic rhgb quiet
Initializing CPU#0
CPU 0 irqstacks, hard=c0454000 soft=c0453000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 849.764 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 253496k/262080k available (2508k kernel code, 7896k reserved, 
684k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1675.26 BogoMIPS (lpj=837632)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps: 0383f1ff c1c7f9ff 00000000 00000020 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 1670k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using ALI IRQ Router
PCI: Using IRQ router ALI [10b9/1533] at 0000:00:07.0
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
audit(1122734871.934:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 57652F2F3358E32D
- User ID: Red Hat, Inc. (Kernel Module GPG key)
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1647 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HITACHI_DK23CA-20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 6, 458752 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Detected 850.279 MHz processor.
powernow: SGTC: 10000
powernow: Minimum speed 300 MHz. Maximum speed 850 MHz.
Freeing unused kernel memory: 184k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
input: PS/2 Generic Mouse on isa0060/serio1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: dm-0: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 4125296
ext3_orphan_cleanup: deleting unreferenced inode 4125294
EXT3-fs: dm-0: 2 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:10.0 (0010 -> 0013)
PCI: setting IRQ 11 as level-triggered
PCI: Assigned IRQ 11 for device 0000:00:10.0
PCI: Sharing IRQ 11 with 0000:00:04.0
PCI: Sharing IRQ 11 with 0000:00:04.1
PCI: Sharing IRQ 11 with 0000:01:00.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 01e1.
eth0: ADMtek Comet rev 17 at d0818000, 00:D0:59:5C:E0:EB, IRQ 11.
PCI: setting IRQ 5 as level-triggered
PCI: Assigned IRQ 5 for device 0000:00:08.0
PCI: Sharing IRQ 5 with 0000:00:08.1
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x1001
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Assigned IRQ 11 for device 0000:00:02.0
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 11, io mem 0xfff70000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 11 for device 0000:00:04.0
PCI: Sharing IRQ 11 with 0000:00:04.1
PCI: Sharing IRQ 11 with 0000:00:10.0
PCI: Sharing IRQ 11 with 0000:01:00.0
Yenta: CardBus bridge found at 0000:00:04.0 [103c:0018]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.0, mfunc 0x009c1b22, devctl 0x66
Yenta: ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000006
PCI: Assigned IRQ 11 for device 0000:00:04.1
PCI: Sharing IRQ 11 with 0000:00:04.0
PCI: Sharing IRQ 11 with 0000:00:10.0
PCI: Sharing IRQ 11 with 0000:01:00.0
Yenta: CardBus bridge found at 0000:00:04.1 [103c:0018]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.1, mfunc 0x009c1b22, devctl 0x66
spurious 8259A interrupt: IRQ7.
Yenta: ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000006
0000:00:10.0: tulip_stop_rxtx() failed
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 524280k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1

Step 3.
Linux version 2.6.12-1.1398_FC4 (bhcompile@tweety.build.redhat.com) (gcc 
version 4.0.0 20050519 (Red Hat 4.0.0-8)) #1 Fri Jul 15 00:52:32 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7c20
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0fffcc46
ACPI: FADT (v001 ALI    M1533    0x06040000 PTL  0x000f4240) @ 0x0fffef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0fffefd8
ACPI: DSDT (v001 COMPAL      736 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 10000000 (gap: 10000000:eff80000)
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 lapic rhgb quiet
Initializing CPU#0
CPU 0 irqstacks, hard=c0454000 soft=c0453000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 849.759 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 253496k/262080k available (2508k kernel code, 7896k reserved, 
684k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1687.55 BogoMIPS (lpj=843776)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps: 0383f1ff c1c7f9ff 00000000 00000020 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0820)
checking if image is initramfs... it is
Freeing initrd memory: 1670k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKU] (IRQs *9)
ACPI: Embedded Controller [EC0] (gpe 25)
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
pnp: 00:06: ioport range 0x3810-0x381f has been reserved
pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:06: ioport range 0x8000-0x805f could not be reserved
pnp: 00:06: ioport range 0x4d6-0x4d6 has been reserved
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1122735011.179:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 57652F2F3358E32D
- User ID: Red Hat, Inc. (Kernel Module GPG key)
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (63 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1647 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ACPI: PCI Interrupt 0000:00:0f.0[A]: no GSI
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HITACHI_DK23CA-20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 6, 458752 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Detected 850.192 MHz processor.
powernow: SGTC: 10000
powernow: Minimum speed 300 MHz. Maximum speed 850 MHz.
ACPI wakeup devices:
SBTN  LAN COM1
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 184k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
input: PS/2 Generic Mouse on isa0060/serio1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:10.0 (0010 -> 0013)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKB] -> GSI 11 (level, 
low) -> IRQ 11
tulip0:  MII transceiver #1 config 1000 status 786d advertising 01e1.
eth0: ADMtek Comet rev 17 at d0834000, 00:D0:59:5C:E0:EB, IRQ 11.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKC] -> GSI 5 (level, low) 
-> IRQ 5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKU] -> GSI 9 (level, low) 
-> IRQ 9
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 9, io mem 0xfff70000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:04.0 [103c:0018]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.0, mfunc 0x009c1b22, devctl 0x66
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:04.1[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:04.1 [103c:0018]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.1, mfunc 0x009c1b22, devctl 0x66
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000006
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 524280k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1

Any ideas would be appreciated.
Steve
