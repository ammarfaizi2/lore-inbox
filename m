Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291434AbSAaXw1>; Thu, 31 Jan 2002 18:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291435AbSAaXwM>; Thu, 31 Jan 2002 18:52:12 -0500
Received: from mail.littlefeet-inc.com ([63.215.255.3]:17415 "EHLO
	ltfsd01.little-ft.com") by vger.kernel.org with ESMTP
	id <S291434AbSAaXvH>; Thu, 31 Jan 2002 18:51:07 -0500
Message-ID: <B9F49C7F90DF6C4B82991BFA8E9D547B12570A@BUFORD.littlefeet-inc.com>
From: Kris Urquhart <kurquhart@littlefeet-inc.com>
To: "'Alexander Viro'" <viro@math.psu.edu>
Cc: "'Andreas Dilger'" <adilger@turbolabs.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: ext2/mount - multiple mounts corrupts inodes
Date: Thu, 31 Jan 2002 15:46:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alexander Viro [mailto:viro@math.psu.edu]
> Sent: Thursday, January 31, 2002 1:58 PM

> On Thu, 31 Jan 2002, Kris Urquhart wrote:
> 
> > Dec 31 23:42:41 jumptec kernel: VFS: Disk change detected on device
> > ide0(3,3)
> > Dec 31 23:42:41 jumptec kernel: VFS: Disk change detected on device
> > ide0(3,3)
> > Dec 31 23:42:41 jumptec kernel: invalidate: dirty buffer
> 
> I'd say...  Looks like a broken disk change check and everything after
> that is not a surprise.
> 
> What patches do you have applied and what chipset it is?
>

No patches - linux-2.4.17 right off of www.linux.org.  

The chipset is an ALI 1487/1489.  
The disk itself is a JUMPtec DISKchip with a SanDisk 20-99-00024-1 on it.

The relevant lines from dmesg are:
 Uniform Multi-Platform E-IDE driver Revision: 6.31
 ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
 hda: SunDisk SDTB-128, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: 31360 sectors (16 MB) w/1KiB Cache, CHS=490/2/32
 Partition check:
  hda: hda1 hda2 hda3

% cat /proc/ide/driver
ide-disk version 1.10

There is a CONFIG_BLK_DEV_ALI14XX, but apparently it only turns on 
support for the second channel.  I tried it anyway (along with the 
ide0=ali14xx boot parameter), but the disk was then not recognized 
at boot time (busy/timeout during partition check).  A google search 
did not turn up any problems with ali14xx.c since 2.0.

What else should I try?

Thanks.

-Kris



