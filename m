Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVHEGFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVHEGFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVHEGFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:05:03 -0400
Received: from [202.125.86.130] ([202.125.86.130]:55170 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262865AbVHEGFB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:05:01 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: HOW to handle partitions on SD Card in the driver?
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 5 Aug 2005 11:30:43 +0530
Message-ID: <C349E772C72290419567CFD84C26E0170424F4@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HOW to handle partitions on SD Card in the driver?
thread-index: AcWZgwPmyi5V//GxRUaP/TGs+WZ30g==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I have problem with my new driver that tired to support the partitions
support on SD cards.

My driver supports 4 SD cards at a time. 
The driver works well when there are partitions are disabled. i.e. when
alloc_disk(1); - i.e. no partitions. It absolutely fine.

Right now, I am working on getting the driver up with partitions
supported. After making below changes in the gendisk initialization, I
am able to mount the device in the socket 0 but I am NOT able mount the
devices in the rest of the sockets when partitions are enabled?

Changes made in gendisk code
----------------------------
gDisk->gd = alloc_disk(4); /* 3 -> 3 partitions */
gDisk->gd->first_minor = (iSock * 4);

i.e. iSock = device no [0-3] ( 4 devices)

Physical nodes creation
------------------------

To support partitions on device 0
--------------------------------- 

mknod /dev/tfa0 b 252 0 ; mknod /dev/tfa1 b 252 1
mknod /dev/tfa2 b 252 2 ; mknod /dev/tfa3 b 252 3

To support partitions on device 1
---------------------------------

mknod /dev/tfa4 b 252 4 ; mknod /dev/tfa5 b 252 5
mknod /dev/tfa6 b 252 6 ; mknod /dev/tfa7 b 252 7

To support partitions on device 2
---------------------------------

mknod /dev/tfa8 b 252 8 ; mknod /dev/tfa9 b 252 9
mknod /dev/tfa10 b 252 10 ; mknod /dev/tfa11 b 252 11

To support partitions on device 3
---------------------------------

mknod /dev/tfa12 b 252 12 ; mknod /dev/tfa13 b 252 13
mknod /dev/tfa14 b 252 14 ; mknod /dev/tfa15 b 252 15


With these physical nodes, I thought I am through & it should work.
When a card is inserted in the socket 0, I am able to mount.
#mount /dev/tfa0 /mnt (works fine & mounts)

BUT, when a card is inserted in the socket 3, I am NOT able to mount.
#mount /dev/tfa12 /mnt
Mount: /dev/tfa12 is not a valid block device

 
However, 
I am in bit confusion whether the above mentioned changes to the gendisk
code will suffice to my partition requirement or NOT?

This gendisk is invoked at on every socket initialization i.e. when card
is inserted.

Can anyone convey me where exactly I am missing or why is it failing?
Any suggestion will be greatly helpful?

Thanks & Regards,
Mukund Jampala


