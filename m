Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSLMECK>; Thu, 12 Dec 2002 23:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLMECK>; Thu, 12 Dec 2002 23:02:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:57490 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261292AbSLMECJ>;
	Thu, 12 Dec 2002 23:02:09 -0500
Message-ID: <3DF95D90.DEE68C66@digeo.com>
Date: Thu, 12 Dec 2002 20:09:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [2.5.51] Failure to mount ext3 root when ext2 compiled in
References: <20021213035016.339092C24F@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2002 04:09:52.0658 (UTC) FILETIME=[7CA40F20:01C2A25D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> Just noticed this (usually ext2 is compiled as a module, but was
> testing a patch with CONFIG_MODULES=n).  Reverted to plain 2.5.51, and
> it's still there:
> 
>         VFS: Cannot open root device "301" or 03:01
>         Please append a correct "root=" boot option
>         Kernel panic: VFS: Unable to mount root fs on 03:01
> 
> Now, I have an ext3 root, but when CONFIG_EXT3_FS=y and
> CONFIG_EXT2_FS=y, I get this failure.  Turning off CONFIG_EXT2_FS
> "fixes" it.
> 

In the past year I've booted about 1,000,000,000 kernels with
CONFIG_EXT2_FS=y and CONFIG_EXT3_FS=y.  Across that period, 
maybe five or ten times I have seen this problem.

As soon as I get down to debug it it goes away.  I once traced it
as far as seeing ext3_fill_super() return failure, then I lost it.

Rebuilding the kernel, even if you "didn't change anything" makes
it go away.

I assume that in your case a `make clean' will not fix it.   You
lucky duck.   Can you stick a printk right at the end of
ext3_fill_super()?
