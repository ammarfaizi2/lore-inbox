Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUB0AKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbUB0AKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:10:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:4487 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261557AbUB0AIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:08:17 -0500
Date: Thu, 26 Feb 2004 16:06:16 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jochen Roemling <jochen@roemling.net>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040226160616.E1652@build.pdx.osdl.net>
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <403E87CF.1080409@roemling.net>; from jochen@roemling.net on Fri, Feb 27, 2004 at 12:57:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jochen Roemling (jochen@roemling.net) wrote:
> Chris Wright wrote:
> > In case that part wasn't clear, it would be CAP_IPC_LOCK capability.
> > 
> Thanks. Capset was the keyword I couldn't remember.
> 
> _Background:_
> I would like to install Oracle 10g Database on Linux with HUGETLB 
> support. The oracle binary exits with -EPERM because it is not allowed 
> to create a shared memory segment with the SHM_HUGETLB flag set.

OK, as expected.

> I installed the libcap2 package (from debian testing) and now have the 
> tool "setcap" available. I wanted to test this on my example pgm 
> mentioned in the original post using:
> 
> roesrv01~ # setcap CAP_IPC_LOCK a.out
> fatal error: Invalid argument
> usage: setcap [-q] (-|<caps>) <filename> [ ... (-|<capsN>) <filenameN> ]
> 
> using the number "14" instead of the name "CAP_IPC_LOCK" doesn't work 
> either. I don't have any glue. Do have a simple example for me?

did you try setpcaps?  smth like setpcaps cap_ipc_lock+e <pid>

> By the way: CAP_IPC_LOCK is only checked in line 508 of ipc/shm.c:
<snip>
>                  if (!capable(CAP_IPC_LOCK)) {
>                          err = -EPERM;
>                          goto out;
>                  }
> 
> There is nothing around that says: "Allow this only without HUGETLB".
> Are you sure that this capability is my problem?

Yes, take a look at fs/hugetlbfs/inode.c::hugetlb_zero_setup()

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

