Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266129AbRGGLdJ>; Sat, 7 Jul 2001 07:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266125AbRGGLc7>; Sat, 7 Jul 2001 07:32:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:45470 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266103AbRGGLcp>;
	Sat, 7 Jul 2001 07:32:45 -0400
Date: Sat, 7 Jul 2001 07:32:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Eugene Crosser <crosser@average.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <9i6oga$jk1$1@pccross.average.org>
Message-ID: <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 7 Jul 2001, Eugene Crosser wrote:

> Doesn't the approach "treat a chunk of data built into bzImage as
> populated ramfs" look cleaner?  No need to fiddle with tar format,
> no copying data from place to place.

What the hell _is_ "populated ramfs"? The thing doesn't live in array
of blocks. Its directory structure consists of a bunch of dentries.
Permissions/ownership/timestamps are in a bunch of struct inode -
sitting in icache and allocated in normal way. Regular files are
entirely in pagecache, ditto for symlinks.

Ramfs has no backing store. At all. That's precisely what remains of
filesystem if you take backing store away - everything is in VFS/VM caches.

