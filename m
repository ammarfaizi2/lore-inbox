Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSKRXZU>; Mon, 18 Nov 2002 18:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSKRXZU>; Mon, 18 Nov 2002 18:25:20 -0500
Received: from mail.big.net.au ([203.24.105.4]:7436 "HELO mail.big.net.au")
	by vger.kernel.org with SMTP id <S265998AbSKRXZM>;
	Mon, 18 Nov 2002 18:25:12 -0500
Date: Tue, 19 Nov 2002 09:24:01 +1100
From: Silvio Cesare <silvio@big.net.au>
To: linux-kernel@vger.kernel.org
Subject: sis650/5513 in 2.4.19 (still broken for 650)
Message-ID: <20021118222401.GA3777@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attachment.

--
Silvio

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sis650

No fixes here.. just reports for anyone interested :(

1) sis650/5513 chipset does not work with UDMA - this was reported a while
   ago, and also reported fixed.. but I don't think its been tested on a
   sis650 specifically, which (for me) appears still broken (fs
   corruptions etc).

   this was reported fixed in 2.4.19; i took a 2.4.18 kernel, and replaced
   drivers/ide/sis5513.c (theres some includes also, but perhaps not
   important).  this came up with the same problems as 2.4.18.

   2.4.18 incidentally has a function #if 0, at the end of sis5513.c,
   which I had to make #if 1 (remove) to get a compile (there appears to be
   no other declaration of this code in the tree) - this has probably
   been noticed a long time ago I imagine (?).

   for the UDMA issues, recompiling with -->

#define BROKEN_LEVEL XFER_SW_DMA_0

   gets it up and running again (ie, without UDMA).

   incidentally.. the sis 0.13 code by the maintainers have patches
   against 2.4.18 which break when you run it with #define DEBUG, as
   some var names have been slightly modified.

