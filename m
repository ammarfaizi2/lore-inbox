Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbRESH7E>; Sat, 19 May 2001 03:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261687AbRESH6z>; Sat, 19 May 2001 03:58:55 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:62663 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261683AbRESH6m>; Sat, 19 May 2001 03:58:42 -0400
Date: Sat, 19 May 2001 03:58:39 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@devserv.devel.redhat.com>
To: Andrew Clausen <clausen@gnu.org>
cc: <torvalds@transmeta.com>, <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <3B06194B.C487240C@gnu.org>
Message-ID: <Pine.LNX.4.33.0105190350080.13165-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, Andrew Clausen wrote:

> (1) these issues are independent.  The partition parsing could
> be done in user space, today, by blkpg, if I read the code correctly
> ;-)  (there's an ioctl for [un]registering partitions)  Never
> tried it though ;-)

I tried to imply that through the use of the the word component.  Yes,
they're independant, but the code is pretty meaningless without a
demonstration of how it's used. ;-)

> (2) what about bootstrapping?  how do you find the root device?
> Do you do "root=/dev/hda/offset=63,limit=1235823"?  Bit nasty.

root= becomes a parameter to mount, and initrd becomes mandatory.  I'd be
all for including all of the bits needed to build the initrd boot code in
the tree, but it's completely in the air.

> (3) how does this work for LVM and RAID?

It's not done yet, but similar techniques would be applied.  I envision
that a raid device would support operations such as
open("/dev/md0/slot=5,hot-add=/dev/sda")

> (4) <propaganda>libparted already has a fair bit of partition
> scanning code, etc.  Should be trivial to hack it up... That said,
> it should be split up into .so modules... 200k is a bit heavy just
> for mounting partitions (most of the bulk is file system stuff).
> </propaganda>

Good.  Less work to do.

> (5) what happens to /etc/fstab?  User-space ([u]mount?) translates
> /dev/hda1 into /dev/hda/offset=63,limit=1235823, and back?

I'd just create a symlink to /dev/hda1 at mount time, although that really
isn't what the user wants to see: the label or uuid is more useful.

		-ben

