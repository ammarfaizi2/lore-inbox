Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131060AbQKVKE3>; Wed, 22 Nov 2000 05:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131140AbQKVKEK>; Wed, 22 Nov 2000 05:04:10 -0500
Received: from 213-123-77-95.btconnect.com ([213.123.77.95]:26884 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131060AbQKVKDw>;
	Wed, 22 Nov 2000 05:03:52 -0500
Date: Wed, 22 Nov 2000 09:34:18 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Joe Harrington <jharring@micron.net>
cc: CSCD 440-01 Mailing List <cs440@tux.ewu.edu>, linux-kernel@vger.kernel.org
Subject: Re: filesystems
In-Reply-To: <007d01c0545d$e6444760$53b613d1@micron.net>
Message-ID: <Pine.LNX.4.21.0011220923100.1197-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Joe Harrington wrote:

> Does a typical Linux system or Mandrake boot using the ext2 filesystem? Do
> all filesystems have or use commands such as stat, read, write and chmod. I
> am trying to figure out without looking through the code how a VFS
> filesystem works. I am assuming that it does not use the major minor system,
> for faster access to data? On my system I have:
> 
>             ext2
>             msdos
> nodev proc
> 
> Yes I did a man filesystems, man virtual filesystems, and manVFS. What does
> the nodev stand for? I have seen other systems containing filesystems such

nodev means the filesystem is not of type FS_REQ|UIRES_DEV, i.e. does not
require a block device to be mounted. In folklore, such are sometimes
called "virtual" filesystems. Examples are sockfs, shm, pipefs, proc, nfs,
devpts.


> as:
> 
>             ext2
>             minix
>             msdos
>             vfat
> nodev proc
> nodev nfs
>             iso9660
>             ufs
> nodev autofs
> nodev devpts
> 
> Basically, do you mount a VFS filesystem, does it keep pages in RAM longer
> than other filesystems.

you do not mount a VFS filesystem. VFS is not a filesystem. VFS is a
Virtual Filesystem Switch, i.e. a set of concepts, philosophy, data
structures and functions which together make writing new filesystems easy.
The name is derived from the SVR4 data structure vfssw (sic?) whence all
the good concepts of VFS came (yea, yea, I know, AV (and history books)
will tell me that Sun had a vnode/vfs layer and that even FreeBSD has a
sort of VFS/vnode layer but we all know that the really good form of VFS
came from SVR4, like it or not, the others, except Linux of course, are
impostors)


> How would a VFS filesystem handle system calls such
> as "stat" or "open"? I am just looking for something that can easily help me
> visualize the VFS process.

when doing stat system call, the VFS does a name lookup which causes the
relevant inode to be read from disk (by means of s_op->read_inode method
the filesystem registered) and so, all the relevant information is already
there in the incore inode, which is then copied to userspace.

You cannot visualize VFS without looking at the source code. In fact, you
cannot even do so by looking at the source, it is so complex. But it is
definitely worth a try -- just remember, it is a lifelong process.
Nevertheless, it is certainly a good thing to dedicate whole life to study
the subject so complex, and which changes so frequently that nobody in the
whole world has an overall picture of it. But we all try :) One day, we
will understand it all and rewrite it to be even better than it is now :)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
