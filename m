Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbRDTXqG>; Fri, 20 Apr 2001 19:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132121AbRDTXp4>; Fri, 20 Apr 2001 19:45:56 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:31890 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132044AbRDTXps>; Fri, 20 Apr 2001 19:45:48 -0400
Message-Id: <5.0.2.1.2.20010421003159.04a028f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sat, 21 Apr 2001 00:48:11 +0100
To: Wayne.Brown@altec.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Current status of NTFS support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:08 20/04/2001, Wayne.Brown@altec.com wrote:
>Where does write support for NTFS stand at the moment?  I noticed that 
>it's still marked "Dangerous" in the kernel configuration.

It is extremely dangerous. Never use unless you are desperate. It creates 
corrupt files and especially directories. It also cannot delete at all (not 
implemented). - If you do write you have to run ntfsfix utility on the 
partition after umount before rebooting into Windows which will let chkdsk 
run on next reboot which should fix all problems created by the driver. - 
ntfsfix is part of the Linux-NTFS project. You can download the 
source/source rpm or pre-compiled rpm from 
http://sourceforge.net/projects/linux-ntfs/

>This is important to me because it looks like I'll have to start using it 
>next week. My office laptop is going to be "upgraded" from Windows 98 to 2000.

Forget it. Windows 2000 NTFS is supported only read-only. The driver will 
refuse to mount read-write (unless you are using an out of date kernel in 
which case it will probably just destroy your partition!). I strongly 
suggest to use kernel 2.4.4-pre5 at least or a 2.4.x-acXYZ kernel (at least 
2.4.2-ac something IIRC) as these kernels contain many important fixes.

>Of course, I hardly ever boot into Windows any more since installing a 
>Linux partition last year.  But our corporate email standard forces me to 
>use Lotus Notes, which I run under Wine.   The Notes executables and 
>databases are installed on my Windows partition.  The upgrade, though, 
>will involve wiping the hard drive, allocating
>the whole drive to a single NTFS partition, and reinstalling Notes after 
>installing Windows 2000 .  That means bye-bye FAT32 partition and hello 
>NTFS.  I can't mount it read-only because I'll still have to update my 
>Notes databases from Linux.  So how risky is this?

Simple answer: you can't. 100% data loss is unfortunately guaranteed if you 
start using it like this, maybe not in one day, maybe not in two but 
eventually you will try to boot into Windows and find it doesn't exist any 
more...

>Also, I'll have to recreate my Linux partitions after the upgrade.  Does 
>anyone know if FIPS can split a partition safely that was created under 
>Windows 2000/NT?  It worked fine for Windows 98, but I'm a little worried 
>about what might happen if I try to use it on an NTFS partition.

It can't. You need to buy Partition Magic or similar utility to do this. 
There is AFAIK no free NTFS resizer available (yet!).

The best solution for you is to ask really kindly (by them a beer?) to have 
your laptop installed with one partition which doesn't fill your entire 
disk (i.e. just ask them to make the partition whatever size you want) and 
to use the FAT-32 filesystem instead of NTFS. Windows 2000 is quite happy 
to do both of these. You could even save them the trouble and do the 
partitioning and formatting for them and just ask them to install Windows 
2000 on your C: drive using FAT-32. Then pray they will oblige. Otherwise 
you will have to spend some money on partition magic I am afraid (or 
equivalent obviously).

If you go for the repartition yourself approach you should be able to keep 
your current linux install. You can use GNU parted to resize you Linux 
partitions so you have enough space for Win2k (find it on 
ftp.gnu.org/gnu/parted/).

Hope this helps,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

