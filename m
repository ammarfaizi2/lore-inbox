Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267996AbRGVPiW>; Sun, 22 Jul 2001 11:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbRGVPiN>; Sun, 22 Jul 2001 11:38:13 -0400
Received: from gear.torque.net ([204.138.244.1]:30995 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S267996AbRGVPiF>;
	Sun, 22 Jul 2001 11:38:05 -0400
Message-ID: <3B5AE813.658ADC66@torque.net>
Date: Sun, 22 Jul 2001 10:49:55 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: MO-Drive under 2.4.7 usinf vfat
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> Is the capacity of your MO disk more than 640M?

No, the capacity is 635600896 bytes.

$ sg_readcap /dev/sg1
Read Capacity results:
   Last block address = 310351 (0x4bc4f), Number of blocks = 310352
   Block size = 2048 bytes

This is from my log:
 Attached scsi removable disk sdb at scsi4, channel 0, id 0, lun 0
 SCSI device sdb: 310352 2048-byte hdwr sectors (636 MB)

$ cat /proc/scsi/scsi 
Attached devices: 
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: M25-MCC3064AP    Rev: 0023
  Type:   Optical Device                   ANSI SCSI revision: 02

On my box the MO drive is /dev/sdb or /dev/sg1 .

Executing 'mount -t vfat /dev/sdb /mnt/extra -o debug'
put this in my log:
 MSDOS: Hardware sector size is 2048
 [MS-DOS FS Rel. 12,FAT 16,check=n,conv=b,uid=0,gid=0,umask=022]
 [me=0xf8,cs=32,#f=2,fs=1,fl=152,ds=305,de=512,data=
   337,se=0,ts=1241408,ls=512,rc=0,fc=4294967295]
 Transaction block size = 2048

> Perhaps, your MO disk will have the `ls' of a value smaller 
> than 2048.
Yes, ls=512 .

> Logical sector size smaller than device sector size cannot
> be handled with FAT of 2.4 series.

Great. When will that be fixed (Jens?) ? If not, can we get 
a more civilized response than the current oops?

Doug Gilbert

