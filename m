Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVHWNF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVHWNF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVHWNF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:05:29 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:54227 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750728AbVHWNF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:05:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N9VpGI1TS8W3l1VmjXIjLmK/m54Qe/okY0UbgVCvNEov3p7kaPOy9c1ZtvU6WOIWU8zeCaU8iEmnZEqsupNFzENXAKF3gID6UpH9T+7IdM1mGkvNizR0y2OQGgnar5Dkt6tnJ1N6u6VjOg8nLpJUzngvxEs17MhwmpXMX1gWQGA=
Message-ID: <68cb949d05082306051b39e317@mail.gmail.com>
Date: Tue, 23 Aug 2005 09:05:27 -0400
From: Jess Balint <jbalint@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Ext3 Errors on Dell RAID
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
I get massive ext3 errors once every few days. See "errors on console"
section below. Almost all commands return I/O error. I have to power
cycle the machine to get it running again. Upon reboot, there are
usually 3 orphan inodes deleted and everything is fine. See "messages
on reboot" below.

Configuration:
System: Dell PowerEdge 6300/500, 4 CPU SMP w/2GB memory
Discs: 3 SCSI discs in a controller-managed striped configuration
Controller: Dell PERC-2
kernel messages in "kernel boot messages" below

Other:
I had this problem before. I upgrade the card firmware to 2.8/build
6809, but still the same issue. I tried with the 2.4.29 kernel
(aacraid driver v 1.1-3) from the Slackware (10?) distribution and
then I upgraded to 2.4.31. It has the same driver version and same
problem. Running fsck always shows everything is fine (rc=0).

Does anybody have experience with this machine working well? If so,
what combination of kernel and firmware version?

Or does anybody know the root cause of the occasional massive ext3
errors or what I can do to test and/or fix it?

Please cc me jbalint-at-gmail as I am not on the list.
Thanks.
Jess

--------------------------------------------------
--------------------------------------------------
errors on console
--------------------------------------------------
--------------------------------------------------
EXT3-fs error (device sd(8,2)) in ext3_reserve_inode_write: IO failure
EXT3-fs error (device sd(8,2)) in ext3_orphan_add: IO failure
EXT3-fs error (device sd(8,2)): ext3_get_inode_loc: unable to read
inode block - inode=1015869, block=1015811
EXT3-fs error (device sd(8,2)) in ext3_reserve_inode_write: IO failure
EXT3-fs error (device sd(8,2)): ext3_get_inode_loc: unable to read
inode block - inode=1015869, block=1015811
EXT3-fs error (device sd(8,2)) in ext3_reserve_inode_write: IO failure
EXT3-fs error (device sd(8,2)) in ext3_orphan_add: IO failure
EXT3-fs error (device sd(8,2)): ext3_get_inode_loc: unable to read
inode block - inode=1213811, block=1212461
EXT3-fs error (device sd(8,2)) in ext3_reserve_inode_write: IO failure
EXT3-fs error (device sd(8,2)) in ext3_new_inode: IO failure

--------------------------------------------------
--------------------------------------------------
messages on reboot
--------------------------------------------------
--------------------------------------------------
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sd(8,2): orphan cleanup on readonly fs
EXT3-fs: sd(8,2): 3 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.

--------------------------------------------------
--------------------------------------------------
kernel boot messages
--------------------------------------------------
--------------------------------------------------
SCSI subsystem driver Revision: 1.00
Red Hat/Adaptec aacraid driver (1.1-3 Aug 16 2005 17:25:05)
AAC0: kernel 2.8.4 build 6089
AAC0: monitor 2.8.4 build 6089
AAC0: bios 2.8.0 build 6089
AAC0: serial 4c72e2fafaf001
scsi0 : percraid
  Vendor: DELL      Model: rootvg            Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi3 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7860 Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

blk: queue f7aaca18, I/O limit 4095Mb (mask 0xffffffff)
(scsi3:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: NEC       Model: CD-ROM DRIVE:465  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f7aac818, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 213274368 512-byte hdwr sectors (109196 MB)
Partition check:
 sda: sda1 sda2
Attached scsi CD-ROM sr0 at scsi3, channel 0, id 5, lun 0
sr0: scsi3-mmc drive: 14x/32x cd/rw xa/form2 cdda tray
