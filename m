Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267979AbRGVOIQ>; Sun, 22 Jul 2001 10:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267980AbRGVOIG>; Sun, 22 Jul 2001 10:08:06 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:60687 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S267979AbRGVOID>; Sun, 22 Jul 2001 10:08:03 -0400
To: Detlev Offenbach <detlev@offenbach.fs.uunet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO-Drive under 2.4.7 usinf vfat
In-Reply-To: <01072115265800.02284@majestix>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 22 Jul 2001 23:07:29 +0900
In-Reply-To: <01072115265800.02284@majestix>
Message-ID: <87g0bpoy5a.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

Detlev Offenbach <detlev@offenbach.fs.uunet.de> writes:

> Hi all,
> 
> I have just tested the new 2.4.7 kernel to see, whether it now works with a 
> MO-Drive using the vfat filesystem. Unfortunately it still doesn't. Mounting 
> a disk and writing to it is ok. However, when I try to read a file off the 
> disk, the program crashes with a Segmentation fault and I get a oops in the 
> messages file (see attachment). I tried ksymoops on this file, but either I 
> did something wrong or it couldn't analyse it.

Is the capacity of your MO disk more than 640M?
In order to clarify a problem, please send the debugging output of FAT.

---------------------- start example --------------------------------
 $ mount -t vfat /dev/sda /mnt -o debug
 $ dmesg | tail
  Type:   Optical Device                     ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 5, lun 0
sym53c875-0-<5,*>: asynchronous.
SCSI device sda: 310352 2048-byte hdwr sectors (636 MB)
sda: Write Protect is off
 sda:
MSDOS: Hardware sector size is 2048
[MS-DOS FS Rel. 12,FAT 16,check=n,conv=b,uid=0,gid=0,umask=022]
[me=0xf8,cs=8,#f=2,fs=1,fl=38,ds=77,de=512,data=85,se=0,ts=310352,ls=2048,rc=0,fc=4294967295]
Transaction block size = 2048
---------------------- end example --------------------------------

Perhaps, your MO disk will have the `ls' of a value smaller than 2048.
Logical sector size smaller than device sector size cannot be handled
with FAT of 2.4 series.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

