Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWIEM1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWIEM1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 08:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIEM1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 08:27:19 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:14066 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S932164AbWIEM1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 08:27:16 -0400
Date: Tue, 5 Sep 2006 14:26:56 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060905122656.GA3650@aepfle.de>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sun, Sep 03, Linus Torvalds wrote:

> 
> Things are definitely calming down, and while I'm not ready to call it a 
> final 2.6.18 yet, this migt be the last -rc.

There is a regression on LVD drives (?) since early 2.6.18rc

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=60eef25701d25e99c991dd0f4a9f3832a0c3ad3e

I get a machine check on an older B&W G3.

<5>SCSI subsystem initialized
<6>st: Version 20050830, fixed bufsize 32768, s/g segs 256
<6>loop: loaded (max 8 devices)
<3>pmac_zilog 0.00013000:ch-b: irda_setup timed out on get_version byte
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
<4>        <Adaptec 2940B Ultra2 SCSI adapter>
<4>        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<5>  Vendor: IBM       Model: DDRS-39130D       Rev: DC2A
<5>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
<6> target0:0:0: Beginning Domain Validation
<6> target0:0:0: wide asynchronous
<4>Machine check in kernel mode.
<4>Caused by (from SRR1=49030): Transfer error ack signal
<4>Oops: Machine check, sig: 7 [#1]
<4>
<4>Modules linked in: aic7xxx scsi_transport_spi cpufreq_ondemand loop nfs nfs_acl lockd sunrpc sg st sd_mod sr_mod scsi_mod ide_cd cdrom
<4>NIP: D21F03A0 LR: D20D9494 CTR: D21F0388
<4>REGS: cf5059f0 TRAP: 0200   Not tainted  (2.6.18-rc6-20060905-default)
<4>MSR: 00049030 <EE,ME,IR,DR>  CR: 22022242  XER: 00000000
<4>TASK = cf1d9990[963] 'insmod' THREAD: cf504000
<6>GPR00: 000000FF CF505AA0 CF1D9990 CF513400 CF505A6C CF564C00 CF564D00 00000000 
<6>GPR08: 00000001 D105C000 CF64D400 00000000 F2841C80 100290EC 0000000F D22BFB50 
<6>GPR16: 0000001E D229EDD0 CFC52500 D229EDA8 CF5139CC CF513818 CF5138BC CF513400 
<6>GPR24: CF513800 CF5139A0 FFFFFFFF C37C0000 CF5139A0 CF513800 CF513000 CF513C00 
<4>NIP [D21F03A0] ahc_linux_get_signalling+0x18/0xa8 [aic7xxx]
<4>LR [D20D9494] spi_dv_device+0x338/0x51c [scsi_transport_spi]
<4>Call Trace:
<4>[CF505AA0] [D20D9364] spi_dv_device+0x208/0x51c [scsi_transport_spi] (unreliable)
<4>[CF505AF0] [D21F0808] ahc_linux_slave_configure+0xfc/0x114 [aic7xxx]
<4>[CF505B30] [D20B71D8] scsi_probe_and_add_lun+0x8d4/0xa40 [scsi_mod]
<4>[CF505B90] [D20B78F8] __scsi_scan_target+0xd8/0x630 [scsi_mod]
<4>[CF505C20] [D20B7E9C] scsi_scan_channel+0x4c/0x9c [scsi_mod]
<4>[CF505C40] [D20B7FD4] scsi_scan_host_selected+0xe8/0x140 [scsi_mod]
<4>[CF505C70] [D21F3998] ahc_linux_register_host+0x344/0x35c [aic7xxx]
<4>[CF505D10] [D21F468C] ahc_linux_pci_dev_probe+0x1a8/0x1c8 [aic7xxx]
<4>[CF505D80] [C016A49C] pci_device_probe+0x6c/0xa0
<4>[CF505DA0] [C01F0AF4] driver_probe_device+0x60/0xf4
<4>[CF505DC0] [C01F0CC4] __driver_attach+0x8c/0xf0
<4>[CF505DE0] [C01F0424] bus_for_each_dev+0x50/0x94
<4>[CF505E10] [C01F0A08] driver_attach+0x24/0x34
<4>[CF505E20] [C01F000C] bus_add_driver+0x78/0x128
<4>[CF505E40] [C01F0FC4] driver_register+0xa0/0xb4
<4>[CF505E50] [C016A2C8] __pci_register_driver+0x4c/0x8c
<4>[CF505E60] [D21F44CC] ahc_linux_pci_init+0x20/0x38 [aic7xxx]
<4>[CF505E70] [D105A3C0] ahc_linux_init+0x3c0/0x530 [aic7xxx]
<4>[CF505EA0] [C004EB50] sys_init_module+0x1368/0x14f8
<4>[CF505F40] [C00125A4] ret_from_syscall+0x0/0x40
<4>--- Exception: c01 at 0xff698a4
<4>    LR = 0x10001100
<4>Instruction dump:
<4>38600000 4e800020 38600000 4e800020 4e800020 4e800020 814302ac 800a0000 
<4>2f800000 409e0018 812a0004 8809001f <0c000000> 4c00012c 48000028 812a0004 
<4> scsi0: PCI error Interrupt at seqaddr = 0x8
<4>scsi0: Signaled a Target Abort


Here is the dmesg from a working 2.6.16 kernel:

...
SCSI subsystem initialized
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2940B Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DDRS-39130D       Rev: DC2A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
sda: Write Protect is off
sda: Mode Sense: e5 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
sda: Write Protect is off
sda: Mode Sense: e5 00 00 08
SCSI device sda: drive cache: write back
 sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
  Vendor: IBM       Model: DNES-318350W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:2:0: Tagged Queuing enabled.  Depth 32
 target0:0:2: Beginning Domain Validation
 target0:0:2: wide asynchronous
 target0:0:2: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
 target0:0:2: Domain Validation skipping write tests
 target0:0:2: Ending Domain Validation
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
sdb: Write Protect is off
sdb: Mode Sense: c3 00 00 08
SCSI device sdb: drive cache: write back
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
sdb: Write Protect is off
sdb: Mode Sense: c3 00 00 08
SCSI device sdb: drive cache: write back
 sdb: [mac] sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12 sdb13
sd 0:0:2:0: Attached scsi disk sdb
sd 0:0:2:0: Attached scsi generic sg1 type 0
mesh: configured for synchronous 5 MB/s
mesh: performing initial bus reset...
scsi1 : MESH
ReiserFS: sda4: found reiserfs format "3.6" with standard journal
ReiserFS: sda4: using ordered data mode
...


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="boot.msg"

<6>Using PowerMac machine description
<4>Total memory = 256MB; using 512kB for hash table (at cff80000)
<5>Linux version 2.6.18-rc6-20060905-default (geeko@buildhost) (gcc version 4.1.2 20060731 (prerelease) (SUSE Linux)) #1 Sun Sep 3 10:14:34 UTC 2006
<4>Found initrd at 0xc3086000:0xc36574f8
<6>Found a Paddington mac-io controller, rev: 0, mapped at 0xfdf80000
<6>PowerMac motherboard: Blue&White G3
<6>Found Grackle (MPC106) PCI host bridge at 0x0000000080000000. Firmware bus number: 0->1
<4>nvram: OF partition at 0x140
<4>nvram: XP partition at 0x11b0
<4>nvram: NR partition at 0x12b0
<7>Top of RAM: 0x10000000, Total RAM: 0x10000000
<7>Memory hole size: 0MB
<7>On node 0 totalpages: 65536
<7>  DMA zone: 65536 pages, LIFO batch:15
<4>Built 1 zonelists.  Total pages: 65536
<5>Kernel command line: root=/dev/sda4  quiet sysrq=1 video=aty128fb:1024x768@85 
<6>irq: Found primary Apple PIC /pci@80000000/pci-bridge@d/mac-io@5 for 64 irqs
<6>irq: System has 64 possible interrupts
<4>PID hash table entries: 2048 (order: 11, 8192 bytes)
<4>GMT Delta read from XPRAM: 0 minutes, DST: off
<7>time_init: decrementer frequency = 24.934500 MHz
<7>time_init: processor frequency   = 400.000000 MHz
<4>Console: colour dummy device 80x25
<4>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
<7>High memory: 0k
<6>Memory: 248320k/262144k available (3588k kernel code, 13628k reserved, 524k data, 452k bss, 192k init)
<7>Calibrating delay loop... 49.79 BogoMIPS (lpj=99584)
<6>Security Framework v1.0.0 initialized
<4>Mount-cache hash table entries: 512
<4>device-tree: Duplicate name in /cpus/PowerPC,750@0, renamed to "l2-cache#1"
<6>checking if image is initramfs... it is
<4>Freeing initrd memory: 5957k freed
<6>NET: Registered protocol family 16
<6>PCI: Probing PCI hardware
<3>PCI: Cannot allocate resource region 0 of PCI bridge 1
<6>PCI: bridge 1 resource 0 moved to 7ff000..7fffff
<3>PCI: Cannot allocate resource region 0 of device 0000:01:01.0
<3>PCI: Cannot allocate resource region 1 of device 0000:01:01.0
<3>PCI: Cannot allocate resource region 2 of device 0000:01:01.0
<3>PCI: Cannot allocate resource region 3 of device 0000:01:01.0
<3>PCI: Cannot allocate resource region 4 of device 0000:01:01.0
<3>PCI: Cannot allocate resource region 1 of device 0000:00:10.0
<3>PCI: Cannot allocate resource region 0 of device 0000:01:04.0
<4>PCI: Enabling device 0000:01:04.0 (0010 -> 0013)
<7>Registering pmac pic with sysfs...
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
<4>TCP established hash table entries: 8192 (order: 3, 32768 bytes)
<4>TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
<6>TCP: Hash tables configured (established 8192 bind 4096)
<6>TCP reno registered
<4>Thermal assist unit using timers, shrink_timer: 500 jiffies
<6>audit: initializing netlink socket (disabled)
<5>audit(1157465930.056:1): initialized
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<4>PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
<6>aty128fb: Found Open Firmware ROM Image
<6>aty128fb: BIOS not located, guessing timings.
<6>aty128fb: Rage128 RE PCI [chip rev 0x2] 16M 128-bit SDR SGRAM (1:1)
<4>Console: switching to colour frame buffer device 128x48
<6>fb0: ATY Rage128 frame buffer device on Rage128 RE PCI
<6>Generic RTC Driver v1.07
<6>Macintosh non-volatile memory driver v1.1
<6>pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
<6>ttyS0 at MMIO 0x80813020 (irq = 16) is a Z85c30 ESCC - Serial port
<6>ttyS1 at MMIO 0x80813000 (irq = 17) is a Z85c30 ESCC - Infrared port
<4>RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
<6>MacIO PCI driver attached to Paddington chipset
<4>Can't request resource 0 for MacIO device 0.00000000:power-mg
<6>input: Macintosh mouse button emulation as /class/input/input0
<4>Macintosh CUDA driver v0.5 for Unified ADB.
<6>apm_emu: Requires a machine with a PMU.
<6>adb: starting probe task...
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>CMD646: IDE controller at PCI slot 0000:01:01.0
<6>CMD646: chipset revision 7
<6>CMD646: chipset revision 0x07, UltraDMA Capable
<6>CMD646: 100% native mode on irq 26
<6>    ide0: BM-DMA at 0x7ff020-0x7ff027, BIOS settings: hda:pio, hdb:pio
<6>    ide1: BM-DMA at 0x7ff028-0x7ff02f, BIOS settings: hdc:pio, hdd:pio
<7>Probing IDE interface ide0...
<7>adb devices:
<6>adb: finished probe task...
<7>Probing IDE interface ide1...
<6>ide2: Found Apple Heathrow ATA controller, bus ID 0, irq 32
<7>Probing IDE interface ide2...
<4>hde: MATSHITAPD-2 LF-D110, ATAPI CD/DVD-ROM drive
<4>hdf: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
<6>hde: Enabling MultiWord DMA 2
<4>ide2 at 0xd101c000-0xd101c007,0xd101c160 on irq 32
<7>Probing IDE interface ide0...
<7>Probing IDE interface ide1...
<7>ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
<6>ohci_hcd 0000:01:06.0: OHCI Host Controller
<6>ohci_hcd 0000:01:06.0: new USB bus registered, assigned bus number 1
<6>ohci_hcd 0000:01:06.0: irq 28, io mem 0x80880000
<6>usb usb1: new device found, idVendor=0000, idProduct=0000
<6>usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb1: Product: OHCI Host Controller
<6>usb usb1: Manufacturer: Linux 2.6.18-rc6-20060905-default ohci_hcd
<6>usb usb1: SerialNumber: 0000:01:06.0
<6>usb usb1: configuration #1 chosen from 1 choice
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 2 ports detected
<6>usb 1-2: new full speed USB device using ohci_hcd and address 2
<6>usb 1-2: new device found, idVendor=05ac, idProduct=1001
<6>usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=0
<6>usb 1-2: Product: Hub in Apple USB Keyboard
<6>usb 1-2: Manufacturer: Alps Electric
<6>usb 1-2: configuration #1 chosen from 1 choice
<6>hub 1-2:1.0: USB hub found
<6>hub 1-2:1.0: 3 ports detected
<6>usb 1-2.1: new low speed USB device using ohci_hcd and address 3
<6>usb 1-2.1: new device found, idVendor=05ac, idProduct=0202
<6>usb 1-2.1: new device strings: Mfr=1, Product=2, SerialNumber=0
<6>usb 1-2.1: Product: Apple USB Keyboard
<6>usb 1-2.1: Manufacturer: Alps Electric
<6>usb 1-2.1: configuration #1 chosen from 1 choice
<6>usb 1-2.2: new low speed USB device using ohci_hcd and address 4
<6>usb 1-2.2: new device found, idVendor=05ac, idProduct=0307
<6>usb 1-2.2: new device strings: Mfr=1, Product=2, SerialNumber=0
<6>usb 1-2.2: Product: Apple Optical USB Mouse
<6>usb 1-2.2: Manufacturer: Logitech
<6>usb 1-2.2: configuration #1 chosen from 1 choice
<6>usbcore: registered new driver hiddev
<6>input: Alps Electric Apple USB Keyboard as /class/input/input1
<6>input: USB HID v1.00 Keyboard [Alps Electric Apple USB Keyboard] on usb-0000:01:06.0-2.1
<6>input: Logitech Apple Optical USB Mouse as /class/input/input2
<6>input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0000:01:06.0-2.2
<6>usbcore: registered new driver usbhid
<6>drivers/usb/input/hid-core.c: v2.6:USB HID core driver
<6>usbcore: registered new driver appletouch
<6>mice: PS/2 mouse device common for all mice
<6>md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: bitmap version 4.39
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 17
<4>Freeing unused kernel memory: 192k init
<6>hde: ATAPI DVD-ROM DVD-RAM drive, 2048kB Cache, DMA
<6>Uniform CD-ROM driver Revision: 3.20
<5>SCSI subsystem initialized
<6>st: Version 20050830, fixed bufsize 32768, s/g segs 256
<6>loop: loaded (max 8 devices)
<3>pmac_zilog 0.00013000:ch-b: irda_setup timed out on get_version byte
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
<4>        <Adaptec 2940B Ultra2 SCSI adapter>
<4>        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<5>  Vendor: IBM       Model: DDRS-39130D       Rev: DC2A
<5>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
<6> target0:0:0: Beginning Domain Validation
<6> target0:0:0: wide asynchronous
<4>Machine check in kernel mode.
<4>Caused by (from SRR1=49030): Transfer error ack signal
<4>Oops: Machine check, sig: 7 [#1]
<4>
<4>Modules linked in: aic7xxx scsi_transport_spi cpufreq_ondemand loop nfs nfs_acl lockd sunrpc sg st sd_mod sr_mod scsi_mod ide_cd cdrom
<4>NIP: D21F03A0 LR: D20D9494 CTR: D21F0388
<4>REGS: cf5059f0 TRAP: 0200   Not tainted  (2.6.18-rc6-20060905-default)
<4>MSR: 00049030 <EE,ME,IR,DR>  CR: 22022242  XER: 00000000
<4>TASK = cf1d9990[963] 'insmod' THREAD: cf504000
<6>GPR00: 000000FF CF505AA0 CF1D9990 CF513400 CF505A6C CF564C00 CF564D00 00000000 
<6>GPR08: 00000001 D105C000 CF64D400 00000000 F2841C80 100290EC 0000000F D22BFB50 
<6>GPR16: 0000001E D229EDD0 CFC52500 D229EDA8 CF5139CC CF513818 CF5138BC CF513400 
<6>GPR24: CF513800 CF5139A0 FFFFFFFF C37C0000 CF5139A0 CF513800 CF513000 CF513C00 
<4>NIP [D21F03A0] ahc_linux_get_signalling+0x18/0xa8 [aic7xxx]
<4>LR [D20D9494] spi_dv_device+0x338/0x51c [scsi_transport_spi]
<4>Call Trace:
<4>[CF505AA0] [D20D9364] spi_dv_device+0x208/0x51c [scsi_transport_spi] (unreliable)
<4>[CF505AF0] [D21F0808] ahc_linux_slave_configure+0xfc/0x114 [aic7xxx]
<4>[CF505B30] [D20B71D8] scsi_probe_and_add_lun+0x8d4/0xa40 [scsi_mod]
<4>[CF505B90] [D20B78F8] __scsi_scan_target+0xd8/0x630 [scsi_mod]
<4>[CF505C20] [D20B7E9C] scsi_scan_channel+0x4c/0x9c [scsi_mod]
<4>[CF505C40] [D20B7FD4] scsi_scan_host_selected+0xe8/0x140 [scsi_mod]
<4>[CF505C70] [D21F3998] ahc_linux_register_host+0x344/0x35c [aic7xxx]
<4>[CF505D10] [D21F468C] ahc_linux_pci_dev_probe+0x1a8/0x1c8 [aic7xxx]
<4>[CF505D80] [C016A49C] pci_device_probe+0x6c/0xa0
<4>[CF505DA0] [C01F0AF4] driver_probe_device+0x60/0xf4
<4>[CF505DC0] [C01F0CC4] __driver_attach+0x8c/0xf0
<4>[CF505DE0] [C01F0424] bus_for_each_dev+0x50/0x94
<4>[CF505E10] [C01F0A08] driver_attach+0x24/0x34
<4>[CF505E20] [C01F000C] bus_add_driver+0x78/0x128
<4>[CF505E40] [C01F0FC4] driver_register+0xa0/0xb4
<4>[CF505E50] [C016A2C8] __pci_register_driver+0x4c/0x8c
<4>[CF505E60] [D21F44CC] ahc_linux_pci_init+0x20/0x38 [aic7xxx]
<4>[CF505E70] [D105A3C0] ahc_linux_init+0x3c0/0x530 [aic7xxx]
<4>[CF505EA0] [C004EB50] sys_init_module+0x1368/0x14f8
<4>[CF505F40] [C00125A4] ret_from_syscall+0x0/0x40
<4>--- Exception: c01 at 0xff698a4
<4>    LR = 0x10001100
<4>Instruction dump:
<4>38600000 4e800020 38600000 4e800020 4e800020 4e800020 814302ac 800a0000 
<4>2f800000 409e0018 812a0004 8809001f <0c000000> 4c00012c 48000028 812a0004 
<4> scsi0: PCI error Interrupt at seqaddr = 0x8
<4>scsi0: Signaled a Target Abort
<6>mesh: configured for synchronous 5 MB/s
<6>mesh: performing initial bus reset...
<6>scsi1 : MESH
<6>Initializing USB Mass Storage driver...
<6>usbcore: registered new driver usb-storage
<6>USB Mass Storage support registered.
<7>ieee1394: Initialized config rom entry `ip1394'
<6>ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
<6>ieee1394: sbp2: Try serialize_io=0 for better performance
<6>eth0: BMAC+ at 00:50:e4:30:77:1f

--PNTmBPCT7hxwcZjr--
