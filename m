Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWC3TQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWC3TQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWC3TQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:16:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:34970 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750757AbWC3TQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:16:52 -0500
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060330174008.GW5030@schatzie.adilger.int>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060330174008.GW5030@schatzie.adilger.int>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 30 Mar 2006 11:16:42 -0800
Message-Id: <1143746202.3896.32.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 10:40 -0700, Andreas Dilger wrote:
> On Mar 29, 2006  17:38 -0800, Mingming Cao wrote:
> > Have verified these two patches on a 64 bit machine with 10TB ext3
> > filesystem, fsx runs fine for a few hours. Also testes on 32 bit machine
> > with <8TB ext3.
> 
> Have you done tests _near_ 8TB with a 32-bit machine, even without these
> patches?
No I haven't. The >8TB right now is attached to a 64 bit machine, but we
should able to move it to a 32 bit machine.

>   In particular, filling up the filesystem to be close to full
> so that we really depend on the > 2TB code to work properly?

I made a kernel patch to allow a file to specify which block group it
wants it's blocks to allocate from(using ioctl to set the goal
allocation block group). I set the goal block group falls to somewhere
>8TB, and did dd tests on that file. Verified this with debugfs, the
allocated block numbers are beyond 2**31.

Also before run fsx tests, created many directories (32768 at most:) and
verified one directory's inode is located in block group >8TB space. So
when we do fsx test on files under that directory, we are
creating/testing files >8TB.

BTW, do you think this ioctl is useful in general for other users? I
attached the patch here.

I also plan to hack the code of inode allocation to force all files's
inode is put in the block group >8TB, so that we could do a full
filesystem tests there.


>   Also, in
> theory with these patches even a 32-bit machine could run > 8TB, right?
> 
> There have been sporadic reports of failure for large ext3 filesystems,
> and some of them say that 32-bit systems fail and 64-bit systems work.
> There is a kernel bugzilla bug open for this, but it was never really
> identified what the source of the problem was.
> 

Sure, I will verify that on my 32 bit machine with >8TB.

> Cheers, Andreas
> --
> Andreas Dilger
> Principal Software Engineer
> Cluster File Systems, Inc.
> 

Thanks,

Mingming

