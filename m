Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbRCLPpT>; Mon, 12 Mar 2001 10:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRCLPpJ>; Mon, 12 Mar 2001 10:45:09 -0500
Received: from caspar.so-net.net.uk ([62.6.176.6]:37638 "HELO
	caspar.so-net.net.uk") by vger.kernel.org with SMTP
	id <S130442AbRCLPow>; Mon, 12 Mar 2001 10:44:52 -0500
Message-ID: <20010312145653.13015.qmail@caspar.so-net.net.uk>
Date: Mon, 12 Mar 2001 15:45:21 +0000
From: D Watanabe <dwata.geo@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Sony VAIO  PCI (NOT USB) MemoryStick Recognition
X-Mailer: Sylpheed version 0.4.61 (GTK+ 1.2.8; Linux 2.4.2; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

I'm trying to use MemoryStick slot on SonyVAIO PCG-Z600NE,
and currently no luck.
Product Name "Z600NE" is a bit funny,
probably this is used for Europe domain.
I believe some "505" series should have same spedification. 


Linux/OS does not recognize MemoryStick as HD at all.

What I can see is:
  * This machine's Memorystick seems to be 
    connected to PCI not USB. <-- important!
    So USB-MASS-STRAGE is no help.

    Anyway, those below config=y but still no help.
    CONFIG_SCSI=y
    CONFIG_BLK_DEV_SD=y
    CONFIG_USB_STORAGE=y

  * As above, SCSI config are included in kernel, but no help.

  * "MemoryStick Controller" appears on /proc/pci 
    so device itself is existing anyway.
    And it will act as ATA-Drive/Scsi(?) HardDrive
    but Linux cannot recognized it as HD.

  * Kernel parameter "hdc=autotune" is no help.
    "hdc=247/2/16" (for example!) leads kernel panic,
     no wander.
    Kernel says, it's "non-ATA Drive".  


Here is specs/logs which could help to tell the situation.
* Debian: woody(testing).
* Linux Kernel Version: 2.4.2 with devfs
* Eithernet/Audio devices are working fine.
* USB-Floppy is working on the same environment,
  which is recognized as SCSI device and appers under
  /dev/scsi/host0(snip)




* BIOS setup.
Menu [Advanced]

> Primary IDE Adapter [12073MB]
> Secondary IDE Adapter [None]
   --> Submenu
       Type [Auto]
       This "Type" option has "ATAPI Removable"
       and "CD-ROM" etc.

Any change for "Secondary IDE Adapter [None]" canNOT be made.
for example, change it to "ATAPI Removbale" from "None"
and Save(F10) and quit restart.
Then the menu "Secondary IDE Adapter" has been back to [None].
No way to change it, as far as I have tested.
Anyway, on the same BIOS configration, Win2K can recognize
memorystick properly.



* dmesg digest

Linux version 2.4.2 (root@chariot) (gcc version 2.95.3 20010125 (prerelease)) 
(snip)
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
  got res[10000000:10000fff] for resource 0 of Ricoh Co Ltd RL5c475
  got res[10001000:100013ff] for resource 0 of Sony Corporation Memory Stick Controller
Limiting direct PCI/PCI transfers.
(snip)
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcb0-0xfcb7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcb8-0xfcbf, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DARA-212000, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 23579136 sectors (12073 MB) w/418KiB Cache, CHS=1467/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 > p4
Floppy drive(s): fd0 is 1.44M
(snip)


[Note]: No "hdc" recognition.



* lspci -vt 
-[00]-+-00.0  Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
      +-01.0-[01]----00.0  Neomagic Corporation: Unknown device 0016
      +-07.0  Intel Corporation 82371AB PIIX4 ISA
      +-07.1  Intel Corporation 82371AB PIIX4 IDE
      +-07.2  Intel Corporation 82371AB PIIX4 USB
      +-07.3  Intel Corporation 82371AB PIIX4 ACPI
      +-08.0  Sony Corporation CXD3222 i.LINK Controller
      +-09.0  Yamaha Corporation YMF-744B [DS-1S Audio Controller]
      +-0a.0  CONEXANT: Unknown device 2443
      +-0b.0  Intel Corporation 82557 [Ethernet Pro 100]
      +-0c.0  Ricoh Co Ltd RL5c475
      \-0d.0  Sony Corporation Memory Stick Controller


* lspci -vvx (digest)

00:0d.0 FLASH memory: Sony Corporation Memory Stick Controller (rev 01)
        Subsystem: Sony Corporation: Unknown device 8085
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort
- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [disabled] [size=1K]
        Capabilities: <available only to root>
00: 4d 10 8a 80 00 00 10 02 01 00 01 05 00 00 00 00
10: 00 10 00 10 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 85 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 01 00 00



* kernel configuration (digest)

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y


--- USB/SCSI
#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
...
#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
...
#
# USB support
#
...
CONFIG_USB_STORAGE=y
...





I cannot decide this problem caused by
  * Need some special driver for the controller
  * some kernel mis configuration
  * lack of some appropriate kernel param
  * some BIOS work
  * other??



Any comments are welcome.

Thank you very much&
Best regards,
D Watanabe<dwata.geo@yahoo.com>

