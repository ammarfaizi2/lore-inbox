Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbRESHYM>; Sat, 19 May 2001 03:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbRESHYD>; Sat, 19 May 2001 03:24:03 -0400
Received: from ha2.rdc2.nsw.optushome.com.au ([203.164.2.51]:36755 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S261680AbRESHXr>; Sat, 19 May 2001 03:23:47 -0400
Message-ID: <3B061F63.194BAF63@gnu.org>
Date: Sat, 19 May 2001 17:23:15 +1000
From: Andrew Clausen <clausen@gnu.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <Pine.GSO.4.21.0105190259350.3724-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> On Sat, 19 May 2001, Andrew Clausen wrote:
> 
> > (1) these issues are independent.  The partition parsing could
> > be done in user space, today, by blkpg, if I read the code correctly
> > ;-)  (there's an ioctl for [un]registering partitions)  Never
> > tried it though ;-)
> 
> ioctls are even more evil than encoding limits into the name.

Why?  Encoding sounds funky... you don't get normal
ls behaviour, etc.

I think I'd prefer something like /dev/hda/table, where
table is something like /proc/partitions for /dev/hda, but
it's read/write ;-)

> Cease and desist, please.

Hehe
 
> > (4) <propaganda>libparted already has a fair bit of partition
> > scanning code, etc.  Should be trivial to hack it up... That said,
> > it should be split up into .so modules... 200k is a bit heavy just
> > for mounting partitions (most of the bulk is file system stuff).
> > </propaganda>
> 
> We will be much better off providing a sane API from the kernel. And
> dropping the layout-aware code from fdisk, parted, yodda, yodda.

What about partition editing on other OSs?  There's no reason
why fdisk/parted/etc. should be Linux only.  Why should the kernel
need to know how to write partition tables?

Also, different partition table formats have different alignment
constraints (which is relevant for creating partitions).  These
mainly need to be respected for other braindead OS's and/or BIOSes.

Communicating those between user/kernel space doesn't excite me.

Any ideas?
 
> Libraries do not remove code duplication. You still need to relink the
> stuff you keep statically linked, etc. Otherwise you get version skew.
> Big way. Besides, you can't use library from a script, etc.

Libtool & friends deals with version skew (ugly, but it works...)

You can write wrappers for libraries.

That said, a kernel API would be nice, if it was doable...

Andrew Clausen
