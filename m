Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbTCVLza>; Sat, 22 Mar 2003 06:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbTCVLza>; Sat, 22 Mar 2003 06:55:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:44260 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262402AbTCVLz0>;
	Sat, 22 Mar 2003 06:55:26 -0500
Date: Sat, 22 Mar 2003 04:05:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: dougg@torque.net
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Message-Id: <20030322040550.0b8baeec.akpm@digeo.com>
In-Reply-To: <3E7C4D05.2030500@torque.net>
References: <200303211056.04060.pbadari@us.ibm.com>
	<3E7C4251.4010406@torque.net>
	<20030322030419.1451f00b.akpm@digeo.com>
	<3E7C4D05.2030500@torque.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2003 12:05:48.0742 (UTC) FILETIME=[6049EE60:01C2F06B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert <dougg@torque.net> wrote:
>
> Andrew Morton wrote:
> > Douglas Gilbert <dougg@torque.net> wrote:
> > 
> >>>Slab:           464364 kB
> >>
> > 
> > It's all in slab.
> > 
> > 
> >>I did notice a rather large growth of nodes
> >>in sysfs. For 84 added scsi_debug pseudo disks the number
> >>of sysfs nodes went from 686 to 3347.
> >>
> >>Does anybody know what is the per node memory cost of sysfs?
> > 
> > 
> > Let's see all of /pro/slabinfo please.
> 
> Andrew,
> Attachments are /proc/slabinfo pre and post:
>   $ modprobe scsi_debug add_host=42 num_devs=2
> which adds 84 pseudo disks.
> 

OK, thanks.  So with 48 disks you've lost five megabytes to blkdev_requests
and deadline_drq objects.  With 4000 disks, you're toast.  That's enough
request structures to put 200 gigabytes of memory under I/O ;)

We need to make the request structures dymanically allocated for other
reasons (which I cannot immediately remember) but it didn't happen.  I guess
we have some motivation now.

