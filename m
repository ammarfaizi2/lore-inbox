Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261262AbRELOx7>; Sat, 12 May 2001 10:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261263AbRELOxu>; Sat, 12 May 2001 10:53:50 -0400
Received: from wawura.off.connect.com.au ([202.21.9.2]:51926 "HELO
	wawura.off.connect.com.au") by vger.kernel.org with SMTP
	id <S261262AbRELOxk>; Sat, 12 May 2001 10:53:40 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tytso@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: Ext2, fsync() and MTA's? 
In-Reply-To: Your message of "Sat, 12 May 2001 15:13:55 +0100."
             <E14ya9b-0004Bc-00@the-village.bc.nu> 
Date: Sun, 13 May 2001 00:53:37 +1000
From: Andrew McNamara <andrewm@connect.com.au>
Message-Id: <20010512145338.0D3D6285BF@wawura.off.connect.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Under Linux, the Postfix MTA sets "chattr +S" on it's spool directories
>> - obviously this hurts it's performance badly (compared to the BSD's).
>
>Not really. BSD directory updates are always synchronous in the cases postfix
>cares about. At least on the old BSD FFS/UFS file systems. Thats the only
>reason the postfix stuff doesnt need it on BSD.

Indeed, but doesn't "chattr +S" on the parent directory causes the file
data to be writen syncronously also, which would really hurt.

>> It would be really nice to be able to say it's no longer necessary. It
>> wants to know that a file (file data, inode and directory entry) are
>> commited to stable storage when an fsync returns.
>
>fsync guarantees the inode data is up to date, fdatasync just the data. The
>directory name SuS and posix dont cover or provide any method for guaranteeing.
>The convention Linux adopted is that its valid to fsync() a directory file
>handle. It seemed the logical abstraction.

I seem to recall that in 2.2, fsync behaved like fdatasync, and that
it's only in 2.4 that it also syncs metadata - is this correct?

Do the BSD's sync the directory data on an fsync of a file? I guess
this is the bone of contention - if linux is now doing exactly what BSD
does, it will make it a lot easier to answer accusations of this
nature.

Wietse isn't prepared to add code to Postfix to fsync the parent
directory's handle just for Linux - it would have to be done in a lot
of places (even though he wraps most system calls already), and he is
concerned one location may be missed: it's not something that can
tested for.

 ---
Andrew McNamara (System Architect)

connect.com.au Pty Ltd
Lvl 3, 213 Miller St, North Sydney, NSW 2060, Australia
Phone: +61 2 9409 2117, Fax: +61 2 9409 2111
