Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288246AbSANSKW>; Mon, 14 Jan 2002 13:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288521AbSANSKO>; Mon, 14 Jan 2002 13:10:14 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:60424 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S288246AbSANSKA>; Mon, 14 Jan 2002 13:10:00 -0500
Date: Mon, 14 Jan 2002 12:09:59 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201141809.MAA27408@tomcat.admin.navo.hpc.mil>
To: mylinuxk@yahoo.ca, linux-kernel@vger.kernel.org
Subject: Re: "dd" collapsed the loop device
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Hello,everyone,I have a problem when I used the loop
> device. I don't know whether is a loop device bug. I
> used the following commands to connect the loop device
> with the floppy disk device.
> 
> losetup -e xor /dev/loop0 /dev/fd0
> mke2fs /dev/loop0
> mount /dev/loop0 /floppy
> 
> Then I copy something to the floppy and read it back.
> Everything is OK. It works perfectly. 
> 
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
> to the floppy. Then I used "umount /floppy" to umount
> the floppy disk device. After that I used the
> following command to try to mount the floppy disk
> again.
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
> What happened to the floppy disk? Is it a bug of the
> loop device?

Nope. User error....

A mounted floppy has a file system on it. The first block is boot block,
super block... inode list.... ( or whatever M$ uses ).

A dd to the DEVICE starts writing at block 0. replaces the bootblock, for
as many blocks as are in the file.

This, naturally, destroys the filesystem.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
