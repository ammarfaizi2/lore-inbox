Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRAKI1l>; Thu, 11 Jan 2001 03:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRAKI1b>; Thu, 11 Jan 2001 03:27:31 -0500
Received: from spey.st-and.ac.uk ([138.251.61.4]:50329 "EHLO
	spey.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id <S129675AbRAKI1U>; Thu, 11 Jan 2001 03:27:20 -0500
From: Mark Hindley <mh15@st-andrews.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14941.28037.780373.812952@hindleyhome.st-andrews.ac.uk>
Date: Thu, 11 Jan 2001 08:23:33 +0000 (GMT)
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
Cc: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 kernel paging error
In-Reply-To: <20010110184709.F21944@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <l03130302b681de2fd7a0@[138.251.135.28]>
	<3A5C93E9.A96EF8AE@innominate.de>
	<20010110184709.F21944@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Rumpf writes:
 > On Wed, Jan 10, 2001 at 05:55:05PM +0100, Daniel Phillips wrote:
 > > Mark Hindley wrote:
 > > > I am running 2.4.0 final. I got the following failed paging request which
 > > > produced a complete freeze.
 > > > 
 > > > As you can see it was precipitated by cron starting to run some
 > > > housekeeping stuff overnight.
 > > > 
 > > > Has anyone else had prblems?
 > > 
 > > It looks real.  It was executing this line of clear_inode in fs/inode.c:
 > > 
 > > 380         if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->clear_inode)
 > >                                                                      ^^^^^^^^^^^^^
 > >                                            and it blew up here ----->
 > 
 > > Unable to handle kernel paging request at virtual address c4870840
 > 
 > I'm pretty sure this is a vmalloc/module address, which would mean ->s_op
 > points to a module that has been unloaded.  This sounds consistent with the
 > "cron starting to run some housekeeping stuff" above.
 > 
 > Mark, which file systems are you using ?

I have ext2 (builtin) and autoload [v]fat, msdos, hfs, iso9660 and
occasionally (but not recently) udf as modules for removable media.

vfat is loaded all the time as I have a couple of partitions from
another OS I used to use permantently mounted RO.

As far as I can remember hfs and iso9660 were the only other ones I had used
just before this happened.

As I use the kernel module autoloader I also have a cron entry for rmmod -a
which runs every so often to clear out the unused modules. Although
the logs record rmmod running, they don't say what if any modules were
removed.

Mark
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
