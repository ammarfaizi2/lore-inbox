Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288614AbSANSTM>; Mon, 14 Jan 2002 13:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288658AbSANSTD>; Mon, 14 Jan 2002 13:19:03 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:5372 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288606AbSANSSv>;
	Mon, 14 Jan 2002 13:18:51 -0500
Date: Mon, 14 Jan 2002 11:18:43 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "dd" collapsed the loop device
Message-ID: <20020114111843.P26688@lynx.adilger.int>
Mail-Followup-To: Michael Zhu <mylinuxk@yahoo.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020114175446.24132.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114175446.24132.qmail@web14913.mail.yahoo.com>; from mylinuxk@yahoo.ca on Mon, Jan 14, 2002 at 12:54:46PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14, 2002  12:54 -0500, Michael Zhu wrote:
> Hello,everyone,I have a problem when I used the loop
> device. I don't know whether is a loop device bug.

User bug.

> I used the following commands to connect the loop device
> with the floppy disk device.
> 
> losetup -e xor /dev/loop0 /dev/fd0
> mke2fs /dev/loop0
> mount /dev/loop0 /floppy
> 
> Then I copy something to the floppy and read it back.
> Everything is OK. It works perfectly. 

Great.

> The problem was happened when I try to copy something
> directly from the /dev/fd0. I use the following
> demand.
> 
> dd if=test.c of=/dev/fd0
> 
> The output of the upper command is:
> 50+1 records in
> 50+1 records out
> 
> Then I used the "ls /floppy". I found nothing copied
> to the floppy.

Well, this is wrong for several reasons:
1) don't access /dev/fd0 when you use it via loopback, use /dev/loop0
2) don't use "dd" to copy a file, use "cp"
3) don't write into the device, but the filesystem instead:
   cp test.c /floppy

> Then I used "umount /floppy" to umount the floppy disk
> device. After that I used the following command to try
> to mount the floppy disk again.
>
> mount /dev/loop0 /floppy
> 
> It returned an error. Say:
> 
> mount: wrong fs type. bad option. bad superblock on
> /dev/loop0. or too many mounted file systems
> 
> It seemed that the "dd if=test.c of=/dev/fd0"
> corrupted the data on the floppy disk. What is wrong?

Because test.c is not a filesystem, and you have overwritten
the filesystem on /dev/fd0 with junk.  This is not a bug
in the loop driver.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

