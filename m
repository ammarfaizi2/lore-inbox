Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbRESHFS>; Sat, 19 May 2001 03:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbRESHFJ>; Sat, 19 May 2001 03:05:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51445 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261679AbRESHE7>;
	Sat, 19 May 2001 03:04:59 -0400
Date: Sat, 19 May 2001 03:04:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Clausen <clausen@gnu.org>
cc: Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <3B06194B.C487240C@gnu.org>
Message-ID: <Pine.GSO.4.21.0105190259350.3724-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Andrew Clausen wrote:

> (1) these issues are independent.  The partition parsing could
> be done in user space, today, by blkpg, if I read the code correctly
> ;-)  (there's an ioctl for [un]registering partitions)  Never
> tried it though ;-)

ioctls are even more evil than encoding limits into the name. Cease
and desist, please.

> (2) what about bootstrapping?  how do you find the root device?
> Do you do "root=/dev/hda/offset=63,limit=1235823"?  Bit nasty.

Ben's patch makes initrd mandatory.

> (3) how does this work for LVM and RAID?

It doesn't
 
> (4) <propaganda>libparted already has a fair bit of partition
> scanning code, etc.  Should be trivial to hack it up... That said,
> it should be split up into .so modules... 200k is a bit heavy just
> for mounting partitions (most of the bulk is file system stuff).
> </propaganda>

We will be much better off providing a sane API from the kernel. And
dropping the layout-aware code from fdisk, parted, yodda, yodda.

Libraries do not remove code duplication. You still need to relink the
stuff you keep statically linked, etc. Otherwise you get version skew.
Big way. Besides, you can't use library from a script, etc.

