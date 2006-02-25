Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWBYU3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWBYU3S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 15:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWBYU3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 15:29:18 -0500
Received: from tachyon.quantumlinux.com ([64.113.1.99]:16282 "EHLO
	tachyon.quantumlinux.com") by vger.kernel.org with ESMTP
	id S1161102AbWBYU3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 15:29:17 -0500
Date: Sat, 25 Feb 2006 12:28:57 -0800 (PST)
From: Chuck Wolber <chuckw@quantumlinux.com>
To: linux-kernel@vger.kernel.org
Subject: vt6410 Problems
Message-ID: <Pine.LNX.4.44.0602251207420.17015-100000@tachyon.quantumlinux.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

Using vanilla 2.6.15.4 on an ASUS P4P800, I have a Maxtor 4A250J0 attached
to the VT6410 IDE port. It shows up as /dev/hdf and no matter what I do,
the system believes it is being used and will not format or mount it.


Attempting to format the drive (regardless of partition size) gets:

root@bailey:/usr/src/linux# mke2fs -j /dev/hdf1
mke2fs 1.38 (30-Jun-2005)
/dev/hdf1 is apparently in use by the system; will not make a filesystem 
here!

(And yes, I have driven myself batty assuring myself that it is *NOT* in 
fact mounted.)


I can override the message and format it anyway with:

root@bailey:/usr/src/linux# mke2fs -j -F /dev/hdf1
mke2fs 1.38 (30-Jun-2005)
/dev/hdf1 is apparently in use by the system; mke2fs forced anyway.
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
2000 inodes, 8000 blocks
400 blocks (5.00%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
2000 inodes per group

Writing inode tables: done
Creating journal (1024 blocks): mke2fs: Device or resource busy
        while trying to create journal



But then when I dump the filesystem, I get:

root@bailey:/usr/src/linux# dumpe2fs /dev/hdf1
dumpe2fs 1.38 (30-Jun-2005)
dumpe2fs: Bad magic number in super-block while trying to open /dev/hdf1
Couldn't find valid filesystem superblock.


Clearly nothing was written to the drive...


The dmesg output is as follows:

[4294673.024000] VP_IDE: chipset revision 6
[4294673.024000] VP_IDE: VIA vt6410 (rev 06) IDE UDMA133 controller on 
pci0000:02:04.0
[4294673.024000] VP_IDE: 100% native mode on irq 19
[4294673.024000]     ide2: BM-DMA at 0xe400-0xe407, BIOS settings: 
hde:pio, hdf:pio
[4294673.024000]     ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: 
hdg:pio, hdh:pio
[4294673.024000] Probing IDE interface ide2...
[4294673.492000] hdf: Maxtor 4A250J0, ATA DISK drive
[4294673.543000] ide2 at 0xec00-0xec07,0xe882 on irq 19
[4294673.543000] hdf: max request size: 1024KiB
[4294673.554000] usb 1-1: new full speed USB device using uhci_hcd and 
address 4
[4294673.573000] hdf: 490234752 sectors (251000 MB) w/2048KiB Cache, 
CHS=30515/255/63, UDMA(133)
[4294673.573000] hdf: cache flushes supported
[4294673.573000]  hdf: hdf1
[4294673.576000] Probing IDE interface ide3...



The hdparm information on the drive is:

/dev/hdf:

ATA device, with non-removable media
        Model Number:       Maxtor 4A250J0
        Serial Number:      A809GX2E
        Firmware Revision:  RAMB1TV0
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  490234752
        device size with M = 1024*1024:      239372 MBytes
        device size with M = 1000*1000:      251000 MBytes (251 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific 
minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 192
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
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
           *    48-bit Address feature set
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
        Device num = 1 determined by the jumper
Checksum: correct




-- 
http://www.quantumlinux.com 
 Quantum Linux Laboratories, LLC.
 ACCELERATING Business with Open Technology

 "The measure of the restoration lies in the extent to which we apply 
  social values more noble than mere monetary profit." - FDR

