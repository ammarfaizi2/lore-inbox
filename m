Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUHLUU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUHLUU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268744AbUHLUU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:20:27 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22915 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268727AbUHLUTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:19:35 -0400
Message-ID: <411BD1B4.2000504@tmr.com>
Date: Thu, 12 Aug 2004 16:23:16 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Clayton <chris@theclaytons.giointernet.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: CDMRW in 2.6
References: <200408091625.31210.chris@theclaytons.giointernet.co.uk>
In-Reply-To: <200408091625.31210.chris@theclaytons.giointernet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Clayton wrote:
> I've posted about this once before but got no response 
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=108547084708532&w=2).
> Since then I've tried kernels (including -rc and -mm) from time to time, but 
> still no joy. However, with 2.6.8-rc3 the error messages that I see from 
> dmesg have changed so I thought I'd give it another go. The other thing 
> that's changed since my last post is my CDRW drive. In an effort to get CDMRW 
> working, I bought a Lite-On LTR-52327S (52x32x52), which according to 
> http://mt-rainier.org/ is a verfied product (we'll have to ignore the 
> firmware version shown on that site; Lite-On insist that it does not exist, 
> but I do have the latest version available from Lite-On).
> 
> The CDRW media works fine with packet writing that I have patched into another 
> kernel, so it doesn't appear to be a media problem. I've also tried some 
> Verbatim 32x media in case it was a speed of drive versus max speed of media 
> problem, but that made no difference. I'm using what I believe to be the 
> latest version of the cdmrw application - posted to this list by Jens Axboe 
> on 2003-12-18 and the latest version of mkudffs (1.0.0b3).
> 
> The process I go through to prepare a cdmrw disk is as follows:
> 
> cdrwtool -d /dev/hdc -t 10 -b fast
> cdmrw -d /dev/hdc -f full
> while cdmrw -d /dev/hdc -f full | grep "mrw format running" ; do sleep 10; 
> done
> mkudffs --media-type=cdrw /dev/hdc
> 
> dmesg then shows:
> 
> Linux version 2.6.8-rc3 (chris@upstairs) (gcc version 3.3.4) #1 Mon Aug 9 
> 11:54:41 UTC 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
>  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 511MB LOWMEM available.
> On node 0 totalpages: 131056
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 126960 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.3 present.
> ACPI: RSDP (v000 KT266                                     ) @ 0x000f7570
> ACPI: RSDT (v001 KT266  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
> ACPI: FADT (v001 KT266  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
> ACPI: DSDT (v001 KT266  AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
> Built 1 zonelists
> Kernel command line: root=/dev/hdb1 ro
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> Initializing CPU#0
> PID hash table entries: 2048 (order 11: 16384 bytes)
> Detected 1741.087 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 515192k/524224k available (2116k kernel code, 8268k reserved, 859k 
> data, 152k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay loop... 3432.44 BogoMIPS
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
> CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm) XP 2100+ stepping 01
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1740.0523 MHz.
> ..... host bus clock speed is 267.0772 MHz.
> NET: Registered protocol family 16
> spurious 8259A interrupt: IRQ7.
> PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=1
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Using IRQ router default [1106/3099] at 0000:00:00.0
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
> udf: registering filesystem
> Initializing Cryptographic API
> lp: driver loaded but no devices found
> Real Time Clock Driver v1.12
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected VIA KT266/KY266x/KT333 chipset
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: AGP aperture is 64M @ 0xe8000000
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> parport0: PC-style at 0x378 [PCSPP,TRISTATE]
> lp0: using parport0 (polling).
> Using anticipatory io scheduler
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> 8139too Fast Ethernet driver 0.9.27
> eth0: RealTek RTL8139 at 0xe0816000, 00:10:a7:16:aa:36, IRQ 11
> eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:DMA
> hda: ExcelStor Technology J360, ATA DISK drive
> hda: IRQ probe failed (0xfefa)
> hdb: ExcelStor Technology J360, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: LITE-ON LTR-52327S, ATAPI CD/DVD-ROM drive
> hdd: OPTORITEDVD RW DD0203, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 1024KiB
> hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
> hdb: max request size: 1024KiB
> hdb: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
>  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 >
> hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
> ehci_hcd 0000:00:09.2: NEC Corporation USB 2.0
> ehci_hcd 0000:00:09.2: irq 10, pci mem e0818000
> ehci_hcd 0000:00:09.2: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:09.2: USB 2.0 enabled, EHCI 0.95, driver 2004-May-10
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 5 ports detected
> ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ohci_hcd: block sizes: ed 64 td 64
> ohci_hcd 0000:00:09.0: NEC Corporation USB
> ohci_hcd 0000:00:09.0: irq 11, pci mem e081a000
> ohci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> ohci_hcd 0000:00:09.1: NEC Corporation USB (#2)
> ohci_hcd 0000:00:09.1: irq 5, pci mem e081c000
> ohci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 3
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> USB Universal Host Controller Interface driver v2.2
> uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller
> uhci_hcd 0000:00:11.2: irq 10, io base 0000d800
> uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 4
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> uhci_hcd 0000:00:11.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (#2)
> uhci_hcd 0000:00:11.3: irq 10, io base 0000dc00
> uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 5
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 2 ports detected
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 
> 2004 UTC).
> PCI: Setting latency timer of device 0000:00:11.5 to 64
> usb 4-1: new full speed USB device using address 2
> ALSA device list:
>   #0: VIA 8233A at 0xe000, irq 5
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 15
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 152k freed
> EXT3 FS on hdb1, internal journal
> Adding 997912k swap on /dev/hdb2.  Priority:-1 extents:1
> ip_tables: (C) 2000-2002 Netfilter core team
> eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> Linux video capture interface: v1.00
> bttv: driver version 0.9.15 loaded
> bttv: using 8 buffers with 2080k (520 pages) each for capture
> bttv: Bt8xx card found (0).
> bttv0: Bt878 (rev 17) at 0000:00:0b.0, irq: 10, latency: 32, mmio: 0xee003000
> bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
> bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
> bttv0: gpio: en=00000000, out=00000000 in=00fffbdf [init]
> bttv0: i2c: checking for MSP34xx @ 0x80... found
> bttv0: pinnacle/mt: id=2 info="PAL+SECAM / stereo" radio=yes
> bttv0: using tuner=33
> bttv0: i2c: checking for MSP34xx @ 0x80... found
> msp34xx: init: chip=MSP3410G-B11 +nicam +simple +radio
> bttv0: i2c: checking for TDA9875 @ 0xb0... not found
> bttv0: i2c: checking for TDA7432 @ 0x8a... not found
> msp3410: daemon started
> tda9885/6/7: chip found @ 0x86
> tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
> tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]
> tuner: microtune: companycode=4d54 part=04 rev=04
> tuner: microtune MT2032 found, OK
> bttv0: registered device video0
> bttv0: registered device vbi0
> bttv0: registered device radio0
> bttv0: PLL: 28636363 => 35468950 .. ok
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be 
> trying access hardware directly.
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be 
> trying access hardware directly.
> cdrom: hdc: mrw address space DMA selected
> cdrom open: mrw_status 'mrw complete'
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1048576
> Buffer I/O error on device hdc, logical block 262144
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1048580
> Buffer I/O error on device hdc, logical block 262145
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1040384
> Buffer I/O error on device hdc, logical block 260096
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1040388
> Buffer I/O error on device hdc, logical block 260097
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1036288
> Buffer I/O error on device hdc, logical block 259072
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1036292
> Buffer I/O error on device hdc, logical block 259073
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1034240
> Buffer I/O error on device hdc, logical block 258560
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1034244
> Buffer I/O error on device hdc, logical block 258561
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1033216
> Buffer I/O error on device hdc, logical block 258304
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1033220
> Buffer I/O error on device hdc, logical block 258305
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1032704
> Buffer I/O error on device hdc, logical block 258176
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1032708
> Buffer I/O error on device hdc, logical block 258177
> 
> As before, I'm more than willing to provide more diagnostics, try patches, 
> etc. Please cc me, I'm not subscribed.

What does hdparm show after boot before you start this process? Any odd 
DMA or mode settings?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
