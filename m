Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWGKQDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWGKQDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWGKQDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:03:52 -0400
Received: from lucidpixels.com ([66.45.37.187]:9665 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751117AbWGKQDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:03:50 -0400
Date: Tue, 11 Jul 2006 12:03:46 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org, Neil Brown <neilb@suse.de>, xfs@oss.sgi.com
Subject: Raid5 Reshape Status + xfs_growfs = Success! (2.6.17.3)
Message-ID: <Pine.LNX.4.64.0607111159470.12230@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

It worked, echo'ing the 600 > to the stripe width in /sys, however, how 
come /dev/md3 says it is 0 MB when I type fdisk -l?

Is this normal?

Disk /dev/md0 doesn't contain a valid partition table

Disk /dev/md3: 0 MB, 0 bytes
2 heads, 4 sectors/track, 0 cylinders
Units = cylinders of 8 * 512 = 4096 bytes

Disk /dev/md3 doesn't contain a valid partition table

Disk /dev/md2: 71.9 GB, 71954661376 bytes
2 heads, 4 sectors/track, 17567056 cylinders
Units = cylinders of 8 * 512 = 4096 bytes

Furthermore, the xfs_growfs worked beautifully!

p34:~# df -h
/dev/md3              2.2T  487G  1.8T  22% /raid5
p34:~# xfs_growfs /raid5
meta-data=/dev/md3               isize=256    agcount=32, agsize=18314368 
blks
          =                       sectsz=4096  attr=0
data     =                       bsize=4096   blocks=586059776, imaxpct=25
          =                       sunit=128    swidth=768 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=32768, version=2
          =                       sectsz=4096  sunit=1 blks
realtime =none                   extsz=3145728 blocks=0, rtextents=0
data blocks changed from 586059776 to 683740288
p34:~# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/md3              2.6T  487G  2.1T  19% /raid5
p34:~# umount /raid5
p34:~# mount /raid5
p34:~# dmesg | tail -5
[4354159.367000]  disk 7, o:1, dev:sdc1
[4360850.548000] XFS mounting filesystem md3
[4360850.803000] Ending clean XFS mount for filesystem: md3
[4360868.121000] XFS mounting filesystem md3
[4360868.189000] Ending clean XFS mount for filesystem: md3

Very nice stuff.

Thanks Neil & XFS team for the information and help!

Justin.
