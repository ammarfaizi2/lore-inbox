Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131750AbRCUTaR>; Wed, 21 Mar 2001 14:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131762AbRCUTaJ>; Wed, 21 Mar 2001 14:30:09 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:25868
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131750AbRCUT3z>; Wed, 21 Mar 2001 14:29:55 -0500
Date: Wed, 21 Mar 2001 11:29:00 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010321095533Z131410-407+1932@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10103211000370.29537-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Geoff,

Thanks Mark for doing a great job while I was doing other stuff.

On Wed, 21 Mar 2001 quintaq@yahoo.co.uk wrote:

> The result of hdparm -tT /dev/hda was, however, exactly the same as
> before (ie circa 15 MB/sec.  The results for /dev/hda7 remain at about
> 30 MB/sec.

You may get a burst because of caching prefetch or predictive readahead,
but that is artifical; however, in your case the root directory begins 25%
in the drive.

/sbin/hdparm -t /dev/hda2 /dev/hda5 /dev/hda6 /dev/hda7 /dev/hda8 /dev/hda9 /dev/hda10
/dev/hda2:
 Timing buffered disk reads:  64 MB in  1.80 seconds = 35.56 MB/sec
/dev/hda5:
 Timing buffered disk reads:  64 MB in  1.85 seconds = 34.59 MB/sec
/dev/hda6:
 Timing buffered disk reads:  64 MB in  1.90 seconds = 33.68 MB/sec
/dev/hda7:
 Timing buffered disk reads:  64 MB in  1.95 seconds = 32.82 MB/sec
/dev/hda8:
 Timing buffered disk reads:  64 MB in  1.95 seconds = 32.82 MB/sec
/dev/hda9:
 Timing buffered disk reads:  64 MB in  2.13 seconds = 30.05 MB/sec
/dev/hda10:
 Timing buffered disk reads:  64 MB in  2.13 seconds = 30.05 MB/sec

Disk /dev/hda: 255 heads, 63 sectors, 3737 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1         7     56196   83  Linux
/dev/hda2             8       269   2104515   83  Linux
/dev/hda3           270      3737  27856710    5  Extended
/dev/hda5           270       661   3148708+  83  Linux
/dev/hda6           662       923   2104483+  83  Linux
/dev/hda7           924      1119   1574338+  83  Linux
/dev/hda8          1120      1642   4200966   83  Linux
/dev/hda9          1643      1773   1052226   83  Linux
/dev/hda10         1774      3737  15775798+  83  Linux


> Further, even though the relevant line was commented out of fstab, I
> could still perform hdparm -tT /dev/hda1 (giving the usual 15 MB/sec).
> I suppose that this is because fdisk still showed :
> 
> Disk /dev/hda: 255 heads, 63 sectors, 3737 cylinders
> Units = cylinders of 16065 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hda1   *         1       932   7486258+   b  Win95 FAT32
> /dev/hda2           933      3737  22531162+   5  Extended
> /dev/hda5           933       935     24066   83  Linux
> /dev/hda6           936       952    136521   82  Linux swap
> /dev/hda7           953      3737  22370481   83  Linux

First you have the faster portion of the drive using a lame OS, so do not
expect Linux to perform if you put it on the slowest portions of the
device.

> On the other hand, am I correct in interpreting the bonnie output for
> the block read (included in my earlier post), of 20937 KB/sec as
> reasonably healthy for my DTLA (ie consistent with hdparm's 30 MB/sec),
> when performing more realistic tasks on the linux filesystem ?

Yes if you adjust for ZONES.

[root@via DiskPerf-1.0.3]# ./DiskPerf /dev/hda
Device: IBM-DTLA-307030 Serial Number: YKDYKM37674
LBA 0 DMA Read Test                      = 56.53 MB/Sec (4.42 Seconds)
Outer Diameter Sequential DMA Read Test  = 35.47 MB/Sec (7.05 Seconds)
Inner Diameter Sequential DMA Read Test  = 17.74 MB/Sec (14.09 Seconds)

As you can clearly see a single sector v/s outer v/s inner zones produce
different transfer throughputs.

> Regards,
> 
> Geoff

Andre Hedrick
Linux ATA Development


