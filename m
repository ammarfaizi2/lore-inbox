Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264461AbTCXWLL>; Mon, 24 Mar 2003 17:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264457AbTCXWLK>; Mon, 24 Mar 2003 17:11:10 -0500
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:18450 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP
	id <S264459AbTCXWLD>; Mon, 24 Mar 2003 17:11:03 -0500
Message-ID: <3E7F853B.1020603@torque.net>
Date: Tue, 25 Mar 2003 08:22:51 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
References: <200303211056.04060.pbadari@us.ibm.com> <3E7C4D05.2030500@torque.net> <20030322040550.0b8baeec.akpm@digeo.com> <200303241332.56996.pbadari@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Saturday 22 March 2003 04:05 am, Andrew Morton wrote:
> 
>>OK, thanks.  So with 48 disks you've lost five megabytes to blkdev_requests
>>and deadline_drq objects.  With 4000 disks, you're toast.  That's enough
>>request structures to put 200 gigabytes of memory under I/O ;)
>>
>>We need to make the request structures dymanically allocated for other
>>reasons (which I cannot immediately remember) but it didn't happen.  I
>>guess we have some motivation now.
> 
> 
> Here is the list of slab caches which consumed more than 1 MB
> in the process of inserting 4000 disks.
> 
> #insmod scsi_debug.ko add_host=4 num_devs=1000
> 
> deadline_drq    before:1280 after:1025420 diff:1024140 size:64 incr:65544960
> blkdev_requests  before:1280 after:1025400 diff:1024120 size:156 incr:159762720
> 
> * deadline_drq, blkdev_requests consumed almost 80 MB. We need to fix this.
> 
> inode_cache     before:700 after:140770 diff:140070 size:364 incr:50985480
> dentry_cache    before:4977 after:145061 diff:140084 size:172 incr:24094448
> 
> * inode cache increased by 50 MB, dentry cache 24 MB. 
> It looks like we cached 140,000 inodes. I wonder why ? 
 > <snip/>

Badari,
What number do you get from
  # cd /sys; du -a | wc
when you have 4000 disks?

With two disks the count on my system is 528.

Also scsi_debug should use only 8 MB (default) for
simulated storage shared between all pseudo disks
(i.e. not 8 MB per simulated host).

Doug Gilbert




