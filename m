Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265647AbUE0Xac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265647AbUE0Xac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 19:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUE0Xac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 19:30:32 -0400
Received: from mail.aei.ca ([206.123.6.14]:30440 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265647AbUE0XaD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 19:30:03 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7-rc1-mm1] cant mount reiserfs using -o barrier=flush
Date: Thu, 27 May 2004 19:28:33 -0400
User-Agent: KMail/1.6.2
Cc: =?iso-8859-1?q?G=FCnther_Persoons?= <gunther_persoons@spymac.com>,
       Andrew Morton <akpm@osdl.org>, Chris Mason <mason@suse.com>
References: <1085689455.7831.8.camel@localhost>
In-Reply-To: <1085689455.7831.8.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405271928.33451.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Think this is not just a barrier problem (unless barrier is the default).
One if my two drives gets the error below during operation.
The drive is the root drive and is mounted with defaults.  2.6.6-mm4
was the last kernel booted on this box.   The 2.6.7-rc1-mm1 was compiled
with 2.95 with the following fs options:

CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

hda reports:
root@bert:/usr/src/linux# hdparm -iI /dev/hda

/dev/hda:

 Model=WDC AC26400R, FwRev=15.01J15, SerialNo=WD-WM6271600165
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=13328/15/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=13328/15/63, CurSects=12594960, LBA=yes, LBAsects=12594960
 IORDY=on/off, tPIO={min:160,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4

 * signifies the current active mode


ATA device, with non-removable media
        Model Number:       WDC AC26400R
        Serial Number:      WD-WM6271600165
        Firmware Revision:  15.01J15
Standards:
        Supported: 4 3 2 1
        Likely used: 4
Configuration:
        Logical         max     current
        cylinders       13328   13328
        heads           15      15
        sectors/track   63      63
        --
        bytes/track: 57600      bytes/sector: 600
        CHS current addressable sectors:   12594960
        LBA    user addressable sectors:   12594960
        device size with M = 1024*1024:        6149 MBytes
        device size with M = 1000*1000:        6448 MBytes (6 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 512.0kB    bytes avail on r/w long: 40     Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=160ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
           *    SMART feature set

root@bert:/usr/src/linux# hdparm -iI /dev/hdb

/dev/hdb:

 Model=Maxtor 6E030L0, FwRev=NAR61590, SerialNo=E178CV5E
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=60058656
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

 * signifies the current active mode


ATA device, with non-removable media
        Model Number:       Maxtor 6E030L0
        Serial Number:      E178CV5E
        Firmware Revision:  NAR61590
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   17475
        heads           16      15
        sectors/track   63      63
        --
        CHS current addressable sectors:   16513875
        LBA    user addressable sectors:   60058656
        device size with M = 1024*1024:       29325 MBytes
        device size with M = 1000*1000:       30750 MBytes (30 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6
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
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command
           *    Device Configuration Overlay feature set
           *    Automatic Acoustic Management feature set
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test
           *    SMART error logging
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 1 determined by CSEL
Checksum: correct

hdb is accessed via dm and evms.   This is what the boot of reports:

May 27 18:17:39 bert kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
May 27 18:17:39 bert kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 27 18:17:39 bert kernel: PIIX4: IDE controller at PCI slot 0000:00:14.1
May 27 18:17:39 bert kernel: PIIX4: chipset revision 1
May 27 18:17:39 bert kernel: PIIX4: not 100%% native mode: will probe irqs later
May 27 18:17:39 bert kernel:     ide0: BM-DMA at 0x10c0-0x10c7, BIOS settings: hda:pio, hdb:DMA
May 27 18:17:39 bert kernel:     ide1: BM-DMA at 0x10c8-0x10cf, BIOS settings: hdc:DMA, hdd:pio
May 27 18:17:39 bert kernel: hda: WDC AC26400R, ATA DISK drive
May 27 18:17:39 bert kernel: hdb: Maxtor 6E030L0, ATA DISK drive
May 27 18:17:39 bert kernel: Using anticipatory io scheduler
May 27 18:17:39 bert kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 27 18:17:39 bert kernel: hdc: HL-DT-ST RW/DVD GCC-4480B, ATAPI CD/DVD-ROM drive
May 27 18:17:39 bert kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 27 18:17:39 bert kernel: pnp: the driver 'ide' has been registered
May 27 18:17:39 bert kernel: hda: max request size: 128KiB
May 27 18:17:39 bert kernel: hda: 12594960 sectors (6448 MB) w/512KiB Cache, CHS=13328/15/63, UDMA(33)
May 27 18:17:39 bert kernel: hda: cache flushes supported
May 27 18:17:39 bert kernel:  hda: hda1 hda2 hda3
May 27 18:17:39 bert kernel: hdb: max request size: 128KiB
May 27 18:17:39 bert kernel: hdb: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=59582/16/63, UDMA(33)
May 27 18:17:39 bert kernel: hdb: cache flushes supported
May 27 18:17:39 bert kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 >
 
followed later by:

May 27 18:18:05 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 27 18:18:05 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
May 27 18:18:06 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 27 18:18:06 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
May 27 18:19:21 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 27 18:19:21 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
May 27 18:19:22 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 27 18:19:22 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
May 27 18:20:01 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 27 18:20:01 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
May 27 18:20:01 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 27 18:20:01 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
May 27 18:21:27 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 27 18:21:27 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }




Hope this help,

Ed

On May 27, 2004 04:24 pm, Günther Persoons wrote:
> Hey,
> When i mount my reiser partitie with the option barrier=flush i get
> following message and error:
> My harddrive is a 2.5 inch Fujitsu 20GB IDE.
> 
> mount /dev/hda10 /tmp -o barrier=flush
> mount: wrong fs type, bad option, bad superblock on /dev/hda10,
>        or too many mounted file systems
> Log:
> ReiserFS: hda10: found reiserfs format "3.6" with standard journal
> ReiserFS: hda10: using ordered data mode
> reiserfs: using flush barriers
> ReiserFS: hda10: journal params: device hda10, size 8192, journal first
> block 18, max trans len 1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: hda10: checking transaction log (hda10)
> hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hda: drive_cmd: error=0x04 { DriveStatusError }
> hda: barrier support doesn't work
> ReiserFS: hda10: warning: journal-837: IO error during journal replay
> ReiserFS: hda10: warning: Replay Failure, unable to mount
> ReiserFS: hda10: warning: sh-2022: reiserfs_fill_super: unable to
> initialize journal space
