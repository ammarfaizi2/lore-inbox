Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319412AbSILCWZ>; Wed, 11 Sep 2002 22:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319413AbSILCWZ>; Wed, 11 Sep 2002 22:22:25 -0400
Received: from packet.digeo.com ([12.110.80.53]:19631 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319412AbSILCWY>;
	Wed, 11 Sep 2002 22:22:24 -0400
Message-ID: <3D7FFF12.24B0FDAA@digeo.com>
Date: Wed, 11 Sep 2002 19:42:26 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
References: <200209120210.g8C2AkD26470@eng4.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 02:27:07.0135 (UTC) FILETIME=[E3B2E8F0:01C25A03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> 
> Here's a patch to put sard changes similar to those in 2.4 into 2.5.  I
> say "similar" because the I/O subsystem has changed sufficiently in 2.5
> that making them exactly the same might be more effort that it's
> worth.  Still, we do record per-partition reads/writes/sectors, and
> per-disk stats on the same plus queue time and number of I/O merges.
> Once applied, "cat /proc/diskstats" outputs this information.

It would be very nice to get better disk accounting into the kernel.

> Because in 2.5.34, gendisk->part[0] no longer is an hd_struct that
> refers to the whole disk, there wasn't a convenient place to record
> this information.  I gratuitously added an hd_struct to gendisk to have
> a place to store the information, below, but that's distasteful and
> ugly. I'd like to move it to a different place.
> 
> Also, with this patch, we are collecting stats twice, once for these
> stats and once for /proc/stat (kstat).  That's stupid and I'd like to
> get the stats only once and use them, perhaps, in two places.

kstat should be a lighter-weight per-cpu thing.  But the current
disk accounting in there would make it 12 kilobytes per CPU.

My vote: remove the disk accounting from kernel_stat and use this.
 
> What follows works, but needs refinements.  Comments welcome.

What are those refinements?

What userspace tools are available for interpreting this information?
