Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288759AbSANSkm>; Mon, 14 Jan 2002 13:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288781AbSANSk3>; Mon, 14 Jan 2002 13:40:29 -0500
Received: from web14908.mail.yahoo.com ([216.136.225.60]:10515 "HELO
	web14908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287827AbSANSkL>; Mon, 14 Jan 2002 13:40:11 -0500
Message-ID: <20020114184010.66277.qmail@web14908.mail.yahoo.com>
Date: Mon, 14 Jan 2002 13:40:10 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Re: "dd" collapsed the loop device
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020114111843.P26688@lynx.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That means that I couldn't access /dev/fd0 directly
when I use it via loopback? Is there any way that I
can use to avoid this accident erase?

Michael


--- Andreas Dilger <adilger@turbolabs.com> wrote:
> On Jan 14, 2002  12:54 -0500, Michael Zhu wrote:
> > Hello,everyone,I have a problem when I used the
> loop
> > device. I don't know whether is a loop device bug.
> 
> User bug.
> 
> > I used the following commands to connect the loop
> device
> > with the floppy disk device.
> > 
> > losetup -e xor /dev/loop0 /dev/fd0
> > mke2fs /dev/loop0
> > mount /dev/loop0 /floppy
> > 
> > Then I copy something to the floppy and read it
> back.
> > Everything is OK. It works perfectly. 
> 
> Great.
> 
> > The problem was happened when I try to copy
> something
> > directly from the /dev/fd0. I use the following
> > demand.
> > 
> > dd if=test.c of=/dev/fd0
> > 
> > The output of the upper command is:
> > 50+1 records in
> > 50+1 records out
> > 
> > Then I used the "ls /floppy". I found nothing
> copied
> > to the floppy.
> 
> Well, this is wrong for several reasons:
> 1) don't access /dev/fd0 when you use it via
> loopback, use /dev/loop0
> 2) don't use "dd" to copy a file, use "cp"
> 3) don't write into the device, but the filesystem
> instead:
>    cp test.c /floppy
> 
> > Then I used "umount /floppy" to umount the floppy
> disk
> > device. After that I used the following command to
> try
> > to mount the floppy disk again.
> >
> > mount /dev/loop0 /floppy
> > 
> > It returned an error. Say:
> > 
> > mount: wrong fs type. bad option. bad superblock
> on
> > /dev/loop0. or too many mounted file systems
> > 
> > It seemed that the "dd if=test.c of=/dev/fd0"
> > corrupted the data on the floppy disk. What is
> wrong?
> 
> Because test.c is not a filesystem, and you have
> overwritten
> the filesystem on /dev/fd0 with junk.  This is not a
> bug
> in the loop driver.
> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> 


______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
