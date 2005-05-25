Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVEYK20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVEYK20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 06:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVEYK2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 06:28:25 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:25744 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S262117AbVEYKY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 06:24:29 -0400
From: Michael Neuffer <neuffer@neuffer.info>
Date: Wed, 25 May 2005 12:24:10 +0200
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Failed Assertion in libata-core.c
Message-ID: <20050525102410.GA14845@neuffer.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeff

I just aquired myself a Promise SATA150 TX4 controller and
a RAIDSonic SATA 4in3 Backplane on Ebay plus 4 drives and 
started playing around with them. 

While building an RAID 5 array I got an assertion.

This is with a 2.6.12-rc4-mm2 kernel

[4338287.713000] md: bind<sdc1>
[4338287.719000] md: bind<sdd1>
[4338287.726000] raid5: device sdd1 operational as raid disk 3
[4338287.732000] raid5: device sdc1 operational as raid disk 2
[4338287.739000] raid5: device sdb1 operational as raid disk 1
[4338287.745000] raid5: device sda1 operational as raid disk 0
[4338287.752000] raid5: allocated 4206kB for md6
[4338287.758000] raid5: raid level 5 set md6 active with 4 out of 4 devices, algorithm 2
[4338287.765000] RAID5 conf printout:
[4338287.771000]  --- rd:4 wd:4 fd:0
[4338287.777000]  disk 0, o:1, dev:sda1
[4338287.783000]  disk 1, o:1, dev:sdb1
[4338287.789000]  disk 2, o:1, dev:sdc1
[4338287.796000]  disk 3, o:1, dev:sdd1
[4338287.802000] .......<6>md: syncing RAID array md6
[4338287.809000] md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
[4338287.815000] md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for reconstruction.
[4338287.821000] md: using 128k window, over a total of 390708736 blocks.
[4338606.290000] md: md6: sync done.
[4338606.303000] md: checkpointing recovery of md6.
[4338606.311000] md: md6 stopped.
[4338606.317000] md: unbind<sdd1>
[4338606.322000] md: export_rdev(sdd1)
[4338606.328000] md: unbind<sdc1>
[4338606.334000] md: export_rdev(sdc1)
[4338606.339000] md: unbind<sdb1>
[4338606.345000] md: export_rdev(sdb1)
[4338606.351000] md: unbind<sda1>
[4338606.356000] md: export_rdev(sda1)
[4338755.703000] md: bind<sda1>
[4338755.708000] md: bind<sdb1>
[4338755.714000] md: bind<sdc1>
[4338755.718000] md: bind<sdd1>
[4338755.723000] raid5: device sdd1 operational as raid disk 3
[4338755.728000] raid5: device sdc1 operational as raid disk 2
[4338755.733000] raid5: device sdb1 operational as raid disk 1
[4338755.738000] raid5: device sda1 operational as raid disk 0
[4338755.744000] raid5: allocated 4206kB for md6
[4338755.749000] raid5: raid level 5 set md6 active with 4 out of 4 devices, algorithm 2
[4338755.753000] RAID5 conf printout:
[4338755.758000]  --- rd:4 wd:4 fd:0
[4338755.763000]  disk 0, o:1, dev:sda1
[4338755.767000]  disk 1, o:1, dev:sdb1
[4338755.772000]  disk 2, o:1, dev:sdc1
[4338755.776000]  disk 3, o:1, dev:sdd1
[4338755.781000] .......<6>md: syncing RAID array md6
[4338755.787000] md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
[4338755.792000] md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for reconstruction.
[4338755.797000] md: using 128k window, over a total of 390708736 blocks.
[4341590.193000] ata1: command timeout
[4341594.292000] Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=2807
[4341594.298000] ata1: status=0x51 { DriveReady SeekComplete Error }
[4341594.302000] ata1: called with no error (51)!
[4341594.307000] SCSI error : <0 0 0 0> return code = 0x8000002
[4341594.312000] sda: Current: sense key: Medium Error
[4341594.319000]     Additional sense: Write error - auto reallocation failed
[4341594.324000] end_request: I/O error, dev sda, sector 475878719
[4341594.329000] raid5: Disk failure on sda1, disabling device. Operation continuing on 3 devices

The system was still usable and claimed to continue building the
array, but an mke2fs that was running against md6 at that time hung 
and couldn't be killed.

After a hard reset - a normal shutdown didn't work and hung, 
the system came up clean and is continuing to (re)build the RAID-5
array

