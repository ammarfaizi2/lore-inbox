Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRB0GyG>; Tue, 27 Feb 2001 01:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRB0Gx4>; Tue, 27 Feb 2001 01:53:56 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:32271 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129106AbRB0Gxs>; Tue, 27 Feb 2001 01:53:48 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Andreas Dilger <adilger@turbolinux.com>
Date: Tue, 27 Feb 2001 07:53:51 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.2.18/ext2: special file corruption?
CC: linux-kernel@vger.kernel.org
Message-ID: <3A9B5D0E.4639.83B72@localhost>
In-Reply-To: <200102261748.f1QHmwd10698@webber.adilger.net>
In-Reply-To: <3A9A2E3D.9135.8E1BCE@localhost> from Ulrich Windl at "Feb 26, 2001 10:21:51 am"
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Feb 2001, at 10:48, Andreas Dilger wrote:

> Ulrich Windl writes:
> > I had an interesting effect: Due to NVdriver I had a lot of system 
> > freezes, and I had to reboot. Using e2fsck 1.19a (SuSE 7.1) I got the 
> > message that one specific "Special (device/socket/fifo) inode .. has 
> > non-zero size. FIXED."
> > 
> > Interestingly I got the message for every reboot. So either the kernel 
> > corrupts the very same inode every time, or e2fsck does not really fix 
> > it, or the error simply doesn't exist. I think the kernel doesn't 
> > temporarily set the size to non-zero, so this seems strange.
> 
> It is strange that it thinks ".." is a special inode.  Maybe e2fsck is

Og course NOT: ``..'' is a meta syntax for ellipsis. I couldn't 
remember the inode number.

> fixing the wrong problem (i.e. truncating the directory ".."), and it
> later fixes the zero-length directory...  Could you try two things:
> 
> 1) unmount the filesystem and run e2fsck on the broken filesystem 1 or 2
>    times, to see if e2fsck is fixing the problem or not.

I did that, and actually it fixed the very same problem again. On a 
second run it was fixed. So either the "-a -t ext2" prevents the 
changes from being written back if the only problem was that special 
file, or there is some corruption undetected by fsck that in turn 
causes the kernel to corrupt the filesystem again and again, or I don't 
know. Here's the log from my tries:

elf:~ # fsck -f /dev/sda6
Parallelizing fsck version 1.19a (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Special (device/socket/fifo) inode 16600 has non-zero size.  Fix<y>? yes

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/sda6: ***** FILE SYSTEM WAS MODIFIED *****
/dev/sda6: 35542/86400 files (0.9% non-contiguous), 124965/172690 blocks
elf:~ # fsck -f /dev/sda6
Parallelizing fsck version 1.19a (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/sda6: 35542/86400 files (0.9% non-contiguous), 124965/172690 blocks


> 
> 2) If it is fixing the problem you need to wait until the next time you have
>    a system crash, start in single user mode.  If it is NOT fixing the problem
>    you can do this right away.  Run "e2fsck -n" to see which inode number is
>    corrupt (the -n option means e2fsck will not fix the filesystem), and then
>    run "debugfs /dev/X", type "dump <inode_number>" and "ncheck inode_number"
>    at the prompt (note you NEED the <> around the inode number for dump).
>    Send the output.

I'll keep your message. Maybe you hear again from me.

Ulrich

