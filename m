Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRKMPpe>; Tue, 13 Nov 2001 10:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRKMPpY>; Tue, 13 Nov 2001 10:45:24 -0500
Received: from NO-SPAM.it.helsinki.fi ([128.214.205.34]:8936 "EHLO
	no-spam.it.helsinki.fi") by vger.kernel.org with ESMTP
	id <S273261AbRKMPpN>; Tue, 13 Nov 2001 10:45:13 -0500
Subject: [Probably OT] Re: Odd partition overlapping problem
From: Robert Holmberg <robert.holmberg@helsinki.fi>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011113095524.1544A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1011113095524.1544A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 13 Nov 2001 17:48:45 -0500
Message-Id: <1005691726.2007.0.camel@localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-13 at 10:08, Richard B. Johnson wrote:
> >    Device Boot    Start       End    Blocks   Id  System
> > /dev/hda1   *         1       523   4200966    c  Win95 FAT32 (LBA)
> > /dev/hda2           524       525     16065   83  Linux
> > /dev/hda3           526      2647  17044965   83  Linux
> > /dev/hda4          2648      3736   8747392+   5  Extended
> > /dev/hda5          2648      2713    530113+  82  Linux swap
> > /dev/hda6          2714      3736   8217216    c  Win95 FAT32 (LBA)
> The extended partition goes from 2648 to 3736. The first part of
> this extended partition from 2648 to 2713 is swap. The second part
> of 2714 to 3736 is the FAT32 partition. It looks as though M$ tries
> to use the swap area, ignoring the 82 code for Linux swap. This
> may be why the M$ partition gets trashed. To test this theory,
> disable swap on this drive (comment it out in /etc/fstab). Re-do
> the M$ partition and see if it remains clean. If it remains
> clean, then do a `mkswap` from Linux. Reboot to M$ and verify that
> the last partition is now corrupt. This will show that M$ is
> trying to use the swap area. If it is, re-fdisk the extended
> partition to put Linux swap at the end instead of the beginning.

Yes, well, the problem is more serious than that, since formatting the
windows partition will write unwanted stuff to my main linux partition
as well. This partition is 17GB, but less than 3GB is used. Unless
reiserfs writes stuff all over the place, there shouldn't be data
anywhere near the end of this partition. 

Anyway, I don't want to kill off random files on my linux partition if
there is some other way to test this.

BTW, sfdisk -l -x /dev/hda says:

Disk /dev/hda: 3736 cylinders, 255 heads, 63 sectors/track
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from
0

   Device Boot Start     End   #cyls   #blocks   Id  System
/dev/hda1   *      0+    522     523-  4200966    c  Win95 FAT32 (LBA)
/dev/hda2        523     524       2     16065   83  Linux
/dev/hda3        525    2646    2122  17044965   83  Linux
/dev/hda4       2647    3735    1089   8747392+   5  Extended

/dev/hda5       2647+   2712      66-   530113+  82  Linux swap
    -           2713    3735    1023   8217247+   5  Extended
    -           2647    2646       0         0    0  Empty
    -           2647    2646       0         0    0  Empty

/dev/hda6       2713+   3735    1023-  8217216    c  Win95 FAT32 (LBA)
    -           2713    2712       0         0    0  Empty
    -           2713    2712       0         0    0  Empty
    -           2713    2712       0         0    0  Empty

cc to me, I'm not on the list.

Robert