If you need any additional information just let me know.

Cheers
   Mike


server:/etc# cat /proc/mdstat 
Personalities : [linear] [raid0] [raid1] [raid5] [multipath] [raid10] 
md6 : active raid5 sdd1[3] sdc1[2] sdb1[1] sda1[0]
      1172126208 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
      [===>.................]  resync = 17.6% (68818176/390708736) finish=172.3min speed=31116K/sec
      
md1 : active raid1 hdd5[1] hda5[0]
      8000256 blocks [2/2] [UU]
      
md2 : active raid1 hdd6[1] hda6[0]
      4000064 blocks [2/2] [UU]
      
md3 : active raid1 hdd7[1] hda7[0]
      20000768 blocks [2/2] [UU]
      
md4 : active raid1 hdd8[1] hda8[0]
      20000768 blocks [2/2] [UU]
      
md5 : active raid1 hdd9[1] hda9[0]
      24153600 blocks [2/2] [UU]
      
md0 : active raid1 hdd1[1] hda1[0]
      995904 blocks [2/2] [UU]
      
unused devices: <none>


[4294667.296000] Linux version 2.6.12-rc4-mm2 (root@server) (gcc version 3.3.6 (Debian 1:3.3.6-5)) #3 Tue May 24 19:41:29 CEST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
[4294667.296000]  BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[4294667.296000] 767MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 196592
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 192496 pages, LIFO batch:31
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 AMI                                   ) @ 0x000fa9f0
[4294667.296000] ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x2fff0000
[4294667.296000] ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x2fff0030
[4294667.296000] ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0x808
[4294667.296000] Allocating PCI resources starting at 30000000 (gap: 30000000:cec00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[4294667.296000] mapped APIC to ffffd000 (01603000)
[4294667.296000] Initializing CPU#0
[4294667.296000] Kernel command line: BOOT_IMAGE=Linux ro root=900 video=vesa:ypan
[4294667.296000] CPU 0 irqstacks, hard=c06f3000 soft=c06f2000
[4294667.296000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[4294667.296000] Detected 1303.546 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour dummy device 80x25
[4294670.078000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[4294670.080000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[4294670.112000] Memory: 772228k/786368k available (3914k kernel code, 13624k reserved, 1906k data, 240k init, 0k highmem)
[4294670.112000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[4294670.173000] Calibrating delay using timer specific routine.. 2607.90 BogoMIPS (lpj=1303952)
[4294670.173000] Mount-cache hash table entries: 512
[4294670.173000] CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
[4294670.173000] CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
[4294670.173000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[4294670.173000] CPU: L2 Cache: 64K (64 bytes/line)
[4294670.173000] CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020 00000000 00000000 00000000
[4294670.173000] CPU: AMD Duron(tm)  stepping 01
[4294670.173000] Enabling fast FPU save and restore... done.
[4294670.173000] Enabling unmasked SIMD FPU exception support... done.
[4294670.173000] Checking 'hlt' instruction... OK.
[4294670.178000]  tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully acquired
[4294670.222000] Parsing all Control Methods:....................................................................................................................................................
[4294670.305000] Table [DSDT](id F004) - 513 Objects with 47 Devices 148 Methods 32 Regions
[4294670.305000] ACPI Namespace successfully loaded at root c0755ae0
[4294670.305000] ACPI: setting ELCR to 0200 (from 0c20)
[4294670.305000] evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode successful
[4294670.305000] softlockup thread 0 started up.
[4294670.306000] NET: Registered protocol family 16
[4294670.306000] ACPI: bus type pci registered
[4294670.307000] PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last bus=1
[4294670.307000] PCI: Using configuration type 1
[4294670.307000] mtrr: v2.0 (20020519)
[4294670.307000] ACPI: Subsystem revision 20050408
[4294670.317000] evgpeblk-1016 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
[4294670.318000] evgpeblk-1024 [06] ev_create_gpe_block   : Found 6 Wake, Enabled 0 Runtime GPEs in this block
[4294670.327000] Completing Region/Field/Buffer/Package initialization:...............................................................................................
[4294670.625000] Initialized 32/32 Regions 9/9 Fields 44/44 Buffers 10/22 Packages (522 nodes)
[4294670.625000] Executing all Device _STA and_INI methods:..................................................
[4294671.545000] 50 Devices found containing: 50 _STA, 1 _INI methods
[4294671.546000] ACPI: Interpreter enabled
[4294671.546000] ACPI: Using PIC for interrupt routing
[4294671.581000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294671.581000] PCI: Probing PCI hardware (bus 00)
[4294671.586000] ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
[4294671.953000] Boot video device is 0000:01:00.0
[4294671.954000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[4294673.813000] ACPI: Power Resource [URP1] (off)
[4294673.818000] ACPI: Power Resource [URP2] (off)
[4294673.824000] ACPI: Power Resource [FDDP] (off)
[4294673.830000] ACPI: Power Resource [LPTP] (off)
[4294673.941000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[4294673.984000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[4294674.028000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[4294674.071000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[4294674.115000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[4294674.159000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[4294674.203000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[4294674.248000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[4294674.267000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294674.267000] pnp: PnP ACPI init
[4294674.985000] pnp: PnP ACPI: found 11 devices
[4294674.985000] PnPBIOS: Disabled by ACPI PNP
[4294674.985000] SCSI subsystem initialized
[4294674.985000] usbcore: registered new driver usbfs
[4294674.985000] usbcore: registered new driver hub
[4294674.985000] PCI: Using ACPI for IRQ routing
[4294674.985000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294675.071000] pnp: the driver 'system' has been registered
[4294675.071000] pnp: match found with the PnP device '00:00' and the driver 'system'
[4294675.071000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[4294675.072000] apm: overridden by ACPI.
[4294675.074000] inotify device minor=63
[4294675.074000] VFS: Disk quotas dquot_6.5.1
[4294675.074000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[4294675.074000] devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
[4294675.074000] devfs: boot_options: 0x1
[4294675.074000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[4294675.074000] fuse init (API version 7.1)
[4294675.074000] Initializing Cryptographic API
[4294675.074000] vesafb: framebuffer at 0xda000000, mapped to 0xf0880000, using 5120k, total 32768k
[4294675.074000] vesafb: mode is 1280x1024x16, linelength=2560, pages=1
[4294675.074000] vesafb: protected mode interface info at c000:03a7
[4294675.074000] vesafb: scrolling: redraw
[4294675.074000] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[4294675.114000] Console: switching to colour frame buffer device 160x64
[4294675.115000] fb0: VESA VGA frame buffer device
[4294675.115000] ACPI: Power Button (FF) [PWRF]
[4294675.116000] ACPI: Power Button (CM) [PWRB]
[4294675.116000] ACPI: Sleep Button (CM) [SLPB]
[4294675.133000] ACPI: CPU0 (power states: C1[C1])
[4294675.133000] isapnp: Scanning for PnP cards...
[4294675.446000] isapnp: No Plug & Play device found
[4294675.497000] Real Time Clock Driver v1.12
[4294675.497000] Linux agpgart interface v0.101 (c) Dave Jones
[4294675.497000] agpgart: Detected VIA KT400/KT400A/KT600 chipset
[4294675.508000] agpgart: AGP aperture is 128M @ 0xe0000000
[4294675.508000] [drm] Initialized drm 1.0.0 20040925
[4294675.508000] cn_fork is registered
[4294675.508000] pnp: the driver 'i8042 kbd' has been registered
[4294675.508000] pnp: match found with the PnP device '00:06' and the driver 'i8042 kbd'
[4294675.508000] pnp: the driver 'i8042 aux' has been registered
[4294675.508000] pnp: match found with the PnP device '00:05' and the driver 'i8042 aux'
[4294675.508000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[4294675.509000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294675.509000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294675.509000] Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
[4294675.510000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294675.510000] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294675.586000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294675.662000] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294675.663000] pnp: the driver 'serial' has been registered
[4294675.663000] pnp: match found with the PnP device '00:08' and the driver 'serial'
[4294675.663000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294675.664000] pnp: match found with the PnP device '00:09' and the driver 'serial'
[4294675.664000] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294675.664000] pnp: the driver 'parport_pc' has been registered
[4294675.665000] pnp: match found with the PnP device '00:0a' and the driver 'parport_pc'
[4294675.665000] parport: PnPBIOS parport detected.
[4294675.665000] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[4294675.748000] io scheduler noop registered
[4294675.748000] io scheduler anticipatory registered
[4294675.748000] io scheduler deadline registered
[4294675.748000] io scheduler cfq registered
[4294675.748000] Floppy drive(s): fd0 is 1.44M
[4294675.762000] FDC 0 is a post-1991 82077
[4294675.764000] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[4294675.764000] loop: loaded (max 8 devices)
[4294675.765000] tg3.c:v3.27 (May 5, 2005)
[4294675.812000] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
[4294675.817000] PCI: setting IRQ 10 as level-triggered
[4294675.822000] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[4294675.880000] eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:11:09:c3:59:97
[4294675.886000] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
[4294675.892000] PPP generic driver version 2.4.2
[4294675.898000] PPP Deflate Compression module registered
[4294675.903000] PPP BSD Compression module registered
[4294675.909000] NET: Registered protocol family 24
[4294675.914000] netconsole: not configured, aborting
[4294675.920000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294675.926000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294675.931000] VP_IDE: IDE controller at PCI slot 0000:00:0f.1
[4294675.937000] acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
[4294675.985000] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[4294675.991000] PCI: setting IRQ 11 as level-triggered
[4294675.997000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[4294676.003000] PCI: Via PIC IRQ fixup for 0000:00:0f.1, from 255 to 11
[4294676.009000] VP_IDE: chipset revision 6
[4294676.015000] VP_IDE: not 100% native mode: will probe irqs later
[4294676.021000] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
[4294676.027000]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
[4294676.033000]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
[4294676.039000] Probing IDE interface ide0...
[4294676.423000] hda: MAXTOR 4K080H4, ATA DISK drive
[4294676.684000] hdb: SAMSUNG SP1604N, ATA DISK drive
[4294676.741000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294676.747000] Probing IDE interface ide1...
[4294677.539000] hdc: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
[4294677.800000] hdd: MAXTOR 4K080H4, ATA DISK drive
[4294677.857000] ide1 at 0x170-0x177,0x376 on irq 15
[4294677.864000] pnp: the driver 'ide' has been registered
[4294677.864000] Probing IDE interface ide2...
[4294678.377000] Probing IDE interface ide3...
[4294678.890000] Probing IDE interface ide4...
[4294679.403000] Probing IDE interface ide5...
[4294679.916000] hda: max request size: 128KiB
[4294679.948000] hda: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=65535/16/63, UDMA(100)
[4294679.954000] hda: cache flushes supported
[4294679.960000]  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 >
[4294680.072000] hdb: max request size: 1024KiB
[4294680.079000] hdb: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
[4294680.086000] hdb: cache flushes supported
[4294680.093000]  /dev/ide/host0/bus0/target1/lun0: p1 < p5 p6 >
[4294680.122000] ide-disk: probe of 1.0 failed with error 1
[4294680.128000] hdd: max request size: 128KiB
[4294680.165000] hdd: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=65535/16/63, UDMA(100)
[4294680.172000] hdd: cache flushes supported
[4294680.179000]  /dev/ide/host0/bus1/target1/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 >
[4294680.298000] hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache
[4294680.305000] Uniform CD-ROM driver Revision: 3.20
[4294680.362000] 3ware 9000 Storage Controller device driver for Linux v2.26.02.002.
[4294680.369000] libata version 1.10 loaded.
[4294680.369000] sata_promise version 1.01
[4294680.410000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
[4294680.417000] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
[4294680.435000] ata1: SATA max UDMA/133 cmd 0xF081E200 ctl 0xF081E238 bmdma 0x0 irq 10
[4294680.442000] ata2: SATA max UDMA/133 cmd 0xF081E280 ctl 0xF081E2B8 bmdma 0x0 irq 10
[4294680.449000] ata3: SATA max UDMA/133 cmd 0xF081E300 ctl 0xF081E338 bmdma 0x0 irq 10
[4294680.456000] ata4: SATA max UDMA/133 cmd 0xF081E380 ctl 0xF081E3B8 bmdma 0x0 irq 10
[4294680.818000] ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
[4294680.818000] ata1: dev 0 ATA, max UDMA/133, 781422768 sectors: lba48
[4294680.825000] ata1: dev 0 configured for UDMA/133
[4294680.832000] scsi0 : sata_promise
[4294681.194000] ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
[4294681.194000] ata2: dev 0 ATA, max UDMA/133, 781422768 sectors: lba48
[4294681.201000] ata2: dev 0 configured for UDMA/133
[4294681.208000] scsi1 : sata_promise
[4294681.570000] ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
[4294681.570000] ata3: dev 0 ATA, max UDMA/133, 781422768 sectors: lba48
[4294681.577000] ata3: dev 0 configured for UDMA/133
[4294681.584000] scsi2 : sata_promise
[4294681.946000] ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
[4294681.946000] ata4: dev 0 ATA, max UDMA/133, 781422768 sectors: lba48
[4294681.953000] ata4: dev 0 configured for UDMA/133
[4294681.960000] scsi3 : sata_promise
[4294681.966000]   Vendor: ATA       Model: ST3400832AS       Rev: 3.02
[4294681.973000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294681.981000]   Vendor: ATA       Model: ST3400832AS       Rev: 3.02
[4294681.988000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294681.995000]   Vendor: ATA       Model: ST3400832AS       Rev: 3.02
[4294682.002000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294682.010000]   Vendor: ATA       Model: ST3400832AS       Rev: 3.02
[4294682.017000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294682.024000] sata_via version 1.1
[4294682.024000] acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
[4294682.072000] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
[4294682.079000] PCI: setting IRQ 5 as level-triggered
[4294682.085000] ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[4294682.092000] sata_via(0000:00:0f.0): routed to hard irq line 5
[4294682.099000] ata5: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xC800 irq 5
[4294682.106000] ata6: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC808 irq 5
[4294682.313000] ata5: no device found (phy stat 00000000)
[4294682.319000] scsi4 : sata_via
[4294682.527000] ata6: no device found (phy stat 00000000)
[4294682.533000] scsi5 : sata_via
[4294682.541000] st: Version 20050501, fixed bufsize 32768, s/g segs 256
[4294682.548000] SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
[4294682.554000] SCSI device sda: drive cache: write back
[4294682.561000] SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
[4294682.568000] SCSI device sda: drive cache: write back
[4294682.574000]  /dev/scsi/host0/bus0/target0/lun0: p1
[4294682.600000] Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
[4294682.607000] SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
[4294682.613000] SCSI device sdb: drive cache: write back
[4294682.620000] SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
[4294682.626000] SCSI device sdb: drive cache: write back
[4294682.633000]  /dev/scsi/host1/bus0/target0/lun0: p1
[4294682.658000] Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
[4294682.665000] SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
[4294682.671000] SCSI device sdc: drive cache: write back
[4294682.678000] SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
[4294682.684000] SCSI device sdc: drive cache: write back
[4294682.690000]  /dev/scsi/host2/bus0/target0/lun0: p1
[4294682.719000] Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
[4294682.726000] SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
[4294682.732000] SCSI device sdd: drive cache: write back
[4294682.738000] SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
[4294682.744000] SCSI device sdd: drive cache: write back
[4294682.750000]  /dev/scsi/host3/bus0/target0/lun0: p1
[4294682.776000] Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
[4294682.782000] Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
[4294682.789000] Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
[4294682.795000] Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
[4294682.801000] Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
[4294682.807000] ieee1394: Initialized config rom entry `ip1394'
[4294682.807000] ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
[4294682.814000] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[4294682.873000] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[dfffe000-dfffe7ff]  Max Packet=[2048]
[4294682.887000] sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
[4294682.893000] usbmon: debugs is not available
[4294682.900000] ACPI: PCI Interrupt 0000:00:0a.2[C] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
[4294682.906000] ehci_hcd 0000:00:0a.2: NEC Corporation USB 2.0
[4294682.934000] ehci_hcd 0000:00:0a.2: new USB bus registered, assigned bus number 1
[4294682.940000] ehci_hcd 0000:00:0a.2: irq 10, io mem 0xdfffef00
[4294682.946000] ehci_hcd 0000:00:0a.2: park 0
[4294682.953000] ehci_hcd 0000:00:0a.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[4294682.960000] hub 1-0:1.0: USB hub found
[4294682.966000] hub 1-0:1.0: 5 ports detected
[4294682.993000] acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
[4294682.999000] ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[4294683.006000] ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
[4294683.012000] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 2
[4294683.019000] ehci_hcd 0000:00:10.4: irq 10, io mem 0xdfffed00
[4294683.025000] ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[4294683.032000] hub 2-0:1.0: USB hub found
[4294683.038000] hub 2-0:1.0: 8 ports detected
[4294683.065000] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[4294683.065000] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[4294683.071000] ohci_hcd 0000:00:0a.0: NEC Corporation USB
[4294683.078000] ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 3
[4294683.084000] ohci_hcd 0000:00:0a.0: irq 5, io mem 0xdfffc000
[4294683.171000] hub 3-0:1.0: USB hub found
[4294683.177000] hub 3-0:1.0: 3 ports detected
[4294683.214000] ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[4294683.220000] ohci_hcd 0000:00:0a.1: NEC Corporation USB (#2)
[4294683.227000] ohci_hcd 0000:00:0a.1: new USB bus registered, assigned bus number 4
[4294683.233000] ohci_hcd 0000:00:0a.1: irq 10, io mem 0xdfffd000
[4294683.320000] hub 4-0:1.0: USB hub found
[4294683.326000] hub 4-0:1.0: 2 ports detected
[4294683.363000] mice: PS/2 mouse device common for all mice
[4294683.369000] i2c /dev entries driver
[4294683.376000] md: linear personality registered as nr 1
[4294683.382000] md: raid0 personality registered as nr 2
[4294683.388000] md: raid1 personality registered as nr 3
[4294683.395000] md: raid10 personality registered as nr 9
[4294683.401000] md: raid5 personality registered as nr 4
[4294683.407000] raid5: automatically using best checksumming function: pIII_sse
[4294683.418000]    pIII_sse  :  3444.000 MB/sec
[4294683.424000] raid5: using function: pIII_sse (3444.000 MB/sec)
[4294683.430000] md: multipath personality registered as nr 7
[4294683.436000] md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
[4294683.442000] md: bitmap version 3.38
[4294683.451000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[4294683.458000] device-mapper: dm-multipath version 1.0.4 loaded
[4294683.464000] device-mapper: dm-round-robin version 1.0.0 loaded
[4294683.470000] Advanced Linux Sound Architecture Driver Version 1.0.9rc3  (Thu Mar 24 10:33:39 2005 UTC).
[4294683.477000] acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
[4294683.484000] ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[4294683.491000] PCI: Setting latency timer of device 0000:00:11.5 to 64
[4294683.507000] input: AT Translated Set 2 keyboard on isa0060/serio0
[4294683.850000] input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
[4294684.002000] ALSA device list:
[4294684.008000]   #0: VIA 8237 with CMI9761 at 0xb000, irq 10
[4294684.015000] NET: Registered protocol family 2
[4294684.032000] IP: routing cache hash table of 8192 buckets, 64Kbytes
[4294684.039000] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[4294684.049000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[4294684.056000] TCP: Hash tables configured (established 131072 bind 65536)
[4294684.063000] NET: Registered protocol family 1
[4294684.070000] NET: Registered protocol family 10
[4294684.076000] Disabled Privacy Extensions on device c05f6de0(lo)
[4294684.083000] IPv6 over IPv4 tunneling driver
[4294684.090000] NET: Registered protocol family 17
[4294684.096000] NET: Registered protocol family 15
[4294684.102000] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[4294684.109000] All bugs added by David S. Miller <davem@redhat.com>
[4294684.117000] BIOS EDD facility v0.16 2004-Jun-25, 7 devices found
[4294684.124000] devfs_mk_dev: could not append to parent for md/0
[4294684.131000] md: Autodetecting RAID arrays.
[4294684.154000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc0000776648]
[4294684.291000] md: autorun ...
[4294684.297000] md: considering hdd9 ...
[4294684.303000] md:  adding hdd9 ...
[4294684.309000] md: hdd8 has different UUID to hdd9
[4294684.316000] md: hdd7 has different UUID to hdd9
[4294684.322000] md: hdd6 has different UUID to hdd9
[4294684.327000] md: hdd5 has different UUID to hdd9
[4294684.333000] md: hdd1 has different UUID to hdd9
[4294684.339000] md:  adding hda9 ...
[4294684.345000] md: hda8 has different UUID to hdd9
[4294684.350000] md: hda7 has different UUID to hdd9
[4294684.356000] md: hda6 has different UUID to hdd9
[4294684.361000] md: hda5 has different UUID to hdd9
[4294684.366000] md: hda1 has different UUID to hdd9
[4294684.372000] devfs_mk_dev: could not append to parent for md/5
[4294684.377000] md: created md5
[4294684.382000] md: bind<hda9>
[4294684.387000] md: bind<hdd9>
[4294684.392000] md: running: <hdd9><hda9>
[4294684.397000] raid1: raid set md5 active with 2 out of 2 mirrors
[4294684.402000] md: considering hdd8 ...
[4294684.408000] md:  adding hdd8 ...
[4294684.413000] md: hdd7 has different UUID to hdd8
[4294684.418000] md: hdd6 has different UUID to hdd8
[4294684.423000] md: hdd5 has different UUID to hdd8
[4294684.427000] md: hdd1 has different UUID to hdd8
[4294684.432000] md:  adding hda8 ...
[4294684.437000] md: hda7 has different UUID to hdd8
[4294684.442000] md: hda6 has different UUID to hdd8
[4294684.447000] md: hda5 has different UUID to hdd8
[4294684.451000] md: hda1 has different UUID to hdd8
[4294684.456000] devfs_mk_dev: could not append to parent for md/4
[4294684.460000] md: created md4
[4294684.465000] md: bind<hda8>
[4294684.469000] md: bind<hdd8>
[4294684.473000] md: running: <hdd8><hda8>
[4294684.478000] raid1: raid set md4 active with 2 out of 2 mirrors
[4294684.482000] md: considering hdd7 ...
[4294684.486000] md:  adding hdd7 ...
[4294684.490000] md: hdd6 has different UUID to hdd7
[4294684.493000] md: hdd5 has different UUID to hdd7
[4294684.497000] md: hdd1 has different UUID to hdd7
[4294684.501000] md:  adding hda7 ...
[4294684.504000] md: hda6 has different UUID to hdd7
[4294684.508000] md: hda5 has different UUID to hdd7
[4294684.511000] md: hda1 has different UUID to hdd7
[4294684.515000] devfs_mk_dev: could not append to parent for md/3
[4294684.518000] md: created md3
[4294684.522000] md: bind<hda7>
[4294684.525000] md: bind<hdd7>
[4294684.528000] md: running: <hdd7><hda7>
[4294684.531000] raid1: raid set md3 active with 2 out of 2 mirrors
[4294684.535000] md: considering hdd6 ...
[4294684.538000] md:  adding hdd6 ...
[4294684.541000] md: hdd5 has different UUID to hdd6
[4294684.544000] md: hdd1 has different UUID to hdd6
[4294684.547000] md:  adding hda6 ...
[4294684.550000] md: hda5 has different UUID to hdd6
[4294684.553000] md: hda1 has different UUID to hdd6
[4294684.556000] devfs_mk_dev: could not append to parent for md/2
[4294684.559000] md: created md2
[4294684.562000] md: bind<hda6>
[4294684.565000] md: bind<hdd6>
[4294684.568000] md: running: <hdd6><hda6>
[4294684.571000] raid1: raid set md2 active with 2 out of 2 mirrors
[4294684.574000] md: considering hdd5 ...
[4294684.578000] md:  adding hdd5 ...
[4294684.581000] md: hdd1 has different UUID to hdd5
[4294684.584000] md:  adding hda5 ...
[4294684.587000] md: hda1 has different UUID to hdd5
[4294684.591000] devfs_mk_dev: could not append to parent for md/1
[4294684.594000] md: created md1
[4294684.597000] md: bind<hda5>
[4294684.601000] md: bind<hdd5>
[4294684.604000] md: running: <hdd5><hda5>
[4294684.608000] raid1: raid set md1 active with 2 out of 2 mirrors
[4294684.611000] md: considering hdd1 ...
[4294684.614000] md:  adding hdd1 ...
[4294684.618000] md:  adding hda1 ...
[4294684.621000] md: created md0
[4294684.624000] md: bind<hda1>
[4294684.628000] md: bind<hdd1>
[4294684.631000] md: running: <hdd1><hda1>
[4294684.634000] raid1: raid set md0 active with 2 out of 2 mirrors
[4294684.638000] md: ... autorun DONE.
[4294684.718000] EXT3-fs: INFO: recovery required on readonly filesystem.
[4294684.722000] EXT3-fs: write access will be enabled during recovery.
[4294684.846000] EXT3-fs: recovery complete.
[4294684.850000] kjournald starting.  Commit interval 5 seconds
[4294684.854000] EXT3-fs: mounted filesystem with ordered data mode.
[4294684.858000] VFS: Mounted root (ext3 filesystem) readonly.
[4294684.894000] Mounted devfs on /dev
[4294684.898000] Freeing unused kernel memory: 240k freed
[4294688.032000] Adding 996020k swap on /dev/hda2.  Priority:-1 extents:1
[4294688.051000] Adding 996020k swap on /dev/hdd2.  Priority:-2 extents:1
[4294688.153000] EXT3 FS on md0, internal journal
[4294691.695000] usbcore: registered new driver usbkbd
[4294691.700000] drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
[4294691.767000] Initializing USB Mass Storage driver...
[4294691.794000] usbcore: registered new driver usb-storage
[4294691.799000] USB Mass Storage support registered.
[4294692.068000] devfs_mk_dev: could not append to parent for md/6
[4294692.073000] md: raidstart(pid 1352) used deprecated START_ARRAY ioctl. This will not be supported beyond 2.6
[4294692.168000] md: autorun ...
[4294692.174000] md: considering sdd1 ...
[4294692.179000] md:  adding sdd1 ...
[4294692.184000] md:  adding sdc1 ...
[4294692.189000] md:  adding sdb1 ...
[4294692.194000] md:  adding sda1 ...
[4294692.200000] md: created md6
[4294692.205000] md: bind<sda1>
[4294692.210000] md: bind<sdb1>
[4294692.215000] md: bind<sdc1>
[4294692.220000] md: bind<sdd1>
[4294692.225000] md: running: <sdd1><sdc1><sdb1><sda1>
[4294692.230000] md: md6: raid array is not clean -- starting background reconstruction
[4294692.235000] raid5: device sdd1 operational as raid disk 3
[4294692.240000] raid5: device sdc1 operational as raid disk 2
[4294692.245000] raid5: device sdb1 operational as raid disk 1
[4294692.250000] raid5: device sda1 operational as raid disk 0
[4294692.256000] raid5: allocated 4206kB for md6
[4294692.261000] raid5: raid level 5 set md6 active with 4 out of 4 devices, algorithm 2
[4294692.266000] RAID5 conf printout:
[4294692.271000]  --- rd:4 wd:4 fd:0
[4294692.275000]  disk 0, o:1, dev:sda1
[4294692.280000]  disk 1, o:1, dev:sdb1
[4294692.285000]  disk 2, o:1, dev:sdc1
[4294692.289000]  disk 3, o:1, dev:sdd1
[4294692.294000] md: ... autorun DONE.
[4294692.299000] .......<6>md: syncing RAID array md6
[4294692.303000] md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
[4294692.308000] md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for reconstruction.
[4294692.320000] md: using 128k window, over a total of 390708736 blocks.
[4294693.111000] kjournald starting.  Commit interval 5 seconds
[4294693.118000] EXT3 FS on md1, internal journal
[4294693.123000] EXT3-fs: mounted filesystem with ordered data mode.
[4294693.182000] kjournald starting.  Commit interval 5 seconds
[4294693.189000] EXT3 FS on md2, internal journal
[4294693.194000] EXT3-fs: mounted filesystem with ordered data mode.
[4294693.264000] kjournald starting.  Commit interval 5 seconds
[4294693.271000] EXT3 FS on md3, internal journal
[4294693.276000] EXT3-fs: mounted filesystem with ordered data mode.
[4294693.331000] kjournald starting.  Commit interval 5 seconds
[4294693.338000] EXT3 FS on md4, internal journal
[4294693.342000] EXT3-fs: mounted filesystem with ordered data mode.
[4294693.419000] kjournald starting.  Commit interval 5 seconds
[4294693.425000] EXT3 FS on md5, internal journal
[4294693.430000] EXT3-fs: mounted filesystem with ordered data mode.
[4294693.456000] kjournald starting.  Commit interval 5 seconds
[4294693.461000] EXT3 FS on hdb5, internal journal
[4294693.466000] EXT3-fs: mounted filesystem with ordered data mode.
[4294693.489000] kjournald starting.  Commit interval 5 seconds
[4294693.495000] EXT3 FS on hdb6, internal journal
[4294693.495000] EXT3-fs: mounted filesystem with ordered data mode.
[4294696.118000] Intel(R) PRO/1000 Network Driver - version 6.0.54-k2-NAPI
[4294696.128000] Copyright (c) 1999-2004 Intel Corporation.
[4294696.158000] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[4294696.741000] e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
[4294701.021000] input: PC Speaker
[4294708.408000] tg3: eth0: Link is up at 1000 Mbps, full duplex.
[4294708.408000] tg3: eth0: Flow control is on for TX and on for RX.
[4294716.068000] eth0: no IPv6 routers present
[4294722.450000] lp0: using parport0 (interrupt-driven).
[4294738.398000] program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
[4294738.421000] program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO

