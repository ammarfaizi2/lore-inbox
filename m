Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291174AbSAaRgP>; Thu, 31 Jan 2002 12:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291177AbSAaRf5>; Thu, 31 Jan 2002 12:35:57 -0500
Received: from mail.little-ft.com ([63.215.255.3]:15371 "EHLO
	ltfsd01.little-ft.com") by vger.kernel.org with ESMTP
	id <S291178AbSAaRfp>; Thu, 31 Jan 2002 12:35:45 -0500
Message-ID: <B9F49C7F90DF6C4B82991BFA8E9D547B1256FB@BUFORD.littlefeet-inc.com>
From: Kris Urquhart <kurquhart@littlefeet-inc.com>
To: "'Alexander Viro'" <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: ext2/mount - multiple mounts corrupts inodes
Date: Thu, 31 Jan 2002 09:31:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alexander Viro [mailto:viro@math.psu.edu]
> Sent: Wednesday, January 30, 2002 9:05 PM
> 
> > + grep /mnt/hd
> > + cat /proc/mounts
> > /dev/hda3 /mnt/hd ext2 rw 0 0
> > + find /mnt/hd -ls
> >      2    1 drwxr-xr-x   3 root     root         1024 Dec 
> 31 15:17 /mnt/hd
> >     11   12 drwxr-xr-x   2 root     root        12288 Dec 31 15:17
> > /mnt/hd/lost+found
> > find: /mnt/hd/tar: Input/output error
> > find: /mnt/hd/zcat: Input/output error
> 
> WTF???  Very interesting...  What about kernel messages?  It 
> looks like
> stat(2) failing.

Yes, please see my recent reply to Andreas Dilger.

> Just in case - could you put the same find before the second 
> attempt of
> mount?
> 

+ find /mnt/hd -ls
     2    1 drwxr-xr-x   3 root     root         1024 Dec 31 23:42 /mnt/hd
    11   12 drwxr-xr-x   2 root     root        12288 Dec 31 23:42
/mnt/hd/lost+found
    12  149 -rwxr-xr-x   1 root     root       150796 Dec 31 23:42
/mnt/hd/tar
    13   52 -rwxr-xr-x   1 root     root        51228 Dec 31 23:42
/mnt/hd/zcat
+ mount -t ext2 /dev/hda3 /mnt/hd
mount: /dev/hda3 already mounted or /mnt/hd busy
mount: according to mtab, /dev/hda3 is already mounted on /mnt/hd
+ cat /proc/mounts
+ grep /mnt/hd
/dev/hda3 /mnt/hd ext2 rw 0 0
+ find /mnt/hd -ls
     2    1 drwxr-xr-x   3 root     root         1024 Dec 31 23:42 /mnt/hd
    11   12 drwxr-xr-x   2 root     root        12288 Dec 31 23:42
/mnt/hd/lost+found
find: /mnt/hd/tar: Input/output error
find: /mnt/hd/zcat: Input/output error

