Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291818AbSBAQEX>; Fri, 1 Feb 2002 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291820AbSBAQEO>; Fri, 1 Feb 2002 11:04:14 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:5823 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291818AbSBAQDz>; Fri, 1 Feb 2002 11:03:55 -0500
Message-Id: <5.1.0.14.2.20020201160018.026603b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 01 Feb 2002 16:06:14 +0000
To: axel@hh59.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.5.3 - (IDE) hda: drive not ready for command errors
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020201153303.A1508@prester.hh59.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I started getting the same errors as you show below about a month or more 
ago now. They became more and more frequent to the point of starting to 
kill the whole IDE controller (other channel was killed too) and killing 
the system within 5-30 minutes of starting up.

I was about to send the drive (IBM 7200rpm 41GiB) back for replacement when 
I as last resort tried to upgrade the firmware of the drive.

After the upgrade the drive started working again, fully passed the Drive 
Fitness Test (IBM utility) and it has been working for a few weeks non-stop 
in my file server RAID-1 array since then.

I know your problems might have nothing to do with mine especially as the 
drives are from different manufacturers but it may be an idea to ask for a 
firmware upgrade. You never know...

Best regards,

Anton

At 14:33 01/02/02, axel@hh59.org wrote:
>Hallo,
>
>I get these warnings/errors from my kernel. For my feeling it does
>not really seem to slow down things a lot but maybe it helps for fixing
>errors.
>
>Feb  1 10:16:48 prester kernel: hda: status error: status=0x58 { 
>DriveReady Seek
>Feb  1 10:16:48 prester kernel: hda: drive not ready for command
>Feb  1 10:16:48 prester kernel: task_out_intr: should not trigger
>Feb  1 10:16:48 prester kernel: task_out_intr: should not trigger
>
>and
>
>Feb  1 15:13:55 prester kernel: hda: status timeout: status=0xd0 { Busy }
>Feb  1 15:13:55 prester kernel: hda: drive not ready for command
>Feb  1 15:13:55 prester kernel: ide0: reset: success
>
>Just now I have experience some new errors, which do not directly seem to be
>related to ide but seem strange to me as well. Hope it gives you some clue.
>
>Feb  1 15:22:28 prester kernel: <ry sread (sector 0x5b1bea88) failed
>Feb  1 15:22:28 prester kernel: attempt to access beyond end of device
>Feb  1 15:22:28 prester kernel: 03:04: rw=0, want=764278084, limit=8377897
>Feb  1 15:22:28 prester kernel: Directory sread (sector 0x5b1bea88) failed
>Feb  1 15:22:28 prester kernel: attempt to access beyond end of device
>Feb  1 15:22:28 prester kernel: 03:04: rw=0, want=764278084, limit=8377897
>...
>Feb  1 15:22:29 prester kernel: Directory sread (sector 0x7007faf) failed
>Feb  1 15:22:29 prester last message repeated 15 times
>
>
>Axel Siebenwirth
>
>with the following setup:
>
>* kernel 2.5.3
>
># ATA/IDE/MFM/RLL support
>CONFIG_IDE=y
># IDE, ATA and ATAPI Block devices
>CONFIG_BLK_DEV_IDE=y
>CONFIG_BLK_DEV_IDEDISK=y
>CONFIG_BLK_DEV_IDECD=m
>CONFIG_IDE_TASK_IOCTL=y
># IDE chipset support/bugfixes
>CONFIG_BLK_DEV_IDEPCI=y
>CONFIG_IDEPCI_SHARE_IRQ=y
>CONFIG_BLK_DEV_IDEDMA_PCI=y
>CONFIG_IDEDMA_PCI_AUTO=y
>CONFIG_BLK_DEV_IDEDMA=y
>CONFIG_IDEDMA_AUTO=y
>CONFIG_BLK_DEV_IDE_MODES=y
>
>name                    value           min             max             mode
>----                    -----           ---             ---             ----
>acoustic                0               0               254             rw
>address                 0               0               2               rw
>bios_cyl                1826            0               65535           rw
>bios_head               255             0               255             rw
>bios_sect               63              0               63              rw
>breada_readahead        8               0               255             rw
>bswap                   0               0               1               r
>current_speed           0               0               69              rw
>failures                0               0               65535           rw
>file_readahead          124             0               16384           rw
>ide_scsi                0               0               1               rw
>init_speed              0               0               69              rw
>io_32bit                0               0               3               rw
>keepsettings            0               0               1               rw
>lun                     0               0               7               rw
>max_failures            1               0               65535           rw
>multcount               0               0               16              rw
>nice1                   1               0               1               rw
>nowerr                  0               0               1               rw
>number                  0               0               3               rw
>pio_mode                write-only      0               255             w
>slow                    0               0               1               rw
>unmaskirq               0               0               1               rw
>using_dma               0               0               1               rw
>wcache                  0               0               1               rw
>
>ide-disk version 1.13
>physical     29104/16/63
>logical      1826/255/63
>QUANTUM FIREBALLlct10 15
>
>00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
>[Master])
>         Subsystem: Intel Corporation 82801AA IDE
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
><TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Region 4: I/O ports at f000 [size=16]
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

