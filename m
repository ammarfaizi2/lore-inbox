Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132700AbRAJN4X>; Wed, 10 Jan 2001 08:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135259AbRAJN4O>; Wed, 10 Jan 2001 08:56:14 -0500
Received: from lotus2.lotus.com ([192.233.136.8]:56494 "EHLO lotus2.lotus.com")
	by vger.kernel.org with ESMTP id <S132700AbRAJN4H>;
	Wed, 10 Jan 2001 08:56:07 -0500
Subject: Re: linux-2.4.0 scsi problems on NetFinity servers
To: "JP Navarro <navarro" <navarro@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V60_12122000 December 12, 2000
Message-ID: <OF57A8F6A1.EBEE4C0B-ON852569D0.0048E35A@lotus.com>
From: "Ken Brunsen/Iris" <kenbo@iris.com>
Date: Wed, 10 Jan 2001 08:58:18 -0500
X-MIMETrack: Serialize by Router on A3MAIL/CAM/H/Lotus(Build V507_12282000 |December 28, 2000) at
 01/10/2001 09:00:24 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, on a suggestion from JP, I've built the 2.4.0 kernel without SMP
support.  I did, however, have to make one change to a header file to get
it to compile the kernel and here is a diff

diff include/linux/linux/kernel_stat.h include/linux/linux/kernel_stat.h.sv
48d47
< #ifdef CONFIG_SMP
50d48
< #endif

The code was only for stats, but did not have the appropriate wrapper
around a for-loop clause to access an SMP only variable.

So, with SMP support off, I started my tests and then headed home for the
evening.  This morning when I arrived, I found my machine had crashed on
the 2nd run of my copy test, but with a little bit of a different crash.
First I'm getting multiple messages of the type

I/O error:  dev 08:01

and then I'm getting messages of the type

EXT2-fs error (device sd(8,1)): read_inode_bitmap: Cannot read inode bitmap
- block_group = 34, inode_bitmap = 1114113
EXT2-fs error (device sd(8,1)): ext2_write_inode: unable to read inode
block - inode=229832, block=458756

where the numbers for the inodes, blocks, bitmaps, and groups vary; also
attempting to run any process in my root tty (even just reboot) results in
a segv and the I/O error messages some more (of note, the only filesystem
that gets trashed, ever, is the one with the test running on it, the root
partition is separate and never is affected, nor is any other partition).
So, although SMP may aggrevate the situation, it is not, apparently, the
cause of the problem.

BTW:  this test case basically destroys my test filesystem such that I've
taken to creating a new fs on the partition each time - I tried fixing it
twice with fsck, and after 2 days it had still not completed the fixup in
each case.

thanks

kenbo

______________________
Firebirds rule, `stangs serve!

Kenneth "kenbo" Brunsen
Iris Associates

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
