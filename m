Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbSLEV4K>; Thu, 5 Dec 2002 16:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbSLEV4K>; Thu, 5 Dec 2002 16:56:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:46494 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267484AbSLEV4I>;
	Thu, 5 Dec 2002 16:56:08 -0500
Message-ID: <3DEFCD3A.29C98E8D@digeo.com>
Date: Thu, 05 Dec 2002 14:03:38 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5: ext3 bug or dying drive?
References: <1039123660.1433.12.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2002 22:03:38.0104 (UTC) FILETIME=[29E4F780:01C29CAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> Overnight, 2.5.50-mm1 took a big stinky shit:
> 
> ...
>
> Rebooted and ext3 replayed the journal and said a manual check was
> needed due to I/O error on the journal.

That'll be e2fsck saying that, when it tries to do journal replay.
I/O errors on the journal during replay not good.

Were there no I/O error messages reported from the device driver,
block, buffer or pagecache layer?  Generally everyone like to have
a shout as one flies past.

>  Ran fsck manually, it found a
> whole bunch of orphan inodes including some scary errors like "inode
> part of corrupt orphan inode list" or similar.
> 
> Rebooted again to force another fsck to be sure, and sure enough it
> found more problems.  Ugh.  I started thinking bad hard drive.
> 
> Back up in X, and the same dmesg error occurred again.  Repeat above.
> 
> Now I am in 2.4 and all seems well.  So perhaps not hard drive?

Well.  Changed driver, scsi layer, block layer, VFS and ext3.  Could
be anywhere :(
 
> IBM U2W drive on a 2940U2W if it matters.  UP kernel.

It would be useful to give the IO system a bit of a thrashing,
to narrow the problem down.  Just a `cat /dev/sda[n] > /dev/null'
would suit.

Bottom line: dunno.
