Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVJQTYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVJQTYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVJQTYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:24:06 -0400
Received: from mail.velocity.net ([66.211.211.55]:38017 "EHLO
	mail.velocity.net") by vger.kernel.org with ESMTP id S1751128AbVJQTYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:24:05 -0400
X-AV-Checked: Mon Oct 17 15:24:04 2005 clean
Subject: scsi disk size reporting in dmesg
From: Dale Blount <linux-kernel@dale.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 17 Oct 2005 15:24:04 -0400
Message-Id: <1129577044.17327.11.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just added 2 external 1TB+ scsi devices to my i686 linux server
running 2.6.13.4 connected to external LSI MPT card.  fdisk and df both
show the sizes correctly (see below), but I'm worried that dmesg reports
them incorrectly.

SCSI device sda: 2460934144 512-byte hdwr sectors (160487 MB)
SCSI device sdb: 3790438400 512-byte hdwr sectors (841193 MB)

I don't think it's as simple as a variable overflow because both
sdkp->capacity and mb look to be cast as unsigned long longs.  I know a
workaround is to present less data per LUN, but I'd like to use it as
it's setup currently if possible.  Is this just printing incorrectly or
will I run into trouble when the device gets more full?


Thanks, 

Dale




# df -h
/dev/sda1             1.2T  129M  1.1T   1% /mnt/sda1
/dev/sdb1             1.8T  129M  1.7T   1% /mnt/sdb1
# df
/dev/sda1            1211159084    131228 1149504532   1% /mnt/sda1
/dev/sdb1            1865473692    131228 1770581860   1% /mnt/sdb1


# fdisk -l /dev/sda
Disk /dev/sda: 1259.9 GB, 1259998281728 bytes
255 heads, 63 sectors/track, 153186 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1      153186  1230466513+  83  Linux

# fdisk -l /dev/sdb

Disk /dev/sdb: 1940.7 GB, 1940704460800 bytes
255 heads, 63 sectors/track, 235943 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1      235943  1895212116   83  Linux




