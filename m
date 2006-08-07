Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWHGItY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWHGItY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWHGItY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:49:24 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:44206 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751164AbWHGItX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:49:23 -0400
Date: Mon, 7 Aug 2006 04:45:50 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] raid1: allow user to force reads from a specific
  disk
To: Neil Brown <neilb@suse.de>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608070447_MC3-1-C756-23FA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <17622.35724.43741.529875@cse.unsw.edu.au>

On Mon, 7 Aug 2006 10:38:36 +1000, Neil Brown wrote:

> > Allow user to force raid1 to read all data from a given disk.
> > This lets users do integrity checking by comparing results
> > from reading different disks.  If at any time the system finds
> > it cannot read from the given disk it resets the disk number
> > to -1, the default, which means to balance reads.
> 
> Could say a little bit more about why you want this?
> 
> You could get nearly the same situation be setting the other drives to
> write-mostly. 

But you couldn't test whether all IO had really gone to the target disk
after doing some reads.

e.g.

        echo 0 >/sys/block/md0/md/read_from_disk
        mount -t ext3 /dev/md0 /mnt/md0
        find /mnt/md0 -type f | xargs md5sum
        cat /sys/block/md0/md/read_from_disk

If the output from the last command isn't 0 then not all reads came from
that disk.

> And the more thorough integrity check is available via
>    echo check > /sys/block/mdX/md/sync_action

I tried that.  It doesn't do anything but print the raid status to the
kernel log.  Either that or on my 100MB mirror it's able to thoroughly
check the integrity in less than 1/4 second.

-- 
Chuck

