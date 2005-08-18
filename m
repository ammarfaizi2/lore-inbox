Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVHRR0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVHRR0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVHRR0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:26:55 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:1951 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932325AbVHRR0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:26:54 -0400
Date: Thu, 18 Aug 2005 13:26:53 -0400
To: "Mukund JB`." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050818172653.GV6714@csclub.uwaterloo.ca>
References: <3AEC1E10243A314391FE9C01CD65429B3886@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B3886@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 06:21:39PM +0530, Mukund JB`. wrote:
> Dear all,
> 
> I have few updates in this issue.
> I have attached the Images as well as the mount-log to this mail.
> Please see the comments inline.
> 
> I think, fdisk it trying to portray that n/o cylinders 448. So, it also
> takes care of displaying the relevant n/o sector & NO more or NO less.
> 
> I have implemented the partition support in the driver but some HOW I am
> NOT able to get the driver working with all the sockets. It is just
> working with the socket 0 and NO other socket. 
> I mean I am able to mount windows & linux formatted SD card with new
> driver present from socket 0.
> 
> I have an update on this.
> 
> I found some common things between the windows formatted SD & Linux
> formatted SD.
> I found that both of then do NOT have the partition table.
> I found that both of them have FAT12 FS in the sector 0 starting at
> offset 0.
> Why? I am NOT able to guess.

If you don't use fdisk to create a partition on the card, then you won't
have one.  If you mkdosfs on /dev/tfa0 then you loose the partition
table and get a filesystem on just the whole disk.  If you do it with
/dev/tfa0p1 then you do it on the first partition which would then have
the FAT filesystem starting at the offset of the first partition (as it
should).

> For Windows formatted SD there is NO partition table at all.
> I went on more R&D and tried to get to format the USB-Thumb drive.
> Even that did NOT have a partition table. 
> It looks like windows treats all removable media device as devices with
> NO partitions.

That is right.  Although I believe if windows sees one with a partition
table it will just use the first valid partition table entry it finds
and ignore the rest.

> Even on Linux formatted SD there is NO partition table present.
> 
> Please have a look at the images I am attaching to this mail.
> I have attached CAM-MS, WIN-Ms & Linux-MS first 512 byte length Images.
> These are the Images of first 512 bytes of sector 0.
> You can find the FS there on Lin & Win Images.
> 
> I have verified this by keeping some DEBUG messages in the FAT layer &
> seeing what data is being passed to this fat_boot_sector structure when
> mount call is issued.
> I am also attaching those LOG messages. please Have a LOOK at them too &
> you will have a fair understanding.
> 
> I have verified it with fdisk -l -u /dev/tfa0 
> It has shown that it is the partition 0 & nothing else.
> 
> Please see the Images-All-MS-512.tar.gz.

Well to mount anything without a partition table, you would mount the
whole device (/dev/tfa0) and to mount one with a partition table on it,
you would mount /dev/tfa0p1 or tfa0p4 or whichever partition it is.

Zip drives used to be the same way.  Some were formated with 1 partition
(usually 1 or 4) and some had no partition table at all and used the
whole disk for the filesystem.  I always had a /zip and /zip4 mount
point I used depending on the particular disk I was looking at.

Len Sorensen
