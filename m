Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTJJBqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbTJJBqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:46:52 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:14795 "EHLO fep3.cogeco.net")
	by vger.kernel.org with ESMTP id S262747AbTJJBqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:46:47 -0400
Date: Thu, 9 Oct 2003 21:43:55 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-ac IDE DMA errors
Message-ID: <20031010014355.GA6285@dragon.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Olivier Dragon <dragon@shadnet.shad.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a newbie so please bare with me if I lack in the informational
department. I'm not subscribed to the list so please CC me in the
replies.

I'm having trouble with the -ac patch and kernel 2.4.22. I think it may
be an issue with PCI-IDE (ALI15X3) trying to set DMA. I've tried both
-ac1 and -ac4 and vanilla with acpi patch 20030918. I get no errors with
vanilla+acpi. I get similar errors for both -ac1 and -ac4. The only
configuration differences is the cpufreq modules and CONFIG_AGP_ATI are
compiled in the kernel (not as loadable modules) for the -ac patches.

The error messages appear in `dmesg` which I've put parts of below.

Thank you,
-Olivier


My current setup:

Compaq Presario 2140CA (Laptop)
Mobile Athlon XP 2200+
Linux gargoyle 2.4.22-ac4 #2 Thu Oct 9 21:03:52 CEST 2003 i686 GNU/Linux


Here are what seem to be relevant parts of dmesg:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Warning: ATI Radeon IGP Northbridge is not yet fully tested.
ALI15X3: IDE controller at PCI slot 00:10.0
PCI: No IRQ known for interrupt pin A of device 00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4021GAS, ATA DISK drive
blk: queue c03a0680, I/O limit 4095Mb (mask 0xffffffff)
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78140160 sectors (40008 MB), CHS=4864/255/63, UDMA(100)
hdc: attached ide-scsi driver.

...

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 112k freed
Adding Swap: 248996k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link up.
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
hda: dma_timer_expiry: dma status == 0x21
hda: error waiting for DMA
hda: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest }

hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
ide0: reset: success



---------
And hdparm:

/dev/hda:

ATA device, with non-removable media
        Model Number:       TOSHIBA MK4021GAS
        Serial Number:      431A0823T
        Firmware Revision:  GA224C
Standards:
        Supported: 5 4 3 2
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   78140160
        device size with M = 1024*1024:       38154 MBytes
        device size with M = 1000*1000:       40007 MBytes (40 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 46     Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0080)
        Recommended acoustic management value: 254, current value: 254
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    Mandatory FLUSH CACHE command
           *    Device Configuration Overlay feature set
                Automatic Acoustic Management feature set
                SET MAX security extension
           *    Advanced Power Management feature set
           *    SMART self-test
           *    SMART error logging
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
        48min for SECURITY ERASE UNIT.
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by CSEL
Checksum: correct

-- 
                  __-/|    ? ?     |\-__
             __--/  /  \   (^^)   /  \  \--__
          _-/   /   /   \ / ( )  /   \   \   \-_
         /  /   /  /     (   ^^ ~     \  \   \  \
         / Oli Dragon    dragon@shadnet.shad.ca \
        /  Sfwr Eng IV   (  McMaster University  \
        /  /  /     __--_ (   ) __--__     \  \  \
        |  /  /  _/        \_ \_       \_  \  \  |
         \/  / _/            \_ \_       \_ \  \/
          \_/ /                -\_\        \ \_/
            \/                    )         \/
                                *~
               ___--<***************>--___
              [http://dragon.homelinux.org]
               ~~~--<***************>--~~~
