Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbRFEIhf>; Tue, 5 Jun 2001 04:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbRFEIhZ>; Tue, 5 Jun 2001 04:37:25 -0400
Received: from cx595243-c.okc1.ok.home.com ([24.6.27.53]:46751 "EHLO
	quark.localdomain") by vger.kernel.org with ESMTP
	id <S263918AbRFEIhO>; Tue, 5 Jun 2001 04:37:14 -0400
From: Vincent Stemen <linuxkernel@AdvancedResearch.org>
Date: Tue, 5 Jun 2001 03:37:03 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: Nick Urbanik <nicku@vtc.edu.hk>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3B1C8C1B.E3946FE1@vtc.edu.hk>
In-Reply-To: <3B1C8C1B.E3946FE1@vtc.edu.hk>
Subject: Re: Cannot mount old ext2 cdrom, but e2fsck shows no problems
MIME-Version: 1.0
Message-Id: <01060503370300.10504@quark>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 June 2001 02:36, Nick Urbanik wrote:
> Dear folks,
>
> I made 18 ext2 cdroms in October 1998 using an old (new at the time) Red
> Hat system.  Now I can't mount them.  e2fsck shows no problems.  I also
> can dd them to a file, then mount the file.  But I want to be able to
> simply access them directly.  Current system: RH 7.1 with all updates.
>
> Sorry, I can't remember the exact command I used to create the images.
>
> I also want to better understand the output of dumpe2fs, and how to
> relate this to mount.
>

I think you are running into a block size issue.  I notice your fs
block size is only 1024.  See if you can mount it on an IDE CDROM
drive.  I ran into the same problem with file systems with a block
size of 1024 when using the ide-scsi module because it saw the device
bs as being 4096.  You cannot mount a file system with block size
smaller than the device.  I would unload the the ide-scsi modules and
mount it as /dev/hdxx and it mounted just fine.  I started specifying
the bs to be 4k when creating the file system to backup to CD and the
problem went away.  The error message was deceiving.  I did not
discover what it was until I left X windows and tried it from the
console and finally got an error relating to block size.

- Vincent Stemen

>
>
> $ dumpe2fs -h /dev/scd0
> dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> Filesystem volume name:   <none>
> Last mounted on:          <not available>
> Filesystem UUID:          7eb1b040-59f7-11d2-9e35-002018530df2
> Filesystem magic number:  0xEF53
> Filesystem revision #:    0 (original)
> Filesystem features:     (none)
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              166624
> Block count:              665600
> Reserved block count:     33280
> Free blocks:              142206
> Free inodes:              153910
> First block:              1
> Block size:               1024
> Fragment size:            1024
> Blocks per group:         8192
> Fragments per group:      8192
> Inodes per group:         2032
> Inode blocks per group:   254
> Last mount time:          Fri Oct  2 21:06:45 1998
> Last write time:          Fri Oct  2 23:53:28 1998
> Mount count:              3
> Maximum mount count:      20
> Last checked:             Fri Oct  2 20:57:46 1998
> Check interval:           15552000 (6 months)
> Next check after:         Wed Mar 31 20:57:46 1999
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
>
> (I originally sent this to the Red Hat list, but there was no response).
>
