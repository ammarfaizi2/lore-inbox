Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311247AbSCMUbl>; Wed, 13 Mar 2002 15:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311308AbSCMUbc>; Wed, 13 Mar 2002 15:31:32 -0500
Received: from [208.48.139.185] ([208.48.139.185]:44524 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S311247AbSCMUbU>; Wed, 13 Mar 2002 15:31:20 -0500
Date: Wed, 13 Mar 2002 12:31:14 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: mke2fs (and mkreiserfs) core dumps
Message-ID: <20020313123114.A11658@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got an interesting situation here where mke2fs and mkreiserfs core dump
with the message: File size limit exceeded (core dumped)

I recently upgraded the storage device in this machine from a single IDE
disk to a mirrored RAID running off a 3ware controller.

The disk was living off the primary controller as hda, I have since moved it
to hdc and the cdrom to hda.

The kernel is 2.4.18-rc4 + Trond's NFS_ALL patch.

Some info:

# fdisk -l /dev/hdc

Disk /dev/hdc: 255 heads, 63 sectors, 4982 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1             1       638   5124703+  83  Linux
/dev/hdc2           639      4982  34893180   83  Linux
# cat /proc/partitions
major minor  #blocks  name

   8     0   97684760 sda
   8     1      16033 sda1
   8     2    1052257 sda2
   8     3   40965750 sda3
   8     4   55649160 sda4
  22     0   40020624 hdc
  22     1    5124703 hdc1
  22     2   34893180 hdc2
# mke2fs /dev/hdc1
mke2fs 1.25 (20-Sep-2001)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
641280 inodes, 1281175 blocks
64058 blocks (5.00%) reserved for the super user
First data block=0
40 block groups
32768 blocks per group, 32768 fragments per group
16032 inodes per group
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736

File size limit exceeded (core dumped)
#

>From dmesg:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
hdc: Maxtor 54098U8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=79406/16/63, UDMA(66)
hda: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)


Anyone have any ideas?  Could it be a bios setting?

Thanks,
Dave
