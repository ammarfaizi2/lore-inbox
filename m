Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTJTINk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTJTINk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:13:40 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:49678 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262432AbTJTINd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:13:33 -0400
Message-ID: <3F939B65.7060507@aitel.hist.no>
Date: Mon, 20 Oct 2003 10:23:01 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: no, en
MIME-Version: 1.0
To: Harold Martin <cocoadev@earthlink.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Mounting /dev/md0 as root in 2.6.0-test7
References: <1066582732.1108.5.camel@localhost>
In-Reply-To: <1066582732.1108.5.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harold Martin wrote:
> First, is it possible to mount an md device as root (superblock is
> present)?

Yes, this is trivial.  /dev/md0 works just as good
as, say, /dev/hda2.


> If not then the rest of this doesn't really matter...
> 
> If so, I can't get it to work :(
> I pass root=/dev/md0 to the kernl, but I get the "Kernel panic: VFS:
> Unable to mount root fs on md0" error.

1. This raid device is properly made and contains a valid root fs?
2. The partitions containing parts of the RAID are of type
   raid autodetect?  (if not, use cfdisk/fdisk/... and change them)
2. Your kernel has the raid-drivers _compiled in_, they're not
   modular?  (Modular _can_ be done if you load the drivers from
   an initrd, but why bother?  Drivers for the root fs will never
   be unloadable anyway, so no reason for modules here.  Compile
   the drivers in, and they just work.

> My setup:
> kernel 2.6.0-test7
> One drive on each of my two IDE channels (i810 chipset)
> RAID 0, set up with raidtools
> Using devfs
I use devfs too.  Note that it isn't "/dev/md0" with devfs,
it is "/dev/md/0".  Note the extra "/".  Now, devfsd may
create a compatibilty symlink called "/dev/md0", but it isn't
there at the time you mount root.

Note that root=/dev/md/0 is not enough when you use devfs.
You also need: append="root=/dev/md/0"
for some strange dark reason.  It wasn't always so, it got broken.
Perhaps an incentive to not use devfs?

> My FS type (ext2 and ext3), partition type (DOS), and RAID-0 support are
> all compiled in (not as modules).
Good.
> 
> What else do I need to do to be able to mount /dev/md0 as root?
> 
Looks like the "append" thing is what you need, seeing that you
already use compiled-in drivers.  Also make sure your raid-partitions
are of the autodetect variety.

Helge Hafting

