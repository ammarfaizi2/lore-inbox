Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVHEFtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVHEFtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 01:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVHEFtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 01:49:19 -0400
Received: from [202.125.86.130] ([202.125.86.130]:38018 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262864AbVHEFs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 01:48:57 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6 partition support driver methods 
Date: Fri, 5 Aug 2005 11:14:34 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <C349E772C72290419567CFD84C26E0170424F1@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6 partition support driver methods 
thread-index: AcWZAliHoi/nIX+3QpO/JvZU90XcfgABWXXg
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <corbet@lwn.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Corbet,

After loading my module that is partitioned supported & having defined a
single FAT partition with 

#mkfs -tvfat /dev/tfa0

sfdisk show the disk info as follows.
# sfdisk -l /dev/taf0 

Disk /dev/tfa0: 448 cylinders, 2 heads, 32 sectors/track
Units = cylinders of 32768 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/tfa0p1          0       -       0          0    0  Empty
/dev/tfa0p2          0       -       0          0    0  Empty
/dev/tfa0p3          0       -       0          0    0  Empty
/dev/tfa0p4          0       -       0          0    0  Empty

Dear Corbet,
Here are the details u might be interested in.
I have explained my physical node creation logic below.

#Cat/proc/partitions
major minor  #blocks  name

   3     0   78184008 hda
   3     1    6144831 hda1
   3     2   10241437 hda2
   3     3    1285200 hda3
   3     4          1 hda4
   3     5   10241406 hda5
 252     0      14336 tfa0

Can you just please explain me what can infer from the cat
/proc/partitions?
Do we expect all the 4 partitions to be show here?

My node creation method is simple

Kern code
---------
gDisk->gd = alloc_disk(4); /* 3 -> 3 partitions */
gDisk->gd->first_minor = (iSock * 4);

i.e. iSock = device no [0-3] ( 4 devices)


Physical nodes design
---------------------

To support partitions on device 0
--------------------------------- 
mknod /dev/tfa0 b 252 0
mknod /dev/tfa1 b 252 1
mknod /dev/tfa2 b 252 2
mknod /dev/tfa3 b 252 3

To support partitions on device 1
---------------------------------
mknod /dev/tfa4 b 252 4
mknod /dev/tfa5 b 252 5
mknod /dev/tfa6 b 252 6
mknod /dev/tfa7 b 252 7

To support partitions on device 2
---------------------------------
mknod /dev/tfa8 b 252 8
mknod /dev/tfa9 b 252 9
mknod /dev/tfa10 b 252 10
mknod /dev/tfa11 b 252 11

To support partitions on device 3
---------------------------------
mknod /dev/tfa12 b 252 12
mknod /dev/tfa13 b 252 13
mknod /dev/tfa14 b 252 14
mknod /dev/tfa15 b 252 15


Thanks & Regards,
Mukund Jampala



>-----Original Message-----
>From: corbet@lwn.net [mailto:corbet@lwn.net]
>Sent: Thursday, August 04, 2005 8:09 PM
>To: Mukund JB.
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: 2.6 partition support driver methods
>
>Mukund JB. <mukundjb@esntechnologies.co.in> wrote:
>
>> BUT, when a card is inserted in the socket 3, I am NOT able to mount
and
>> it says.
>> Mount: /dev/tfa12 is not a valid block device
>>
>> Can you convey me where exactly I am missing or why is it failing?
>
>First step would be to look in /proc/partitions (and the system
logfile)
>to get an idea of what the kernel thinks is there.  When you call
>add_disk(), the kernel should emit some messages noting the partitions
>that it sees.  My guess is a mismatch of minor numbers between your
>device nodes and what the kernel sees (it's hard for me to make
complete
>sense out of your minor number logic), but I could be wrong.
>
>jon
