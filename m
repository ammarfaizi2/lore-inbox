Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131981AbRCYNMh>; Sun, 25 Mar 2001 08:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRCYNM1>; Sun, 25 Mar 2001 08:12:27 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:23976 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S131981AbRCYNMW>; Sun, 25 Mar 2001 08:12:22 -0500
From: Wayne Pascoe <wayne@penguinpowered.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Remounting usb camera causes problems with copy of data
Date: 25 Mar 2001 14:09:04 +0100
Message-ID: <87ofuq0zdb.fsf@ford.penguinpowered.org.uk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found this problem (the hard way - through stupid data loss by not
checking things before erasing my memory stick) while on holiday. I
have been able to reproduce it using kernel 2.4.0 and kernel 2.4.2.

The camera is a Sony Cybershot DSC-F505. The laptop is a Sony Vaio
PCG-505G. 

I am using the usb-storage module to mount my camera as a filesystem
on the machine, then copying data off of the memory sticks. I have 2
16MB Memory sticks. I have also tried this with usb-storage compiled
into my kernel, not as a module, and in that case, once I umount
/camera and swap memory sticks, I can't remount it. It says something
to the effect of incorrect major or minor device number.

All the tests and the output below are using the usb-storage stuff as
a module.

When I power up the camera I get the following message :
Vendor: Sony      Model: DSC - F505      Rev: 1.06
  Type: Direct Access                 ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id0, lun 0
usb-uhci.c: interrupt, status 3, frame #184
usb-uhci.c: interrupt, status 3, frame #187
sda: test WP failed, assume Write Protected

When I mount it, I get the following output
maggie# mount /camera
mount: block device /dev/sda1 is write protected, mounting read-only
usb-uhci.c: interrupt, status 3, frame #35
usb-uhci.c: interrupt, status 3, frame #37

If I have 2 memory sticks with data on them and need to get the data
to my machine before clearing the memory sticks, this is the procedure
that I normally use :

Insert 1st memory stick
Power up camera
modprobe usb-storage
mount /dev/sda1 /camera
mkdir 1
cp /camera/dcim/100msdcf/* 1
umount /camera
mkdir 2
Swap memory sticks so that now the 2nd stick is in the camera, and
   power back on.
mount /dev/sda1 /camera
cp /camera/dcim/100msdcf/* 2
umount /camera

All of the pictures from the 1st memory stick copy fine. Their file
sizes match the sizes of the files on the memory stick.

The first 22 pictures of the 2nd memory stick copy fine. All files
after that (dsc00023.jpg - dsc000??.jpg) are empty files (0 bytes).

If I rmmod usb-storage, modprobe usb-storage and try again, it works
fine. _BUT_ I have to rmmod usb-storage before swapping sticks.

This is only really an inconvinience, and now that I know about it, I
can work around it, but I thought that someone should know in case
this is a bug.

Also, just out of curiosity, why does the Sony Cybershot mount
read-only? The Fujitsu finepix range all mount read-write, and writing
to the flash seems to work ok. Is this because the Cybershot is using
a non-standard interface?

TIA,

-- 
--Wayne--
I laugh in the face of danger...            | wayne@penguinpowered.org.uk
Then I run and hide until it goes away!     | www.penguinpowered.org.uk
