Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271106AbRIOLPH>; Sat, 15 Sep 2001 07:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272240AbRIOLO4>; Sat, 15 Sep 2001 07:14:56 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:16812 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S271106AbRIOLOs>; Sat, 15 Sep 2001 07:14:48 -0400
Message-ID: <3BA33818.8030503@korseby.net>
Date: Sat, 15 Sep 2001 13:14:32 +0200
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext2fs corruption again
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

For about 3 weeks I sent a report that I've got very strange kernel error messages.

I changed my harddrive to IBM 75 GB because someone said that IBM's 40 GB
harddisks are not very stable.

Today I've got these from the kernel (with the new hd):

Sep 15 10:01:58 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4215
Sep 15 10:01:58 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4217
Sep 15 10:01:59 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4234
Sep 15 10:01:59 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4236
Sep 15 10:01:59 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4239
Sep 15 10:02:03 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4847
Sep 15 10:02:03 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4848
Sep 15 10:02:03 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4852
Sep 15 10:02:03 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4855
Sep 15 10:02:06 adlib kernel: EXT2-fs error (device ide0(3,5)): ext2_new_block:
Allocating block in system zone - block = 174
Sep 15 10:02:06 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: Freeing blocks in system zones - Block = 179, count = 3
Sep 15 10:02:09 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4839

Then I did an e2fsck on that device (hda5) and the errors occured after the
check (and a complete reboot) again:

Sep 15 10:10:38 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4163
Sep 15 10:10:38 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4166
Sep 15 10:10:38 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4131
Sep 15 10:10:38 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4132
Sep 15 10:10:38 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4155
Sep 15 10:10:38 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4156
Sep 15 10:10:38 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4157
Sep 15 10:10:38 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4161
Sep 15 10:10:38 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 4162
Sep 15 10:10:43 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 716
Sep 15 10:10:43 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 717
Sep 15 10:10:43 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 720
Sep 15 10:10:43 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 723
Sep 15 10:10:43 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 724
Sep 15 10:10:43 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 725
Sep 15 10:10:43 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 726
Sep 15 10:10:43 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: bit already cleared for block 727

I've written down all e2fsck messages by hand. ;-) And I compared them.

The following messages from e2fsck are always the same even on the old and on
the new hd. Here they are:

Duplicate/bad bock(s) in inode:  97: 643
Duplicate/bad bock(s) in inode: 100: 649
Duplicate/bad bock(s) in inode: 101: 650 651
Duplicate/bad bock(s) in inode: 102: 652
Duplicate/bad bock(s) in inode: 103: 653 656
Duplicate/bad bock(s) in inode: 104: 659 660
Duplicate/bad bock(s) in inode: 105: 661 662 663 664 665 666
Duplicate/bad bock(s) in inode: 106: 667 668
Duplicate/bad bock(s) in inode: 107: 669 671
Duplicate/bad bock(s) in inode: 108: 672 673 674
Duplicate/bad bock(s) in inode: 110: 678

Inodes 643-678 are always connected to faults.

The following files are always in connection with these errors:
/var/log/wtmp
/var/log/messages

The old hd was hda: IBM-DTLA-305040, ATA DISK drive. The new is: hda:
IBM-DTLA-307075, ATA DISK drive.

hdparm says:
    Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSFN9998
    Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
    RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
    BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=8
    CurCHS=17475/15/63, CurSects=-78446341, LBA=yes, LBAsects=150136560
    IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
    PIO modes: pio0 pio1 pio2 pio3 pio4
    DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2
    AdvancedPM=yes: disabled (255)
    Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5

I currently use linux 2.4.9 and e2fsprogs 1.23 and fileutils-4.1 and a modified
RedHat 6.2. These errors only occured with linux>=2.4.5-ac11.

I might say this is definitely an error with ext2 !

Kristian

·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                            :: http://www.korseby.net
                            :: http://www.tomlab.de
kristian@korseby.net ....::

