Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284964AbRLQB5V>; Sun, 16 Dec 2001 20:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284965AbRLQB5M>; Sun, 16 Dec 2001 20:57:12 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:41537 "EHLO
	tsmtp2.mail.isp") by vger.kernel.org with ESMTP id <S284963AbRLQB4y>;
	Sun, 16 Dec 2001 20:56:54 -0500
Date: Mon, 17 Dec 2001 02:58:56 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011217025856.A1649@diego>
In-Reply-To: <20011216184836.A418@diego> <20011216211208.D5226@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011216211208.D5226@vestdata.no>; from kernel@ragnark.vestdata.no on Sun, Dec 16, 2001 at 21:12:08 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Dec 2001 21:12:08 Ragnar Kjørstad wrote:
> On Sun, Dec 16, 2001 at 06:48:36PM +0100, Diego Calleja wrote:
> > Dec 16 17:40:40 diego kernel: vs-13070: reiserfs_read_inode2: i/o
> failure
> > occurred trying to find stat data of [4160 68669 0x0 SD]
> 
> It appears you have a broken harddrive. You can verify this with the
> "badblocks" program

badblocks -n (non-destructive write-test) -vv /dev/hdc5
results in:
attempt to access beyond end of device
16:05: rw=0, want=9671068, limit=9671067
attempt to access beyond end of device
16:05: rw=0, want=9671068, limit=9671067
attempt to access beyond end of device
16:05: rw=0, want=9671068, limit=9671067
3 bad blocks found

This means it's broken? 
More info: (hdc5 is the drive):

Dec 16 17:48:12 diego kernel: hdc: 78165360 sectors (40021 MB) w/2048KiB
Cache, CHS=77545/16/63
Dec 16 17:48:12 diego kernel: Partition check:
Dec 16 17:48:12 diego kernel:  hdc: [DM6:DDO] [remap +63] [4865/255/63]
hdc1 < hdc5 hdc6 > hdc2

cat /proc/partitions:
major minor  #blocks  name

  22     0   39082648 hdc
  22     1          1 hdc1
  22     2   10241437 hdc2
  22     5    9671067 hdc5
  22     6      96358 hdc6

fdisk -lu /dev/hdc:
Disk /dev/hdc: 255 heads, 63 sectors, 4865 cylinders
Units = sectors of 1 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1            63  19535039   9767488+   5  Extended
/dev/hdc2   *  19535040  40017914  10241437+  83  Linux
/dev/hdc5   *       126  19342259   9671067   83  Linux
/dev/hdc6      19342323  19535039     96358+  82  Linux swap


The drive is a seagate 40 GB UDMA 100, the bios doesn't support drives >
8'4 GB,
I've to boot from a seagate 2 GB drive, which have real bad-blocks.(IT was
my fault).
And when I used it with linux, the error messages were very different (and
they are different today).
Those messages doesn't appears here. I don't think it's broken.
If someone can confirm that it's broken, please mail me. I bought it a
month ago and I can change it.

> 
> 
> -- 
> Ragnar Kjørstad
> Big Storage
> 


