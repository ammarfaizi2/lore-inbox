Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282683AbRLBCOi>; Sat, 1 Dec 2001 21:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282681AbRLBCO1>; Sat, 1 Dec 2001 21:14:27 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:63127 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282675AbRLBCOS>; Sat, 1 Dec 2001 21:14:18 -0500
Message-Id: <5.1.0.14.2.20011202015029.00ae5360@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 02 Dec 2001 02:13:14 +0000
To: Andries.Brouwer@cwi.nl
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Cc: Andries.Brouwer@cwi.nl, adilger@turbolabs.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <UTC200112012243.WAA115170.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:43 01/12/01, Andries.Brouwer@cwi.nl wrote:
>     From: Anton Altaparmakov <aia21@cam.ac.uk>
>
>     > It will still break things.
>
>     Sure. I anticipated it would break things but then again it is
>     2.5.1-pre5 and not 2.4.x.
>
>True. But this is the reporting side of the block device stuff.
>And all is going to be changed. It is better to wait until the
>new situation has been established.

That is true.

>    >Adding such stuff to the kernel would be especially unfortunate if,
>     >as I did in my version of the block layer, the unit becomes byte
>     >instead of sector. We would have to change again.
>
>     So you are going to change it anyway at some point?
>
>Who am I? I have plans, but other people may have other plans,

Sorry, I meant: s/going/planning/

>and it is not me who decides.

True.

btw. You sent a patch to fsdevel some time ago converting parts of the 
kernel to use bytes instead of 1024 byte blocks. Have you got an 
updated/more complete version of that?

>    We could just make the changes at the same time in that case?
>     If it is in bytes even better. Just give start byte and length,
>
>But why not do it in user space?
>
># ./blockdev --report /dev/hda?
>RO    RA   SSZ   BSZ   StartSec     Size    Device
>rw     8   512  1024   16450560          2  /dev/hda1
>rw     8   512  1024          0          0  /dev/hda2
>rw     8   512  1024          0          0  /dev/hda3
>rw     8   512  1024         63   16450497  /dev/hda4
>rw     8   512  4096   16450623    4096512  /dev/hda5
>rw     8   512  4096   20547198   13108977  /dev/hda6
>rw     8   512  1024   33656238      80262  /dev/hda7
>rw     8   512  1024     481950    4209030  /dev/hda8
>rw     8   512  1024      64260     417690  /dev/hda9
>
>(util-linux-2.11n)

That's great! Thanks for the info.

>    And I agree with Andreas the partition type would be useful
>     in the display, too.
>
>I don't.
>
>This type is irrelevant. It would be very bad to make it available.
>People might start using it, and that can only cause problems.
>Moreover, usually there is no type, and in the future that I plan
>there will never be a type. If there is a type, *fdisk will tell you.

I am afraid I disagree. - Type is important when a partitioned device is 
being worked on. LDM for example needs to know the types in order to make 
sure not to take over a non-dynamic disk by mistake / to know that it is a 
dynamic disk.

MD RAID uses partition types for autodiscovery of raid partitions during boot.

And there might be other uses... For example IMHO it would make perfect 
sense to determine which fs to attempt to mount on a partition depending on 
its type.

>[We all have plans, and some of these will actually be implemented.
>In util-linux I already distribute for quite some time code that will
>do partition setup. That means that no partition code is required
>in the kernel. If 2.5 adds an initrd or so to the kernel, so that
>Linux boots in its own ramdisk, then all partition reading code
>can be thrown out of the kernel. That is one of my goals.
>User space comes and tells the kernel: on device /dev/hda,
>let hda7 be the interval of length 80262 sectors, starting at
>sector 33656238. It is possible today, but not many people
>use it. The plan is to make that the only way to get partitions.]

That sounds cool for normal partitions but how is handling of things like 
MD RAID and LDM going to be dealt with in that case?

I.e. where several different partitions have to be combined in various ways 
to give new devices? What are your thoughts on this? And do you have or are 
you aware of any code for these more advanced uses of partitioned devices?

(I will have a look at util-linux when I have some time.)

>    If it really is only a list of available devices why show the size in
>     blocks at all?
>
>History. It happened to be implemented like that.
>There were some reasons, but not very strong ones.

The usual answer in other words...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

