Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268870AbRHBJvg>; Thu, 2 Aug 2001 05:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268871AbRHBJv0>; Thu, 2 Aug 2001 05:51:26 -0400
Received: from ns.caldera.de ([212.34.180.1]:28622 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268870AbRHBJvO>;
	Thu, 2 Aug 2001 05:51:14 -0400
Date: Thu, 2 Aug 2001 11:51:10 +0200
Message-Id: <200108020951.f729pAc13598@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: ext3-2.4-0.9.4
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010802110341.B17927@emma1.emma.line.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010802110341.B17927@emma1.emma.line.org> you wrote:
>
> http://www.opengroup.org/onlinepubs/007908799/xbd/glossary.html#tag_004_000_291
>
>   "synchronised I/O data integrity completion
>
>   [...]
>
>   * For write, when the operation has been completed or diagnosed if
>   unsuccessful.  The write is complete only when the data specified in
>   the write request is successfully transferred and all file system
>   information required to retrieve the data is successfully transferred.
>
>   File attributes that are not necessary for data retrieval (access
>   time, modification time, status change time) need not be successfully
>   transferred prior to returning to the calling process.

NOTE: _file_ attributes

>
>   synchronised I/O file integrity completion
>
>   Identical to a synchronised I/O data integrity completion with the
>   addition that all file attributes relative to the I/O operation
>   (including access time, modification time, status change time) will be
>   successfully transferred prior to returning to the calling process."
>
> As I understand it, the directory entry's st_ino is a file attribute
> necessary for data retrieval and also contains the m/a/ctime, so it must
> be flushed to disk on fsync() as well.
>

As long as you have an open fd, no directory entry is needed for
data retrieval.  In fact some fds never have a directory entry
(e.g. sockets - but these don't support fsync anyway) or do not have a
directory entry in their user-visble interface (e.g. posix shm).

And m/a/ctime is in the inode of the file, not in the directory enrty.
(at least for usual UNIX filesystems).

> Well, if there's not a single dirent, you cannot retrieve the data,

Of course you can, you can pass and fd for an unliked file everywhere
using AF_LOCAL descriptor passing.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
