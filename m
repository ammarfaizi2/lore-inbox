Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSIEXe5>; Thu, 5 Sep 2002 19:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318264AbSIEXe4>; Thu, 5 Sep 2002 19:34:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37265 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318243AbSIEXeu>;
	Thu, 5 Sep 2002 19:34:50 -0400
Date: Thu, 5 Sep 2002 19:39:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] IDE cleanup (1.612) broke all fdisks I have...
In-Reply-To: <20020905181350.GA1822@vana.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0209051934060.16225-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Sep 2002, Petr Vandrovec wrote:

> Hi Al,
>    it is nice that blkdev_ioctl calls blk_ioctl itself, but unfortunately
> it does that only if driver's ioctl returns -EINVAL - and IDE returns -EIO :-(
> 
> Patch below is tested for disks - I do not have IDE floppy nor IDE tape.

For ide-disk.c, ide-floppy.c and ide-cd.c patch is OK.  For ide-tape.c...
Not needed.

Keep in mind that current setup (some ioctls are unconditionally done
in fs/block_dev.c, for some we only call driver, for some - give
driver a chance and do our thing if it doesn't recongnize the ioctl)
will change.  Most of the 3rd group actually belong to the 1st one -
the only reason why they are not there is handling of unpartitioned
devices that don't have gendisks.  When that gets fixed, the kludge
with calling driver and handling -EINVAL will disappear...

