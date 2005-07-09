Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVGIMch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVGIMch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 08:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVGIMcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 08:32:36 -0400
Received: from imap.gmx.net ([213.165.64.20]:43232 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261254AbVGIMcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 08:32:36 -0400
X-Authenticated: #6553809
Message-ID: <42CFC3EF.2090804@gmx.net>
Date: Sat, 09 Jul 2005 14:32:47 +0200
From: Thomas Heinz <thomasheinz@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI DVD-RAM partitions
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My SCSI DVD-RAM is available as /dev/sr1. fdisk -l /dev/sr1 shows
for a certain medium:

Note: sector size is 2048 (not 512)

Disk /dev/sr1: 2496 MB, 2496430080 bytes
255 heads, 63 sectors/track, 75 cylinders
Units = cylinders of 16065 * 2048 = 32901120 bytes

     Device Boot      Start         End      Blocks   Id  System
/dev/sr1p1   *           1          75     2409624    b  W95 FAT32


Note that /dev/sr1p1 does not exist. Neither does /dev/sdX.

Mounting /dev/sr1 does not work. However, I was able to mount the
partition with the following "trick":
# losetup -o 129024 /dev/loop0 /dev/sr1
# mount /dev/loop0 /mnt

Is it possible to make the DVD-RAM partitions available as device
nodes (or at least directly mountable without the losetup hack)?
One solution would be to make the device available as /dev/sdX and
/dev/srX. Is that possible?

Thanks for your help. If this is a known issue, I would appreciate
a pointer on that topic.


Here is some more information about my system:

Linux version 2.6.11-gentoo-r9 (root@localhost) (gcc version 
3.3.5-20050130 (Gentoo Hardened 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, 
pie-8.7.7.1))

Host: scsi0 Channel: 00 Id: 04 Lun: 00
   Vendor: MATSHITA Model: PD-2 LF-D100     Rev: A113
   Type:   CD-ROM                           ANSI SCSI revision: 02


Regards,

Thomas
