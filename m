Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVHXIkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVHXIkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 04:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVHXIkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 04:40:23 -0400
Received: from [202.125.80.34] ([202.125.80.34]:53301 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1750748AbVHXIkW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 04:40:22 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: The Linux FAT issue on SD Cards.. maintainer support please
Date: Wed, 24 Aug 2005 14:03:16 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B03CB99@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The Linux FAT issue on SD Cards.. maintainer support please
Thread-Index: AcWkGTYhA/29mEB/RCiTQ1ztHJ88VQEbTRqA
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <hirofumi@mail.parknet.co.jp>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Lenneart,

One good news
I have implemented the partition support in the driver.
I am able to mount the partition of the individual device.
I partition them using the fdisk and mounted them.
The architecture this some thing like this
The whole device is represented by tfa0
And rest of the partitions by tfa0p1, tfa0p2 and so on...
If there is a device in second socket, the whole device is represented
by tfa1 and rest of the partitions by tfa1p1, tfa1p2 and so on... I am
following the above conventions. Is the is what in general all Linux
devices follow. 

I have four sockets on which I have to support individual device with
partitions on them. Is there a better conventional way to represent all
the four devices? My driver also supports 4 such controllers. To support
first socket device on the second controller I am using tfb0, tfb0p1,
tfb0p2...

I have left with handling lot of generalization in the code.

Regards,
Mukund Jampala


>-----Original Message-----
>From: Lennart Sorensen [mailto:lsorense@csclub.uwaterloo.ca]
>Sent: Thursday, August 18, 2005 10:57 PM
>To: Mukund JB`.
>Cc: hirofumi@mail.parknet.co.jp; linux-kernel-Mailing-list
>Subject: Re: The Linux FAT issue on SD Cards.. maintainer support
please
>
>On Thu, Aug 18, 2005 at 06:21:39PM +0530, Mukund JB`. wrote:
>> Dear all,
>>
>> I have few updates in this issue.
>> I have attached the Images as well as the mount-log to this mail.
>> Please see the comments inline.
>>
>> I think, fdisk it trying to portray that n/o cylinders 448. So, it
also
>> takes care of displaying the relevant n/o sector & NO more or NO
less.
>>
>> I have implemented the partition support in the driver but some HOW I
am
>> NOT able to get the driver working with all the sockets. It is just
>> working with the socket 0 and NO other socket.
>> I mean I am able to mount windows & linux formatted SD card with new
>> driver present from socket 0.
>>
>> I have an update on this.
>>
>> I found some common things between the windows formatted SD & Linux
>> formatted SD.
>> I found that both of then do NOT have the partition table.
>> I found that both of them have FAT12 FS in the sector 0 starting at
>> offset 0.
>> Why? I am NOT able to guess.
>
>If you don't use fdisk to create a partition on the card, then you
won't
>have one.  If you mkdosfs on /dev/tfa0 then you loose the partition
>table and get a filesystem on just the whole disk.  If you do it with
>/dev/tfa0p1 then you do it on the first partition which would then have
>the FAT filesystem starting at the offset of the first partition (as it
>should).
>
>> For Windows formatted SD there is NO partition table at all.
>> I went on more R&D and tried to get to format the USB-Thumb drive.
>> Even that did NOT have a partition table.
>> It looks like windows treats all removable media device as devices
with
>> NO partitions.
>
>That is right.  Although I believe if windows sees one with a partition
>table it will just use the first valid partition table entry it finds
>and ignore the rest.
>
>> Even on Linux formatted SD there is NO partition table present.
>>
>> Please have a look at the images I am attaching to this mail.
>> I have attached CAM-MS, WIN-Ms & Linux-MS first 512 byte length
Images.
>> These are the Images of first 512 bytes of sector 0.
>> You can find the FS there on Lin & Win Images.
>>
>> I have verified this by keeping some DEBUG messages in the FAT layer
&
>> seeing what data is being passed to this fat_boot_sector structure
when
>> mount call is issued.
>> I am also attaching those LOG messages. please Have a LOOK at them
too &
>> you will have a fair understanding.
>>
>> I have verified it with fdisk -l -u /dev/tfa0
>> It has shown that it is the partition 0 & nothing else.
>>
>> Please see the Images-All-MS-512.tar.gz.
>
>Well to mount anything without a partition table, you would mount the
>whole device (/dev/tfa0) and to mount one with a partition table on it,
>you would mount /dev/tfa0p1 or tfa0p4 or whichever partition it is.
>
>Zip drives used to be the same way.  Some were formated with 1
partition
>(usually 1 or 4) and some had no partition table at all and used the
>whole disk for the filesystem.  I always had a /zip and /zip4 mount
>point I used depending on the particular disk I was looking at.
>
>Len Sorensen
