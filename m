Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293448AbSCVImt>; Fri, 22 Mar 2002 03:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293452AbSCVImd>; Fri, 22 Mar 2002 03:42:33 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:42236 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S310241AbSCVImS>; Fri, 22 Mar 2002 03:42:18 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 22 Mar 2002 01:42:09 -0700
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: max partition size
Message-ID: <20020322084209.GD3451@turbolinux.com>
Mail-Followup-To: Michal Jaegermann <michal@harddata.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020322005037.A9256@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 22, 2002  00:50 -0700, Michal Jaegermann wrote:
> Who knows for sure what is the current upper limit on ext2/ext3
> file system size (4KiB blocks as this is what tools will accept)?  It
> definitely is not 1 TB as we were making working partition nearly twice
> that.  But practice seems to indicate that 2 TB, or whereabout, can be
> too much.  Is this a property of a file system or we bumping into
> block device boundaries or this are just tools?

2TB is the limit for all block devices in 2.2 and 2.4 kernels.  This is
from 2^32 * 512 byte sectors.  Using LVM or MD devices will not overcome
this limitation.

There was a patch floating around which extended the block counts to
64-bit ints (Jens Axboe and/or Ben LaHaise posted it), and I think at
least part of it is in 2.5.  Even if you have 64-bit block counts,
there are other issues which pop up fairly soon - 32-bit page indexes
and other 32-bit overflows in calculations in the ext2 code.  There
is definitely a hard limit at 16TB for 4kB block ext2 filesystems,
but I suspect you will have problems at 8TB even after the 2TB block
device limit is lifted.

> BTW - mke2fs goes most of the way but gets stuck eventually when
> writing inode tables if that it is too close to 2 TB.  Yes, there
> are people who really want that much of a file system or maybe even
> more. :-)   This was not done for a sake of a record.

You could always try it on a real 64-bit machine to see if that helps.
You can concievably use 8kB blocks on an Alpha, giving you an upper
limit of 32TB for the filesystem until the ext2 extent code is
implemented (which will give us 64-bit block numbers among other things).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

