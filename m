Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284952AbRLQBnl>; Sun, 16 Dec 2001 20:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284955AbRLQBnc>; Sun, 16 Dec 2001 20:43:32 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:29524 "EHLO
	tsmtp7.mail.isp") by vger.kernel.org with ESMTP id <S284952AbRLQBnY>;
	Sun, 16 Dec 2001 20:43:24 -0500
Date: Mon, 17 Dec 2001 02:45:29 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011217024529.E418@diego>
In-Reply-To: <20011217002350.D418@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011217002350.D418@diego>; from grundig@teleline.es on Mon, Dec 17, 2001 at 00:23:50 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Dec 16 17:40:40 diego kernel: vs-13070: reiserfs_read_inode2: i/o
> failure
> > occurred trying to find stat data of [4160 68669 0x0 SD]
> 
> It appears you have a broken harddrive. You can verify this with the
> "badblocks" program

As you said, i've tested the drive:

root@diego:~# badblocks -n -vv /dev/hdc5
attempt to access beyond end of device
16:05: rw=0, want=9671068, limit=9671067
967106456/  9671067
attempt to access beyond end of device
16:05: rw=0, want=9671068, limit=9671067
9671065
attempt to access beyond end of device
16:05: rw=0, want=9671068, limit=9671067
9671066
done
Pass completed, 3 bad blocks found.

This means it's broken?, affected partition is hdc5
Dec 16 16:54:41 diego kernel: hdc: 78165360 sectors (40021 MB) w/2048KiB
Cache, CHS=77545/16/63
Dec 16 16:54:41 diego kernel: Partition check:
Dec 16 16:54:41 diego kernel:  hdc: [DM6:DDO] [remap +63] [4865/255/63]
hdc1 < hdc5 hdc6 > hdc2

root@diego:~#  fdisk -lu /dev/hdc
Disk /dev/hdc: 255 heads, 63 sectors, 4865 cylinders
Units = sectors of 1 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1            63  19535039   9767488+   5  Extended
/dev/hdc2   *  19535040  40017914  10241437+  83  Linux
/dev/hdc5   *       126  19342259   9671067   83  Linux <---------
/dev/hdc6      19342323  19535039     96358+  82  Linux swap

root@diego:~# cat /proc/partitions
major minor  #blocks  name

  22     0   39082648 hdc
  22     1          1 hdc1
  22     2   10241437 hdc2
  22     5    9671067 hdc5 <-----------
  22     6      96358 hdc6
   3     0    2062368 hda
   3     1      42304 hda1
   3     2    2018016 hda2


This drive is a seagate UDMA 40 GB. My BIOS doesn't
support drives > 8'4 GB, I've to boot from an old 2 GB
seagate IDE drive. This old drive have bad sectors.(It was my fault).
When I used it, the bad blocks message was very different. Shouldn't the
bad block be reported by the IDE driver?. 


Can someone say me if this drive is really broken?. I've bought it a month
ago,
i could try to change it.

