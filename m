Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275486AbRJFSlU>; Sat, 6 Oct 2001 14:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275504AbRJFSlL>; Sat, 6 Oct 2001 14:41:11 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:5508 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S275486AbRJFSkx>;
	Sat, 6 Oct 2001 14:40:53 -0400
Message-Id: <5.1.0.14.2.20011006193144.00ae90f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 06 Oct 2001 19:42:37 +0100
To: "John Fredrik Juell" <isi@efnet.no>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Dynamisc Disks under Linux..how..to?
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>If I haven't misunderstood completely, you can use the package at 
>http://linux-ntfs.sourceforge.net to read LDM information on spanned disks 
>under w2k/XP. What is not clear [to me anyways] is;

LDM is now part of the standard kernel, so you do not need to download 
anything from SF. (Unless you want/need the userspace utilities of course.)

>a) Is it possible to mount and read/extract the data on a 5-disk w2k 
>Dynamic Disks? In case, what commands do I use [commands, options, etc]?

Of course. Just configure your kernel with LDM partition support, 
recompile, install and boot into new kernel and the device (say it is 
/dev/hdc), will be as follows:

/dev/hdc1 = LDM database, you don't need to care about this

/dev/hdc5 = first data partition
/dev/hdc6 = second data partition
etc...

Note the order of partitions is not necessarily the same as in Windows 
because we take them in the order they appear in the database without any 
sorting. We left it for the future to decide on some kind of sorting as we 
haven't made up our minds what criteria to use for the sort yet.

Then to mount a partition (note you need to have NTFS driver configured in 
the kernel) you do:

mkdir /mnt/mynta
mount -t ntfs -o ro /dev/hdc5 /mnt/mynta

>b) Is there any difference between NTFS 3.0 and NTFS 3.1 in regards to 
>handling the file systems and/or commands?

No. The NTFS driver can read both fine. Writing is disallowed at the moment.

Best regards,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