2) External floppy drive via USB not 100% working..  No idea on this one;
   I've included very small snippets of bootup messages, but it's no
   major drama currently (works for the most part), so I don't really
   expect anyone to look at this (especially with the minimal info
   I've provided here) :)

For the sis650, maybe (?) the following will help -->
[ I've no real clue how useful or non useful this is, but maybe its
  worth a look for the current development ]

Nov 18 15:57:19 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 18 15:57:19 localhost kernel: SIS5513: IDE controller on PCI bus 00 dev 15
Nov 18 15:57:19 localhost kernel: SIS5513: chipset revision 208
Nov 18 15:57:19 localhost kernel: SIS5513: not 100%% native mode: will probe irqs later
Nov 18 15:57:19 localhost kernel: SiS650    ATA 100 controller
Nov 18 15:57:19 localhost kernel: SIS5513 pci_init_sis5513 start
Nov 18 15:57:19 localhost kernel: SIS5513 dump:
Nov 18 15:57:19 localhost kernel:               0x0:0x39 0x1:0x10 0x2:0x13 0x3:0x55 0x4:0x5 0x5:0x0 0x6:0x0 0x7:0x0 0x8:0xd0 0x9:0x80 0xa:0x1 0xb:0x1 0xc:0x0 0xd:0x80 0xe:0x80 0xf:0x0
Nov 18 15:57:19 localhost kernel:               0x10:0x0 0x11:0x0 0x12:0x0 0x13:0x0 0x14:0x0 0x15:0x0 0x16:0x0 0x17:0x0 0x18:0x0 0x19:0x0 0x1a:0x0 0x1b:0x0 0x1c:0x0 0x1d:0x0 0x1e:0x0 0x1f:0x0
Nov 18 15:57:19 localhost kernel:               0x20:0x1 0x21:0xff 0x22:0x0 0x23:0x0 0x24:0x0 0x25:0x0 0x26:0x0 0x27:0x0 0x28:0x0 0x29:0x0 0x2a:0x0 0x2b:0x0 0x2c:0x39 0x2d:0x10 0x2e:0x13 0x2f:0x55
Nov 18 15:57:19 localhost kernel:               0x30:0x0 0x31:0x0 0x32:0x0 0x33:0x0 0x34:0x0 0x35:0x0 0x36:0x0 0x37:0x0 0x38:0x0 0x39:0x0 0x3a:0x0 0x3b:0x0 0x3c:0x0 0x3d:0x0 0x3e:0x0 0x3f:0x0
Nov 18 15:57:19 localhost kernel:               0x40:0x31 0x41:0x81 0x42:0x0 0x43:0x0 0x44:0x31 0x45:0x85 0x46:0x0 0x47:0x0 0x48:0xf8 0x49:0x1 0x4a:0xe6 0x4b:0x11 0x4c:0x0 0x4d:0x2 0x4e:0x0 0x4f:0x2 0x50:0x1 0x51:0x0 0x52:0x1 0x53:0x6 0x54:0x0 0x55:0x0 0x56:0x0 0x57:0x0
Nov 18 15:57:19 localhost kernel: SIS5513: pci_init_sis5513 end, changed registers:
Nov 18 15:57:19 localhost kernel: none
Nov 18 15:57:19 localhost kernel:     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
Nov 18 15:57:19 localhost kernel:     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Nov 18 15:57:19 localhost kernel: hda: IC25N040ATCS04-0, ATA DISK drive
Nov 18 15:57:19 localhost kernel: hdc: QSI CD-RW/DVD-ROM SBW-081, ATAPI CD/DVD-ROM drive
Nov 18 15:57:19 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 18 15:57:19 localhost nfslock: rpc.statd startup succeeded
Nov 18 15:57:19 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 18 15:57:19 localhost kernel: SIS5513: config_drive_art_rwp, drive 0
Nov 18 15:57:19 localhost kernel: SIS5513: config_drive_art_rwp start, changed registers:
Nov 18 15:57:19 localhost rpc.statd[672]: Version 1.0.1 Starting
Nov 18 15:57:19 localhost kernel: none
Nov 18 15:57:19 localhost kernel: SIS5513: config_drive_art_rwp end, changed registers:
Nov 18 15:57:19 localhost kernel: none
Nov 18 15:57:19 localhost keytable: Loading keymap:
Nov 18 15:57:19 localhost kernel: SIS5513: config_drive_art_rwp_pio start, changed registers:
Nov 18 15:57:19 localhost kernel: none
Nov 18 15:57:19 localhost keytable:
Nov 18 15:57:19 localhost kernel: SIS5513: config_drive_art_rwp, drive 0
Nov 18 15:57:19 localhost keytable:
Nov 18 15:57:19 localhost kernel: SIS5513: config_drive_art_rwp start, changed registers:
Nov 18 15:57:19 localhost kernel: none
Nov 18 15:57:19 localhost rc: Starting keytable:  succeeded
Nov 18 15:57:19 localhost kernel: SIS5513: config_drive_art_rwp end, changed registers:
Nov 18 15:57:19 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp_pio, drive 0, pio 4, timing 4
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp_pio start, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp_pio start, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp, drive 0
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp start, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp end, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp_pio, drive 0, pio 4, timing 4
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp_pio start, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: config_chipset_for_dma, drive 0, ultra 3f, udma_66 0
Nov 18 15:57:20 localhost kernel: SIS5513: sis5513_tune_chipset start, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: sis5513_tune_chipset, drive 0, speed
66
Nov 18 15:57:20 localhost kernel: SIS5513: BROKEN_LEVEL activated, speed=66 -> speed=16
Nov 18 15:57:20 localhost kernel: SIS5513: sis5513_tune_chipset end, changed registers:
Nov 18 15:57:20 localhost random: Initializing random number generator:  succeeded
Nov 18 15:57:20 localhost kernel: 0x41: 0x81 -> 0x1
Nov 18 15:57:20 localhost kernel: hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
Nov 18 15:57:20 localhost kernel: hda: set_drive_speed_status: error=0x04 { DriveStatusError }
Nov 18 15:57:20 localhost kernel: SIS5513: config_chipset_for_dma, drive 0, ultra 3f, udma_66 0
Nov 18 15:57:20 localhost kernel: SIS5513: sis5513_tune_chipset start, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: sis5513_tune_chipset, drive 0, speed
34
Nov 18 15:57:20 localhost kernel: SIS5513: BROKEN_LEVEL activated, speed=34 -> speed=16
Nov 18 15:57:20 localhost kernel: SIS5513: sis5513_tune_chipset end, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
Nov 18 15:57:20 localhost kernel: hda: set_drive_speed_status: error=0x04 { DriveStatusError }
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp_pio start, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp, drive 0
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp start, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp end, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp_pio, drive 0, pio 4, timing 4
Nov 18 15:57:20 localhost kernel: SIS5513: config_drive_art_rwp_pio start, changed registers:
Nov 18 15:57:20 localhost kernel: none
Nov 18 15:57:20 localhost kernel: hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=4864/255/63

-- some logs probably not relevant (re floppy), but oh well..

Nov 18 15:57:20 localhost kernel: usb.c: USB device 2 (vend/prod 0x3ee/0x6901) is not claimed by any active driver.
Nov 18 15:57:20 localhost kernel: SCSI subsystem driver Revision: 1.00
Nov 18 15:57:20 localhost kernel: Initializing USB Mass Storage driver...
Nov 18 15:57:20 localhost kernel: usb.c: registered new driver usb-storage
Nov 18 15:57:20 localhost kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Nov 18 15:57:20 localhost kernel:   Vendor: MITSUMI   Model: USB FDD           Rev: 1039
Nov 18 15:57:20 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Nov 18 15:57:20 localhost kernel: USB Mass Storage support registered.

--
Silvio

--J2SCkAp4GZ/dPZZf--
